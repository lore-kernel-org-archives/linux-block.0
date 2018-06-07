Return-Path: <axboe@kernel.dk>
Subject: Re: Block IO issue in kernel-v4.17
From: Jens Axboe <axboe@kernel.dk>
To: Chunyu Hu <chuhu.ncepu@gmail.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, Li Wang <liwang@redhat.com>,
 Coly Li <colyli@suse.de>, hch@lst.de, darrick.wong@oracle.com,
 snitzer@redhat.com, linux-block@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <CAEemH2fbPv2wphVBHxSSS+KEK5S-rercXhvgLJ7YMOZnrTpexg@mail.gmail.com>
 <20180606084105.GA10720@kmo-pixel>
 <015f6160-216a-31ba-e251-11336e7ff5d6@kernel.dk>
 <CABATaM7FHcXF7rO5kuMVFRFKFqhqnkoJ_t4w-y4=mNx42=b3Cg@mail.gmail.com>
 <39e797fa-b24c-d122-c06b-196ba2a2d395@kernel.dk>
Message-ID: <75ca49d6-0a09-20d5-20c9-dac77604fdd4@kernel.dk>
Date: Thu, 7 Jun 2018 09:41:10 -0600
MIME-Version: 1.0
In-Reply-To: <39e797fa-b24c-d122-c06b-196ba2a2d395@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/7/18 8:46 AM, Jens Axboe wrote:
> On 6/7/18 12:33 AM, Chunyu Hu wrote:
>> kasan reported a user-after-free. I'm using a kvm machine, it panic
>> during boot. I'm using the latest linux tree. which contains below.
>>
>> commit d377535405686f735b90a8ad4ba269484cd7c96e
>> Author: Kent Overstreet <kent.overstreet@gmail.com>
>> Date:   Tue Jun 5 05:26:33 2018 -0400
>>
>>     dm: Use kzalloc for all structs with embedded biosets/mempools
> 
> Can you try with the below? Li Wang, would be great if you could too.

Please try this one instead.
 

diff --git a/block/bio.c b/block/bio.c
index 595663e0281a..0616d86b15c6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1967,6 +1967,21 @@ int bioset_init(struct bio_set *bs,
 }
 EXPORT_SYMBOL(bioset_init);
 
+int bioset_init_from_src(struct bio_set *new, struct bio_set *src)
+{
+	unsigned int pool_size = src->bio_pool.min_nr;
+	int flags;
+
+	flags = 0;
+	if (src->bvec_pool.min_nr)
+		flags |= BIOSET_NEED_BVECS;
+	if (src->rescue_workqueue)
+		flags |= BIOSET_NEED_RESCUER;
+
+	return bioset_init(new, pool_size, src->front_pad, flags);
+}
+EXPORT_SYMBOL(bioset_init_from_src);
+
 #ifdef CONFIG_BLK_CGROUP
 
 /**
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
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 810a8bee8f85..307682ac2f31 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -417,6 +417,7 @@ enum {
 extern int bioset_init(struct bio_set *, unsigned int, unsigned int, int flags);
 extern void bioset_exit(struct bio_set *);
 extern int biovec_init_pool(mempool_t *pool, int pool_entries);
+extern int bioset_init_from_src(struct bio_set *new, struct bio_set *src);
 
 extern struct bio *bio_alloc_bioset(gfp_t, unsigned int, struct bio_set *);
 extern void bio_put(struct bio *);

-- 
Jens Axboe
