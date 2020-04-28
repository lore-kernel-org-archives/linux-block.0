Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB429C83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 16:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 884C92063A
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 16:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RUazIUhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgD1Qon (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:44:43 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8957 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgD1Qom (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 12:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588092283; x=1619628283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=06v5O8tW8kzIBm6bmkPzLJeuF2xdN6mC9xe+H6q9iHw=;
  b=RUazIUhRHJhYadSziOwQB5boUlLVLjXEYQrwE6GB6B16zkXce0YSb7bU
   QqXMZ4xS6jq+0Ujvm4D386OCdaJkl3EOjLLP5HzVhJTnU4G3wCTPRf+fr
   uc26ikxUC0VaANrAywTLrRIyAIdh+QqbGNQXyNmnPyg/vfk+n58QicY5/
   D3p1pBcujhfWd3ilsgodOT/7fm4K/RWHh3n4KLm2XGZ6QhM7O/zrkpcbE
   Nl/fMzGmoG0VI8HtJZBDwa9VG2e2iwxP7uBKAbVQbe2XdAzRAWkGQwFPc
   0ZDqW0air7rzq7xeDYacByVCxqJfk4fEzF3OMiJCu7rLrBxuc1UiccPnC
   w==;
IronPort-SDR: spZq2HX5DreFkJhtHjz+eXYMZHe/H4Yzv2N92r/f1MhmfZ2iE7V8MdHtJtDekW0M/aZLEmJTn+
 TfSDAZPVZLONTjBbcivb75sgi7TSoXQ/HWoAekDbrjnrOQLtt3vBskOwb1Z0CFwqKK8wMxRqNj
 LsX56FQmTnMcShwSYhiJHPN8/q9hgeH/Kl1FR6lBegohC/HlHSMB6XbK5qdudGuFKQcIMSaiFo
 AS75YZcFzlxr5vRsLeDMzjPKQ0x4cpdhdW+bPksGK2QKpuWcDqCwcIA5BhuNPogwyxgZayHLyS
 lHg=
X-IronPort-AV: E=Sophos;i="5.73,328,1583164800"; 
   d="scan'208";a="140725865"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2020 00:44:43 +0800
IronPort-SDR: c48jMLVZC2nH6pCJwhChMnUM/xyI7e/MvhVwR5Mq7LYYUImduw0VZVC09Ykbc8vcQCG7yLCFkZ
 mOIYKmvBWeI1KNh/OEq6HiUzW04iWBvEA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 09:34:48 -0700
IronPort-SDR: 4xRn4iZHpSy14wyJXbnliLGEDeN/SJmEwxR6qNPZVpf2Nq4ufj9FXYZjE8n9v7KDHy/ZUzh8ts
 5WRxJx1eESIw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Apr 2020 09:44:40 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/3] block: open-code blkg_path in it's sole caller
Date:   Wed, 29 Apr 2020 01:44:34 +0900
Message-Id: <20200428164434.1517-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428164434.1517-1-johannes.thumshirn@wdc.com>
References: <20200428164434.1517-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkg_path() is a trivial one-line helper that only has a single caller,
bfq_bic_update_cgroup().

Remove blkg_path() and open-code it in bfq_bic_update_cgroup().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bfq-cgroup.c         |  3 ++-
 include/linux/blk-cgroup.h | 14 --------------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 68882b9b8f11..8fe7d47eb4dd 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -794,7 +794,8 @@ void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
 	 * refcounter for bfqg, to let it disappear only after no
 	 * bfq_queue refers to it any longer.
 	 */
-	blkg_path(bfqg_to_blkg(bfqg), bfqg->blkg_path, sizeof(bfqg->blkg_path));
+	cgroup_path(bfqg_to_blkg(bfqg)->blkcg->css.cgroup, bfqg->blkg_path,
+		    sizeof(bfqg->blkg_path));
 	bic->blkcg_serial_nr = serial_nr;
 out:
 	rcu_read_unlock();
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index b356d4eed08d..3e61298fae6a 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -433,19 +433,6 @@ static inline void blkcg_unpin_online(struct blkcg *blkcg)
 	} while (blkcg);
 }
 
-/**
- * blkg_path - format cgroup path of blkg
- * @blkg: blkg of interest
- * @buf: target buffer
- * @buflen: target buffer length
- *
- * Format the path of the cgroup of @blkg into @buf.
- */
-static inline int blkg_path(struct blkcg_gq *blkg, char *buf, int buflen)
-{
-	return cgroup_path(blkg->blkcg->css.cgroup, buf, buflen);
-}
-
 /**
  * blkg_get - get a blkg reference
  * @blkg: blkg to get
@@ -655,7 +642,6 @@ static inline struct blkcg *bio_blkcg(struct bio *bio) { return NULL; }
 static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
 						  struct blkcg_policy *pol) { return NULL; }
 static inline struct blkcg_gq *pd_to_blkg(struct blkg_policy_data *pd) { return NULL; }
-static inline char *blkg_path(struct blkcg_gq *blkg) { return NULL; }
 static inline void blkg_get(struct blkcg_gq *blkg) { }
 static inline void blkg_put(struct blkcg_gq *blkg) { }
 
-- 
2.24.1

