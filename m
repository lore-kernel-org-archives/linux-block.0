Return-Path: <ktkhai@virtuozzo.com>
Subject: [PATCH 5/5] blkcg: Add cgroup file to configure
 blkcg::blkg_aio_max_nr
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: axboe@kernel.dk, bcrl@kvack.org, viro@zeniv.linux.org.uk, tj@kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org,
 oleg@redhat.com, ktkhai@virtuozzo.com
Date: Mon, 04 Dec 2017 19:13:34 +0300
Message-ID: <151240401439.10164.661741658187634131.stgit@localhost.localdomain>
In-Reply-To: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-Path: ktkhai@virtuozzo.com
List-ID: <linux-block@vger.kernel.org>

Add a file to configure per-cgroup maximum number of available
aio requests.

Allow write the values, which are less then currently allocated
numbers of requests.

Show numbers of currently allocated and maximum available requests.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 block/blk-cgroup.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9cc6e9574946..dc5600ef4523 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -981,12 +981,52 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	return 0;
 }
 
+#ifdef CONFIG_AIO
+static int blkcg_write_aio_max_nr(struct cgroup_subsys_state *css,
+				  struct cftype *cftype, u64 val)
+{
+	struct blkcg *blkg = css_to_blkcg(css);
+	int ret = 0;
+
+	percpu_down_read(&cgroup_threadgroup_rwsem);
+	spin_lock(&aio_nr_lock);
+	if (val >= blkg->blkg_aio_nr)
+		blkg->blkg_aio_max_nr = val;
+	else
+		ret = -EBUSY;
+	spin_unlock(&aio_nr_lock);
+	percpu_up_read(&cgroup_threadgroup_rwsem);
+	return ret;
+}
+
+static int blkcg_show_aio_nrs(struct seq_file *sf, void *v)
+{
+	struct blkcg *blkg = css_to_blkcg(seq_css(sf));
+	unsigned long max_nr, nr;
+
+	spin_lock(&aio_nr_lock);
+	max_nr = blkg->blkg_aio_max_nr;
+	nr = blkg->blkg_aio_nr;
+	spin_unlock(&aio_nr_lock);
+
+	seq_printf(sf, "used=%lu, max=%lu\n", nr, max_nr);
+	return 0;
+}
+#endif /* CONFIG_AIO */
+
 static struct cftype blkcg_files[] = {
 	{
 		.name = "stat",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = blkcg_print_stat,
 	},
+#ifdef CONFIG_AIO
+	{
+		.name = "aio_nr",
+		.write_u64 = blkcg_write_aio_max_nr,
+		.seq_show = blkcg_show_aio_nrs,
+	},
+#endif
 	{ }	/* terminate */
 };
 
