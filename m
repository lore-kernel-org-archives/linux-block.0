Return-Path: <joelaf@google.com>
Return-Path: <joelaf@google.com>
From: Joel Fernandes <joelaf@google.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>,
	kernel-team@android.com,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [RFC v2 2/4] tracing: Add support for recording tgid of tasks
Date: Sat,  3 Jun 2017 21:03:48 -0700
Message-Id: <20170604040350.12641-3-joelaf@google.com>
In-Reply-To: <20170604040350.12641-1-joelaf@google.com>
References: <20170604040350.12641-1-joelaf@google.com>
List-ID: <linux-block@vger.kernel.org>

Inorder to support recording of tgid, the following changes are made:

- Introduce a new API for optionally recording the tgid along with the task's
  comm which replaces the existing '*cmdline*' APIs.
- reuse the existing sched_switch and sched_wakeup probes
- replace all uses of the old API
- add a new option 'record-tgid' to enable recording of tgid

This will have no memory or runtime overhead if record-tgid option isn't enabled.

Cc: kernel-team@android.com
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com> 
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 include/linux/trace_events.h         | 10 ++++-
 kernel/trace/blktrace.c              |  2 +-
 kernel/trace/trace.c                 | 79 ++++++++++++++++++++++++++++------
 kernel/trace/trace.h                 |  9 +++-
 kernel/trace/trace_events.c          | 83 ++++++++++++++++++++++++++++++------
 kernel/trace/trace_functions.c       |  5 ++-
 kernel/trace/trace_functions_graph.c |  4 +-
 kernel/trace/trace_sched_switch.c    | 67 +++++++++++++++++++++--------
 kernel/trace/trace_selftest.c        |  2 +-
 9 files changed, 208 insertions(+), 53 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index a556805eff8a..bc54f1469971 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -151,7 +151,11 @@ trace_event_buffer_lock_reserve(struct ring_buffer **current_buffer,
 				int type, unsigned long len,
 				unsigned long flags, int pc);
 
-void tracing_record_cmdline(struct task_struct *tsk);
+void tracing_record_taskinfo(struct task_struct **tasks, int len, bool cmd,
+			     bool tgid);
+
+void tracing_record_taskinfo_single(struct task_struct *task, bool cmd,
+				    bool tgid);
 
 int trace_output_call(struct trace_iterator *iter, char *name, char *fmt, ...);
 
