Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] iowatcher: Allow external program to be used for IO tagging
Date: Fri, 20 May 2016 13:54:58 +0200
Message-Id: <1463745299-5951-3-git-send-email-jack@suse.cz>
In-Reply-To: <1463745299-5951-1-git-send-email-jack@suse.cz>
References: <1463745299-5951-1-git-send-email-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jan Kara <jack@suse.cz>
---
 iowatcher/blkparse.c | 225 ++++++++++++++++++++++++++++++++++++++-------------
 iowatcher/blkparse.h |   4 +-
 iowatcher/main.c     |  46 ++++++++++-
 iowatcher/tracers.c  |  53 +++++++++---
 iowatcher/tracers.h  |   1 +
 5 files changed, 259 insertions(+), 70 deletions(-)

diff --git a/iowatcher/blkparse.c b/iowatcher/blkparse.c
index 6f48079a2982..32fc614ea479 100644
--- a/iowatcher/blkparse.c
+++ b/iowatcher/blkparse.c
@@ -377,12 +377,6 @@ static void handle_notify(struct trace *trace)
 	void *payload = (char *)io + sizeof(*io);
 	u32 two32[2];
 
-	if (io->action == BLK_TN_PROCESS) {
-		if (io_per_process)
-			process_hash_insert(io->pid, payload);
-		return;
-	}
-
 	if (io->action != BLK_TN_TIMESTAMP)
 		return;
 
