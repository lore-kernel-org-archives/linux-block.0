Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA640C63797
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbjAIX2L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237945AbjAIX2C (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:28:02 -0500
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3497CB49B
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:28:01 -0800 (PST)
Received: by mail-pf1-f175.google.com with SMTP id g20so7428173pfb.3
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 15:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWjzdVi+aWCeBtDSYSYYVmiFG7iSPPW9f3buG776fN4=;
        b=QFKcjRYZASp+O+/2yx24VaWTKvxjwMc73XLcU7QQE9szzflEAnkOXEOKs5AxH0gOTk
         uJFHWzoAar6k+tl8S+YytlGtJS1PNfPre6P7OAVwLmvPyjtjiWFCYKFNrdfg7dokpsqv
         KjhLHAcm5UKDlS1NL0waSrzKEK9JFWFeeUN+/1NpNunJN5ziQS82dvGcR6qcHkKGnbUD
         ewHgwU8BlhuDvyuCPDolb2n1/pn7G9PW06vkIUBNTUDdaW2pwunfzbphyzsKTaYXtbun
         wITTZwqtXCzR2Krqh1Z+cb6+MLQ7ymcgnGSiglFZ+ppq1OZlrz4LAZQ3IKSEgcAFQiaV
         q14g==
X-Gm-Message-State: AFqh2kq3AMvQ5dR8086bTd2w8QFEpnLBO0quEVHRJ975jCClhuS1yHZw
        mr/+DvXqH1ZbS16zUut501k=
X-Google-Smtp-Source: AMrXdXtbrhAvSS4fg34fXFxwLfYAT7R8ti1/P5zSwM65EmGYclDYBq0GedKs7uAMmDr7p7ZaXe6PQQ==
X-Received: by 2002:a62:1d0e:0:b0:57f:ef11:acf8 with SMTP id d14-20020a621d0e000000b0057fef11acf8mr64630016pfd.2.1673306880671;
        Mon, 09 Jan 2023 15:28:00 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id s2-20020a625e02000000b0057ef155103asm5032244pfb.155.2023.01.09.15.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:27:59 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH 8/8] scsi: ufs: Enable zoned write pipelining
Date:   Mon,  9 Jan 2023 15:27:38 -0800
Message-Id: <20230109232738.169886-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230109232738.169886-1-bvanassche@acm.org>
References: <20230109232738.169886-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From the UFSHCI 4.0 specification, about the legacy (single queue) mode:
"The host controller always process transfer requests in-order according
to the order submitted to the list. In case of multiple commands with
single doorbell register ringing (batch mode), The dispatch order for
these transfer requests by host controller will base on their index in
the List. A transfer request with lower index value will be executed
before a transfer request with higher index value."

From the UFSHCI 4.0 specification, about the MCQ mode:
"Command Submission
1. Host SW writes an Entry to SQ
2. Host SW updates SQ doorbell tail pointer

Command Processing
3. After fetching the Entry, Host Controller updates SQ doorbell head
   pointer
4. Host controller sends COMMAND UPIU to UFS device"

In other words, for both legacy and MCQ mode, UFS controllers are
required to forward commands to the UFS device in the order these
commands have been received from the host.

Note: for legacy mode this is only correct if the host submits one
command at a time. The UFS driver does this.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index e18c9f4463ec..9198505e953b 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5031,6 +5031,7 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 
 	ufshcd_hpb_configure(hba, sdev);
 
+	blk_queue_flag_set(QUEUE_FLAG_PIPELINE_ZONED_WRITES, q);
 	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
 	if (hba->quirks & UFSHCD_QUIRK_ALIGN_SG_WITH_PAGE_SIZE)
 		blk_queue_update_dma_alignment(q, PAGE_SIZE - 1);
