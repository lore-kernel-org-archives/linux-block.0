Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC3BC76194
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 02:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D1B2239E
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 02:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IELyJyyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfGWCOB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:14:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38801 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfGWCOB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 22:14:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so19933298plb.5;
        Mon, 22 Jul 2019 19:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bcJiCvbMXNOA/uN8ruxT781zjh9D6EPOuwlY9SZ0FHs=;
        b=IELyJyyym8TNmLoys+GUIZL8k3PcKiok4b+5IqeJ8Y25pV0llokCEjDZz8mGyrfJWr
         CHXZSc0HFJahfZu2W4OF+zGScl7nyYpuDc0mAhDg5Q8AAbTODW86wxpkeQ8uKT950+fi
         YoILo3U+D5L4tGecuRmsqZQeWuJzh7BMhdg6j+Z0ZXgtFA2PTvHkBsUDB7naHTaEl9GE
         flBHr8axRUDC6wtYgzlnWZrdHnYWwJ2ISyo22JRIp/GMGDxGxl3yAI9HRrqKGgca5Vf4
         IxEG0LUYyQaefZtRoU6BqKphhDMuSbKiqnRvW3rr0yRfi7tjlCR9Odc7gaLYDWC26Erv
         BhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bcJiCvbMXNOA/uN8ruxT781zjh9D6EPOuwlY9SZ0FHs=;
        b=B1TXYA+I6PmlVHIC8nftqh2Nb/Hz/l5VmhkH5/VQI4FE/3hCEawDHYvCsxeUrhkCLH
         tgaMmlJ2rH1gfEavg8IE+Q/frjlx4NUzSQGirYnv2kkFnHRuavKZGJmQhwfQCa8NIB39
         RDFYd0tgs9vtB9m0TQAz7l7sEktAyPDn1zuEGK3Wjkq/fHMyRf9+fnBl7UDO7VQ2hU4K
         AWKtUceNx7Lzrzf4GXvJpJ7R7UHyeOhhQcbrUV0Mzwz61mGmiwuI9K/SWq6R17uweFPy
         3Stbgo3rtkdP3KcRADLpSnjmXcj5lii5m9DT1kmfVqHY5ZSsxuZiXaTI7QR5KXBPQSHH
         CB0w==
X-Gm-Message-State: APjAAAWjbm/5w3xIbCPE3t0DMqArrrXLKkJxXB4Mrm3S8syOomVwkC/3
        xse+z4chI6oMROqcVa+jeYN76C4QLJ8=
X-Google-Smtp-Source: APXvYqwJlApLg8k9xUxoYw0CE/f4MdedKH2O4nqfxcLPO80QsXqJI7H8K5qQm2kHNNu+5G5eP+9BCg==
X-Received: by 2002:a17:902:4683:: with SMTP id p3mr72153269pld.31.1563848039881;
        Mon, 22 Jul 2019 19:13:59 -0700 (PDT)
Received: from continental.prv.suse.net ([191.248.110.143])
        by smtp.gmail.com with ESMTPSA id v126sm7999257pgb.23.2019.07.22.19.13.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 19:13:59 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, hare@suse.com
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 2/2] include: elevator.h: Remove started_request from elevator_mq_ops
Date:   Mon, 22 Jul 2019 23:14:39 -0300
Message-Id: <20190723021439.8419-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723021439.8419-1-marcos.souza.org@gmail.com>
References: <20190723021439.8419-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function is not implemented by any available IO scheduler, so
remove it.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 include/linux/elevator.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 17cd0078377c..1dd014c9c87b 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -45,7 +45,6 @@ struct elevator_mq_ops {
 	struct request *(*dispatch_request)(struct blk_mq_hw_ctx *);
 	bool (*has_work)(struct blk_mq_hw_ctx *);
 	void (*completed_request)(struct request *, u64);
-	void (*started_request)(struct request *);
 	void (*requeue_request)(struct request *);
 	struct request *(*former_request)(struct request_queue *, struct request *);
 	struct request *(*next_request)(struct request_queue *, struct request *);
-- 
2.22.0