@@ -1029,50 +1023,93 @@ void add_tput(struct trace *trace, struct graph_line_data *writes_gld,
 
 #define GDD_PTR_ALLOC_STEP 32
 
-static int per_process_get_io_index(struct trace_file *tf,
-				    struct blk_io_trace *io,
-				    char **label, char **suffix)
+static void io_graph_new_index(struct trace_file *tf, int index, char *label,
+			       char *suffix)
+{
+	if (index >= tf->io_plots_allocated) {
+		int old_alloc = tf->io_plots_allocated;
+
+		tf->io_plots_allocated += GDD_PTR_ALLOC_STEP;
+		if (index >= tf->io_plots_allocated)
+			tf->io_plots_allocated = index + 1;
+		tf->gdd_io = realloc(tf->gdd_io, tf->io_plots_allocated * sizeof(struct graph_dot_data *));
+		if (!tf->gdd_io)
+			abort();
+		memset(tf->gdd_io + old_alloc, 0,
+		       (tf->io_plots_allocated - old_alloc) * sizeof(struct graph_dot_data *));
+	}
+	if (tf->io_plots < index + 1)
+		tf->io_plots = index + 1;
+
+	if (!tf->gdd_io[index]) {
+		int len = strlen(label) + strlen(suffix) + 1;
+		char *concat = malloc(len);
+		char *color = pick_color();
+
+		if (!concat)
+			abort();
+		strcpy(concat, label);
+		strcat(concat, suffix);
+		tf->gdd_io[index] = alloc_dot_data(tf->min_seconds, tf->max_seconds, tf->min_offset, tf->max_offset, tf->stop_seconds, color, concat);
+	}
+}
+
+static int per_process_get_io_index(struct trace *trace, struct trace_file *tf)
 {
 	struct pid_map *pm;
+	struct blk_io_trace *io = trace->io;
 	int rw = !(BLK_DATADIR(io->action) & BLK_TC_READ);
+	int action = io->action & BLK_TA_MASK;
+	char *suffix;
+
+	if (io->action == BLK_TN_PROCESS) {
+		void *payload = (char *)io + sizeof(*io);
+
+		process_hash_insert(io->pid, payload);
+		return -1;
+	}
+
+	if (action != io_event(trace))
+		return -1;
+
+	if (!(BLK_DATADIR(io->action) & BLK_TC_READ) &&
+	    !(BLK_DATADIR(io->action) & BLK_TC_WRITE))
+		return -1;
 
 	pm = process_hash_insert(io->pid, NULL);
 	if (rw)
-		*suffix = " Writes";
+		suffix = " Writes";
 	else
-		*suffix = " Reads";
-	*label = pm->name;
+		suffix = " Reads";
 	/* New entry? */
 	if (!pm->index[rw]) {
-		if (tf->io_plots == tf->io_plots_allocated) {
-			tf->io_plots_allocated += GDD_PTR_ALLOC_STEP;
-			tf->gdd_io = realloc(tf->gdd_io, tf->io_plots_allocated * sizeof(struct graph_dot_data *));
-			if (!tf->gdd_io)
-				abort();
-			memset(tf->gdd_io + tf->io_plots_allocated - GDD_PTR_ALLOC_STEP,
-			       0, GDD_PTR_ALLOC_STEP * sizeof(struct graph_dot_data *));
-		}
-		pm->index[rw] = tf->io_plots++;
-
+		pm->index[rw] = tf->io_plots;
+		io_graph_new_index(tf, tf->io_plots, pm->name, suffix);
 		return pm->index[rw];
 	}
 	return pm->index[rw];
 }
 
-static int default_get_io_index(struct trace_file *tf,
-				struct blk_io_trace *io,
-				char **label, char **suffix)
+static int default_get_io_index(struct trace *trace, struct trace_file *tf)
 {
+	struct blk_io_trace *io = trace->io;
 	int rw = !(BLK_DATADIR(io->action) & BLK_TC_READ);
+	int action = io->action & BLK_TA_MASK;
+	char *suffix;
+
+	if (action != io_event(trace))
+		return -1;
+
+	if (!(BLK_DATADIR(io->action) & BLK_TC_READ) &&
+	    !(BLK_DATADIR(io->action) & BLK_TC_WRITE))
+		return -1;
 
-	*label = "";
 	if (rw)
-		*suffix = "Writes";
+		suffix = "Writes";
 	else
-		*suffix = "Reads";
-	/* We assume we have space for at least two plot pointers in gdd_io... */
-	if (tf->io_plots <= rw)
-		tf->io_plots = rw + 1;
+		suffix = "Reads";
+	if (!tf->gdd_io[rw])
+		io_graph_new_index(tf, rw, "", suffix);
 	return rw;
 }
 
@@ -1081,8 +1118,7 @@ void add_io(struct trace *trace, struct trace_file *tf)
 	struct blk_io_trace *io = trace->io;
 	int action = io->action & BLK_TA_MASK;
 	u64 offset;
-	int index;
-	char *label, *suffix;
+	int index = trace->io_tag;
 
 	if (io->action & BLK_TC_ACT(BLK_TC_NOTIFY))
 		return;
@@ -1096,33 +1132,19 @@ void add_io(struct trace *trace, struct trace_file *tf)
 
 	offset = map_io(trace, io);
 
-	if (!io_per_process)
-		index = default_get_io_index(tf, io, &label, &suffix);
-	else
-		index = per_process_get_io_index(tf, io, &label, &suffix);
+	set_gdd_bit(tf->gdd_io[index], offset, io->bytes, io->time);
 
-	if (!tf->gdd_io[index]) {
-		int len = strlen(label) + strlen(suffix) + 1;
-		char *concat = malloc(len);
-		char *color = pick_color();
+	if (!io_per_process) {
 		int rw = !(BLK_DATADIR(io->action) & BLK_TC_READ);
 
-		if (!concat)
-			abort();
-		strcpy(concat, label);
-		strcat(concat, suffix);
-		tf->gdd_io[index] = alloc_dot_data(tf->min_seconds, tf->max_seconds, tf->min_offset, tf->max_offset, tf->stop_seconds, color, concat);
-		if (!io_per_process) {
-			/* Use the color also for corresponding line graphs. */
-			if (!tf->line_color)
-				tf->line_color = color;
-			if (!rw && !tf->reads_color)
-				tf->reads_color = color;
-			if (rw && !tf->writes_color)
-				tf->writes_color = color;
-		}
+		/* Use the color also for corresponding line graphs. */
+		if (!tf->line_color)
+			tf->line_color = tf->gdd_io[index]->color;
+		if (!rw && !tf->reads_color)
+			tf->reads_color = tf->gdd_io[index]->color;
+		if (rw && !tf->writes_color)
+			tf->writes_color = tf->gdd_io[index]->color;
 	}
-	set_gdd_bit(tf->gdd_io[index], offset, io->bytes, io->time);
 }
 
 void add_pending_io(struct trace *trace, struct graph_line_data *gld)
@@ -1242,7 +1264,96 @@ void add_iop(struct trace *trace, struct graph_line_data *gld)
 		gld->max = gld->data[seconds].sum;
 }
 
