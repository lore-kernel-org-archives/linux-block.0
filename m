Return-Path: <SRS0=S578=Z3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6B0C43603
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 02:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2AD21823
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 02:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S75hR2v/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfLECJQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:09:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50293 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728121AbfLECJP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Dec 2019 21:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575511754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fBGz+zdacxQ8v40nCTTqXW4v4AG5mnPERHjisuIPnRI=;
        b=S75hR2v/drOahRiffOTcIO+6k+174RdEV6YUQ6/Cv+TR2Mno3wU/y3CoixwvZF1kWq5Tvi
        6M79QxsiIOz3zvIgxmF76OzsaqwLbXtFm3XmofjgC/pWyLZFQt5jBbOwS89H5bwTdzEu9v
        bixsAJqkEPH9ZUsGi5oUyXSDNljuvNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-PUJ0UGOXPV-xIo9Mdr5oUw-1; Wed, 04 Dec 2019 21:09:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ACD41005502;
        Thu,  5 Dec 2019 02:09:10 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0436719481;
        Thu,  5 Dec 2019 02:09:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Justin Tee <justin.tee@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: fix memleak of bio integrity data
Date:   Thu,  5 Dec 2019 10:09:01 +0800
Message-Id: <20191205020901.18737-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: PUJ0UGOXPV-xIo9Mdr5oUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Justin Tee <justin.tee@broadcom.com>

7c20f11680a4 ("bio-integrity: stop abusing bi_end_io") moves
bio_integrity_free from bio_uninit() to bio_integrity_verify_fn()
and bio_endio(). This way looks wrong because bio may be freed
without calling bio_endio(), for example, blk_rq_unprep_clone() is
called from dm_mq_queue_rq() when the underlying queue of dm-mpath
is busy.

So memory leak of bio integrity data is caused by commit 7c20f11680a4.

Fixes this issue by re-adding bio_integrity_free() to bio_uninit().

Fixes: 7c20f11680a4 ("bio-integrity: stop abusing bi_end_io")
Cc: Justin Tee <justin.tee@broadcom.com>
Cc: Christoph Hellwig <hch@lst.de>

Add commit log, and simplify/fix the original patch wroten by Justin.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio-integrity.c | 2 +-
 block/bio.c           | 3 +++
 block/blk.h           | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index fb95dbb21dd8..bf62c25cde8f 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -87,7 +87,7 @@ EXPORT_SYMBOL(bio_integrity_alloc);
  * Description: Used to free the integrity portion of a bio. Usually
  * called from bio_free().
  */
-static void bio_integrity_free(struct bio *bio)
+void bio_integrity_free(struct bio *bio)
 {
 =09struct bio_integrity_payload *bip =3D bio_integrity(bio);
 =09struct bio_set *bs =3D bio->bi_pool;
diff --git a/block/bio.c b/block/bio.c
index b1170ec18464..9d54aa37ce6c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -233,6 +233,9 @@ struct bio_vec *bvec_alloc(gfp_t gfp_mask, int nr, unsi=
gned long *idx,
 void bio_uninit(struct bio *bio)
 {
 =09bio_disassociate_blkg(bio);
+
+=09if (bio_integrity(bio))
+=09=09bio_integrity_free(bio);
 }
 EXPORT_SYMBOL(bio_uninit);
=20
diff --git a/block/blk.h b/block/blk.h
index 2bea40180b6f..6842f28c033e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -121,6 +121,7 @@ static inline void blk_rq_bio_prep(struct request *rq, =
struct bio *bio,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
+void bio_integrity_free(struct bio *bio);
 static inline bool bio_integrity_endio(struct bio *bio)
 {
 =09if (bio_integrity(bio))
@@ -166,6 +167,9 @@ static inline bool bio_integrity_endio(struct bio *bio)
 {
 =09return true;
 }
+static inline void bio_integrity_free(struct bio *bio)
+{
+}
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
=20
 unsigned long blk_rq_timeout(unsigned long timeout);
--=20
2.20.1

