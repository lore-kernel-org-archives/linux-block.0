Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DF5C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 02:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACFB2086D
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 02:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRnUGBiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfF1Cqa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:46:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36145 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfF1Cqa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 22:46:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so2196904pfl.3;
        Thu, 27 Jun 2019 19:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lprdAp4I4hQ+OkI+ylVrTJYpLV/EDTCILsV7Or+t/p0=;
        b=qRnUGBiCGvsZ8fUArtk9j36WGi9y2mAT6/TC1A6rjFvwCsB8PrtpKEVzOlTG3rctgn
         WSeUjZsn1CKL58xHAP9Xz/cEzsuFMCXUXuMX2JVq4STdiebN0ZDBHsv0ha9g3oWrYERV
         3ngNL0fdNR1m5D7Yc7CY+6gKI8Kg+17IDglcaeuQcirobvcX2p6yHl9QuLPQNz/qhHTt
         Mw3sVrVKzkwUp8PjOEnTkq0vx/LrjntZ3nT45v2s+XiMpurEce4rKVJma+XdPjJ4X5Oi
         4Vy0O/HrnmjnKdphz0I1a/rP2affFk6QGgvsir+Ug0u/rMUSZN2IXxU7PXlsVb5/hXME
         8GTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lprdAp4I4hQ+OkI+ylVrTJYpLV/EDTCILsV7Or+t/p0=;
        b=qmC2C7YQ3axQqHk002uX/nb9IiOWldwKuBOkjgpoSdW4s0K75QKcT1dGJuEsk+mE7r
         7ez196GxONWnbbgAw6wjIWuQwB1ENraJF2O9pCJS3FQGMzU98WLjEiHB/WtL3YvSHw/6
         ZQi7Yq4lLEXEulUZC8IiZ7Ukfi8P5QPaZHW7Vqu4UZcrtAVVHikJwrxY9XrpyZJ75fCn
         9Wytjd7M5Ax2z1+vguyZ6CHI/OpiJF0iw0MFYIvqOllIaXtHP8QHwK8ToX6EbTmeLq2h
         jDk4JvM2OdU2rCi6LVEHYwDjnNbwluQxkNFMmZFoOUHMll65dQwd/JQSqUJmBGgNxcVe
         a3TQ==
X-Gm-Message-State: APjAAAXiZGNNYFW6SEKZxvaQoSgxLWZRlVo1dDWd05MhyGY1guqXWGSW
        PtuogJKOnlMU7iuHGEmnFDc=
X-Google-Smtp-Source: APXvYqyGR38R3mD9hcOIzCcth3QJI225sFSiDpnXYkNIEuBlCwG+5bS62rECzwR+U1YMEzKaYIQ0bw==
X-Received: by 2002:a17:90a:d817:: with SMTP id a23mr9984385pjv.54.1561689989375;
        Thu, 27 Jun 2019 19:46:29 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id n89sm12095775pjc.0.2019.06.27.19.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:46:29 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/27] block: remove memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 10:46:21 +0800
Message-Id: <20190628024622.14981-1-huangfq.daxian@gmail.com>
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
 drivers/block/skd_main.c          | 1 -
 2 files changed, 6 deletions(-)

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
diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index c479235862e5..51569c199a6c 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2694,7 +2694,6 @@ static int skd_cons_skmsg(struct skd_device *skdev)
 		     (FIT_QCMD_ALIGN - 1),
 		     "not aligned: msg_buf %p mb_dma_address %pad\n",
 		     skmsg->msg_buf, &skmsg->mb_dma_address);
-		memset(skmsg->msg_buf, 0, SKD_N_FITMSG_BYTES);
 	}
 
 err_out:
-- 
2.11.0