-void check_record(struct trace *trace)
+enum {
+	TAG_RESP_END,		/* No more responses for given IO event */
+	TAG_RESP_NEW_TAG,	/* Create new tag */
+	TAG_RESP_TAG_IO,	/* Tag IO with given tag */
+};
+
+extern int tag_io_fd;
+
+static void read_safe(void *buf, int len)
+{
+	ssize_t ret;
+
+	while (len > 0) {
+		ret = read(tag_io_fd, buf, len);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to get IO tag. Read error: %s\n", strerror(errno));
+			exit(1);
+		}
+		if (ret == 0) {
+			fprintf(stderr, "Failed to get IO tag. Premature EOF.\n");
+			exit(1);
+		}
+		buf += ret;
+		len -= ret;
+	}
+}
+
+#define BUFSIZE 65536
+
+static int tag_prog_get_io_index(struct trace *trace, struct trace_file *tf)
+{
+	struct blk_io_trace *io = trace->io;
+	ssize_t ret;
+	char buf[BUFSIZE];
+	u32 response;
+	int index = -1;
+
+	ret = write(tag_io_fd, io, sizeof(*io) + io->pdu_len);
+	if (ret != (int)sizeof(*io) + io->pdu_len) {
+		fprintf(stderr, "Failed to get IO tag. Write returned %d\n", (int)ret);
+		exit(1);
+	}
+	while (1) {
+		read_safe(&response, sizeof(response));
+		if (response == TAG_RESP_END)
+			break;
+		else if (response == TAG_RESP_TAG_IO) {
+			u32 tag;
+
+			read_safe(&tag, sizeof(tag));
+			index = tag;
+		}
+		else if (response == TAG_RESP_NEW_TAG) {
+			u32 tag;
+			u32 len;
+
+			read_safe(&tag, sizeof(tag));
+			read_safe(&len, sizeof(len));
+			if (len > BUFSIZE) {
+				fprintf(stderr, "Failed to get IO tag. Too long tag label: %u\n", (unsigned)len);
+				exit(1);
+			}
+			read_safe(buf, len);
+			/* We expect \0 terminated string in buf as a label */
+			io_graph_new_index(tf, tag, buf, "");
+		}
+		else {
+			fprintf(stderr, "Failed to get IO tag. Unknown response %u\n", response);
+			exit(1);
+		}
+	}
+
+	return index;
+}
+
+static void handle_io_tags(struct trace *trace, struct trace_file *tf)
+{
+	int index;
+
+	if (tag_io_fd)
+		index = tag_prog_get_io_index(trace, tf);
+	else if (io_per_process)
+		index = per_process_get_io_index(trace, tf);
+	else
+		index = default_get_io_index(trace, tf);
+	trace->io_tag = index;
+}
+
+void check_record(struct trace *trace, struct trace_file *tf)
 {
 	handle_notify(trace);
+	handle_io_tags(trace, tf);
 }
