Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] iowatcher: Do not distinguish between reads and writes in IO graphs
Date: Fri, 20 May 2016 13:54:57 +0200
Message-Id: <1463745299-5951-2-git-send-email-jack@suse.cz>
In-Reply-To: <1463745299-5951-1-git-send-email-jack@suse.cz>
References: <1463745299-5951-1-git-send-email-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Currently names of struct members distinguish between IO graphs for
reads and writes. However with more involved IO graph coloring this
doesn't necessarily make sense and also it leads to a duplication where
we have to work with two arrays instead of one. There are only a few
places which care about read vs write distinction and those can be
implemented differently. So just replace two IO graph arrays with a
single one.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 iowatcher/blkparse.c | 136 +++++++++++++++++++++++++++++++++------------------
 iowatcher/blkparse.h |   7 ++-
 iowatcher/main.c     | 116 +++++++++++++------------------------------
 iowatcher/plot.h     |   3 +-
 4 files changed, 125 insertions(+), 137 deletions(-)

diff --git a/iowatcher/blkparse.c b/iowatcher/blkparse.c
index c7d1d652c78e..6f48079a2982 100644
--- a/iowatcher/blkparse.c
+++ b/iowatcher/blkparse.c
@@ -174,7 +174,7 @@ struct pending_io {
 struct pid_map {
 	struct list_head hash_list;
 	u32 pid;
-	int index;
+	int index[2];
 	char name[0];
 };
 
@@ -329,11 +329,25 @@ static struct pid_map *process_hash_search(u32 pid)
 	return NULL;
 }
 
-static struct pid_map *process_hash_insert(u32 pid, char *name)
+static struct pid_map *process_hash_new(u32 pid, char *name)
 {
+	struct pid_map *pm;
 	int slot = hash_pid(pid);
+
+	pm = malloc(sizeof(struct pid_map) + strlen(name) + 1);
+	pm->pid = pid;
+	pm->index[0] = 0;
+	pm->index[1] = 0;
+	strcpy(pm->name, name);
+	list_add_tail(&pm->hash_list, process_hash_table + slot);
+
+	return pm;
+}
+
+static struct pid_map *process_hash_insert(u32 pid, char *name)
+{
 	struct pid_map *pm;
-	int old_index = 0;
+	int old_index[2] = {};
 	char buf[16];
 
 	pm = process_hash_search(pid);
@@ -342,18 +356,17 @@ static struct pid_map *process_hash_insert(u32 pid, char *name)
 		if (!name || !strcmp(name, pm->name))
 			return pm;
 		list_del(&pm->hash_list);
-		old_index = pm->index;
+		old_index[0] = pm->index[0];
+		old_index[1] = pm->index[1];
 		free(pm);
 	}
 	if (!name) {
 		sprintf(buf, "[%u]", pid);
 		name = buf;
 	}
-	pm = malloc(sizeof(struct pid_map) + strlen(name) + 1);
-	pm->pid = pid;
-	pm->index = old_index;
-	strcpy(pm->name, name);
-	list_add_tail(&pm->hash_list, process_hash_table + slot);
+	pm = process_hash_new(pid, name);
+	pm->index[0] = old_index[0];
+	pm->index[1] = old_index[1];
 
 	return pm;
 }
@@ -1014,39 +1027,53 @@ void add_tput(struct trace *trace, struct graph_line_data *writes_gld,
 		gld->max = gld->data[seconds].sum;
 }
 
-#define GDD_PTR_ALLOC_STEP 16
+#define GDD_PTR_ALLOC_STEP 32
 
