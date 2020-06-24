Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F37AC433DF
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 10:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0B420706
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 10:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="Zqq2uqhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbgFXKWU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 06:22:20 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17155 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390182AbgFXKWO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 06:22:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592994106; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=oB2vqppnmLPNPjPWjgnwmMs6SIa3pr+lU1MqWevzZHeZud+Rk0be81fXdst8H1wiVlbuM3oIQ4xUvled3lkjoHd6InxgoKx/P8K10cUOkAqBJGYHZF+6PnYCsSN+f36oSevq7E9MpuxTA+wUT+WyJnGtzhmWN2v/Z2b8emyHdYw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1592994106; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Our1M0g5qkNVugR2IoSWM2RGdpXRscnVefySaYe4rU4=; 
        b=hn8zJx/H2+qSSufVsakO8Qw4dLYjuguUVQ1z+nWvdGtDljuozn7A3wPS9B0TaQ2YlYou4Gp3ni7s9JS6tswtQxoiPPZbw2IZ8CwS2XpmzkOxRlPyl9hbvWTR1F/x039d+hjT03pT2IvUZ/4hHhlu5PHhU+goxIR/FI989ROb5K4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1592994106;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=Our1M0g5qkNVugR2IoSWM2RGdpXRscnVefySaYe4rU4=;
        b=Zqq2uqhGBSR8tSy/mKNNUTPDmx99RJ+SfCol9xUUgvJlY2az2oAyFHnd0etoezWO
        qGRyzF8Lh45ghCrVUPv4XhgpjwFwsbG8xwzkCc4C+oCN07/+eXevBhgApMJDbn357FX
        UyTbaYjE8lRR9x+mrPDNf2NNjQub4ex99e3uQfuQ=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1592994105219900.3657167381867; Wed, 24 Jun 2020 18:21:45 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     axboe@kernel.dk
Cc:     hch@infradead.org, linux-block@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200624102139.5048-1-cgxu519@mykernel.net>
Subject: [PATCH v2] block: release bip in a right way in error path
Date:   Wed, 24 Jun 2020 18:21:39 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Release bip using kfree() in error path when that was allocated
by kmalloc().

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
v1->v2:
- Introduce a new helper __bio_integrity_free() to reduce duplicated
code.

 block/bio-integrity.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index bf62c25cde8f..1d173feb3883 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -24,6 +24,18 @@ void blk_flush_integrity(void)
 =09flush_workqueue(kintegrityd_wq);
 }
=20
+void __bio_integrity_free(struct bio_set *bs, struct bio_integrity_payload=
 *bip)
+{
+=09if (bs && mempool_initialized(&bs->bio_integrity_pool)) {
+=09=09if (bip->bip_vec)
+=09=09=09bvec_free(&bs->bvec_integrity_pool, bip->bip_vec,
+=09=09=09=09  bip->bip_slab);
+=09=09mempool_free(bip, &bs->bio_integrity_pool);
+=09} else {
+=09=09kfree(bip);
+=09}
+}
+
 /**
  * bio_integrity_alloc - Allocate integrity payload and attach it to bio
  * @bio:=09bio to attach integrity metadata to
@@ -75,7 +87,7 @@ struct bio_integrity_payload *bio_integrity_alloc(struct =
bio *bio,
=20
 =09return bip;
 err:
-=09mempool_free(bip, &bs->bio_integrity_pool);
+=09__bio_integrity_free(bs, bip);
 =09return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL(bio_integrity_alloc);
@@ -96,14 +108,7 @@ void bio_integrity_free(struct bio *bio)
 =09=09kfree(page_address(bip->bip_vec->bv_page) +
 =09=09      bip->bip_vec->bv_offset);
=20
-=09if (bs && mempool_initialized(&bs->bio_integrity_pool)) {
-=09=09bvec_free(&bs->bvec_integrity_pool, bip->bip_vec, bip->bip_slab);
-
-=09=09mempool_free(bip, &bs->bio_integrity_pool);
-=09} else {
-=09=09kfree(bip);
-=09}
-
+=09__bio_integrity_free(bs, bip);
 =09bio->bi_integrity =3D NULL;
 =09bio->bi_opf &=3D ~REQ_INTEGRITY;
 }
--=20
2.20.1


