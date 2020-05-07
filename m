Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D77EC38A2A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 08:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F28D2073A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 08:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="humgBGs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgEGIxJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 04:53:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47387 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgEGIxI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 04:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588841587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l87rumYo2p4hXTIKwj6Io6LLNxzbdxDBXUXIPwk5y/U=;
        b=humgBGs916rPp8MrtD4uaxAPIqR2F59IE2FJdF1iIjdBAIB9XLxBRA1TJbQgSmZ7apjc3c
        NZNxl8u7BiHWiBLxr/CjLA5FfkLSB+sWf3QzvrjdDhOduLX5DCrLGOD/01rtWEGTFbyDEv
        kKdiOC/ow+jRKLATseJ8gzz3+fKDBkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-iMLE8h2WOh6qt96SMKFYHQ-1; Thu, 07 May 2020 04:53:03 -0400
X-MC-Unique: iMLE8h2WOh6qt96SMKFYHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 217E180058A;
        Thu,  7 May 2020 08:53:02 +0000 (UTC)
Received: from localhost (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FE9160CCC;
        Thu,  7 May 2020 08:52:57 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH 2/4] block: only define 'nr_sects_seq' in hd_part for 32bit SMP
Date:   Thu,  7 May 2020 16:52:37 +0800
Message-Id: <20200507085239.1354854-3-ming.lei@redhat.com>
In-Reply-To: <20200507085239.1354854-1-ming.lei@redhat.com>
References: <20200507085239.1354854-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
 block/genhd.c           | 2 +-
 block/partitions/core.c | 2 +-
 include/linux/genhd.h   | 9 +++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8b33f0e54356..c0288b89a7ad 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1724,7 +1724,7 @@ struct gendisk *__alloc_disk_node(int minors, int n=
ode_id)
 		 * TODO: Ideally set_capacity() and get_capacity() should be
 		 * converted to make use of bd_mutex and sequence counters.
 		 */
-		seqcount_init(&disk->part0.nr_sects_seq);
+		hd_sects_seq_init(&disk->part0);
 		if (hd_ref_init(&disk->part0)) {
 			hd_free_part(&disk->part0);
 			kfree(disk);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b6cbc9b98426..efccb1be4c5c 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -391,7 +391,7 @@ static struct hd_struct *add_partition(struct gendisk=
 *disk, int partno,
 		goto out_free;
 	}
=20
-	seqcount_init(&p->nr_sects_seq);
+	hd_sects_seq_init(p);
 	pdev =3D part_to_dev(p);
=20
 	p->start_sect =3D start;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index c28d1d9bfa72..2732120751e8 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -68,7 +68,9 @@ struct hd_struct {
 	 * can be non-atomic on 32bit machines with 64bit sector_t.
 	 */
 	sector_t nr_sects;
+#if BITS_PER_LONG=3D=3D32 && defined(CONFIG_SMP)
 	seqcount_t nr_sects_seq;
+#endif
 	sector_t alignment_offset;
 	unsigned int discard_alignment;
 	struct device __dev;
@@ -275,6 +277,13 @@ static inline void disk_put_part(struct hd_struct *p=
art)
 		put_device(part_to_dev(part));
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
  * Smarter partition iterator without context limits.
  */
--=20
2.25.2

