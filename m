Return-Path: <SRS0=4w+H=2Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF58AC32767
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 15:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE062467D
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 15:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1qRXyx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgACPQf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jan 2020 10:16:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38716 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727646AbgACPQf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jan 2020 10:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578064593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9AsGilvyV2Z6OLaLu5sdX40vENM2j1K6Fw1EdozQSqQ=;
        b=g1qRXyx/XIoqwuO0FWeluZOjpDItSf8ebn9HpjJpdCiZ0KA3/h1CO9X8AqoX6c/46Jj/pR
        M7aG/BMMvWV9TLmLFZRsWr4avTbpHlu8Wus7CdIRQ8bpjLVHlbN6JnpgWsIx/DgyzhPQdp
        5OgnuEnXjymjmCyNUPGB2iTN7/Cr190=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-cFVocyjxNzOMNP7ZnLdykA-1; Fri, 03 Jan 2020 10:16:32 -0500
X-MC-Unique: cFVocyjxNzOMNP7ZnLdykA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8565B800D41;
        Fri,  3 Jan 2020 15:16:30 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 881D77BA26;
        Fri,  3 Jan 2020 15:16:20 +0000 (UTC)
Date:   Fri, 3 Jan 2020 23:16:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Hou Tao <houtao1@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, hch@lst.de, zhengchuan@huawei.com,
        yi.zhang@huawei.com, paulmck@kernel.org, joel@joelfernandes.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] block: make sure last_lookup set as NULL after part
 deleted
Message-ID: <20200103151616.GA23308@ming.t460p>
References: <20191231110945.10857-1-yuyufen@huawei.com>
 <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
 <20200102012314.GB16719@ming.t460p>
 <c12da8ca-be66-496b-efb2-a60ceaf9ce54@huawei.com>
 <20200103041805.GA29924@ming.t460p>
 <ea362a86-d2de-7dfe-c826-d59e8b5068c3@huawei.com>
 <20200103081745.GA11275@ming.t460p>
 <82c10514-aec5-0d7c-118f-32c261015c6a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82c10514-aec5-0d7c-118f-32c261015c6a@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Yufen,

On Fri, Jan 03, 2020 at 08:03:54PM +0800, Yufen Yu wrote:
> Hi, Ming
> 
> On 2020/1/3 16:17, Ming Lei wrote:
> > 
> > We may avoid that by clearing partition pointer after killing the
> > partition, how about the following change?
> > 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 089e890ab208..79599f5fd5b7 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -1365,18 +1365,6 @@ void blk_account_io_start(struct request *rq, bool new_io)
> >   		part_stat_inc(part, merges[rw]);
> >   	} else {
> >   		part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
> > -		if (!hd_struct_try_get(part)) {
> > -			/*
> > -			 * The partition is already being removed,
> > -			 * the request will be accounted on the disk only
> > -			 *
> > -			 * We take a reference on disk->part0 although that
> > -			 * partition will never be deleted, so we can treat
> > -			 * it as any other partition.
> > -			 */
> > -			part = &rq->rq_disk->part0;
> > -			hd_struct_get(part);
> > -		}
> >   		part_inc_in_flight(rq->q, part, rw);
> >   		rq->part = part;
> >   	}
> > diff --git a/block/genhd.c b/block/genhd.c
> > index ff6268970ddc..e3dec90b1f43 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -286,17 +286,21 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
> >   	ptbl = rcu_dereference(disk->part_tbl);
> >   	part = rcu_dereference(ptbl->last_lookup);
> > -	if (part && sector_in_part(part, sector))
> > +	if (part && sector_in_part(part, sector) && hd_struct_try_get(part))
> >   		return part;
> >   	for (i = 1; i < ptbl->len; i++) {
> >   		part = rcu_dereference(ptbl->part[i]);
> >   		if (part && sector_in_part(part, sector)) {
> > +                       if (!hd_struct_try_get(part))
> > +                               goto exit;
> >   			rcu_assign_pointer(ptbl->last_lookup, part);
> >   			return part;
> >   		}
> >   	}
> > + exit:
> > +	hd_struct_get(&disk->part0);
> >   	return &disk->part0;
> >   }
> >   EXPORT_SYMBOL_GPL(disk_map_sector_rcu);
> > diff --git a/block/partition-generic.c b/block/partition-generic.c
> > index 1d20c9cf213f..9ef6c13d5650 100644
> > --- a/block/partition-generic.c
> > +++ b/block/partition-generic.c
> > @@ -283,8 +283,8 @@ void delete_partition(struct gendisk *disk, int partno)
> >   	if (!part)
> >   		return;
> > -	rcu_assign_pointer(ptbl->part[partno], NULL);
> > -	rcu_assign_pointer(ptbl->last_lookup, NULL);
> > +	get_device(disk_to_dev(disk));
> > +
> >   	kobject_put(part->holder_dir);
> >   	device_del(part_to_dev(part));
> > @@ -296,6 +296,15 @@ void delete_partition(struct gendisk *disk, int partno)
> >   	 */
> >   	blk_invalidate_devt(part_devt(part));
> >   	hd_struct_kill(part);
> > +
> > +	/*
> > +	 * clear partition pointers after this partition is killed, then
> > +	 * IO path can't re-assign ->last_lookup any more
> > +	 */
> > +	rcu_assign_pointer(ptbl->part[partno], NULL);
> > +	rcu_assign_pointer(ptbl->last_lookup, NULL);
> > +
> > +	put_device(disk_to_dev(disk));
> >   }
> 
> This change may cannot solve follow case:
> 
> disk_map_sector_rcu     delete_partition  disk_map_sector_rcu
> hd_struct_try_get(part)
>                         hd_struct_kill
>                         last_lookup = NULL;
> last_lookup = part
> 
> 
> call_rcu
>                                            read last_lookup
> 
> free()
>                                            //use-after-free
>                                            sector_in_part(part, sector)
> 
> There is an interval between getting part and setting last_lookup
> in disk_map_sector_rcu(). If we kill the part and clear last_lookup
> at that interval, last_lookup will be re-assign again, which can cause
> use-after-free for readers after call_rcu.

