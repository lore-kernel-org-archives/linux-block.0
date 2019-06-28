Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A56DC4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5187208C4
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfF1UH7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:07:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36421 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfF1UH7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 16:07:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so3532254pfl.3
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2019 13:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YzjQUCzMMWqN95NqHm9kNlqyu4468/vZuxTyImQfx4A=;
        b=qfZADct3oIh4VkxDTjBlYLBnx2yf52hynP+j3AB+GAVNbxDmrR8Lmt3MMM09jcG/B8
         TtukD7KHynd+4EurxMREbNX22R+gspFEbr1+BElADLsbFFFxX+aqtUVk2CP1h+qdzQid
         VJBTW9zd6ovtU/U0PRilgYzHjFbjmY9gt2FkLUdcW7kKXIJPmvXzxwruAotqEFQv3XVP
         Ia0AO/nQnvtYrRwVfPSoBiT+So/wcyCk3pcUsQZ/6J/GTj5Zce0sJIVItbfRNumqN5hT
         JD3N6fwVQaFec+TbL2Kr8FluOFEue7vj0aVizC++zAXYBMqH6mnqQS0MW1Iwb8y8FmQZ
         OM8w==
X-Gm-Message-State: APjAAAWeDOrmyyBWBfFWtTYIWrWhkUo+k3cDpmGK70ghqZwIv++Ujexy
        yooMN9nfGEIduExg2FTkOd8=
X-Google-Smtp-Source: APXvYqzfaCAwlcej9WZu2IQw1zaj9QNkZIHC0SFoF03PcPEguAzz4n11v4d/YLABd7jnQAbH6QHTMQ==
X-Received: by 2002:a17:90a:3225:: with SMTP id k34mr15103389pjb.31.1561752478360;
        Fri, 28 Jun 2019 13:07:58 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 65sm1186010pff.148.2019.06.28.13.07.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 13:07:57 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 3/4] block, documentation: Explain the word 'segments'
Date:   Fri, 28 Jun 2019 13:07:44 -0700
Message-Id: <20190628200745.206110-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190628200745.206110-1-bvanassche@acm.org>
References: <20190628200745.206110-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Several block layer users who are not kernel developers do not know that
the word 'segment' refers to an element in a DMA scatter/gather list. Make
the block layer documentation easier to understand by stating explicitly
what the word 'segment' stands for.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/block/queue-sysfs.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
index f6da2efe2105..1515dcf3dec4 100644
--- a/Documentation/block/queue-sysfs.txt
+++ b/Documentation/block/queue-sysfs.txt
@@ -98,8 +98,9 @@ This is the maximum number of kilobytes supported in a single data transfer.
 
 max_integrity_segments (RO)
 ---------------------------
-When read, this file shows the max limit of integrity segments as
-set by block layer which a hardware controller can handle.
+Maximum number of elements in a DMA scatter/gather list with integrity
+data that will be submitted by the block layer core to the associated
+block driver.
 
 max_sectors_kb (RW)
 -------------------
@@ -109,11 +110,12 @@ size allowed by the hardware.
 
 max_segments (RO)
 -----------------
-Maximum number of segments of the device.
+Maximum number of elements in a DMA scatter/gather list that is submitted
+to the associated block driver.
 
 max_segment_size (RO)
 ---------------------
-Maximum segment size of the device.
+Maximum size in bytes of a single element in a DMA scatter/gather list.
 
 minimum_io_size (RO)
 --------------------
-- 
2.22.0.410.gd8fdbe21b5-goog

