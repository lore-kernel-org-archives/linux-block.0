Return-Path: <SRS0=Yh1G=6Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD755C3A5A9
	for <linux-block@archiver.kernel.org>; Sat,  2 May 2020 23:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993E920721
	for <linux-block@archiver.kernel.org>; Sat,  2 May 2020 23:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpbsxdWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgEBXzd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 May 2020 19:55:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46399 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725798AbgEBXzd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 2 May 2020 19:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588463731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/fiNh3tZPJTEEjHU8so2xEDBf/sHFznv5Ifn+GeJ+6o=;
        b=bpbsxdWkB2jQhQiSYEysbC3ZGnkBa4ZreQUweMWbXnf5VnfQMcrobjOMAquXNQ0vQvM4Me
        MxosYpPURT5tt2O3FzqHcTnu+rk39LhlkdReHIw7vCdGJ20sAmRef4yIbHRGvNvJzWwRPm
        vwrxtC2cD5BGZEhtmwA4A78YhB++/Jw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-fi8XbbMrOayEmxPXHXAjgw-1; Sat, 02 May 2020 19:55:29 -0400
X-MC-Unique: fi8XbbMrOayEmxPXHXAjgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5347080058A;
        Sat,  2 May 2020 23:55:28 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 774D25D9CD;
        Sat,  2 May 2020 23:55:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH V9 02/11] block: add helper for copying request
Date:   Sun,  3 May 2020 07:54:45 +0800
Message-Id: <20200502235454.1118520-3-ming.lei@redhat.com>
In-Reply-To: <20200502235454.1118520-1-ming.lei@redhat.com>
References: <20200502235454.1118520-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one new helper of blk_rq_copy_request() to copy request, and the help=
er
will be used in this patch for re-submitting request, so make it as a blo=
ck
layer internal helper.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 31 ++++++++++++++++++-------------
 block/blk.h      |  2 ++
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1fe73051fec3..ec50d7e6be21 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1581,6 +1581,23 @@ void blk_rq_unprep_clone(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_rq_unprep_clone);
=20
+void blk_rq_copy_request(struct request *rq, struct request *rq_src)
+{
+	/* Copy attributes of the original request to the clone request. */
+	rq->__sector =3D blk_rq_pos(rq_src);
+	rq->__data_len =3D blk_rq_bytes(rq_src);
+	if (rq_src->rq_flags & RQF_SPECIAL_PAYLOAD) {
+		rq->rq_flags |=3D RQF_SPECIAL_PAYLOAD;
+		rq->special_vec =3D rq_src->special_vec;
+	}
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	rq->nr_integrity_segments =3D rq_src->nr_integrity_segments;
+#endif
+	rq->nr_phys_segments =3D rq_src->nr_phys_segments;
+	rq->ioprio =3D rq_src->ioprio;
+	rq->write_hint =3D rq_src->write_hint;
+}
+
 /**
  * blk_rq_prep_clone - Helper function to setup clone request
  * @rq: the request to be setup
@@ -1623,19 +1640,7 @@ int blk_rq_prep_clone(struct request *rq, struct r=
equest *rq_src,
 			rq->bio =3D rq->biotail =3D bio;
 	}
=20
-	/* Copy attributes of the original request to the clone request. */
-	rq->__sector =3D blk_rq_pos(rq_src);
-	rq->__data_len =3D blk_rq_bytes(rq_src);
-	if (rq_src->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		rq->rq_flags |=3D RQF_SPECIAL_PAYLOAD;
-		rq->special_vec =3D rq_src->special_vec;
-	}
-#ifdef CONFIG_BLK_DEV_INTEGRITY
-	rq->nr_integrity_segments =3D rq_src->nr_integrity_segments;
-#endif
-	rq->nr_phys_segments =3D rq_src->nr_phys_segments;
-	rq->ioprio =3D rq_src->ioprio;
-	rq->write_hint =3D rq_src->write_hint;
+	blk_rq_copy_request(rq, rq_src);
=20
 	return 0;
=20
diff --git a/block/blk.h b/block/blk.h
index 73bd3b1c6938..73dd86dc8f47 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -120,6 +120,8 @@ static inline void blk_rq_bio_prep(struct request *rq=
, struct bio *bio,
 		rq->rq_disk =3D bio->bi_disk;
 }
=20
+void blk_rq_copy_request(struct request *rq, struct request *rq_src);
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
--=20
2.25.2