@@ -290,6 +294,7 @@ struct trace_subsystem_dir;
 enum {
 	EVENT_FILE_FL_ENABLED_BIT,
 	EVENT_FILE_FL_RECORDED_CMD_BIT,
+	EVENT_FILE_FL_RECORDED_TGID_BIT,
 	EVENT_FILE_FL_FILTERED_BIT,
 	EVENT_FILE_FL_NO_SET_FILTER_BIT,
 	EVENT_FILE_FL_SOFT_MODE_BIT,
@@ -315,6 +320,7 @@ enum {
 enum {
 	EVENT_FILE_FL_ENABLED		= (1 << EVENT_FILE_FL_ENABLED_BIT),
 	EVENT_FILE_FL_RECORDED_CMD	= (1 << EVENT_FILE_FL_RECORDED_CMD_BIT),
+	EVENT_FILE_FL_RECORDED_TGID	= (1 << EVENT_FILE_FL_RECORDED_TGID_BIT),
 	EVENT_FILE_FL_FILTERED		= (1 << EVENT_FILE_FL_FILTERED_BIT),
 	EVENT_FILE_FL_NO_SET_FILTER	= (1 << EVENT_FILE_FL_NO_SET_FILTER_BIT),
 	EVENT_FILE_FL_SOFT_MODE		= (1 << EVENT_FILE_FL_SOFT_MODE_BIT),
@@ -463,7 +469,7 @@ int trace_set_clr_event(const char *system, const char *event, int set);
 #define event_trace_printk(ip, fmt, args...)				\
 do {									\
 	__trace_printk_check_format(fmt, ##args);			\
-	tracing_record_cmdline(current);				\
+	tracing_record_taskinfo_single(current, true, false);		\
 	if (__builtin_constant_p(fmt)) {				\
 		static const char *trace_printk_fmt			\
 		  __attribute__((section("__trace_printk_fmt"))) =	\
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 193c5f5e3f79..d7394cdf899e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -236,7 +236,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	cpu = raw_smp_processor_id();
 
 	if (blk_tracer) {
-		tracing_record_cmdline(current);
+		tracing_record_taskinfo_single(current, true, false);
 
 		buffer = blk_tr->trace_buffer.buffer;
 		pc = preempt_count();
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 63deff9cdf2c..7be21ae4f0a8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -87,7 +87,7 @@ dummy_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
  * tracing is active, only save the comm when a trace event
  * occurred.
  */
-static DEFINE_PER_CPU(bool, trace_cmdline_save);
+static DEFINE_PER_CPU(bool, trace_taskinfo_save);
 
 /*
  * Kill all tracing for good (never come back).
@@ -790,7 +790,7 @@ EXPORT_SYMBOL_GPL(tracing_on);
 static __always_inline void
 __buffer_unlock_commit(struct ring_buffer *buffer, struct ring_buffer_event *event)
 {
-	__this_cpu_write(trace_cmdline_save, true);
+	__this_cpu_write(trace_taskinfo_save, true);
 
 	/* If this is the temp buffer, we need to commit fully */
 	if (this_cpu_read(trace_buffered_event) == event) {
@@ -1709,6 +1709,15 @@ void tracing_reset_all_online_cpus(void)
 	}
 }
 
+static unsigned int *tgid_map;
+
+void tracing_alloc_tgid_map(void)
+{
+	tgid_map = kzalloc((PID_MAX_DEFAULT + 1) * sizeof(*tgid_map),
+			   GFP_KERNEL);
+	WARN_ONCE(!tgid_map, "Allocation of tgid_map failed\n");
+}
+
 #define SAVED_CMDLINES_DEFAULT 128
 #define NO_CMDLINE_MAP UINT_MAX
 static arch_spinlock_t trace_cmdline_lock = __ARCH_SPIN_LOCK_UNLOCKED;
@@ -1722,7 +1731,7 @@ struct saved_cmdlines_buffer {
 static struct saved_cmdlines_buffer *savedcmd;
 
 /* temporary disable recording */
-static atomic_t trace_record_cmdline_disabled __read_mostly;
+static atomic_t trace_record_taskinfo_disabled __read_mostly;
 
 static inline char *get_saved_cmdlines(int idx)
 {
@@ -1990,16 +1999,55 @@ void trace_find_cmdline(int pid, char comm[])
 	preempt_enable();
 }
 
-void tracing_record_cmdline(struct task_struct *tsk)
+unsigned int trace_find_tgid(unsigned int pid)
+{
+	if (!tgid_map || !pid || unlikely(pid > PID_MAX_DEFAULT))
+		return 0;
+
+	return tgid_map[pid];
+}
+
+static int trace_save_tgid(struct task_struct *tsk)
+{
+	if (!tgid_map || !tsk->pid || unlikely(tsk->pid > PID_MAX_DEFAULT))
+		return 0;
+
+	tgid_map[tsk->pid] = tsk->tgid;
+	return 1;
+}
+
+void tracing_record_taskinfo(struct task_struct **tasks, int len,
+			     bool cmdline, bool tgid)
 {
-	if (atomic_read(&trace_record_cmdline_disabled) || !tracing_is_on())
+	int i;
+
+	if (unlikely(!cmdline && !tgid))
 		return;
 
-	if (!__this_cpu_read(trace_cmdline_save))
+	if (atomic_read(&trace_record_taskinfo_disabled) || !tracing_is_on())
 		return;
 
-	if (trace_save_cmdline(tsk))
-		__this_cpu_write(trace_cmdline_save, false);
+	if (!__this_cpu_read(trace_taskinfo_save))
+		return;
+
+	for (i = 0; i < len; i++) {
+		if (cmdline && !trace_save_cmdline(tasks[i]))
+			break;
+		if (tgid && !trace_save_tgid(tasks[i]))
+			break;
+	}
+
+	if (i == len)
+		__this_cpu_write(trace_taskinfo_save, false);
+}
+
+void tracing_record_taskinfo_single(struct task_struct *task,
+				    bool cmd, bool tgid)
+{
+	struct task_struct *tasks[1];
+
+	tasks[0] = task;
+	return tracing_record_taskinfo(tasks, 1, cmd, tgid);
 }
 
 /*
@@ -2761,7 +2809,7 @@ void trace_printk_init_buffers(void)
 	 * allocated here, then this was called by module code.
 	 */
 	if (global_trace.trace_buffer.buffer)
-		tracing_start_cmdline_record();
+		tracing_start_taskinfo_record(true, false);
 }
 
 void trace_printk_start_comm(void)
@@ -2769,7 +2817,7 @@ void trace_printk_start_comm(void)
 	/* Start tracing comms if trace printk is set */
 	if (!buffers_allocated)
 		return;
-	tracing_start_cmdline_record();
+	tracing_start_taskinfo_record(true, false);
 }
 
 static void trace_printk_start_stop_comm(int enabled)
@@ -2778,9 +2826,9 @@ static void trace_printk_start_stop_comm(int enabled)
 		return;
 
 	if (enabled)
-		tracing_start_cmdline_record();
+		tracing_start_taskinfo_record(true, false);
 	else
-		tracing_stop_cmdline_record();
+		tracing_stop_taskinfo_record(true, false);
 }
 
 /**
@@ -3144,7 +3192,7 @@ static void *s_start(struct seq_file *m, loff_t *pos)
 #endif
 
 	if (!iter->snapshot)
-		atomic_inc(&trace_record_cmdline_disabled);
+		atomic_inc(&trace_record_taskinfo_disabled);
 
 	if (*pos != iter->pos) {
 		iter->ent = NULL;
@@ -3189,7 +3237,7 @@ static void s_stop(struct seq_file *m, void *p)
 #endif
 
 	if (!iter->snapshot)
-		atomic_dec(&trace_record_cmdline_disabled);
+		atomic_dec(&trace_record_taskinfo_disabled);
 
 	trace_access_unlock(iter->cpu_file);
 	trace_event_read_unlock();
@@ -4236,6 +4284,9 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 	if (mask == TRACE_ITER_RECORD_CMD)
 		trace_event_enable_cmd_record(enabled);
 
+	if (mask == TRACE_ITER_RECORD_TGID)
+		trace_event_enable_tgid_record(enabled);
+
 	if (mask == TRACE_ITER_EVENT_FORK)
 		trace_event_follow_fork(tr, enabled);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 39fd77330aab..17a66d459ee3 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -635,8 +635,9 @@ void trace_graph_return(struct ftrace_graph_ret *trace);
 int trace_graph_entry(struct ftrace_graph_ent *trace);
 void set_graph_array(struct trace_array *tr);
 
-void tracing_start_cmdline_record(void);
-void tracing_stop_cmdline_record(void);
+void tracing_alloc_tgid_map(void);
+void tracing_start_taskinfo_record(bool cmd, bool tgid);
+void tracing_stop_taskinfo_record(bool cmd, bool tgid);
 int register_tracer(struct tracer *type);
 int is_tracing_stopped(void);
 
@@ -697,6 +698,7 @@ static inline void __trace_stack(struct trace_array *tr, unsigned long flags,
 extern u64 ftrace_now(int cpu);
 
 extern void trace_find_cmdline(int pid, char comm[]);
+extern unsigned int trace_find_tgid(unsigned int pid);
 extern void trace_event_follow_fork(struct trace_array *tr, bool enable);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -1107,6 +1109,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(CONTEXT_INFO,		"context-info"),   /* Print pid/cpu/time */ \
 		C(LATENCY_FMT,		"latency-format"),	\
 		C(RECORD_CMD,		"record-cmd"),		\
+		C(RECORD_TGID,		"record-tgid"),		\
 		C(OVERWRITE,		"overwrite"),		\
 		C(STOP_ON_FREE,		"disable_on_free"),	\
 		C(IRQ_INFO,		"irq-info"),		\
@@ -1423,6 +1426,8 @@ struct ftrace_event_field *
 trace_find_event_field(struct trace_event_call *call, char *name);
 
 extern void trace_event_enable_cmd_record(bool enable);
+extern void trace_event_enable_tgid_record(bool enable);
+
 extern int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr);
 extern int event_trace_del_tracer(struct trace_array *tr);
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e7973e10398c..c71d6223e667 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -321,6 +321,16 @@ int trace_event_reg(struct trace_event_call *call,
 }
 EXPORT_SYMBOL_GPL(trace_event_reg);
 
+static bool trace_event_file_cmd_record(struct trace_event_file *file)
+{
+	return !!(file->flags & EVENT_FILE_FL_RECORDED_CMD);
+}
+
+static bool trace_event_file_tgid_record(struct trace_event_file *file)
+{
+	return !!(file->flags & EVENT_FILE_FL_RECORDED_TGID);
+}
+
 void trace_event_enable_cmd_record(bool enable)
 {
 	struct trace_event_file *file;
@@ -328,21 +338,54 @@ void trace_event_enable_cmd_record(bool enable)
 
 	mutex_lock(&event_mutex);
 	do_for_each_event_file(tr, file) {
+		bool cmd_record = trace_event_file_cmd_record(file);
 
 		if (!(file->flags & EVENT_FILE_FL_ENABLED))
 			continue;
 
 		if (enable) {
-			tracing_start_cmdline_record();
+			if (cmd_record)
+				continue;
+			tracing_start_taskinfo_record(true, false);
 			set_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
 		} else {
-			tracing_stop_cmdline_record();
+			if (!cmd_record)
+				continue;
+			tracing_stop_taskinfo_record(true, false);
 			clear_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
 		}
 	} while_for_each_event_file();
 	mutex_unlock(&event_mutex);
 }
 
+void trace_event_enable_tgid_record(bool enable)
+{
+	struct trace_event_file *file;
+	struct trace_array *tr;
+
+	mutex_lock(&event_mutex);
+	do_for_each_event_file(tr, file) {
+		bool tgid_record = trace_event_file_tgid_record(file);
+
+		if (!(file->flags & EVENT_FILE_FL_ENABLED))
+			continue;
+
+		if (enable) {
+			if (tgid_record)
+				continue;
+			tracing_start_taskinfo_record(false, true);
+			set_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
+		} else {
+			if (!tgid_record)
+				continue;
+			tracing_stop_taskinfo_record(false, true);
+			clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT,
+				  &file->flags);
+		}
+	} while_for_each_event_file();
+	mutex_unlock(&event_mutex);
+}
+
 static int __ftrace_event_enable_disable(struct trace_event_file *file,
 					 int enable, int soft_disable)
 {
@@ -351,6 +394,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 	unsigned long file_flags = file->flags;
 	int ret = 0;
 	int disable;
+	bool cmd_record, tgid_record;
 
 	switch (enable) {
 	case 0:
@@ -377,10 +421,18 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 
 		if (disable && (file->flags & EVENT_FILE_FL_ENABLED)) {
 			clear_bit(EVENT_FILE_FL_ENABLED_BIT, &file->flags);
-			if (file->flags & EVENT_FILE_FL_RECORDED_CMD) {
-				tracing_stop_cmdline_record();
-				clear_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
-			}
+
+			cmd_record = trace_event_file_cmd_record(file);
+			tgid_record = trace_event_file_tgid_record(file);
+
+			tracing_stop_taskinfo_record(cmd_record, tgid_record);
+			if (cmd_record)
+				clear_bit(EVENT_FILE_FL_RECORDED_CMD_BIT,
+					  &file->flags);
+			if (tgid_record)
+				clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT,
+					  &file->flags);
+
 			call->class->reg(call, TRACE_REG_UNREGISTER, file);
 		}
 		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
@@ -407,18 +459,25 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		}
 
 		if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
-
 			/* Keep the event disabled, when going to SOFT_MODE. */
 			if (soft_disable)
 				set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
 
-			if (tr->trace_flags & TRACE_ITER_RECORD_CMD) {
-				tracing_start_cmdline_record();
-				set_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
-			}
+			cmd_record = tr->trace_flags & TRACE_ITER_RECORD_CMD;
+			tgid_record = tr->trace_flags & TRACE_ITER_RECORD_TGID;
+
+			tracing_start_taskinfo_record(cmd_record, tgid_record);
+			if (cmd_record)
+				set_bit(EVENT_FILE_FL_RECORDED_CMD_BIT,
+					&file->flags);
+			if (tgid_record)
+				set_bit(EVENT_FILE_FL_RECORDED_TGID_BIT,
+					&file->flags);
+
 			ret = call->class->reg(call, TRACE_REG_REGISTER, file);
 			if (ret) {
-				tracing_stop_cmdline_record();
+				tracing_stop_taskinfo_record(cmd_record,
+							     tgid_record);
 				pr_info("event trace: Could not enable event "
 					"%s\n", trace_event_name(call));
 				break;
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index a3bddbfd0874..05da1e7513f6 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -103,7 +103,8 @@ static int function_trace_init(struct trace_array *tr)
 	tr->trace_buffer.cpu = get_cpu();
 	put_cpu();
 
-	tracing_start_cmdline_record();
+	tracing_start_taskinfo_record(true, false);
+
 	tracing_start_function_trace(tr);
 	return 0;
 }
@@ -111,7 +112,7 @@ static int function_trace_init(struct trace_array *tr)
 static void function_trace_reset(struct trace_array *tr)
 {
 	tracing_stop_function_trace(tr);
-	tracing_stop_cmdline_record();
+	tracing_stop_taskinfo_record(true, false);
 	ftrace_reset_array_ops(tr);
 }
 
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index d56123cdcc89..3691198b4778 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -524,14 +524,14 @@ static int graph_trace_init(struct trace_array *tr)
 					    &trace_graph_entry);
 	if (ret)
 		return ret;
-	tracing_start_cmdline_record();
+	tracing_start_taskinfo_record(true, false);
 
 	return 0;
 }
 
 static void graph_trace_reset(struct trace_array *tr)
 {
-	tracing_stop_cmdline_record();
+	tracing_stop_taskinfo_record(true, false);
 	unregister_ftrace_graph();
 }
 
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index 4c896a0101bd..8f61897fd6e3 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -12,27 +12,30 @@
 
 #include "trace.h"
 
