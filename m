Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05740C48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 17:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24342064A
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 17:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZ1DO9kN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfF0RfP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:35:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41335 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfF0RfP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 13:35:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so1570362pff.8;
        Thu, 27 Jun 2019 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Dk5sQ5ZFeuoZXTtaSHu6PQg+hlqGUQKhdZoVXzJW+cE=;
        b=sZ1DO9kNOru7Hq4zMswf4bV9ZwyJP1N7GcRlNpkSg2w9IcAK0LPGy2PsjERhQu5Wwt
         uwnn4VGgLKOkfRU5tsQ3Zbr0dfUA0NyZHd5qR1f7vaQ6iTz2Nga55m+GIzVSeOp95We5
         qyPOuz0b0s5xtIaU+J1qrN0ZVNNgVJiJUzZ0WLzRvqj7df7CwLevm7mZ6lTWfgYD410U
         OFtEGPPX0zgov9e/8oqdVDQkX4sCDapetUYlxrYnCIE6bpMzcwqZGeMVta6wdAi2sR0Q
         49HK7k7sx4OdAGTZOUbozYH0b0S63cK7XHuSXMf6/30vc1q8WbmSeMROH6R+oS+gE8ub
         ifGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dk5sQ5ZFeuoZXTtaSHu6PQg+hlqGUQKhdZoVXzJW+cE=;
        b=b1L90lw88UJBt23yp7vHeWES0474b21vI4T08nlvw1sk1QvbXTdiu2+w9ubiiXRKer
         ldl2lxpsvyCmCWphP6biuyxkUkCrf2+wIzuSfedU1Oxyzk4b2zulzAZY9kD7ljzWu/3L
         amRAoz6MrmXr4yI2oMEeV4sK0raO7tE8b5M3qB36SyosHM2P2/mFacgTrTgWdU3bb/sA
         GWfOTehFR/BQgy6gqJe7Fy99GqiyulMFuZMuFVDI8SqogAnFg3YOg+6DlNjxflBhHfNk
         cozRnoVdBc+QxKvQbH/JKSeMOAGFIJE9AuTKH9IT+xmqqJoQhpc0KGrZiia+RgBtPHwJ
         9hpA==
X-Gm-Message-State: APjAAAUkled91fqW7TVEKlfr07LC7EF3B9DZknM6JVIDB8OA/OeqTv9b
        +UCLXRR9r3NDNFeloM3sJPM=
X-Google-Smtp-Source: APXvYqxBSOWXRRaKR+KPeMqkLOw2Ne+DglGuBMoRhdQ3PEjUKB80d3TM/Nh2iRMVrtumzHXqeUBPYQ==
X-Received: by 2002:a63:905:: with SMTP id 5mr4911406pgj.173.1561656914413;
        Thu, 27 Jun 2019 10:35:14 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id a21sm4999687pgd.45.2019.06.27.10.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:35:14 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/87] block: mtip32xx: Remove call to memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:35:04 +0800
Message-Id: <20190627173506.2297-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index a14b09ab3a41..964f78cfffa0 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -1577,7 +1577,6 @@ static int exec_drive_command(struct mtip_port *port, u8 *command,
 				ATA_SECT_SIZE * xfer_sz);
 			return -ENOMEM;
 		}
-		memset(buf, 0, ATA_SECT_SIZE * xfer_sz);
 	}
 
 	/* Build the FIS. */
@@ -2776,7 +2775,6 @@ static int mtip_dma_alloc(struct driver_data *dd)
 					&port->block1_dma, GFP_KERNEL);
 	if (!port->block1)
 		return -ENOMEM;
-	memset(port->block1, 0, BLOCK_DMA_ALLOC_SZ);
 
 	/* Allocate dma memory for command list */
 	port->command_list =
@@ -2789,7 +2787,6 @@ static int mtip_dma_alloc(struct driver_data *dd)
 		port->block1_dma = 0;
 		return -ENOMEM;
 	}
-	memset(port->command_list, 0, AHCI_CMD_TBL_SZ);
 
 	/* Setup all pointers into first DMA region */
 	port->rxfis         = port->block1 + AHCI_RX_FIS_OFFSET;
@@ -3529,8 +3526,6 @@ static int mtip_init_cmd(struct blk_mq_tag_set *set, struct request *rq,
 	if (!cmd->command)
 		return -ENOMEM;
 
-	memset(cmd->command, 0, CMD_DMA_ALLOC_SZ);
-
 	sg_init_table(cmd->sg, MTIP_MAX_SG);
 	return 0;
 }
-- 
2.11.0

