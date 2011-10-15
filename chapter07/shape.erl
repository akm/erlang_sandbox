-module(shape).
-export([area/1, circumference/1]).

% % Shapeからcircleやrectangleなどのレコード名が取得できれば
% % ポリモーフィズムを実現できるんだけどなー
% area(Shape) -> 
%   mod = record_info(name, Shape),
%   apply(mod, area, [Shape]).
% circumference(Shape)  ->
%   mod = record_info(name, Shape),
%   apply(mod, circumference, [Shape]).
