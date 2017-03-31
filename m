Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Omar Sandoval
	<osandov@fb.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH v4 1/2] blk-mq: Export queue state through
 /sys/kernel/debug/block/*/state
Date: Fri, 31 Mar 2017 23:23:13 +0000
Message-ID: <1D08B61A9CF0974AA09887BE32D889DA1310F4@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <20170330182127.24288-1-bart.vanassche@sandisk.com>
 <20170330182127.24288-2-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Make it possible to check whether or not a block layer queue has=0A=
been stopped. Make it possible to start and to run a blk-mq queue=0A=
from user space.=0A=
=0A=
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>=0A=
Cc: Omar Sandoval <osandov@fb.com>=0A=
Cc: Hannes Reinecke <hare@suse.com>=0A=
=0A=
---=0A=
=0A=
Changes compared to v3:=0A=
- Return -ENOENT for attempts to run or start a queue after it has reached =
the=0A=
  state "dead". This is needed to avoid a use-after-free and potentially a =
kernel=0A=
  crash.=0A=
=0A=
---=0A=
=0A=
 block/blk-mq-debugfs.c | 114 +++++++++++++++++++++++++++++++++++++++++++++=
++++=0A=
 1 file changed, 114 insertions(+)=0A=
=0A=
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c=0A=
index 4b3f962a9c7a..bd3afa4e1602 100644=0A=
--- a/block/blk-mq-debugfs.c=0A=
+++ b/block/blk-mq-debugfs.c=0A=
@@ -43,6 +43,117 @@ static int blk_mq_debugfs_seq_open(struct inode *inode,=
 struct file *file,=0A=
 	return ret;=0A=
 }=0A=
 =0A=
+static int blk_flags_show(struct seq_file *m, const unsigned long flags,=
=0A=
+			  const char *const *flag_name, int flag_name_count)=0A=
+{=0A=
+	bool sep =3D false;=0A=
+	int i;=0A=
+=0A=
+	for (i =3D 0; i < sizeof(flags) * BITS_PER_BYTE; i++) {=0A=
+		if (!(flags & BIT(i)))=0A=
+			continue;=0A=
+		if (sep)=0A=
+			seq_puts(m, " ");=0A=
+		sep =3D true;=0A=
+		if (i < flag_name_count && flag_name[i])=0A=
+			seq_puts(m, flag_name[i]);=0A=
+		else=0A=
+			seq_printf(m, "%d", i);=0A=
+	}=0A=
+	seq_puts(m, "\n");=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static const char *const blk_queue_flag_name[] =3D {=0A=
+	[QUEUE_FLAG_QUEUED]	 =3D "QUEUED",=0A=
+	[QUEUE_FLAG_STOPPED]	 =3D "STOPPED",=0A=
+	[QUEUE_FLAG_SYNCFULL]	 =3D "SYNCFULL",=0A=
+	[QUEUE_FLAG_ASYNCFULL]	 =3D "ASYNCFULL",=0A=
+	[QUEUE_FLAG_DYING]	 =3D "DYING",=0A=
+	[QUEUE_FLAG_BYPASS]	 =3D "BYPASS",=0A=
+	[QUEUE_FLAG_BIDI]	 =3D "BIDI",=0A=
+	[QUEUE_FLAG_NOMERGES]	 =3D "NOMERGES",=0A=
+	[QUEUE_FLAG_SAME_COMP]	 =3D "SAME_COMP",=0A=
+	[QUEUE_FLAG_FAIL_IO]	 =3D "FAIL_IO",=0A=
+	[QUEUE_FLAG_STACKABLE]	 =3D "STACKABLE",=0A=
+	[QUEUE_FLAG_NONROT]	 =3D "NONROT",=0A=
+	[QUEUE_FLAG_IO_STAT]	 =3D "IO_STAT",=0A=
+	[QUEUE_FLAG_DISCARD]	 =3D "DISCARD",=0A=
+	[QUEUE_FLAG_NOXMERGES]	 =3D "NOXMERGES",=0A=
+	[QUEUE_FLAG_ADD_RANDOM]	 =3D "ADD_RANDOM",=0A=
+	[QUEUE_FLAG_SECERASE]	 =3D "SECERASE",=0A=
+	[QUEUE_FLAG_SAME_FORCE]	 =3D "SAME_FORCE",=0A=
+	[QUEUE_FLAG_DEAD]	 =3D "DEAD",=0A=
+	[QUEUE_FLAG_INIT_DONE]	 =3D "INIT_DONE",=0A=
+	[QUEUE_FLAG_NO_SG_MERGE] =3D "NO_SG_MERGE",=0A=
+	[QUEUE_FLAG_POLL]	 =3D "POLL",=0A=
+	[QUEUE_FLAG_WC]		 =3D "WC",=0A=
+	[QUEUE_FLAG_FUA]	 =3D "FUA",=0A=
+	[QUEUE_FLAG_FLUSH_NQ]	 =3D "FLUSH_NQ",=0A=
+	[QUEUE_FLAG_DAX]	 =3D "DAX",=0A=
+	[QUEUE_FLAG_STATS]	 =3D "STATS",=0A=
+	[QUEUE_FLAG_POLL_STATS]	 =3D "POLL_STATS",=0A=
+	[QUEUE_FLAG_REGISTERED]	 =3D "REGISTERED",=0A=
+};=0A=
+=0A=
+static int blk_queue_flags_show(struct seq_file *m, void *v)=0A=
+{=0A=
+	struct request_queue *q =3D m->private;=0A=
+=0A=
+	blk_flags_show(m, q->queue_flags, blk_queue_flag_name,=0A=
+		       ARRAY_SIZE(blk_queue_flag_name));=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static ssize_t blk_queue_flags_store(struct file *file, const char __user =
*ubuf,=0A=
+				     size_t len, loff_t *offp)=0A=
+{=0A=
+	struct request_queue *q =3D file_inode(file)->i_private;=0A=
+	char op[16] =3D { }, *s;=0A=
+=0A=
+	/*=0A=
+	 * The debugfs attributes are removed after blk_cleanup_queue() has=0A=
+	 * called blk_mq_free_queue(). Return if QUEUE_FLAG_DEAD has been set=0A=
+	 * to avoid triggering a use-after-free.=0A=
+	 */=0A=
+	if (blk_queue_dead(q))=0A=
+		return -ENOENT;=0A=
+=0A=
+	len =3D min(len, sizeof(op) - 1);=0A=
+	if (copy_from_user(op, ubuf, len))=0A=
+		return -EFAULT;=0A=
+	s =3D op;=0A=
+	strsep(&s, " \t\n"); /* strip trailing whitespace */=0A=
+	if (strcmp(op, "run") =3D=3D 0) {=0A=
+		blk_mq_run_hw_queues(q, true);=0A=
+	} else if (strcmp(op, "start") =3D=3D 0) {=0A=
+		blk_mq_start_stopped_hw_queues(q, true);=0A=
+	} else {=0A=
+		pr_err("%s: unsupported operation %s. Use either 'run' or 'start'\n",=0A=
+		       __func__, op);=0A=
+		return -EINVAL;=0A=
+	}=0A=
+	return len;=0A=
+}=0A=
+=0A=
+static int blk_queue_flags_open(struct inode *inode, struct file *file)=0A=
+{=0A=
+	return single_open(file, blk_queue_flags_show, inode->i_private);=0A=
+}=0A=
+=0A=
+static const struct file_operations blk_queue_flags_fops =3D {=0A=
+	.open		=3D blk_queue_flags_open,=0A=
+	.read		=3D seq_read,=0A=
+	.llseek		=3D seq_lseek,=0A=
+	.release	=3D single_release,=0A=
+	.write		=3D blk_queue_flags_store,=0A=
+};=0A=
+=0A=
+static const struct blk_mq_debugfs_attr blk_queue_attrs[] =3D {=0A=
+	{"state", 0600, &blk_queue_flags_fops},=0A=
+	{},=0A=
+};=0A=
+=0A=
 static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)=0A=
 {=0A=
 	if (stat->nr_samples) {=0A=
@@ -735,6 +846,9 @@ int blk_mq_debugfs_register_hctxs(struct request_queue =
*q)=0A=
 	if (!q->debugfs_dir)=0A=
 		return -ENOENT;=0A=
 =0A=
+	if (!debugfs_create_files(q->debugfs_dir, q, blk_queue_attrs))=0A=
+		goto err;=0A=
+=0A=
 	q->mq_debugfs_dir =3D debugfs_create_dir("mq", q->debugfs_dir);=0A=
 	if (!q->mq_debugfs_dir)=0A=
 		goto err;=0A=
-- =0A=
2.12.0=0A=
=0A=
=0A=
