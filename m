Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48138C43217
	for <linux-block@archiver.kernel.org>; Thu, 16 Dec 2021 16:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbhLPQFn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Dec 2021 11:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbhLPQFn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 11:05:43 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFAFC061574
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 08:05:42 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id x6so35532632iol.13
        for <linux-block@vger.kernel.org>; Thu, 16 Dec 2021 08:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrsB3UCm4bmi73wguDQBqQCr2m0pev3vraLfK00rcq4=;
        b=NASmxMQXOzlzQl2P97eko9egq2Ee1UYORkMMfIMKOdwKqjMhjXLDTv/9JYPlKBgGCr
         oYeCIdjtUfNRkeKpro/j7f8I9AC7YQ0f6tSQUYAppLrQW5NSx2adWPwop+FeVVvPMwZf
         hMX8tXRXS3IJ8x86apPVybcmoWRw1Z2knYpIGBBBQUXUrDGaRZx5bl1rSsx0h2pZQEFB
         STbDmk7bPjwm2NWSA2mf6VHl2AUdvkGw+UN6veCxGHs8D5dUpLXg+hs6p8WvgR+vSz5j
         JJLipSh854HDnsQdrDVbPWzmviIyo/gLLA4+x4MDcBYeHq/0Ij1UZ6uSDBO0o9/DHqpd
         UdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrsB3UCm4bmi73wguDQBqQCr2m0pev3vraLfK00rcq4=;
        b=kGJzEmBXu4oAAVPImcyQdvcb2GsO4kfNA/NF9J/uiwhUFr493bbRZuWFmAUZ+gQjvP
         Pl3Df3WuCyflq5HMJo4xa6VCsyIa4RDAwWaLGZphyBSiImjkfDGVpQIJc7FVmobce0Gh
         PoJO0ES61a1BzGZo6cQ2xIBz5uQgWnWTGJfeNMVNFms6xYIuuhNCdrVrX39Mn688f3hu
         AfjZzcJQuNYhkn7iF/Z8qLLCO5b5StBOPD7aBwNXRxv/BM7iyyuUrqGapMF5XKeF9eK1
         DEESBsgZs+xo59a3AhGFvGu5DE1G6zqYsMxYFW5g1uvLHeQsAxzfO2EvchCXbIQt4/gC
         U52Q==
X-Gm-Message-State: AOAM531uWWSNzFfipPHyKPyMhO6nQ7RlosXrSnqP1YMYzRP788u/dCq4
        md+qcgvPjSOR7/ZSv9qPU87G7w==
X-Google-Smtp-Source: ABdhPJzr/bFJjYd6Il7Y+kIQ7ggNza0pgizMOaeK51YYrulffnpxoSLrnypU+JIpE8iPqtsuB2JQEQ==
X-Received: by 2002:a05:6638:4089:: with SMTP id m9mr9928722jam.187.1639670742320;
        Thu, 16 Dec 2021 08:05:42 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s9sm3237155ild.14.2021.12.16.08.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:05:41 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 2/4] nvme: split command copy into a helper
Date:   Thu, 16 Dec 2021 09:05:35 -0700
Message-Id: <20211216160537.73236-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216160537.73236-1-axboe@kernel.dk>
References: <20211216160537.73236-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We'll need it for batched submit as well.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8637538f3fd5..09ea21f75439 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -500,6 +500,15 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
 
+static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
+				    struct nvme_command *cmd)
+{
+	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes), cmd,
+		sizeof(*cmd));
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+}
+
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -510,10 +519,7 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 			    bool write_sq)
 {
 	spin_lock(&nvmeq->sq_lock);
-	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
-	       cmd, sizeof(*cmd));
-	if (++nvmeq->sq_tail == nvmeq->q_depth)
-		nvmeq->sq_tail = 0;
+	nvme_sq_copy_cmd(nvmeq, cmd);
 	nvme_write_sq_db(nvmeq, write_sq);
 	spin_unlock(&nvmeq->sq_lock);
 }
-- 
2.34.1

