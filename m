Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4CFC32771
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 06:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58B6206ED
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 06:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gywq3+Bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgAIGVi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:21:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60360 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbgAIGVi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jan 2020 01:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578550897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ew5IR1SLoji8W9+I8kKsPLUpLqL4mxiunsfZvG7bXYw=;
        b=Gywq3+BqISwtA88GGyLmXEDuIgeewxEGardfBHIJRopkmX4nEHaIqmjIo6TOzDGMn5rw8Z
        1FIAQKOtw3InYrJy43OjF6+/2EtxBbHeQ5xfUaMP8RlEe8lPgn0klL4L79gZ4hEPzyokDB
        OCAwFkqzTc12EnVJXO7ONmFjONtJtfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-HiamYrTgPZ2jFbvVMAl-AQ-1; Thu, 09 Jan 2020 01:21:33 -0500
X-MC-Unique: HiamYrTgPZ2jFbvVMAl-AQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C482477;
        Thu,  9 Jan 2020 06:21:32 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 858D6271AF;
        Thu,  9 Jan 2020 06:21:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH 2/4] block: only define 'nr_sects_seq' in hd_part for 32bit SMP
Date:   Thu,  9 Jan 2020 14:21:07 +0800
Message-Id: <20200109062109.2313-3-ming.lei@redhat.com>
In-Reply-To: <20200109062109.2313-1-ming.lei@redhat.com>
References: <20200109062109.2313-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The seqcount of 'nr_sects_seq' is only needed in case of 32bit SMP,
so define it just for 32bit SMP.

Cc: Yufen Yu <yuyufen@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hou Tao <houtao1@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c             | 2 +-
 block/partition-generic.c | 2 +-
 include/linux/genhd.h     | 9 +++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 6029c94510f0..bfc4148ec341 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1506,7 +1506,7 @@ struct gendisk *__alloc_disk_node(int minors, int n=
ode_id)
 		 * TODO: Ideally set_capacity() and get_capacity() should be
 		 * converted to make use of bd_mutex and sequence counters.
 		 */
-		seqcount_init(&disk->part0.nr_sects_seq);
+		hd_sects_seq_init(&disk->part0);
 		if (hd_ref_init(&disk->part0)) {
 			hd_free_part(&disk->part0);
 			kfree(disk);
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 1739f750dbf2..eb606c2c3d6c 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -345,7 +345,7 @@ struct hd_struct *add_partition(struct gendisk *disk,=
 int partno,
 		goto out_free;
 	}
=20
-	seqcount_init(&p->nr_sects_seq);
+	hd_sects_seq_init(p);
 	pdev =3D part_to_dev(p);
=20
 	p->start_sect =3D start;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 1b09cfe00aa3..5f5718ce5e86 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -113,7 +113,9 @@ struct hd_struct {
 	 * can be non-atomic on 32bit machines with 64bit sector_t.
 	 */
 	sector_t nr_sects;
+#if BITS_PER_LONG=3D=3D32 && defined(CONFIG_SMP)
 	seqcount_t nr_sects_seq;
+#endif
 	sector_t alignment_offset;
 	unsigned int discard_alignment;
 	struct device __dev;
@@ -713,6 +715,13 @@ static inline void hd_free_part(struct hd_struct *pa=
rt)
 	percpu_ref_exit(&part->ref);
 }
=20
+static inline void hd_sects_seq_init(struct hd_struct *p)
+{
+#if BITS_PER_LONG=3D=3D32 && defined(CONFIG_SMP)
+	seqcount_init(&p->nr_sects_seq);
+#endif
+}
+
 /*
  * Any access of part->nr_sects which is not protected by partition
  * bd_mutex or gendisk bdev bd_mutex, should be done using this
--=20
2.20.1