-static struct pid_map *get_pid_map(struct trace_file *tf, u32 pid)
+static int per_process_get_io_index(struct trace_file *tf,
+				    struct blk_io_trace *io,
+				    char **label, char **suffix)
 {
 	struct pid_map *pm;
+	int rw = !(BLK_DATADIR(io->action) & BLK_TC_READ);
 
-	if (!io_per_process) {
-		if (!tf->io_plots)
-			tf->io_plots = 1;
-		return NULL;
-	}
-
-	pm = process_hash_insert(pid, NULL);
+	pm = process_hash_insert(io->pid, NULL);
+	if (rw)
+		*suffix = " Writes";
+	else
+		*suffix = " Reads";
+	*label = pm->name;
 	/* New entry? */
-	if (!pm->index) {
+	if (!pm->index[rw]) {
 		if (tf->io_plots == tf->io_plots_allocated) {
 			tf->io_plots_allocated += GDD_PTR_ALLOC_STEP;
-			tf->gdd_reads = realloc(tf->gdd_reads, tf->io_plots_allocated * sizeof(struct graph_dot_data *));
-			if (!tf->gdd_reads)
-				abort();
-			tf->gdd_writes = realloc(tf->gdd_writes, tf->io_plots_allocated * sizeof(struct graph_dot_data *));
-			if (!tf->gdd_writes)
+			tf->gdd_io = realloc(tf->gdd_io, tf->io_plots_allocated * sizeof(struct graph_dot_data *));
+			if (!tf->gdd_io)
 				abort();
-			memset(tf->gdd_reads + tf->io_plots_allocated - GDD_PTR_ALLOC_STEP,
-			       0, GDD_PTR_ALLOC_STEP * sizeof(struct graph_dot_data *));
-			memset(tf->gdd_writes + tf->io_plots_allocated - GDD_PTR_ALLOC_STEP,
+			memset(tf->gdd_io + tf->io_plots_allocated - GDD_PTR_ALLOC_STEP,
 			       0, GDD_PTR_ALLOC_STEP * sizeof(struct graph_dot_data *));
 		}
-		pm->index = tf->io_plots++;
+		pm->index[rw] = tf->io_plots++;
 
-		return pm;
+		return pm->index[rw];
 	}
-	return pm;
+	return pm->index[rw];
+}
+
+static int default_get_io_index(struct trace_file *tf,
+				struct blk_io_trace *io,
+				char **label, char **suffix)
+{
+	int rw = !(BLK_DATADIR(io->action) & BLK_TC_READ);
+
+	*label = "";
+	if (rw)
+		*suffix = "Writes";
+	else
+		*suffix = "Reads";
+	/* We assume we have space for at least two plot pointers in gdd_io... */
+	if (tf->io_plots <= rw)
+		tf->io_plots = rw + 1;
+	return rw;
 }
 
 void add_io(struct trace *trace, struct trace_file *tf)
@@ -1055,8 +1082,7 @@ void add_io(struct trace *trace, struct trace_file *tf)
 	int action = io->action & BLK_TA_MASK;
 	u64 offset;
 	int index;
-	char *label;
-	struct pid_map *pm;
+	char *label, *suffix;
 
 	if (io->action & BLK_TC_ACT(BLK_TC_NOTIFY))
 		return;
@@ -1064,25 +1090,39 @@ void add_io(struct trace *trace, struct trace_file *tf)
 	if (action != io_event(trace))
 		return;
 
+	if (!(BLK_DATADIR(io->action) & BLK_TC_READ) &&
+	    !(BLK_DATADIR(io->action) & BLK_TC_WRITE))
+		return;
+
 	offset = map_io(trace, io);
 
-	pm = get_pid_map(tf, io->pid);
-	if (!pm) {
-		index = 0;
-		label = "";
-	} else {
-		index = pm->index;
-		label = pm->name;
-	}
-	if (BLK_DATADIR(io->action) & BLK_TC_READ) {
-		if (!tf->gdd_reads[index])
-			tf->gdd_reads[index] = alloc_dot_data(tf->min_seconds, tf->max_seconds, tf->min_offset, tf->max_offset, tf->stop_seconds, pick_color(), strdup(label));
-		set_gdd_bit(tf->gdd_reads[index], offset, io->bytes, io->time);
-	} else if (BLK_DATADIR(io->action) & BLK_TC_WRITE) {
-		if (!tf->gdd_writes[index])
-			tf->gdd_writes[index] = alloc_dot_data(tf->min_seconds, tf->max_seconds, tf->min_offset, tf->max_offset, tf->stop_seconds, pick_color(), strdup(label));
-		set_gdd_bit(tf->gdd_writes[index], offset, io->bytes, io->time);
+	if (!io_per_process)
+		index = default_get_io_index(tf, io, &label, &suffix);
+	else
+		index = per_process_get_io_index(tf, io, &label, &suffix);
+
+	if (!tf->gdd_io[index]) {
+		int len = strlen(label) + strlen(suffix) + 1;
+		char *concat = malloc(len);
+		char *color = pick_color();
+		int rw = !(BLK_DATADIR(io->action) & BLK_TC_READ);
+
+		if (!concat)
+			abort();
+		strcpy(concat, label);
+		strcat(concat, suffix);
+		tf->gdd_io[index] = alloc_dot_data(tf->min_seconds, tf->max_seconds, tf->min_offset, tf->max_offset, tf->stop_seconds, color, concat);
+		if (!io_per_process) {
+			/* Use the color also for corresponding line graphs. */
+			if (!tf->line_color)
+				tf->line_color = color;
+			if (!rw && !tf->reads_color)
+				tf->reads_color = color;
+			if (rw && !tf->writes_color)
+				tf->writes_color = color;
+		}
 	}
+	set_gdd_bit(tf->gdd_io[index], offset, io->bytes, io->time);
 }
 
 void add_pending_io(struct trace *trace, struct graph_line_data *gld)
diff --git a/iowatcher/blkparse.h b/iowatcher/blkparse.h
index fce9d01ed2c6..0448b70bbb09 100644
--- a/iowatcher/blkparse.h
+++ b/iowatcher/blkparse.h
@@ -91,13 +91,12 @@ struct trace_file {
 	int fio_trace;
 	struct graph_line_data *fio_gld;
 
-	/* Number of entries in gdd_writes / gdd_reads */
+	/* Number of entries in gdd_io */
 	int io_plots;
 
-	/* Allocated array size for gdd_writes / gdd_reads */
+	/* Allocated array size for gdd_io */
 	int io_plots_allocated;
-	struct graph_dot_data **gdd_writes;
-	struct graph_dot_data **gdd_reads;
+	struct graph_dot_data **gdd_io;
 
 	unsigned int mpstat_min_seconds;
 	unsigned int mpstat_max_seconds;
diff --git a/iowatcher/main.c b/iowatcher/main.c
index 54325fbfde52..f64c44d2ca5c 100644
--- a/iowatcher/main.c
+++ b/iowatcher/main.c
@@ -278,9 +278,9 @@ static void setup_trace_file_graphs(void)
 	int alloc_ptrs;
 
 	if (io_per_process)
-		alloc_ptrs = 16;
+		alloc_ptrs = 32;
 	else
-		alloc_ptrs = 1;
+		alloc_ptrs = 2;
 
 	list_for_each_entry(tf, &all_traces, list) {
 		tf->tput_reads_gld = alloc_line_data(tf->min_seconds, tf->max_seconds, tf->stop_seconds);
@@ -289,8 +289,7 @@ static void setup_trace_file_graphs(void)
 		tf->queue_depth_gld = alloc_line_data(tf->min_seconds, tf->max_seconds, tf->stop_seconds);
 
 		tf->iop_gld = alloc_line_data(tf->min_seconds, tf->max_seconds, tf->stop_seconds);
-		tf->gdd_writes = calloc(alloc_ptrs, sizeof(struct graph_dot_data *));
-		tf->gdd_reads = calloc(alloc_ptrs, sizeof(struct graph_dot_data *));
+		tf->gdd_io = calloc(alloc_ptrs, sizeof(struct graph_dot_data *));
 		tf->io_plots_allocated = alloc_ptrs;
 
 		if (tf->trace->mpstat_num_cpus == 0)
@@ -370,25 +369,19 @@ static void read_traces(void)
 static void pick_line_graph_color(void)
 {
 	struct trace_file *tf;
-	int i;
 
 	list_for_each_entry(tf, &all_traces, list) {
-		for (i = 0; i < tf->io_plots; i++) {
-			if (tf->gdd_reads[i]) {
-				tf->line_color = tf->gdd_reads[i]->color;
-				tf->reads_color = tf->gdd_reads[i]->color;
-			}
-			if (tf->gdd_writes[i]) {
-				tf->line_color = tf->gdd_writes[i]->color;
-				tf->writes_color = tf->gdd_writes[i]->color;
-			}
-			if (tf->writes_color && tf->reads_color)
-				break;
-		}
+		/*
+		 * For normal IO graph view colors will be already selected in
+		 * add_io().  However for more involved coloring of IO graph it
+		 * doesn't make sense to align colors so just pick some here.
+		 */
+		if (!tf->line_color)
+			tf->line_color = pick_color();
 		if (!tf->reads_color)
-			tf->reads_color = tf->line_color;
+			tf->reads_color = pick_color();
 		if (!tf->writes_color)
-			tf->writes_color = tf->line_color;
+			tf->writes_color = pick_color();
 	}
 }
 
@@ -603,22 +596,15 @@ static struct plot_history *alloc_plot_history(struct trace_file *tf)
 		perror("memory allocation failed");
 		exit(1);
 	}
-	ph->read_pid_history = calloc(tf->io_plots, sizeof(struct pid_plot_history *));
-	if (!ph->read_pid_history) {
-		perror("memory allocation failed");
-		exit(1);
-	}
-	ph->write_pid_history = calloc(tf->io_plots, sizeof(struct pid_plot_history *));
-	if (!ph->write_pid_history) {
+	ph->io_pid_history = calloc(tf->io_plots, sizeof(struct pid_plot_history *));
+	if (!ph->io_pid_history) {
 		perror("memory allocation failed");
 		exit(1);
 	}
 	ph->pid_history_count = tf->io_plots;
 	for (i = 0; i < tf->io_plots; i++) {
-		if (tf->gdd_reads[i])
-			ph->read_pid_history[i] = alloc_pid_plot_history(tf->gdd_reads[i]->color);
-		if (tf->gdd_writes[i])
-			ph->write_pid_history[i] = alloc_pid_plot_history(tf->gdd_writes[i]->color);
+		if (tf->gdd_io[i])
+			ph->io_pid_history[i] = alloc_pid_plot_history(tf->gdd_io[i]->color);
 	}
 	return ph;
 }
@@ -631,13 +617,10 @@ static void free_plot_history(struct plot_history *ph)
 	int pid;
 
 	for (pid = 0; pid < ph->pid_history_count; pid++) {
-		if (ph->read_pid_history[pid])
-			free(ph->read_pid_history[pid]);
-		if (ph->write_pid_history[pid])
-			free(ph->write_pid_history[pid]);
+		if (ph->io_pid_history[pid])
+			free(ph->io_pid_history[pid]);
 	}
-	free(ph->read_pid_history);
-	free(ph->write_pid_history);
+	free(ph->io_pid_history);
 	free(ph);
 }
 
@@ -666,22 +649,13 @@ static void plot_movie_history(struct plot *plot, struct list_head *list)
 
 	list_for_each_entry(ph, list, list) {
 		for (pid = 0; pid < ph->pid_history_count; pid++) {
-			if (ph->read_pid_history[pid]) {
+			if (ph->io_pid_history[pid]) {
 				if (movie_style == MOVIE_SPINDLE) {
 					svg_io_graph_movie_array_spindle(plot,
-						ph->read_pid_history[pid]);
+						ph->io_pid_history[pid]);
 				} else {
 					svg_io_graph_movie_array(plot,
-						ph->read_pid_history[pid]);
-				}
-			}
-			if (ph->write_pid_history[pid]) {
-				if (movie_style == MOVIE_SPINDLE) {
-					svg_io_graph_movie_array_spindle(plot,
-						ph->write_pid_history[pid]);
-				} else {
-					svg_io_graph_movie_array(plot,
-						ph->write_pid_history[pid]);
+						ph->io_pid_history[pid]);
 				}
 			}
 		}
@@ -707,29 +681,16 @@ static int count_io_plot_types(void)
 
 	list_for_each_entry(tf, &all_traces, list) {
 		for (i = 0; i < tf->io_plots; i++) {
-			if (tf->gdd_reads[i])
-				total_io_types++;
-			if (tf->gdd_writes[i])
+			if (tf->gdd_io[i])
 				total_io_types++;
 		}
 	}
 	return total_io_types;
 }
 
-static void plot_io_legend(struct plot *plot, struct graph_dot_data *gdd, char *prefix, char *rw)
+static void plot_io_legend(struct plot *plot, struct graph_dot_data *gdd, char *prefix)
 {
-	int ret = 0;
-	char *label = NULL;
-	if (io_per_process)
-		ret = asprintf(&label, "%s %s", prefix, gdd->label);
-	else
-		ret = asprintf(&label, "%s", prefix);
-	if (ret < 0) {
-		perror("Failed to process labels");
-		exit(1);
-	}
-	svg_add_legend(plot, label, rw, gdd->color);
-	free(label);
+	svg_add_legend(plot, prefix, gdd->label, gdd->color);
 }
 
 static void plot_io(struct plot *plot, unsigned int min_seconds,
@@ -755,13 +716,9 @@ static void plot_io(struct plot *plot, unsigned int min_seconds,
 		char *prefix = tf->label ? tf->label : "";
 
 		for (i = 0; i < tf->io_plots; i++) {
-			if (tf->gdd_writes[i]) {
-				svg_io_graph(plot, tf->gdd_writes[i]);
-				plot_io_legend(plot, tf->gdd_writes[i], prefix, " Writes");
-			}
-			if (tf->gdd_reads[i]) {
-				svg_io_graph(plot, tf->gdd_reads[i]);
-				plot_io_legend(plot, tf->gdd_reads[i], prefix, " Reads");
+			if (tf->gdd_io[i]) {
+				svg_io_graph(plot, tf->gdd_io[i]);
+				plot_io_legend(plot, tf->gdd_io[i], prefix);
 			}
 		}
 	}
@@ -1158,23 +1115,16 @@ static void plot_io_movie(struct plot *plot)
 			history->col = i;
 
 			for (pid = 0; pid < tf->io_plots; pid++) {
-				if (tf->gdd_reads[pid])
-					plot_io_legend(plot, tf->gdd_reads[pid], prefix, " Reads");
-				if (tf->gdd_writes[pid])
-					plot_io_legend(plot, tf->gdd_writes[pid], prefix, " Writes");
+				if (tf->gdd_io[pid])
+					plot_io_legend(plot, tf->gdd_io[pid], prefix);
 			}
 
 			batch_i = 0;
 			while (i < cols && batch_i < batch_count) {
 				for (pid = 0; pid < tf->io_plots; pid++) {
-					if (tf->gdd_reads[pid]) {
-						svg_io_graph_movie(tf->gdd_reads[pid],
-								   history->read_pid_history[pid],
-								   i);
-					}
-					if (tf->gdd_writes[pid]) {
-						svg_io_graph_movie(tf->gdd_writes[pid],
-								   history->write_pid_history[pid],
+					if (tf->gdd_io[pid]) {
+						svg_io_graph_movie(tf->gdd_io[pid],
+								   history->io_pid_history[pid],
 								   i);
 					}
 				}
diff --git a/iowatcher/plot.h b/iowatcher/plot.h
index d65bbcf3396e..48e17e8bd81b 100644
--- a/iowatcher/plot.h
+++ b/iowatcher/plot.h
@@ -128,8 +128,7 @@ struct plot_history {
 	struct list_head list;
 	int pid_history_count;
 	int col;
-	struct pid_plot_history **read_pid_history;
-	struct pid_plot_history **write_pid_history;
+	struct pid_plot_history **io_pid_history;
 };
 
 char *pick_color(void);
-- 
2.6.6
