Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1976DC433DF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFBFD2064B
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 18:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nGfS6sLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgF2SsN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:48:13 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56660 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgF2SsM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 14:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593456492; x=1624992492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NPLGPmIw7b2Zu/HtFbkfQA5ar4CvWd9+hzzGGxGa4rs=;
  b=nGfS6sLHWVcGfi0xpha6vBwzPT9N7qk1Ch4EMCPVtUnwcMdZjWRmnQbl
   ZsQYVNf8lp0nfkYf3ec4zdF3HEraHqlv01xoMseh0J042W9vFMDTdiUoH
   YK+p44UOdgdyt8Hpnjk6QKJW53RhejaYAO2SqDIGuFkNaRISPuxDznD/K
   0JFcdV5PGi2J9EgJbk7yRQExn9NVBcAyKa6R9kPMRZJfUIVRYKC3PAFSF
   3waY1t8K9srbhWih2xq7+NPuC+2YihZaNov5lZr1PIGSswoU/nqbG03f9
   nSledBysSY99XUu9M4UHtYJCnSdy94cs6/obgbsWHXU0NGtLMUYHBjmaT
   Q==;
IronPort-SDR: zFbn1PBwZwFuC9fQ/bntTpYIkfVGIt604LPqajRS6/+xIvSVTaodw4e4//8upFG98QCQqngDrB
 UAf1Hsic3sl7Hl82j8/l2yHDJPmUXomCpD/0fjzUieHqHhuDs5oo9HKLfx9kEKEPJtdYwkf/ZA
 HC6zsEw3OlRqzPkzu1qML3r+2wUP6CfmqQl30NzZdh4aSxuPDLULlgRfk/dQia1y38zdWmVgnZ
 2qiqqtZbHMmVFYMIRkMCZAMeL4KvX8jdgTOkIoO7xQz6ZZPeIrMUJGSChIz5/3yTzoAngaQHe3
 hrw=
X-IronPort-AV: E=Sophos;i="5.75,294,1589212800"; 
   d="scan'208";a="141379671"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2020 16:26:29 +0800
IronPort-SDR: NJhpXAF9ZIc3vp59KDBsQmJXVO5j2iUbjxN2VQsCVwOkKdRI4MaBi/HhUbfkLnrySQOMcOypUW
 vlf2NxoxdemSENNlHBLk/k9Yp5dSsseZs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 01:14:49 -0700
IronPort-SDR: 09c1CdMY9RBxW9SLscbVW/MXR554NUhU4fmZ9SOkJGb16Or40Z5MLRuLisLbPuk/G19egDCnEl
 60Uy6ljIHUWA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Jun 2020 01:26:27 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        "linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>,
        paolo.valente@linaro.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 2/2] block: open-code blkg_path in it's sole caller
Date:   Mon, 29 Jun 2020 17:26:22 +0900
Message-Id: <20200629082622.37611-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629082622.37611-1-johannes.thumshirn@wdc.com>
References: <20200629082622.37611-1-johannes.thumshirn@wdc.com>
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
index 6aa633cedfb0..5f2aea4d1c43 100644
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
@@ -736,7 +723,6 @@ static inline struct blkcg *bio_blkcg(struct bio *bio) { return NULL; }
 static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
 						  struct blkcg_policy *pol) { return NULL; }
 static inline struct blkcg_gq *pd_to_blkg(struct blkg_policy_data *pd) { return NULL; }
-static inline char *blkg_path(struct blkcg_gq *blkg) { return NULL; }
 static inline void blkg_get(struct blkcg_gq *blkg) { }
 static inline void blkg_put(struct blkcg_gq *blkg) { }
 
-- 
2.26.2