diff --git a/iowatcher/blkparse.h b/iowatcher/blkparse.h
index 0448b70bbb09..3dabe3675566 100644
--- a/iowatcher/blkparse.h
+++ b/iowatcher/blkparse.h
@@ -40,6 +40,7 @@ struct trace {
 	char *start;
 	char *cur;
 	struct blk_io_trace *io;
+	int io_tag;
 	u64 start_timestamp;
 	struct timespec abs_start_time;
 
@@ -124,7 +125,8 @@ int filter_outliers(struct trace *trace, u64 min_offset, u64 max_offset,
 		    u64 *yzoom_min, u64 *yzoom_max);
 int action_char_to_num(char action);
 void add_iop(struct trace *trace, struct graph_line_data *gld);
-void check_record(struct trace *trace);
+void check_record(struct trace *trace, struct trace_file *tf);
+void get_io_tag(struct trace *trace);
 void add_completed_io(struct trace *trace,
 		      struct graph_line_data *latency_gld);
 void add_io(struct trace *trace, struct trace_file *tf);
diff --git a/iowatcher/main.c b/iowatcher/main.c
index f64c44d2ca5c..c3e06b006be5 100644
--- a/iowatcher/main.c
+++ b/iowatcher/main.c
@@ -62,9 +62,14 @@ static double max_time = DBL_MAX;
 static unsigned long long min_mb = 0;
 static unsigned long long max_mb = ULLONG_MAX >> 20;
 
+#define MAX_TAG_IO_ARGS 1024
+
 int plot_io_action = 0;
 int io_per_process = 0;
+char *tag_io_argv[MAX_TAG_IO_ARGS + 1];
+int tag_io_arg_cnt = 0;
 unsigned int longest_proc_name = 0;
+int tag_io_fd;
 
 /*
  * this doesn't include the IO graph,
@@ -277,7 +282,7 @@ static void setup_trace_file_graphs(void)
 	int i;
 	int alloc_ptrs;
 
-	if (io_per_process)
+	if (io_per_process || tag_io_argv[0])
 		alloc_ptrs = 32;
 	else
 		alloc_ptrs = 2;
@@ -425,7 +430,7 @@ static void read_trace_events(void)
 
 		first_record(trace);
 		do {
-			check_record(trace);
+			check_record(trace, tf);
 			if (SECONDS(get_record_time(trace)) > tf->max_seconds)
 				continue;
 			add_tput(trace, tf->tput_writes_gld, tf->tput_reads_gld);
@@ -1268,6 +1273,8 @@ static void check_plot_columns(struct plot *plot, int index)
 
 enum {
 	HELP_LONG_OPT = 1,
+	TAG_IO_LONG_OPT,
+	TAG_IO_ARG_LONG_OPT,
 };
 
 char *option_string = "+F:T:t:o:l:r:O:N:d:D:pm::h:w:c:x:y:a:C:PK";
@@ -1293,6 +1300,8 @@ static struct option long_options[] = {
 	{"yzoom", required_argument, 0, 'y'},
 	{"io-plot-action", required_argument, 0, 'a'},
 	{"per-process-io", no_argument, 0, 'P'},
+	{"tag-io", required_argument, 0, TAG_IO_LONG_OPT},
+	{"tag-io-arg", required_argument, 0, TAG_IO_ARG_LONG_OPT},
 	{"help", no_argument, 0, HELP_LONG_OPT},
 	{0, 0, 0, 0}
 };
@@ -1322,6 +1331,8 @@ static void print_usage(void)
 		"\t-y (--yzoom): limit processed sectors to min:max\n"
 		"\t-a (--io-plot-action): plot given action (one of Q,D,C) in IO graph\n"
 		"\t-P (--per-process-io): distinguish between processes in IO graph\n"
+		"\t--tag-io: tag IO by external program, display different tags with different color in IO graph\n"
+		"\t--tag-io-arg: argument for external tagging program, may be used repeatedly\n"
 	       );
 	exit(1);
 }
@@ -1504,6 +1515,16 @@ action_err:
 		case 'P':
 			io_per_process = 1;
 			break;
+		case TAG_IO_LONG_OPT:
+			tag_io_argv[0] = optarg;
+			break;
+		case TAG_IO_ARG_LONG_OPT:
+			if (tag_io_arg_cnt >= MAX_TAG_IO_ARGS) {
+				fprintf(stderr, "Too many arguments for tagging program. Maximum is %d\n", MAX_TAG_IO_ARGS);
+				exit(1);
+			}
+			tag_io_argv[1 + tag_io_arg_cnt++] = optarg;
+			break;
 		case '?':
 		case HELP_LONG_OPT:
 			print_usage();
@@ -1524,6 +1545,11 @@ action_err:
 		exit(1);
 	}
 
+	if (io_per_process && tag_io_argv[0]) {
+		fprintf(stderr, "Cannot combine --per-process-io and --tag-io\n");
+		exit(1);
+	}
+
 	return 0;
 }
 
@@ -1548,6 +1574,7 @@ int main(int ac, char **av)
 	struct trace_file *tf;
 	int ret;
 	int rows, cols;
+	pid_t tag_io_pid = 0;
 
 	init_io_hash_table();
 	init_process_hash_table();
@@ -1613,6 +1640,15 @@ int main(int ac, char **av)
 		free(path);
 	}
 
+	if (tag_io_argv[0]) {
+		ret = run_program_piped(tag_io_arg_cnt + 1, tag_io_argv,
+					&tag_io_pid, &tag_io_fd);
+		if (ret) {
+			fprintf(stderr, "Failed to run tagging program: %s\n", strerror(ret));
+			exit(1);
+		}
+	}
+
 	/* step one, read all the traces */
 	read_traces();
 
@@ -1638,6 +1674,12 @@ int main(int ac, char **av)
 	/* run through all the traces and read their events */
 	read_trace_events();
 
+	/* done with traces, stop tagging program */
+	if (tag_io_pid) {
+		wait_program(tag_io_pid, tag_io_argv[0], SIGKILL);
+		close(tag_io_fd);
+	}
+
 	pick_line_graph_color();
 
 	plot = alloc_plot();
diff --git a/iowatcher/tracers.c b/iowatcher/tracers.c
index 4c3d10dfb5f7..7dfe23473541 100644
--- a/iowatcher/tracers.c
+++ b/iowatcher/tracers.c
@@ -32,6 +32,7 @@
 #include <signal.h>
 #include <sys/wait.h>
 #include <spawn.h>
+#include <sys/socket.h>
 
 #include "plot.h"
 #include "blkparse.h"
@@ -123,26 +124,19 @@ int wait_program(pid_t pid, const char *pname, int sig)
 	return ret;
 }
 
