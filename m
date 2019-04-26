Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD12C43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD0D206BA
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 00:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n419d2H/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfDZAVg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:21:36 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40380 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfDZAVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 20:21:36 -0400
Received: by mail-yw1-f66.google.com with SMTP id t79so571766ywc.7
        for <linux-block@vger.kernel.org>; Thu, 25 Apr 2019 17:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJAKFIUwXmdu8PAlVtviwz/Fyb0DGbl6JsI8sXHzYrc=;
        b=n419d2H/edMvMTnPWCA0jHqd1XLaO+L6cCzlr11ST5P3AGokTBIiEJEiFRQPCRzyBI
         Ll2tmFFL5C022dyR5kmWmA3igMoZJTRaEz+B80CRCTApr1t8c2Z8BYnzWhwkpAj5waiy
         bFjhyAdbUoH27IZcvImUOxdqEFLtJA4ihxrllkYlZELOljV7DIkSGqPFpkFrF2UHHr1M
         CatFCW7NVbqaXymfRqJ3iXAArxjfyGeX0RbMPieraAIupJwHVDyMXGCWKiCWyEMOb8vp
         w4P8MOdn8iAj2Qhea3/sJMMQDk9XgCbDo6hXHop49tVBxtvU4hiauuRobqLVvgZYH6mL
         pH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJAKFIUwXmdu8PAlVtviwz/Fyb0DGbl6JsI8sXHzYrc=;
        b=hLK8t1IL/92ItdrTGk54TTWUneg+NRLxPcqV2tCwjk40+hi5J5VTa991z7zoV7Ipon
         bAoK21wcrOasUzXeFZ/eowy0JrIaVuRKqsWVKw6UyGVTf8lw+V/NeRD02vBa4cMbsw8A
         W6Bucx5Sxe1tHVppenDjt5FHZb6YL18XhzKYbCNWIsCWL1O5JeYX8i6nxCSoh7Pmweiv
         6SHZCNwpBG1Utv7mXMgbsjwfDKpuPV3SYyNOXQxEfkoCgEqGn9Y1+QG/29HY1s3zg3Ev
         rFf+wq5Oo9XfH9wCKNZ1E+xpdeJ7tQ5CHeGMavnYdA8ixWF4BeSRFUmn6Dw2tVXM80Ts
         BoyA==
X-Gm-Message-State: APjAAAWXJPaL8rEOl9e5kzuExTNf3bNzhNahXhxnJ3+nL4K1snlu/M8T
        GVvDfymO+QpzDD5yU0GmVBK7kwpy
X-Google-Smtp-Source: APXvYqxARVlO37HbaMq8P+LJkxVN7wKO4l+N/TVNqnIP2L7mBKZKfrZI3xCNzNouTJ8+Giit4mT+TQ==
X-Received: by 2002:a81:9913:: with SMTP id q19mr32242105ywg.215.1556238094765;
        Thu, 25 Apr 2019 17:21:34 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::5484])
        by smtp.gmail.com with ESMTPSA id v144sm10066822ywc.37.2019.04.25.17.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 17:21:34 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     josef@toxicpanda.com, kernel-team@fb.com
Subject: [PATCH 5/5] Expand block stats to export number of of requests per bucket
Date:   Thu, 25 Apr 2019 20:20:50 -0400
Message-Id: <20190426002050.15499-6-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426002050.15499-1-Jes.Sorensen@gmail.com>
References: <20190426002050.15499-1-Jes.Sorensen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

Signed-off-by: Jes Sorensen <jsorensen@fb.com>
---
 block/blk-sysfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f54d91b54b61..04d1938d1aa9 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -543,6 +543,14 @@ static ssize_t queue_stat_show(struct request_queue *q, char *p)
 				       q->dev_stat[i + 3 * bkt].size);
 		}
 		off += sprintf(p + off, "\n");
+
+		off += sprintf(p + off, "%s reqs: ", name[i]);
+		for (bkt = 0; bkt < (BLK_DEV_STATS_BKTS / 3); bkt++) {
+			off += sprintf(p + off, "%u ",
+				       q->dev_stat[i + 3 * bkt].nr_samples);
+		}
+
+		off += sprintf(p + off, "\n");
 	}
 	return off;
 }
-- 
2.17.1

