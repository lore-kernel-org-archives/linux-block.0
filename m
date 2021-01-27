Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAF3C433E6
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 10:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B63E20724
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 10:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhA0KxC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 05:53:02 -0500
Received: from mail.xenproject.org ([104.130.215.37]:46664 "EHLO
        mail.xenproject.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbhA0Ktx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 05:49:53 -0500
X-Greylist: delayed 1099 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2021 05:49:50 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From;
        bh=6/ptHMbuxYa6BXHfF9UQPcY2KxtZZywQRKCjkU8Fz9o=; b=J0YcgcpU/TQzwemcTYqNewhQSD
        ziPvpCBJgSy68kc79RsBYacQqZsE3MR3iPY0Ov8RJ5b9Yx9fTBKICJSuuLK67icSdmfi4XreSC3oj
        KQVdPhvzPH3uDVqjCtHr9ONoKhqagQtSNAdeFmSpIsBiU5wM3ci6Vf7oxl/LkiftEmYk=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1l4i5z-0003o8-AR; Wed, 27 Jan 2021 10:30:43 +0000
Received: from host86-190-149-163.range86-190.btcentralplus.com ([86.190.149.163] helo=ubuntu.home)
        by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1l4i5y-0005F8-W1; Wed, 27 Jan 2021 10:30:43 +0000
From:   Paul Durrant <paul@xen.org>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paul Durrant <pdurrant@amazon.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH] xen-blkback: fix compatibility bug with single page rings
Date:   Wed, 27 Jan 2021 10:30:34 +0000
Message-Id: <20210127103034.2559-1-paul@xen.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Paul Durrant <pdurrant@amazon.com>

Prior to commit 4a8c31a1c6f5 ("xen/blkback: rework connect_ring() to avoid
inconsistent xenstore 'ring-page-order' set by malicious blkfront"), the
behaviour of xen-blkback when connecting to a frontend was:

- read 'ring-page-order'
- if not present then expect a single page ring specified by 'ring-ref'
- else expect a ring specified by 'ring-refX' where X is between 0 and
  1 << ring-page-order

This was correct behaviour, but was broken by the afforementioned commit to
become:

- read 'ring-page-order'
- if not present then expect a single page ring
- expect a ring specified by 'ring-refX' where X is between 0 and
  1 << ring-page-order
- if that didn't work then see if there's a single page ring specified by
  'ring-ref'

This incorrect behaviour works most of the time but fails when a frontend
that sets 'ring-page-order' is unloaded and replaced by one that does not
because, instead of reading 'ring-ref', xen-blkback will read the stale
'ring-ref0' left around by the previous frontend will try to map the wrong
grant reference.

This patch restores the original behaviour.

Fixes: 4a8c31a1c6f5 ("xen/blkback: rework connect_ring() to avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront")
Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Roger Pau Monné" <roger.pau@citrix.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/block/xen-blkback/common.h |  1 +
 drivers/block/xen-blkback/xenbus.c | 36 +++++++++++++-----------------
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index b0c71d3a81a0..524a79f10de6 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -313,6 +313,7 @@ struct xen_blkif {
 
 	struct work_struct	free_work;
 	unsigned int 		nr_ring_pages;
+	bool                    multi_ref;
 	/* All rings for this device. */
 	struct xen_blkif_ring	*rings;
 	unsigned int		nr_rings;
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 9860d4842f36..4c1541cde68c 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -998,10 +998,15 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 	for (i = 0; i < nr_grefs; i++) {
 		char ring_ref_name[RINGREF_NAME_LEN];
 
-		snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
+		if (blkif->multi_ref)
+			snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref%u", i);
+		else {
+			WARN_ON(i != 0);
+			snprintf(ring_ref_name, RINGREF_NAME_LEN, "ring-ref");
+		}
+
 		err = xenbus_scanf(XBT_NIL, dir, ring_ref_name,
 				   "%u", &ring_ref[i]);
-
 		if (err != 1) {
 			if (nr_grefs == 1)
 				break;
@@ -1013,18 +1018,6 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 		}
 	}
 
-	if (err != 1) {
-		WARN_ON(nr_grefs != 1);
-
-		err = xenbus_scanf(XBT_NIL, dir, "ring-ref", "%u",
-				   &ring_ref[0]);
-		if (err != 1) {
-			err = -EINVAL;
-			xenbus_dev_fatal(dev, err, "reading %s/ring-ref", dir);
-			return err;
-		}
-	}
-
 	err = -ENOMEM;
 	for (i = 0; i < nr_grefs * XEN_BLKIF_REQS_PER_PAGE; i++) {
 		req = kzalloc(sizeof(*req), GFP_KERNEL);
@@ -1129,10 +1122,15 @@ static int connect_ring(struct backend_info *be)
 		 blkif->nr_rings, blkif->blk_protocol, protocol,
 		 blkif->vbd.feature_gnt_persistent ? "persistent grants" : "");
 
-	ring_page_order = xenbus_read_unsigned(dev->otherend,
-					       "ring-page-order", 0);
-
-	if (ring_page_order > xen_blkif_max_ring_order) {
+	err = xenbus_scanf(XBT_NIL, dev->otherend, "ring-page-order", "%u",
+			   &ring_page_order);
+	if (err != 1) {
+		blkif->nr_ring_pages = 1;
+		blkif->multi_ref = false;
+	} else if (ring_page_order <= xen_blkif_max_ring_order) {
+		blkif->nr_ring_pages = 1 << ring_page_order;
+		blkif->multi_ref = true;
+	} else {
 		err = -EINVAL;
 		xenbus_dev_fatal(dev, err,
 				 "requested ring page order %d exceed max:%d",
@@ -1141,8 +1139,6 @@ static int connect_ring(struct backend_info *be)
 		return err;
 	}
 
-	blkif->nr_ring_pages = 1 << ring_page_order;
-
 	if (blkif->nr_rings == 1)
 		return read_per_ring_refs(&blkif->rings[0], dev->otherend);
 	else {
-- 
2.17.1

