Return-Path: <SRS0=w0su=DW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A34C433E7
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 14:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6FDF2225A
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 14:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="HHdCFMYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388123AbgJOO0E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Oct 2020 10:26:04 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:29824 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388099AbgJOO0D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 10:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1602771963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nec4gD5X3MmxS0I+tIlw7vXxkm0qi/q39D7bqb697+c=;
  b=HHdCFMYdp3iaiytTJKwwuZXXhBJuVSTxYO1RZ3dMYNibrbr2a4k1Lf8W
   h36r2U2wmCpY1PXpCQdgw0XxhrRWMt0fkpnKnu9SjBfJJUPvARX99CGGQ
   MvgBIhO5ITQu2SjW3B1t5gju0nnWS/237zPuSacssCCqCyxuQTl1K7C/e
   U=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: iDE2yqknkOfC10XRaSF9d4E7CcP5Q7x0CCeK4aQp5Q1/nZv/prDXfC+SlM5ci1UypwQ6cB1QW+
 Rl8ICdJBrilb1/wW5SOKfXC43Dd3QJpWshFMC/Mu6GwUhqTT1AsidtLjSrF0UP9RjAgeNOlQ79
 8HTIxkcBb2U8ycE40/DnqPu0OXqxHm6i21NwnLMHnvEgjCF+aZN/ES0ZdS0A8AuJi3b9RvwYcM
 ZD4BGKRh2YA84jLWIu2a3ImyVJs3BdlrheZginPypI7gTI5wlbJDTrAusT9k6r+iiKjqi7gyug
 CCw=
X-SBRS: 2.5
X-MesageID: 29146562
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,379,1596513600"; 
   d="scan'208";a="29146562"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        SeongJae Park <sjpark@amazon.de>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        "J . Roeleveld" <joost@antarean.org>,
        =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>
Subject: [PATCH 1/2] xen/blkback: turn the cache purge LRU interval into a parameter
Date:   Thu, 15 Oct 2020 16:24:15 +0200
Message-ID: <20201015142416.70294-2-roger.pau@citrix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015142416.70294-1-roger.pau@citrix.com>
References: <20201015142416.70294-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Assume that reads and writes to the variable will be atomic. The worse
that could happen is that one of the LRU intervals is not calculated
properly if a partially written value is read, but that would only be
a transient issue.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: SeongJae Park <sjpark@amazon.de>
Cc: xen-devel@lists.xenproject.org
Cc: linux-block@vger.kernel.org
Cc: J. Roeleveld <joost@antarean.org>
Cc: Jürgen Groß <jgross@suse.com>
---
 Documentation/ABI/testing/sysfs-driver-xen-blkback | 10 ++++++++++
 drivers/block/xen-blkback/blkback.c                |  9 ++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
index ecb7942ff146..776f25d335ca 100644
--- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
+++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
@@ -35,3 +35,13 @@ Description:
                 controls the duration in milliseconds that blkback will not
                 cache any page not backed by a grant mapping.
                 The default is 10ms.
+
+What:           /sys/module/xen_blkback/parameters/lru_internval
+Date:           October 2020
+KernelVersion:  5.10
+Contact:        Roger Pau Monné <roger.pau@citrix.com>
+Description:
+                The LRU mechanism to clean the lists of persistent grants needs
+                to be executed periodically. This parameter controls the time
+                interval between consecutive executions of the purge mechanism
+                is set in ms.
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index adfc9352351d..6ad9b76fdb2b 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -117,7 +117,10 @@ MODULE_PARM_DESC(max_ring_page_order, "Maximum order of pages to be used for the
  * be executed periodically. The time interval between consecutive executions
  * of the purge mechanism is set in ms.
  */
-#define LRU_INTERVAL 100
+static unsigned int lru_interval = 100;
+module_param_named(lru_interval, lru_interval, uint, 0644);
+MODULE_PARM_DESC(lru_internval,
+		 "Time interval between consecutive executions of the cache purge mechanism (in ms)");
 
 /*
  * When the persistent grants list is full we will remove unused grants
@@ -620,7 +623,7 @@ int xen_blkif_schedule(void *arg)
 		if (unlikely(vbd->size != vbd_sz(vbd)))
 			xen_vbd_resize(blkif);
 
-		timeout = msecs_to_jiffies(LRU_INTERVAL);
+		timeout = msecs_to_jiffies(lru_interval);
 
 		timeout = wait_event_interruptible_timeout(
 			ring->wq,
@@ -650,7 +653,7 @@ int xen_blkif_schedule(void *arg)
 		if (blkif->vbd.feature_gnt_persistent &&
 		    time_after(jiffies, ring->next_lru)) {
 			purge_persistent_gnt(ring);
-			ring->next_lru = jiffies + msecs_to_jiffies(LRU_INTERVAL);
+			ring->next_lru = jiffies + msecs_to_jiffies(lru_interval);
 		}
 
 		/* Shrink the free pages pool if it is too large. */
-- 
2.28.0

