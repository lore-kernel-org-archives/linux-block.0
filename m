Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFBEC4724C
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 07:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECFB21655
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 07:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7j465h0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHHmQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 03:42:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48620 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726049AbgEHHmO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 03:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588923733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wCpmm0ryH5X+9WdYVTd1Qkb9ae4GnWNFPnWBVCJvKMs=;
        b=J7j465h0hGDmVq6h+DEXzzazz0+/WpAwP/U013VsaVyp4So601vB7zGjBAT6LNhrS2DN+i
        V1pgM7TOrB8DRBsqIsk6rDXj9uO4jFNH1jwpPEDm0skmO+OEw8j7a4g/X6KOQ+fqJlprr/
        Uxl3YebaO/F7GpB8alVDo7bfaO7Jq2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-n1yZfmLNMlKnjHdLNKn5yg-1; Fri, 08 May 2020 03:42:11 -0400
X-MC-Unique: n1yZfmLNMlKnjHdLNKn5yg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 373AB835B42;
        Fri,  8 May 2020 07:42:10 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E6E82B4DE;
        Fri,  8 May 2020 07:42:02 +0000 (UTC)
Date:   Fri, 8 May 2020 15:41:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yufen Yu <yuyufen@huawei.com>, Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH V2 4/4] block: don't hold part0's refcount in IO path
Message-ID: <20200508074157.GA1375901@T590>
References: <20200508044407.1371907-1-ming.lei@redhat.com>
 <20200508044407.1371907-5-ming.lei@redhat.com>
 <20200508064133.GA11136@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508064133.GA11136@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 07, 2020 at 11:41:33PM -0700, Christoph Hellwig wrote:
> On Fri, May 08, 2020 at 12:44:07PM +0800, Ming Lei wrote:
> > gendisk can't be gone when there is IO activity, so not hold
> > part0's refcount in IO path.
> > 
> > Cc: Yufen Yu <yuyufen@huawei.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Hou Tao <houtao1@huawei.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> This looks correct, although I'd still prefer to centralize the
> partno checks in the helpers.  Also hd_struct_get is unused with
> this patch isn't it?
 
OK, are you fine with the following patch?

diff --git a/block/blk.h b/block/blk.h
index 133fb0b99759..8efd1ca5c975 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -376,19 +376,18 @@ int bdev_resize_partition(struct block_device *bdev, int partno,
 int disk_expand_part_tbl(struct gendisk *disk, int target);
 int hd_ref_init(struct hd_struct *part);
 
-static inline void hd_struct_get(struct hd_struct *part)
-{
-	percpu_ref_get(&part->ref);
-}
-
+/* no need to get/put refcount of part0 */
 static inline int hd_struct_try_get(struct hd_struct *part)
 {
-	return percpu_ref_tryget_live(&part->ref);
+	if (part->partno)
+		return percpu_ref_tryget_live(&part->ref);
+	return 1;
 }
 
 static inline void hd_struct_put(struct hd_struct *part)
 {
-	percpu_ref_put(&part->ref);
+	if (part->partno)
+		percpu_ref_put(&part->ref);
 }
 
 static inline void hd_free_part(struct hd_struct *part)
diff --git a/block/genhd.c b/block/genhd.c
index bf8cbb033d64..d97b95d1a2fd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -345,7 +345,8 @@ static inline int sector_in_part(struct hd_struct *part, sector_t sector)
  *
  * CONTEXT:
  * RCU read locked.  The returned partition pointer is always valid
- * because its refcount is grabbed.
+ * because its refcount is grabbed except for part0, which lifetime
+ * is same with the disk.
  *
  * RETURNS:
  * Found partition on success, part0 is returned if no partition matches
@@ -378,7 +379,6 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 			return part;
 		}
 	}
-	hd_struct_get(&disk->part0);
 	return &disk->part0;
 }
 


Thanks,
Ming

