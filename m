Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1F1EB64DC
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 18:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGJSCw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 14:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjGJSCw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 14:02:52 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9557128
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 11:02:50 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-263036d4bc3so3495438a91.2
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 11:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012170; x=1691604170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EY7/MdXMbHZJmt1qUeo9JN1ygy4O7c3IfbaOSwHr8k=;
        b=XnWcS9KUONIGx9K8wxPvn11tsnyRYrW6u7kQ61AWlLKEcq03sU3WvpzIVrAFE8jP16
         tfE+37w6LVqOLNiG6Per9CdaxDKlO2O1XZlRdUsorkLh95bIBh4aZDt1wt6nYAvDdPxS
         BIqV344uRV1WqHae+batLDq/9mD1D+IcYV/GDnlHlGTpMjEFIudL5yBEpgl9hiv/si4H
         weh0SZ475egXeQDDWrvUJFgfbr6T69GOsTXEzACGbfsLojW7opq1MdLPtN/N+YGKh58+
         4GNCGWqwX/zLRgL+ql8SqHdCo+QHQ9toS9y7FiJsW1H8tv3yytZ2rEMWc6F2VzUFn5KQ
         Bxug==
X-Gm-Message-State: ABy/qLZ2vUhq0/83hSGP/Rgd+BuBusm3DBasfr1OP9uqPVg7qNn2cI4S
        ePplr29l3zEG7Zbkk9T3++s=
X-Google-Smtp-Source: APBJJlGrQQgCP319ix8sUw1znhWbJPNJRoutDjk3xbjqoKuGIdOQy/DSzvAH0IP6G71y/xwEDj4rRQ==
X-Received: by 2002:a17:90b:283:b0:263:45c3:b17c with SMTP id az3-20020a17090b028300b0026345c3b17cmr14045721pjb.14.1689012170178;
        Mon, 10 Jul 2023 11:02:50 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:e582:53b1:a691:ab70])
        by smtp.gmail.com with ESMTPSA id gt4-20020a17090af2c400b00263f446d432sm6531846pjb.43.2023.07.10.11.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:02:49 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Bean Huo <beanhuo@micron.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Ziqi Chen <quic_ziqichen@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Adrien Thierry <athierry@redhat.com>
Subject: [PATCH v2 5/5] scsi: ufs: Enable zoned write pipelining
Date:   Mon, 10 Jul 2023 11:01:42 -0700
Message-ID: <20230710180210.1582299-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230710180210.1582299-1-bvanassche@acm.org>
References: <20230710180210.1582299-1-bvanassche@acm.org>
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

This patch improves small write IOPS by about 150% on my test setup.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index e7e79f515e14..8d0e495ae6fa 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5146,6 +5146,7 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 
 	ufshcd_hpb_configure(hba, sdev);
 
+	blk_queue_flag_set(QUEUE_FLAG_PIPELINE_ZONED_WRITES, q);
 	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
 	if (hba->quirks & UFSHCD_QUIRK_4KB_DMA_ALIGNMENT)
 		blk_queue_update_dma_alignment(q, 4096 - 1);
