Return-Path: <jthumshirn@suse.de>
Date: Mon, 2 Jul 2018 15:27:04 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: code clean-up by adding an API to clear
 set->mq_map
Message-ID: <20180702132704.3nwi4y6ex6fn5z67@linux-x5ow.site>
References: <1530375699-20461-1-git-send-email-minwoo.im.dev@gmail.com>
 <20180702081539.z5rj6wfh6v4zz6bv@linux-x5ow.site>
 <1530536157.13674.4.camel@gmail.com>
 <20180702130227.gjpblurxccjqechl@linux-x5ow.site>
 <1530537603.13674.8.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1530537603.13674.8.camel@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 02, 2018 at 10:20:03PM +0900, Minwoo Im wrote:
[...]
> > You could still evaluate if it isn't worth to make it:
> > +static void blk_mq_clear_mq_map(struct blk_mq_tag_set *set)
> > +{
> > +	int cpu;
> > +
> > +	for_each_possible_cpu(cpu)
> > +		set->mq_map[cpu] = 0;
> > +}
> > 
> > and put it into 'include/linux/blk-mq.h'.
> 
> Do you mean this whole bunch of function should be moved into blk-mq.h with
> 'inline' format?

yes

> I have already added this function prototype to blk-mq.h without 'static' to
> make blk-mq-pci.c to use it.

The function itself is pretty small and you use it in two different
files, so I'd make it an inline function in blk-mq.h, like this:

diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index e233996bb76f..ccb9d7e9adbd 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -48,8 +48,7 @@ int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev,
 
 fallback:
 	WARN_ON_ONCE(set->nr_hw_queues > 1);
-	for_each_possible_cpu(cpu)
-		set->mq_map[cpu] = 0;
+	blk_mq_clear_mq_map(set);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_mq_pci_map_queues);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 95919268564b..664c3817545b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2687,7 +2687,6 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 {
 	if (set->ops->map_queues) {
-		int cpu;
 		/*
 		 * transport .map_queues is usually done in the following
 		 * way:
@@ -2702,8 +2701,7 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 		 * killing stale mapping since one CPU may not be mapped
 		 * to any hw queue.
 		 */
-		for_each_possible_cpu(cpu)
-			set->mq_map[cpu] = 0;
+		blk_mq_clear_mq_map(set);
 
 		return set->ops->map_queues(set);
 	} else
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e3147eb74222..a8ac78faa2fc 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -237,6 +237,14 @@ enum {
 
 u32 blk_mq_unique_tag(struct request *rq);
 
+static inline void blk_mq_clear_mq_map(struct blk_mq_tag_set *set)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		set->mq_map[cpu] = 0;
+}
+
 static inline u16 blk_mq_unique_tag_to_hwq(u32 unique_tag)
 {
 	return unique_tag >> BLK_MQ_UNIQUE_TAG_BITS;


-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
