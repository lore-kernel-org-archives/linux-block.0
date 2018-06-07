Return-Path: <axboe@kernel.dk>
Subject: Re: Block IO issue in kernel-v4.17
To: Chunyu Hu <chuhu.ncepu@gmail.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, Li Wang <liwang@redhat.com>,
 Coly Li <colyli@suse.de>, hch@lst.de, darrick.wong@oracle.com,
 snitzer@redhat.com, linux-block@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <CAEemH2fbPv2wphVBHxSSS+KEK5S-rercXhvgLJ7YMOZnrTpexg@mail.gmail.com>
 <20180606084105.GA10720@kmo-pixel>
 <015f6160-216a-31ba-e251-11336e7ff5d6@kernel.dk>
 <CABATaM7FHcXF7rO5kuMVFRFKFqhqnkoJ_t4w-y4=mNx42=b3Cg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <39e797fa-b24c-d122-c06b-196ba2a2d395@kernel.dk>
Date: Thu, 7 Jun 2018 08:46:22 -0600
MIME-Version: 1.0
In-Reply-To: <CABATaM7FHcXF7rO5kuMVFRFKFqhqnkoJ_t4w-y4=mNx42=b3Cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/7/18 12:33 AM, Chunyu Hu wrote:
> kasan reported a user-after-free. I'm using a kvm machine, it panic
> during boot. I'm using the latest linux tree. which contains below.
> 
> commit d377535405686f735b90a8ad4ba269484cd7c96e
> Author: Kent Overstreet <kent.overstreet@gmail.com>
> Date:   Tue Jun 5 05:26:33 2018 -0400
> 
>     dm: Use kzalloc for all structs with embedded biosets/mempools

Can you try with the below? Li Wang, would be great if you could too.


diff --git a/block/bio.c b/block/bio.c
index 595663e0281a..45bdee67d28b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1967,6 +1967,27 @@ int bioset_init(struct bio_set *bs,
 }
 EXPORT_SYMBOL(bioset_init);
 
+void bioset_move(struct bio_set *dst, struct bio_set *src)
+{
+	dst->bio_slab = src->bio_slab;
+	dst->front_pad = src->front_pad;
+	mempool_move(&dst->bio_pool, &src->bio_pool);
+	mempool_move(&dst->bvec_pool, &src->bvec_pool);
+#if defined(CONFIG_BLK_DEV_INTEGRITY)
+	mempool_move(&dst->bio_integrity_pool, &src->bio_integrity_pool);
+	mempool_move(&dst->bvec_integrity_pool, &src->bvec_integrity_pool);
+#endif
+	BUG_ON(!bio_list_empty(&src->rescue_list));
+	BUG_ON(work_pending(&src->rescue_work));
+	spin_lock_init(&dst->rescue_lock);
+	bio_list_init(&dst->rescue_list);
+	INIT_WORK(&dst->rescue_work, bio_alloc_rescue);
+	dst->rescue_workqueue = src->rescue_workqueue;
+
+	memset(src, 0, sizeof(*src));
+}
+EXPORT_SYMBOL(bioset_move);
+
 #ifdef CONFIG_BLK_CGROUP
 
 /**
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 98dff36b89a3..87f636815baf 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1982,10 +1982,8 @@ static void __bind_mempools(struct mapped_device *md, struct dm_table *t)
 	       bioset_initialized(&md->bs) ||
 	       bioset_initialized(&md->io_bs));
 
-	md->bs = p->bs;
-	memset(&p->bs, 0, sizeof(p->bs));
-	md->io_bs = p->io_bs;
-	memset(&p->io_bs, 0, sizeof(p->io_bs));
+	bioset_move(&md->bs, &p->bs);
+	bioset_move(&md->io_bs, &p->io_bs);
 out:
 	/* mempool bind completed, no longer need any mempools in the table */
 	dm_table_free_md_mempools(t);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 810a8bee8f85..7581231dd0a3 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -417,6 +417,7 @@ enum {
 extern int bioset_init(struct bio_set *, unsigned int, unsigned int, int flags);
 extern void bioset_exit(struct bio_set *);
 extern int biovec_init_pool(mempool_t *pool, int pool_entries);
+extern void bioset_move(struct bio_set *dst, struct bio_set *src);
 
 extern struct bio *bio_alloc_bioset(gfp_t, unsigned int, struct bio_set *);
 extern void bio_put(struct bio *);
diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index 0c964ac107c2..20818919180c 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -47,6 +47,7 @@ extern int mempool_resize(mempool_t *pool, int new_min_nr);
 extern void mempool_destroy(mempool_t *pool);
 extern void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask) __malloc;
 extern void mempool_free(void *element, mempool_t *pool);
+extern void mempool_move(mempool_t *dst, mempool_t *src);
 
 /*
  * A mempool_alloc_t and mempool_free_t that get the memory from
diff --git a/mm/mempool.c b/mm/mempool.c
index b54f2c20e5e0..dd402653367b 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -181,6 +181,8 @@ int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 		      mempool_free_t *free_fn, void *pool_data,
 		      gfp_t gfp_mask, int node_id)
 {
+	memset(pool, 0, sizeof(*pool));
+
 	spin_lock_init(&pool->lock);
 	pool->min_nr	= min_nr;
 	pool->pool_data = pool_data;
@@ -546,3 +548,19 @@ void mempool_free_pages(void *element, void *pool_data)
 	__free_pages(element, order);
 }
 EXPORT_SYMBOL(mempool_free_pages);
+
+void mempool_move(mempool_t *dst, mempool_t *src)
+{
+	BUG_ON(waitqueue_active(&src->wait));
+
+	spin_lock_init(&dst->lock);
+	dst->min_nr = src->min_nr;
+	dst->curr_nr = src->curr_nr;
+	memcpy(dst->elements, src->elements, sizeof(void *) * src->curr_nr);
+	dst->pool_data = src->pool_data;
+	dst->alloc = src->alloc;
+	dst->free = src->free;
+	init_waitqueue_head(&dst->wait);
+
+	memset(src, 0, sizeof(*src));
+}

-- 
Jens Axboe
