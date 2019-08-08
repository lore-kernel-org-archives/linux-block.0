Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC860C0650F
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 20:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF5F21743
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 20:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404055AbfHHUFU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:05:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42972 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732704AbfHHUFU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 16:05:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so44026992plb.9
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 13:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFGSxl9VItZvVMU/SEOzPttnqjIgO4UH7axrM2LnrbY=;
        b=XCxGKpUh1mZwMZunhIrvLATMyYQYYMfS+wE4uyTG+taW0MjyIINk/9AabvsaYfSFOF
         oTRshYogI+RqOaGEsxLccuWwqD/c5lM4OhQGr7Oy7mU4TTiro0OureINHyeCgaG0x87q
         nYw+dB09IAVh43s+H3jj0CcbCl3DS0+uDBejJbw18+6L2QcZHKu8BRDAmMkRjbCYzLUE
         HXyAnw43cq/huJiOtkA9tvQIQZ/9lruMRq/DRvyqZwtW2gHnlCXKb26tijY+ByuhlH9t
         nAf39amo1gVvy2A4zC3zL6OYl5mAjJiQDdHsz1Shuz8kO0B9Fg0GJcB8aIvxn5vAj/sS
         Wriw==
X-Gm-Message-State: APjAAAWKVXtZHU9R5CHfKIs4X01pinDnw693cAynEispIr3+OUphwGXa
        lBOAVvInv/z4gH/9hoo0iHw=
X-Google-Smtp-Source: APXvYqxndmd9LitS7xXGPCLHqRWjGo7/WY2f2NGu87RKu26fKeYea7hH7P5Jo/xFtqiVKqH3GTuMmA==
X-Received: by 2002:a17:902:b418:: with SMTP id x24mr2900494plr.219.1565294718736;
        Thu, 08 Aug 2019 13:05:18 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b6sm83307093pgq.26.2019.08.08.13.05.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 13:05:17 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 3/4] tests/nvmeof-mp/rc: Make the NVMeOF multipath tests more reliable
Date:   Thu,  8 Aug 2019 13:05:05 -0700
Message-Id: <20190808200506.186137-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190808200506.186137-1-bvanassche@acm.org>
References: <20190808200506.186137-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the following failure for tests 002, 003, 004 and 011:

+tests/nvmeof-mp/rc: line 99: echo: write error: Operation already in progress

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tests/nvmeof-mp/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index 7352b1628cd3..2493fcee12de 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -124,7 +124,7 @@ simulate_network_failure_loop() {
 	done 2>>"$FULL"
 
 	for ((i=0;i<5;i++)); do
-		log_in && break
+		log_in 2>/dev/null && break
 		sleep 1
 	done
 }
-- 
2.22.0.770.g0f2c4a37fd-goog

