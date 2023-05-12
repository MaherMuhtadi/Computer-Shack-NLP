% Knowledge Base

% atomic propositions for product
product(three_ft_HDMI, rocketfish, hdmi_cable, 15, 4.3).
product(galaxy_tab_10, samsung, tablet, 599, 4.7).
product(galaxy_tab_9, samsung, tablet, 199, 2.1).
product(galaxy_tab_11, samsung, tablet, 499, 3.9).
product(galaxy_tab_12, samsung, tablet, 899, 4.9).
product(dm1, acer, monitor, 199, 4.2).
product(thinkvision, lenovo, monitor, 99, 2.3).
product(odyssey, samsung, monitor, 249, 4.5).
product(macbook_pro, apple, laptop, 1299, 4.2).
product(x1_carbon, lenovo, laptop, 699, 4.1).
product(inspiron_3511, dell, laptop, 599, 3.7).
product(aspire, acer, laptop, 799, 4.9).

% atomic propositions for inStock
inStock(three_ft_HDMI, montreal_computer_shack, 10).
inStock(galaxy_tab_10, square_one_computer_shack, 25).					
inStock(x1_carbon, mississauga_computer_shack, 12).		
inStock(dm1, montreal_computer_shack, 12).
inStock(thinkvision, montreal_computer_shack, 15).												
inStock(galaxy_tab_9, eaton_centre_computer_shack, 15).
inStock(galaxy_tab_10, eaton_centre_computer_shack, 3).
inStock(galaxy_tab_10, montreal_computer_shack, 7).
inStock(macbook_pro, montreal_computer_shack, 5).
inStock(x1_carbon, square_one_computer_shack, 4).
inStock(x1_carbon, eaton_centre_computer_shack,6).
inStock(macbook_pro, waterloo_computer_shack, 15).
inStock(aspire, square_one_computer_shack, 12).
inStock(odyssey, ottawa_computer_shack, 20).
inStock(galaxy_tab_11, scarborough_computer_shack, 19).
inStock(inspiron_3511, mississauga_computer_shack, 20).

% atomic propositions for location
location(montreal_computer_shack, montreal).
location(square_one_computer_shack, toronto).
location(mississauga_computer_shack, mississauga).
location(eaton_centre_computer_shack, toronto).
location(brampton_computer_shack, brampton).
location(scarborough_computer_shack, scarborough).
location(waterloo_computer_shack, waterloo).
location(ottawa_computer_shack, ottawa).
location(vaughan_computer_shack, vaughan).
location(hamilton_computer_shack, hamilton).

% atomic propositions for canShip

canShip(x1_carbon, montreal).
canShip(x1_carbon, toronto).
canShip(dm1, toronto).
canShip(thinkvision, toronto).
canShip(x1_carbon, mississauga).
canShip(aspire, mississauga).
canShip(odyssey, toronto).
canShip(three_ft_HDMI, waterloo).
canShip(galaxy_tab_10, toronto).
canShip(galaxy_tab_9, hamilton).
canShip(galaxy_tab_11, vaughan).
canShip(macbook_pro, brampton).
canShip(inspiron_3511, scarborough).


% Lexicon

article(Art) :- member(Art, [a, an, any]).

adjective(Adj, What) :- product(What, Adj, _, _, _).
adjective(rated, What) :- product(What, _, _, _, R), R > 0.
adjective(highly_rated, What) :- product(What, _, _, _, R), R >= 4, R =< 5.
adjective(medium_rated, What) :- product(What, _, _, _, R), R >= 2, R < 4.
adjective(lowly_rated, What) :- product(What, _, _, _, R), R >= 0, R < 2.
adjective(cheapest, What) :- product(What, _, T, P, _), not (product(What2, _, T, P2, _), not (What = What2), P2 < P).
adjective(expensive, What) :- product(What2, _, T, P2, _), not (product(What3, _, T, P3, _), not (What3 = What2), P3 < P2), product(What, _, T, P, _), P >= P2*2.

