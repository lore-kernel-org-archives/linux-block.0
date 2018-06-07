Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: snitzer@redhat.com,
	kent.overstreet@gmail.com,
	liwang@redhat.com,
	vrbagal1@linux.vnet.ibm.com,
	chuhu.ncepu@gmail.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] dm: use bioset_init_from_src() to copy bio_set
Date: Thu,  7 Jun 2018 14:45:41 -0600
Message-Id: <20180607204541.13491-3-axboe@kernel.dk>
In-Reply-To: <20180607204541.13491-1-axboe@kernel.dk>
References: <20180607204541.13491-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We can't just copy and clear a bio_set, use the bio helper to
setup a new bio_set with the settings from another one.

Fixes: 6f1c819c219f ("dm: convert to bioset_init()/mempool_init()")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/md/dm.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 98dff36b89a3..20a8d63754bf 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1953,9 +1953,10 @@ static void free_dev(struct mapped_device *md)
 	kvfree(md);
 }
 
-static void __bind_mempools(struct mapped_device *md, struct dm_table *t)
+static int __bind_mempools(struct mapped_device *md, struct dm_table *t)
 {
 	struct dm_md_mempools *p = dm_table_get_md_mempools(t);
+	int ret = 0;
 
 	if (dm_table_bio_based(t)) {
 		/*
@@ -1982,13 +1983,16 @@ static void __bind_mempools(struct mapped_device *md, struct dm_table *t)
 	       bioset_initialized(&md->bs) ||
 	       bioset_initialized(&md->io_bs));
 
-	md->bs = p->bs;
-	memset(&p->bs, 0, sizeof(p->bs));
-	md->io_bs = p->io_bs;
-	memset(&p->io_bs, 0, sizeof(p->io_bs));
+	ret = bioset_init_from_src(&md->bs, &p->bs);
+	if (ret)
+		goto out;
+	ret = bioset_init_from_src(&md->io_bs, &p->io_bs);
+	if (ret)
+		bioset_exit(&md->bs);
 out:
 	/* mempool bind completed, no longer need any mempools in the table */
 	dm_table_free_md_mempools(t);
+	return ret;
 }
 
 /*
@@ -2033,6 +2037,7 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 	struct request_queue *q = md->queue;
 	bool request_based = dm_table_request_based(t);
 	sector_t size;
+	int ret;
 
 	lockdep_assert_held(&md->suspend_lock);
 
@@ -2068,7 +2073,11 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 		md->immutable_target = dm_table_get_immutable_target(t);
 	}
 
-	__bind_mempools(md, t);
+	ret = __bind_mempools(md, t);
+	if (ret) {
+		old_map = ERR_PTR(ret);
+		goto out;
+	}
 
 	old_map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
 	rcu_assign_pointer(md->map, (void *)t);
@@ -2078,6 +2087,7 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 	if (old_map)
 		dm_sync_table(md);
 
+out:
 	return old_map;
 }
 
-- 
2.17.1
