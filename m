Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D1CC28CC2
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8368025972
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfEaABE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 20:01:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37517 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaABD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 20:01:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id e7so2729674pln.4
        for <linux-block@vger.kernel.org>; Thu, 30 May 2019 17:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a3M4CAL5+YI0RIrBs3HShKXlvw263WQkN/Gvkpmg3h4=;
        b=h7lT3Hj3Krq8tYSo0MhBya65aLbLIPlF0CVfpaRxOcLdceNl7d/HTTc39cNPP7buB6
         sfuZoQ33MJpSapX9OuJd3vKG5wJ6Jz8r0UskTr7R/bhtP9c3lHfZb+FpJRsqpxqsQ2Fu
         zTt5Uo6I859+fy97BbibP3Zjkx0viEyq5/DVedWGwblcAOF7CZ6xG3kxztLu6BzvtUPK
         e/MKj4wMrE7eAk3p/vsGzVQNrY2owHMbFh6kJiDsTjPm4B1JpY3uI/8hyBj5KcE2OuME
         5Yg7n1zQVojUsikb/GRRR5UnLAOqYC/JiqLIQaa/SjWQBCSu2aBcpV8Y73B41F1s/oAC
         EVww==
X-Gm-Message-State: APjAAAUyHk2yeNA+ggPIuI8OP6MUiOFnhR0lh3fy//JaMEV5ic9Pa0/V
        j+bFotl/1BYi/vpINiCV5MI=
X-Google-Smtp-Source: APXvYqw+BoAjeruYMepu+bHBwPkV4sNLsG4LMZNbhknOxQfbgPstg/Lw9pO24EJ7yKZ2NnIeQrsQJw==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8mr6293573plp.105.1559260863004;
        Thu, 30 May 2019 17:01:03 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g8sm3539851pjp.17.2019.05.30.17.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 17:01:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/8] block: Convert blk_invalidate_devt() header into a non-kernel-doc header
Date:   Thu, 30 May 2019 17:00:47 -0700
Message-Id: <20190531000053.64053-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190531000053.64053-1-bvanassche@acm.org>
References: <20190531000053.64053-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch avoids that the kernel-doc tool warns about this function
header when building with W=1.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/genhd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index ad6826628e79..24654e1d83e6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -532,8 +532,8 @@ void blk_free_devt(dev_t devt)
 	}
 }
 
-/**
- *	We invalidate devt by assigning NULL pointer for devt in idr.
+/*
+ * We invalidate devt by assigning NULL pointer for devt in idr.
  */
 void blk_invalidate_devt(dev_t devt)
 {
-- 
2.22.0.rc1