-int run_program(int argc, char **argv, int wait, pid_t *pid, char *outpath)
+static int run_program_fa(int argc, char **argv, int wait, pid_t *pid,
+			  posix_spawn_file_actions_t *facts)
 {
 	int i;
 	int err;
 	pid_t _pid;
-	posix_spawn_file_actions_t facts;
-	posix_spawn_file_actions_t *factp = NULL;
-
-	if (outpath != NULL) {
-		posix_spawn_file_actions_init(&facts);
-		posix_spawn_file_actions_addopen(&facts, 1, outpath, O_WRONLY|O_CREAT|O_TRUNC, 0600);
-		factp = &facts;
-	}
 
 	fprintf(stderr, "Start");
 	for (i = 0; i < argc; i++)
 		fprintf(stderr, " %s", argv[i]);
 	fprintf(stderr, "\n");
 
-	err = posix_spawnp(&_pid, argv[0], factp, NULL, argv, environ);
+	err = posix_spawnp(&_pid, argv[0], facts, NULL, argv, environ);
 	if (err != 0) {
 		fprintf(stderr, "Could not run '%s': %s\n", argv[0], strerror(err));
 	} else if (wait) {
@@ -156,6 +150,45 @@ int run_program(int argc, char **argv, int wait, pid_t *pid, char *outpath)
 	return err;
 }
 
+int run_program(int argc, char **argv, int wait, pid_t *pid, char *outpath)
+{
+	posix_spawn_file_actions_t facts;
+	posix_spawn_file_actions_t *factp = NULL;
+
+	if (outpath != NULL) {
+		posix_spawn_file_actions_init(&facts);
+		posix_spawn_file_actions_addopen(&facts, 1, outpath, O_WRONLY|O_CREAT|O_TRUNC, 0600);
+		factp = &facts;
+	}
+
+	return run_program_fa(argc, argv, wait, pid, factp);
+}
+
+int run_program_piped(int argc, char **argv, pid_t *pid, int *fd)
+{
+	int err;
+	posix_spawn_file_actions_t facts;
+	int sockfd[2];
+
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sockfd))
+		return errno;
+
+	posix_spawn_file_actions_init(&facts);
+	posix_spawn_file_actions_adddup2(&facts, sockfd[1], 0);
+	posix_spawn_file_actions_adddup2(&facts, sockfd[1], 1);
+
+	err = run_program_fa(argc, argv, 0, pid, &facts);
+	if (err) {
+		close(sockfd[0]);
+		close(sockfd[1]);
+		return err;
+	}
+	close(sockfd[1]);
+	*fd = sockfd[0];
+
+	return 0;
+}
+
 int wait_for_tracers(int sig)
 {
 	int err;
diff --git a/iowatcher/tracers.h b/iowatcher/tracers.h
index 9b4f6a5480e4..68a972701104 100644
--- a/iowatcher/tracers.h
+++ b/iowatcher/tracers.h
@@ -18,6 +18,7 @@
 #ifndef __IOWATCH_TRACERS
 #define __IOWATCH_TRACERS
 int run_program(int argc, char **argv, int wait, pid_t *pid, char *stdoutpath);
+int run_program_piped(int argc, char **argv, pid_t *pid, int *fd);
 int wait_program(pid_t pid, const char *pname, int signal);
 int stop_blktrace(void);
 int start_blktrace(char **devices, int num_devices, char *trace_name, char *dest);
-- 
2.6.6
