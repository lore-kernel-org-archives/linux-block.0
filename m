Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C853EC433E2
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB0092063A
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qmv0QtuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgF2SsO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:48:14 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56654 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbgF2SsL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 14:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593456492; x=1624992492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jfZ8Q7wIT62fV8sPtp8AoAx2hC0xeCtCKF3MCygoTso=;
  b=qmv0QtuT4OAu4bqK3UDTlOEQqzt/iTMOUE0jjrK6y9EyusQikkOOnADx
   1vhlmiFB49UR7SNK3DBzfqeuqdaK8jaiRuV7vEOWn5LzX7QfLSkyQMYbL
   +DlDmzuSiU1owvru8NTyeUBS5xPZgGnDVBwEvRcwPY4Aamzf83II1GRFk
   mEgHpMJXSUTzXzs0B93UkRlG/7VBzTbP7HFdDpI8OOCd0OFZntHdPLmmN
   hCRCbu5ua13TDOXspp16F5C7cL5wI8XxMn+BPbEwQZVV2G/CyE8wUJgH7
   vJ9dUA9dsCxyungqtMYWrt1PCDLsHHIsEvFuv5y93/7QZ2sdwyu2s18lj
   g==;
IronPort-SDR: 6bTWd3/pVM/H5YesMMjz/MvIQzwyQ2siUMsj0Jxx7q/0d2JfHz1xkGcMd1W7pd5EWGB5Q575Ve
 TQU+lRz9Elwg1MENGjLU2ZT298r81+9c3E7mZKA3AojT2IdOJuXfhJsDxonx08/7hfFUY2FEw0
 rHkmKzq1lD3QcSASj57im3u/Ieqg4xpM3/QHbm2ya7M4NSxzKFAyNpRrJLDlKSfur9j/ggFv9P
 1s0NPvK9V1WqrEO1mGKF0bszuy7owuTK7hgCAiHJ4ZEbNsQyrNeSgK3aCg/JON0+3+JvBw9ba5
 5Pk=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="141379668"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 16:26:28 +0800
IronPort-SDR: /vdz54D/SZcs3J8O/vdVG1cAguXOmpuKvgZjyZbDvRocLm3+uGuDQYXoy1UQtNGQjivKVFmVNo
 BXh7sER/4A4YzEP28VJ5olT4sbeeDHQ3w=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 01:14:48 -0700
IronPort-SDR: jE7mzBFrSWZmfUmjCK4uIuDmnOlCllvcmAyfVFMSUxycX+4lRormUAUqGyGGInUtuu9gYnAmdz
 IdGkkfJ6wmFA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Jun 2020 01:26:26 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        "linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>,
        paolo.valente@linaro.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/2] block: remove blk_queue_root_blkg
Date:   Mon, 29 Jun 2020 17:26:21 +0900
Message-Id: <20200629082622.37611-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629082622.37611-1-johannes.thumshirn@wdc.com>
References: <20200629082622.37611-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_queue_root_blkg() has no callers, remove it.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk-cgroup.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index a57ebe2f00ab..6aa633cedfb0 100644
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
@@ -732,8 +721,6 @@ static inline bool blk_cgroup_congested(void) { return false; }
 static inline void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay) { }
 
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
-static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
-{ return NULL; }
 static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
 static inline void blkcg_exit_queue(struct request_queue *q) { }
 static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
-- 
2.26.2

