Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F21C4724C
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 15:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD3B20775
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 15:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n4p0DtYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgD3PEF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:04:05 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20784 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgD3PEF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 11:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588259045; x=1619795045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FQaXs1VYIfjr/X5z0nt9Df90tYEbq3V6Uqejor5RY4k=;
  b=n4p0DtYTtuTWUr2xvmYsSNWp5tQVGjXHUDDhDDeP9rSt17+PP3Hb7x8O
   aRXuf0qLwdOdAEGi1jt5vyKLIab5NcMQVJbDIwMqQ8aIKZzmVXFNGBUmW
   mRsMNnMN8O6ml5hNWHieKSiWAa6rHUIMr3oqYdjteQpoBfLnXYspdUy/i
   3yFaabgeGd95LKG/bQyRScqfMG/Me8tnPmsmLdRF+8uaEt7gvRc2BnU4w
   Ysarclj9ZkFJr2RCMs80KTpz6a0JTnjZdVbvonOytljrBhEcIsepwSNb3
   zs306xmTYf92Qzu69VTAEJ0Ig63RMW0tLRlIEFea/XgYMR8ccZPJ9iMBy
   w==;
IronPort-SDR: QpN7gUrFKn1wdMBkn9QU6kNz/w3SDdy4Kbgf19EFRt1BpdcgFsFhyyrxkOEtcOsf1rxkVcjyO7
 CikEjiwMCtzCOL/YS+5TObslg+w4IyaAqfoYhJdXROrOhQv3TReolTa/cflJO74ADIZ274pJdx
 JvhD0Li9apdX9ibpSiWcGH/moDNnig9rjyxWLq151DSOZO8S2gl8jUqZ7Q5n3eYzSn5UfIRNSv
 L2MHvjMDIXPN0QoJRZLDZoJE5mA0i0aZZXzmPaHK5aJnlJvX2iZwNRcZkDrDiGf01YdJVbitDQ
 fjg=
X-IronPort-AV: E=Sophos;i="5.73,336,1583164800"; 
   d="scan'208";a="140916572"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 23:04:04 +0800
IronPort-SDR: GgKQosOi00pXewvBvWagv7oAqw1B4ZkLx4tIu0pIKf4/TCtS62skH578ykthBC6P8Mx4TsRLAT
 3KPkyZ65H/lqvn80nuptMBMbNGqA+ZJ/Y=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 07:54:07 -0700
IronPort-SDR: RGWvfGo2OO/IbhhjavL63FwDA1Yo+wtSAUXaiu02Xs62SrU6bIsc37pOdYOax0HrqTuIA1S2G4
 n+tORWdjtPqw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2020 08:04:04 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 3/3] block: open-code blkg_path in it's sole caller
Date:   Fri,  1 May 2020 00:03:56 +0900
Message-Id: <20200430150356.35691-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200430150356.35691-1-johannes.thumshirn@wdc.com>
References: <20200430150356.35691-1-johannes.thumshirn@wdc.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

