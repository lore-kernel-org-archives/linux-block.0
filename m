Return-Path: <SRS0=4w+H=2Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8098C00523
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 08:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61CE21835
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 08:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiwjkqjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgACISK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:18:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20406 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726054AbgACISK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Jan 2020 03:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578039488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Pzczq1MemrN8Qun1c3a5FlGzlcFvE9MzD8Dtf48uPQ=;
        b=XiwjkqjLADxSr/pmu5q7FVBtd4FjYXZpKfIwStAjmgISSRV4q0Qg92Cx8OOa5t31+R4dOG
        KeBcWCYbCl9BQ8FNilANrFWkKmt44vXTWrj/xsaRs4aEJxauf9wFdgvCsqG2sUzc0dhwlw
        /53sg+G3RG7QUp3co6EDUBxk1YP0XrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-kQZd5XElNuiBiDU6RMSPvg-1; Fri, 03 Jan 2020 03:18:05 -0500
X-MC-Unique: kQZd5XElNuiBiDU6RMSPvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 246D9100551D;
        Fri,  3 Jan 2020 08:18:03 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F23B60BF1;
        Fri,  3 Jan 2020 08:17:50 +0000 (UTC)
Date:   Fri, 3 Jan 2020 16:17:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, hch@lst.de, zhengchuan@huawei.com,
        yi.zhang@huawei.com, paulmck@kernel.org, joel@joelfernandes.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] block: make sure last_lookup set as NULL after part
 deleted
Message-ID: <20200103081745.GA11275@ming.t460p>
References: <20191231110945.10857-1-yuyufen@huawei.com>
 <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
 <20200102012314.GB16719@ming.t460p>
 <c12da8ca-be66-496b-efb2-a60ceaf9ce54@huawei.com>
 <20200103041805.GA29924@ming.t460p>
 <ea362a86-d2de-7dfe-c826-d59e8b5068c3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea362a86-d2de-7dfe-c826-d59e8b5068c3@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 03, 2020 at 03:35:42PM +0800, Hou Tao wrote:
> Hi,
> 
> On 2020/1/3 12:18, Ming Lei wrote:
> > On Fri, Jan 03, 2020 at 11:06:25AM +0800, Hou Tao wrote:
> >> Hi,
> >>
> >> On 2020/1/2 9:23, Ming Lei wrote:
> >>> On Tue, Dec 31, 2019 at 10:55:47PM +0800, Hou Tao wrote:
> >>>> Hi,
> >>>>
> snip
> 
> >> We have got a seemingly better solution: caching the index of last_lookup in tbl->part[]
> >> instead of caching the pointer itself, so we can ensure the validity of returned pointer
> >> by ensuring it's not NULL in tbl->part[] as does when last_lookup is NULL or 0.
> > 
> > Thinking of the problem further, looks we don't need to hold ref for
> > .last_lookup.
> > 
> > What we need is to make sure the partition's ref is increased just
> > before assigning .last_lookup, so how about something like the following?
> > 
> The approach will work for the above case, but it will not work for the following case:
> 
> when blk_account_io_done() releases the last ref-counter of last_lookup and calls call_rcu(),
> and then a RCU read gets the to-be-freed hd-struct.
> 
> blk_account_io_done
>   rcu_read_lock()
>   // the last ref of last_lookup
>   hd_struct_put()
>     call_rcu
> 
>                               rcu_read_lock
>                               read last_lookup
> 
>     free()
>                               // use-after-free ?
>                               hd_struct_try_get

We may avoid that by clearing partition pointer after killing the
partition, how about the following change?

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
index 1d20c9cf213f..9ef6c13d5650 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -283,8 +283,8 @@ void delete_partition(struct gendisk *disk, int partno)
 	if (!part)
 		return;
 
-	rcu_assign_pointer(ptbl->part[partno], NULL);
-	rcu_assign_pointer(ptbl->last_lookup, NULL);
+	get_device(disk_to_dev(disk));
+
 	kobject_put(part->holder_dir);
 	device_del(part_to_dev(part));
 
@@ -296,6 +296,15 @@ void delete_partition(struct gendisk *disk, int partno)
 	 */
 	blk_invalidate_devt(part_devt(part));
 	hd_struct_kill(part);
+
+	/*
+	 * clear partition pointers after this partition is killed, then
+	 * IO path can't re-assign ->last_lookup any more
+	 */
+	rcu_assign_pointer(ptbl->part[partno], NULL);
+	rcu_assign_pointer(ptbl->last_lookup, NULL);
+
+	put_device(disk_to_dev(disk));
 }
 
 static ssize_t whole_disk_show(struct device *dev,

Thanks,
Ming

