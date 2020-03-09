Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C414C10F29
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 20:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C1124654
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 20:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ82whP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgCIU7y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:59:54 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41209 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgCIU7y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 16:59:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id b5so10718155qkh.8
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oBF6vFzhfgORCnyZFI3GVvM0MlUXIpfqinf2HssDIU4=;
        b=gQ82whP0mMciC/r3mXbbvJBMoeLgr3+8KBNxNdiMNuMoCv4+AZWuqbkdhXRJwbdp9y
         gwsazx5fBPTti/ptm0f3xRCc3TkZVpJyVj0aVEO8N83V7vurV/r6saQcG3oiRDpPDlwl
         OWmNqEx+HuzirmmUZXVuDE7nDc9MyjF0MBfx94VvE+zBKKel7r1P/YGpgXjulrJ7HCzJ
         k8GWDo8RdwTHM+hdjuT+/3cc0FU1qu0qHfhTOPa4sz9HNyU8cXzvKB4VXhjQ2z3F/yus
         SzfCFRpf+3bR2mDNsI4Vqtp2CyjevHWTLRSYlLZOAl8CYpO4+G2srR128twnSc29jWUp
         drMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oBF6vFzhfgORCnyZFI3GVvM0MlUXIpfqinf2HssDIU4=;
        b=k9fVqgaJVQK9La3D2Ob6bWi5YvozDn506Bh9X++RS/EwFyWTxIMfkzTT+66UxCfVc/
         VfnZtBsiC4qewZBTCKgfW3bNYsTEQYrKyeYbjE1uAl8D5xNr7FP9T4XFCrzDKrF9KEA3
         mGcFTxt5iTxQD2q42YVWCQFxwKCTpog8I3DLH8YJ1wDz5+Zsorq44M0OA4eortftgvP/
         f7HSMRKxW5/De07B4IfOPiXCT8x6Y4PPWuTkoChxty+TFGJKth+MfsxwZdLjZHDMfnne
         L1DH7Y9p47gwBBDc6r+8HYnGWc0uddjI/g/rnBhee5nBWa0zs8v/3XU/UFQNSgcPD0BB
         QJcQ==
X-Gm-Message-State: ANhLgQ29LdEl4etqgn0NNWacDqOvLIgFzuGQ4uw3eZb3C55Tlp+uIxEB
        wR6KLy66Q2qkfjDXL7tLQJvTnOQwtPM=
X-Google-Smtp-Source: ADFU+vutrXiTf1FZhllHw8sbeAxiTHYscx3RK9RKjVvu6nQMzn289weT8T0j43g/Use2+hrRKD1PMw==
X-Received: by 2002:a37:992:: with SMTP id 140mr7237498qkj.36.1583787592303;
        Mon, 09 Mar 2020 13:59:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4078])
        by smtp.gmail.com with ESMTPSA id w132sm597586qkb.96.2020.03.09.13.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:59:51 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, mmullins@fb.com, josef@toxicpanda.com,
        Jes Sorensen <jsorensen@fb.com>
Subject: [PATCH 4/7] Expand block stats to export number of of requests per bucket
Date:   Mon,  9 Mar 2020 16:59:28 -0400
Message-Id: <20200309205931.24256-5-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309205931.24256-1-Jes.Sorensen@gmail.com>
References: <20200309205931.24256-1-Jes.Sorensen@gmail.com>
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
index 44517799a2e8..aeb69c57ffb7 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -542,6 +542,14 @@ static ssize_t queue_stat_show(struct request_queue *q, char *p)
 				       q->req_stat[i + 3 * bkt].sectors << 9);
 		}
 		off += sprintf(p + off, "\n");
+
+		off += sprintf(p + off, "%s reqs: ", name[i]);
+		for (bkt = 0; bkt < (BLK_REQ_STATS_BKTS / 3); bkt++) {
+			off += sprintf(p + off, "%u ",
+				       q->req_stat[i + 3 * bkt].nr_samples);
+		}
+
+		off += sprintf(p + off, "\n");
 	}
 	return off;
 }
-- 
2.17.1