-static int			sched_ref;
+static int		sched_cmdline_ref;
+static int		sched_tgid_ref;
 static DEFINE_MUTEX(sched_register_mutex);
 
+#define RECORD_CMD	BIT(0)
+#define RECORD_TGID	BIT(1)
+
 static void
 probe_sched_switch(void *ignore, bool preempt,
 		   struct task_struct *prev, struct task_struct *next)
 {
-	if (unlikely(!sched_ref))
-		return;
+	struct task_struct *tasks[2] = { prev, next };
 
-	tracing_record_cmdline(prev);
-	tracing_record_cmdline(next);
+	tracing_record_taskinfo(tasks, 2,
+				(sched_cmdline_ref != 0),
+				(sched_tgid_ref != 0));
 }
 
 static void
 probe_sched_wakeup(void *ignore, struct task_struct *wakee)
 {
-	if (unlikely(!sched_ref))
-		return;
-
-	tracing_record_cmdline(current);
+	tracing_record_taskinfo_single(current,
+				       (sched_cmdline_ref != 0),
+				       (sched_tgid_ref != 0));
 }
 
 static int tracing_sched_register(void)
@@ -75,28 +78,58 @@ static void tracing_sched_unregister(void)
 	unregister_trace_sched_wakeup(probe_sched_wakeup, NULL);
 }
 
