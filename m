Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2066C001DC
	for <linux-block@archiver.kernel.org>; Mon, 17 Jul 2023 20:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjGQUxQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjGQUxP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jul 2023 16:53:15 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE6810FE
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 13:52:32 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2674d0e10c4so2617101a91.3
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 13:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689627152; x=1692219152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH+74KMTL+L9e/FPJJhBQz9M6cjA6jC0gGOvpB2jAmc=;
        b=CuslUpiddDiFhafVdkKe9Dy9tPlaefwNgDAfrjQeWdRqYkrYgD/rK1jj9TkFWdf3nS
         V0DmWawtcpFWfsuBDtlw7fUX2sPSP2ws0wwCnoyY8O9rC3ztczWZ1e9BXiD6LZvDyrsI
         sz92h7PNBrC4bJXk+qJuCf/EDkfObK7IgrGpczpzgP+KSU/bS0h/PwzpYDIXWNnk/Vzm
         Wwe1MDKBaPRCV2S1S4qtE+fbfJ5A/UAjqN7mIZMNfcvry5It+C9OxbuQAGVzfVvcC0hD
         LxdGOAuMoQbup/tqD5BiWo5lk21qOEYD8MTmpY7iQnYNintdgE/j5ar48CA6Q1UZHgdx
         8XDQ==
X-Gm-Message-State: ABy/qLZlcKA4bDO3abWK6OkntPKVzinAQvnSkJAP2mhpP6+ceM+PYrzB
        si/nf/T3QU4XsWhmYxHeJWX4hptvMx0=
X-Google-Smtp-Source: APBJJlE0MrMC2wiJqc4A2PixPJLclEPbgbnkga1Ii5YHp/GF6UUsQaWiLzDMiU6TTyMF7FDWPPYecA==
X-Received: by 2002:a17:90a:9307:b0:262:df58:2411 with SMTP id p7-20020a17090a930700b00262df582411mr9460711pjo.18.1689627152155;
        Mon, 17 Jul 2023 13:52:32 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ac3:b183:3725:4b8f])
        by smtp.gmail.com with ESMTPSA id v17-20020a17090abb9100b0025645ce761dsm5222403pjr.35.2023.07.17.13.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 13:52:31 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH 2/3] scsi: Remove a blk_mq_run_hw_queues() call
Date:   Mon, 17 Jul 2023 13:52:14 -0700
Message-ID: <20230717205216.2024545-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230717205216.2024545-1-bvanassche@acm.org>
References: <20230717205216.2024545-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_kick_requeue_list() calls blk_mq_run_hw_queues() asynchronously.
Leave out the direct blk_mq_run_hw_queues() call since it is
superfluous. Note: scsi_run_queue() is not called from the hot I/O
submission path so there is no performance concern.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_lib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 414d29eef968..7043ca0f4da9 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -448,7 +448,6 @@ static void scsi_run_queue(struct request_queue *q)
 		scsi_starved_list_run(sdev->host);
 
 	blk_mq_kick_requeue_list(q);
-	blk_mq_run_hw_queues(q, false);
 }
 
 void scsi_requeue_run_queue(struct work_struct *work)