proper_noun(Name) :- product(Name, _, _, _, _).
proper_noun(Name) :- product(_, _, _, Name, _).
proper_noun(Name) :- product(_, _, _, _, Name).
proper_noun(Name) :- inStock(Name, _, _).
proper_noun(Name) :- inStock(_, Name, _).
proper_noun(Name) :- inStock(_, _, Name).
proper_noun(Name) :- location(Name, _).
proper_noun(Name) :- location(_, Name).
proper_noun(Name) :- canShip(Name, _).
proper_noun(Name) :- canShip(_, Name).

common_noun(hdmi_cord, What) :- product(What, _, hdmi_cable, _, _). % Synonym of hdmi_cable
common_noun(Noun, What) :- product(What, _, Noun, _, _).
common_noun(price, What) :- product(_, _, _, What, _).
common_noun(cost, What) :- product(_, _, _, What, _). % Synonym of price
common_noun(rating, What) :- product(_, _, _, _, What).
common_noun(stock, What) :- inStock(_, _, What).
common_noun(store, What) :- inStock(_, What, _).
common_noun(store, What) :- location(What, _).
common_noun(city, What) :- location(_, What).
common_noun(city, What) :- canShip(_, What).

preposition(of, What, Ref) :- product(Ref, _, _, _, What).
preposition(of, What, Ref) :- product(Ref, _, _, What, _).
preposition(of, What, Ref) :- inStock(Ref, _, What).
preposition(in, What, Ref) :- location(What, Ref).
preposition(in, What, Ref) :- inStock(What, S, _), location(S, Ref).
preposition(at, What, Ref) :- inStock(What, Ref, _).
preposition(at, What, Ref) :- inStock(_, Ref, What).
preposition(that_can_ship_to, What, Ref) :- canShip(What, Ref).
preposition(with, What, Ref) :- inStock(Ref, What, N), N > 0.
preposition(with, What, Ref) :- product(What, _, _, _, Ref).
preposition(with, What, Ref) :- product(What, _, _, Ref, _).
preposition(between, What, Value1, Value2) :- product(_, _, _, _, What), What >= Value1, What =< Value2.
preposition(between, What, Value1, Value2) :- product(_, _, _, What, _), What >= Value1, What =< Value2.
preposition(between, What, Value1, Value2) :- inStock(_, _, What), What >= Value1, What =< Value2.


% Parser

what(Words, Ref) :- np(Words, Ref).

% Noun phrase can be a proper name or can start with an article
np([Name],Name) :- proper_noun(Name).
np([Art|Rest], What) :- article(Art), np2(Rest, What).

% This rule handles the article 'the' in a noun phrase. A noun phrase can start with the article 'the'.
np([the|Rest], What) :- np2(Rest, What), not (np2(Rest, What2), not (What2 = What)).

/* If a noun phrase starts with an article, then it must be followed
   by another noun phrase that starts either with an adjective
   or with a common noun. */
np2([Adj|Rest],What) :- adjective(Adj,What), np2(Rest, What).
np2([Noun|Rest], What) :- common_noun(Noun, What), mods(Rest,What).

% This rule handles proper nouns in noun phrases such as 'the rating of an apple macbook_pro'
np2([Noun|Rest], Noun) :- proper_noun(Noun), mods(Rest,Noun).

/* Modifier(s) provide an additional specific info about nouns.
   Modifier can be a prepositional phrase followed by none, one or more
   additional modifiers.  */
mods([], _).
mods([in, the, stock | Rest], What) :- mods(Rest, What).
mods([in, stock | Rest], What) :- mods(Rest, What).
mods(Words, What) :-
   not Words = [in, the, stock | _], not Words = [in, stock | _],
   appendLists(Start, End, Words),
   prepPhrase(Start, What), mods(End, What).

prepPhrase([Prep|Rest], What) :-
	preposition(Prep, What, Ref), np(Rest, Ref).

% This rule handles the preposition 'between' in a preposition phrase of the form 'between X and Y'
prepPhrase([between, Value1, and, Value2| Rest ], What) :-
   number(Value1), number(Value2),
   preposition(between, What, Value1, Value2), mods(Rest, What).

appendLists([], L, L).
appendLists([H|L1], L2, [H|L3]) :-  appendLists(L1, L2, L3).
