function figSave(path)
saveas(gcf,strcat([path '.svg']));
saveas(gcf,strcat([path '.fig']));
saveas(gcf,strcat([path '.png']));
end