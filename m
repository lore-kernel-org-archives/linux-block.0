Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33EAC433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 17:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345050AbiFNRuD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345067AbiFNRt7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 13:49:59 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C739834B93
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:49:58 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id h1so8329704plf.11
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmdhgrhYHwEjRTnnC3UU3+gDPCKazau9D7Dw49utVSE=;
        b=oHhpxD2ZBvLd2DYTHzobA/xla7/CMSbCrTSPXHZc7PQisAjnNRnidWG5umXhmRdsNT
         dZQQQk4swohsc1+x1LEvDVqTK9j+R2u/SOJY/0maYwGE6Ycs6bbKc3H3v+vPeruL4tND
         3uiY1gI2h/8Z8GoAeaxpaTTGsw+u92i5gFr7Ff8GvdlzzNo4nscgr2M51o606yP/iruH
         h5Ol2NgGTyII9DgpvUmqBFKKPc2WmuazStDxs5/LefNQhCrfSgqXpMhLWkhMk3FzhrSt
         uUIGFRK86SSjZ5kPP9SUIEyp52MZbIS2uBzk6AvelAMjsTA8HOlc/8Tbu0pCMHZ5tfxu
         8/zw==
X-Gm-Message-State: AJIora82Q9Y0TBKfO51rYk59d0afFYtShrcjDmW2PFR4pi7hJJghPsyk
        mkuRjBVJrhGauMl/7R/MgIM=
X-Google-Smtp-Source: AGRyM1vnZo5qQMzWofnBCnHS6q8wNOXdWiYx74S2v5+IBXYkILgFc9hBsxzEmwOjCtp2SAZPAySwqg==
X-Received: by 2002:a17:90b:38c4:b0:1e6:89f9:73da with SMTP id nn4-20020a17090b38c400b001e689f973damr5764817pjb.220.1655228998436;
        Tue, 14 Jun 2022 10:49:58 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id gd3-20020a17090b0fc300b001e2da6766ecsm9866922pjb.31.2022.06.14.10.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:49:57 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 4/5] nvme: Increase the number of retries for zoned writes
Date:   Tue, 14 Jun 2022 10:49:42 -0700
Message-Id: <20220614174943.611369-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220614174943.611369-1-bvanassche@acm.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before removing zone locking, increase the number of retries for zoned
writes to the maximum number of outstanding commands.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fe0d09fc70ba..347a06118282 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -854,6 +854,10 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	if (req->cmd_flags & REQ_RAHEAD)
 		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
 
+	if (blk_rq_is_seq_write(req))
+		nvme_req(req)->max_retries += req->q->nr_hw_queues *
+			req->q->nr_requests;
+
 	cmnd->rw.opcode = op;
 	cmnd->rw.flags = 0;
 	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