OK, we still can move clearing .last_lookup into __delete_partition(),
at that time all IO path can observe the partition percpu-refcount killed.

Also the rcu work fn is run after one RCU grace period, at that time,
the NULL .last_lookup becomes visible in all IO path too.

diff --git a/block/blk-core.c b/block/blk-core.c
index 089e890ab208..79599f5fd5b7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1365,18 +1365,6 @@ void blk_account_io_start(struct request *rq, bool new_io)
 		part_stat_inc(part, merges[rw]);
 	} else {
 		part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
-		if (!hd_struct_try_get(part)) {
-			/*
-			 * The partition is already being removed,
-			 * the request will be accounted on the disk only
-			 *
-			 * We take a reference on disk->part0 although that
-			 * partition will never be deleted, so we can treat
-			 * it as any other partition.
-			 */
-			part = &rq->rq_disk->part0;
-			hd_struct_get(part);
-		}
 		part_inc_in_flight(rq->q, part, rw);
 		rq->part = part;
 	}
diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..e3dec90b1f43 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -286,17 +286,21 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 	ptbl = rcu_dereference(disk->part_tbl);
 
 	part = rcu_dereference(ptbl->last_lookup);
-	if (part && sector_in_part(part, sector))
+	if (part && sector_in_part(part, sector) && hd_struct_try_get(part))
 		return part;
 
 	for (i = 1; i < ptbl->len; i++) {
 		part = rcu_dereference(ptbl->part[i]);
 
 		if (part && sector_in_part(part, sector)) {
+                       if (!hd_struct_try_get(part))
+                               goto exit;
 			rcu_assign_pointer(ptbl->last_lookup, part);
 			return part;
 		}
 	}
+ exit:
+	hd_struct_get(&disk->part0);
 	return &disk->part0;
 }
 EXPORT_SYMBOL_GPL(disk_map_sector_rcu);
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 1d20c9cf213f..1739f750dbf2 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -262,6 +262,12 @@ static void delete_partition_work_fn(struct work_struct *work)
 void __delete_partition(struct percpu_ref *ref)
 {
 	struct hd_struct *part = container_of(ref, struct hd_struct, ref);
+	struct disk_part_tbl *ptbl =
+		rcu_dereference_protected(part->disk->part_tbl, 1);
+
+	rcu_assign_pointer(ptbl->last_lookup, NULL);
+	put_device(disk_to_dev(part->disk));
+
 	INIT_RCU_WORK(&part->rcu_work, delete_partition_work_fn);
 	queue_rcu_work(system_wq, &part->rcu_work);
 }
@@ -283,8 +289,9 @@ void delete_partition(struct gendisk *disk, int partno)
 	if (!part)
 		return;
 
+	get_device(disk_to_dev(disk));
 	rcu_assign_pointer(ptbl->part[partno], NULL);
-	rcu_assign_pointer(ptbl->last_lookup, NULL);
+
 	kobject_put(part->holder_dir);
 	device_del(part_to_dev(part));
 
@@ -349,6 +356,7 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	p->nr_sects = len;
 	p->partno = partno;
 	p->policy = get_disk_ro(disk);
+	p->disk = disk;
 
 	if (info) {
 		struct partition_meta_info *pinfo = alloc_part_info(disk);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8bb63027e4d6..66660ec5e8ee 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -129,6 +129,7 @@ struct hd_struct {
 #else
 	struct disk_stats dkstats;
 #endif
+	struct gendisk *disk;
 	struct percpu_ref ref;
 	struct rcu_work rcu_work;
 };


Thanks,
Ming