-static void tracing_start_sched_switch(void)
+static void tracing_start_sched_switch(int flags)
 {
+	bool sched_register;
 	mutex_lock(&sched_register_mutex);
-	if (!(sched_ref++))
+	sched_register = (!sched_cmdline_ref && !sched_tgid_ref);
+
+	if (flags & RECORD_CMD)
+		sched_cmdline_ref++;
+
+	if (flags & RECORD_TGID)
+		sched_tgid_ref++;
+
+	if (sched_tgid_ref == 1)
+		tracing_alloc_tgid_map();
+
+	if (sched_register && (sched_cmdline_ref || sched_tgid_ref))
 		tracing_sched_register();
 	mutex_unlock(&sched_register_mutex);
 }
 
-static void tracing_stop_sched_switch(void)
+static void tracing_stop_sched_switch(int flags)
 {
 	mutex_lock(&sched_register_mutex);
-	if (!(--sched_ref))
+	if (flags & RECORD_CMD)
+		sched_cmdline_ref--;
+
+	if (flags & RECORD_TGID)
+		sched_tgid_ref--;
+
+	if (!sched_cmdline_ref && !sched_tgid_ref)
 		tracing_sched_unregister();
 	mutex_unlock(&sched_register_mutex);
 }
 
-void tracing_start_cmdline_record(void)
+void tracing_start_taskinfo_record(bool cmdline, bool tgid)
 {
-	tracing_start_sched_switch();
+	int flags;
+
+	if (!cmdline && !tgid)
+		return;
+	flags  = (tgid ? RECORD_TGID : 0);
+	flags |= (cmdline ? RECORD_CMD : 0);
+	tracing_start_sched_switch(flags);
 }
 
-void tracing_stop_cmdline_record(void)
+void tracing_stop_taskinfo_record(bool cmdline, bool tgid)
 {
-	tracing_stop_sched_switch();
+	int flags;
+
+	if (!cmdline && !tgid)
+		return;
+	flags  = (tgid ? RECORD_TGID : 0);
+	flags |= (cmdline ? RECORD_CMD : 0);
+	tracing_stop_sched_switch(flags);
 }
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index cb917cebae29..83029d94d643 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -770,7 +770,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 		warn_failed_init_tracer(trace, ret);
 		goto out;
 	}
-	tracing_start_cmdline_record();
+	tracing_start_taskinfo_record(true, false);
 
 	/* Sleep for a 1/10 of a second */
 	msleep(100);
-- 
2.13.0.506.g27d5fe0cd-goog
