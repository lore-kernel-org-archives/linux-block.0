Return-Path: <SRS0=qpPD=UU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C309C48BE0
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 13:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D7F21530
	for <linux-block@archiver.kernel.org>; Fri, 21 Jun 2019 13:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="WiMV9WZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfFUNHz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:07:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44417 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfFUNHe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jun 2019 09:07:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so5881503ljc.11
        for <linux-block@vger.kernel.org>; Fri, 21 Jun 2019 06:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yP4hCZ6yL3D/UZqgqC/Ov+Z6vjll5loZko6056/cetY=;
        b=WiMV9WZtz6n4ISyy7pUtYCnGw26um/pfnCPW0IUhTrj5WLELiUwQzTzG1Ps+Fm34sU
         niM84VraxJjxEYv4lANQu3cYxfRtxumRLPBQhauTyA3CnBL4peWd+iHPQtOun7Vq50zL
         HNHQiBxrBvNYVwNdhOGm90h2gZQDczlnARy2Q53GRYk/CeAka+BWLGtHypDgvFyVfhri
         lTPNVcm6BwJSShquC+A8X9br/R1xmVZkUNVve76ifd960/mo4rMXML0R/zeJGhy+vvhd
         T1yWVku6ySVz5E63YpGfCMcCgCDAfB92y09Sw+3UECBT3fmJSiSVa5pI9at0YCp0c5rI
         Zzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yP4hCZ6yL3D/UZqgqC/Ov+Z6vjll5loZko6056/cetY=;
        b=BvseW+6/Q9Rhfe6GEAGAoZw3jJSxfRBPwupS6sY8w3JX6iTHY/suLKzUPrPa58cciV
         OqjxjkQSBemBOBF/XAHvHiEezixuJNBPAOtL+Ri2BVcklj3kb/els9dMgAH2eyIzwsPd
         XmBJo979td3jx1RPzKrlXllPVrfMjO6s1wsiPLyuBZoSMPQwYliausOTF3Bnhav0WnvS
         IlSN40y1hil5WX6TRMKqSIDlWhnRhQj7K4XYBPo8XHPzGUx1+NyKqEJB2xjKnzpwudbh
         vILyJFTAREjnN90JTAabYKmXKdYa04nyE/DHq0vCZ2rDdPmva/OYlqTMOHUeg5io/u5+
         2/dA==
X-Gm-Message-State: APjAAAWUl16DBLIPdWPpOXMjzNM5FugEjSmvVEci06om6mAmVEiD4hMz
        yqyj9cwGV4b+20nwLI+kqF2EYg==
X-Google-Smtp-Source: APXvYqz0iDNEIsEABaU1xi7aYwfBGvl2BdjDcs2x8HZgfccJp7p8AirvIqLaeTE1wbjQW06IpIgp+g==
X-Received: by 2002:a2e:900c:: with SMTP id h12mr3609956ljg.197.1561122451127;
        Fri, 21 Jun 2019 06:07:31 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id r2sm387100lfi.51.2019.06.21.06.07.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 06:07:30 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com, hch@lst.de, damien.lemoal@wdc.com,
        chaitanya.kulkarni@wdc.com, dmitry.fomichev@wdc.com,
        ajay.joshi@wdc.com, aravind.ramesh@wdc.com,
        martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        agk@redhat.com, snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 2/4] null_blk: add zone open, close, and finish support
Date:   Fri, 21 Jun 2019 15:07:09 +0200
Message-Id: <20190621130711.21986-3-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190621130711.21986-1-mb@lightnvm.io>
References: <20190621130711.21986-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ajay Joshi <ajay.joshi@wdc.com>

Implement REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH
support to allow explicit control of zone states.

Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
---
 drivers/block/null_blk.h       |  4 ++--
 drivers/block/null_blk_main.c  | 13 ++++++++++---
 drivers/block/null_blk_zoned.c | 33 ++++++++++++++++++++++++++++++---
 3 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 34b22d6523ba..62ef65cb0f3e 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -93,7 +93,7 @@ int null_zone_report(struct gendisk *disk, sector_t sector,
 		     gfp_t gfp_mask);
 void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 			unsigned int nr_sectors);
-void null_zone_reset(struct nullb_cmd *cmd, sector_t sector);
+void null_zone_mgmt_op(struct nullb_cmd *cmd, sector_t sector);
 #else
 static inline int null_zone_init(struct nullb_device *dev)
 {
@@ -111,6 +111,6 @@ static inline void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 				   unsigned int nr_sectors)
 {
 }
-static inline void null_zone_reset(struct nullb_cmd *cmd, sector_t sector) {}
+static inline void null_zone_mgmt_op(struct nullb_cmd *cmd, sector_t sector) {}
 #endif /* CONFIG_BLK_DEV_ZONED */
 #endif /* __NULL_BLK_H */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 447d635c79a2..5058fb980c9c 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1209,10 +1209,17 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 			nr_sectors = blk_rq_sectors(cmd->rq);
 		}
 
-		if (op == REQ_OP_WRITE)
+		switch (op) {
+		case REQ_OP_WRITE:
 			null_zone_write(cmd, sector, nr_sectors);
-		else if (op == REQ_OP_ZONE_RESET)
-			null_zone_reset(cmd, sector);
+			break;
+		case REQ_OP_ZONE_RESET:
+		case REQ_OP_ZONE_OPEN:
+		case REQ_OP_ZONE_CLOSE:
+		case REQ_OP_ZONE_FINISH:
+			null_zone_mgmt_op(cmd, sector);
+			break;
+		}
 	}
 out:
 	/* Complete IO by inline, softirq or timer */
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index fca0c97ff1aa..47d956b2e148 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -121,17 +121,44 @@ void null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	}
 }
 
-void null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
+void null_zone_mgmt_op(struct nullb_cmd *cmd, sector_t sector)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
 	struct blk_zone *zone = &dev->zones[zno];
+	enum req_opf op = req_op(cmd->rq);
 
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
 		cmd->error = BLK_STS_IOERR;
 		return;
 	}
 
-	zone->cond = BLK_ZONE_COND_EMPTY;
-	zone->wp = zone->start;
+	switch (op) {
+	case REQ_OP_ZONE_RESET:
+		zone->cond = BLK_ZONE_COND_EMPTY;
+		zone->wp = zone->start;
+		return;
+	case REQ_OP_ZONE_OPEN:
+		if (zone->cond == BLK_ZONE_COND_FULL) {
+			cmd->error = BLK_STS_IOERR;
+			return;
+		}
+		zone->cond = BLK_ZONE_COND_EXP_OPEN;
+		return;
+	case REQ_OP_ZONE_CLOSE:
+		if (zone->cond == BLK_ZONE_COND_FULL) {
+			cmd->error = BLK_STS_IOERR;
+			return;
+		}
+		zone->cond = BLK_ZONE_COND_CLOSED;
+		return;
+	case REQ_OP_ZONE_FINISH:
+		zone->cond = BLK_ZONE_COND_FULL;
+		zone->wp = zone->start + zone->len;
+		return;
+	default:
+		/* Invalid zone condition */
+		cmd->error = BLK_STS_IOERR;
+		return;
+	}
 }
-- 
2.19.1

