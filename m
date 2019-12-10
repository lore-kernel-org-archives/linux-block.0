Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55491C43603
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 14:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2558B2077B
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 14:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VqS3SpQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfLJOxO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:53:14 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:18750 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfLJOxO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 09:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575989593; x=1607525593;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NAV6kZQrewVA32BcVnXou+TwbV5q6MZxjxEtrGeNo8M=;
  b=VqS3SpQ5JJ2oVUm7hETyjPKTuQAxYpYpBnjjT2gO5u8an9JWUl7dTmme
   iSA53jSaCo8v9J3FLYsP6/mMKSxDWjCMarkzWL8k8tuRjzEi2ULl1vp0d
   mS1DLMsKhIhi5FoeciX6faUSMdzyyNPh8+KIHVkGYKSnVgYVcC3ph8KQG
   4=;
IronPort-SDR: wVWUhxat8iw5Q6ERyDQmmnGyVDPqrDPvphLeTNPJ5eufTf7zRgq8/rqezj2Zfh8mbPGQUj9a9W
 6wuUfkDS+udQ==
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="scan'208";a="7928558"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 10 Dec 2019 14:53:11 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id A2C651A1EEE;
        Tue, 10 Dec 2019 14:53:10 +0000 (UTC)
Received: from EX13D32EUB002.ant.amazon.com (10.43.166.114) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 14:53:10 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D32EUB002.ant.amazon.com (10.43.166.114) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 14:53:09 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 10 Dec 2019 14:53:07 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] xen-blkback: prevent premature module unload
Date:   Tue, 10 Dec 2019 14:53:05 +0000
Message-ID: <20191210145305.6605-1-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Objects allocated by xen_blkif_alloc come from the 'blkif_cache' kmem
cache. This cache is destoyed when xen-blkif is unloaded so it is
necessary to wait for the deferred free routine used for such objects to
complete. This necessity was missed in commit 14855954f636 "xen-blkback:
allow module to be cleanly unloaded". This patch fixes the problem by
taking/releasing extra module references in xen_blkif_alloc/free()
respectively.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Roger Pau Monné" <roger.pau@citrix.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/xen-blkback/xenbus.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index e8c5c54e1d26..59d576d27ca7 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -171,6 +171,15 @@ static struct xen_blkif *xen_blkif_alloc(domid_t domid)
 	blkif->domid = domid;
 	atomic_set(&blkif->refcnt, 1);
 	init_completion(&blkif->drain_complete);
+
+	/*
+	 * Because freeing back to the cache may be deferred, it is not
+	 * safe to unload the module (and hence destroy the cache) until
+	 * this has completed. To prevent premature unloading, take an
+	 * extra module reference here and release only when the object
+	 * has been free back to the cache.
+	 */
+	__module_get(THIS_MODULE);
 	INIT_WORK(&blkif->free_work, xen_blkif_deferred_free);
 
 	return blkif;
@@ -320,6 +329,7 @@ static void xen_blkif_free(struct xen_blkif *blkif)
 
 	/* Make sure everything is drained before shutting down */
 	kmem_cache_free(xen_blkif_cachep, blkif);
+	module_put(THIS_MODULE);
 }
 
 int __init xen_blkif_interface_init(void)
-- 
2.20.1

