Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CA8C83008
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 16:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3238B2063A
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 16:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XtqHMtJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgD1Qol (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:44:41 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8957 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgD1Qol (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 12:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588092281; x=1619628281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5WpxtjBh2s6BxlDOvuwN20Kbq0kjXPjqzRnU/ns1PPg=;
  b=XtqHMtJPd7bp69UtV9zRjVmly0Eu5ZlfdnQD2e2h49NRWaUdhFr2iKfu
   GGrOANhQyiu7iIMYfYcUd0xdWOeDCE0L9446qxsoclUvB4pFNpH872jgJ
   mPrSmNPH/5LpxqweBNtpQBnQtstYyLjUWngnMqPQokGdv90/mPtx1zpns
   KLIkVaapnrzURfeogihq4GeTmsKqn7OWcHMPf+yjom9dw/58/sOLlrdCy
   eicmKUbRgr98TpW+nyBxLswxHR5sij13jRWaA6jfFOMLMGtdWc7Pzq54R
   yw7I+ITKVbOveHGvpBRraaduQ1vIkI06XbPiWAM7CT4rwRdxhKHl79YYT
   w==;
IronPort-SDR: XN+WU6IUuzYc+NKTImHOHnMUc/hrRVadlT+T7V+lxEDz670NIUP/+x3Zdx+xFCSN/VEaG7NC5r
 FreZXCV4VXSpsOnJVyah4qreJHMw6+aO/zwynkGfcf84klbWz3/Pa4fWJPZcKmD6TFPxcaW32n
 zwpyKAPKts/Yqli4HSXWdGSnxXiAyMh9F1UVPTcoKfOrCiwEr+iZqVN7sqT+K3p0mX059J6Oas
 m1F8i7kZ0UAfy1cqEmGHn0e1oinnbFmQtmVXZ9izFGHw1IWEn9SmNApn8/GEg1/7XjdndvVt3O
 a6E=
X-IronPort-AV: E=Sophos;i="5.73,328,1583164800"; 
   d="scan'208";a="140725861"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2020 00:44:41 +0800
IronPort-SDR: 1sSuWw8WUdlN0RyhOzBw3Q77YIV4pseGZeHVVVKae3GOowa1BSNwSzD+bwO2gNPEKVyWSoa3uF
 kg9b848yKXp4wUDYOsGdkxFP7PmypusHs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 09:34:47 -0700
IronPort-SDR: 3XD82Ayx5mRRWJ5ayWPW1Jc/7ooeZMlj2gQE/VV0Sab3goKuFjQ/sWroLBrl70Fc+925fBRvyw
 E5j0R6KmMXzw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Apr 2020 09:44:38 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/3] block: remove blk_queue_root_blkg
Date:   Wed, 29 Apr 2020 01:44:32 +0900
Message-Id: <20200428164434.1517-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428164434.1517-1-johannes.thumshirn@wdc.com>
References: <20200428164434.1517-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_queue_root_blkg() has no callers, remove it.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/blk-cgroup.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 35f8ffe92b70..333885133b1f 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -364,17 +364,6 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 	return __blkg_lookup(blkcg, q, false);
 }
 
-/**
- * blk_queue_root_blkg - return blkg for the (blkcg_root, @q) pair
- * @q: request_queue of interest
- *
- * Lookup blkg for @q at the root level. See also blkg_lookup().
- */
-static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
-{
-	return q->root_blkg;
-}
-
 /**
  * blkg_to_pdata - get policy private data
  * @blkg: blkg of interest
@@ -707,8 +696,6 @@ static inline bool blk_cgroup_congested(void) { return false; }
 static inline void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay) { }
 
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
-static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
-{ return NULL; }
 static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
 static inline void blkcg_exit_queue(struct request_queue *q) { }
 static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
-- 
2.24.1

