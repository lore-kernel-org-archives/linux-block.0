Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89CAC38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 08:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C9A208D6
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 08:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLD0U9Bb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgEHIS1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 04:18:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45904 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726746AbgEHIS1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 04:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588925905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/oaaQ4C9wcrt0h4NLM933HxrSlP7xIww0UEPzR3D7U=;
        b=JLD0U9Bbm0i3xJt8Kc+lh70BxFrIiTI3RyP1Oz3gwj3QlSFTwbA/EWivakyK6tupY+NOng
        t+GTr/WScu3JQIl6ZXKnOnvk6NNgGXgCV00hhB6yvc4hC9QylB76xIYoJp8yYeTKmkwXgD
        OAd48pYTd9/Kf+A01b9JSRCm9en6MB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-5xZj_AqjP5eUydR5Z-IWeA-1; Fri, 08 May 2020 04:18:24 -0400
X-MC-Unique: 5xZj_AqjP5eUydR5Z-IWeA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48A65473;
        Fri,  8 May 2020 08:18:23 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C210C5C1BE;
        Fri,  8 May 2020 08:18:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH V3 2/4] block: only define 'nr_sects_seq' in hd_part for 32bit SMP
Date:   Fri,  8 May 2020 16:17:56 +0800
Message-Id: <20200508081758.1380673-3-ming.lei@redhat.com>
In-Reply-To: <20200508081758.1380673-1-ming.lei@redhat.com>
References: <20200508081758.1380673-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The seqcount of 'nr_sects_seq' is only needed in case of 32bit SMP,
so define it just for 32bit SMP.

Cc: Yufen Yu <yuyufen@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hou Tao <houtao1@huawei.com>
Reviewed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c           | 2 +-
 block/partitions/core.c | 2 +-
 include/linux/genhd.h   | 9 +++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index ec57d5d7a64d..bf8cbb033d64 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1729,7 +1729,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 		 * TODO: Ideally set_capacity() and get_capacity() should be
 		 * converted to make use of bd_mutex and sequence counters.
 		 */
-		seqcount_init(&disk->part0.nr_sects_seq);
+		hd_sects_seq_init(&disk->part0);
 		if (hd_ref_init(&disk->part0)) {
 			hd_free_part(&disk->part0);
 			kfree(disk);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index f4000dac23ef..ec81986b358e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -392,7 +392,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 		goto out_free;
 	}
 
-	seqcount_init(&p->nr_sects_seq);
+	hd_sects_seq_init(p);
 	pdev = part_to_dev(p);
 
 	p->start_sect = start;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index f9c226f9546a..b4744035ae58 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -68,7 +68,9 @@ struct hd_struct {
 	 * can be non-atomic on 32bit machines with 64bit sector_t.
 	 */
 	sector_t nr_sects;
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
 	seqcount_t nr_sects_seq;
+#endif
 	sector_t alignment_offset;
 	unsigned int discard_alignment;
 	struct device __dev;
@@ -274,6 +276,13 @@ static inline void disk_put_part(struct hd_struct *part)
 		put_device(part_to_dev(part));
 }
 
+static inline void hd_sects_seq_init(struct hd_struct *p)
+{
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+	seqcount_init(&p->nr_sects_seq);
+#endif
+}
+
 /*
  * Smarter partition iterator without context limits.
  */
-- 
2.25.2

