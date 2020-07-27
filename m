Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1C1C433E1
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 22:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E382072E
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 22:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgG0WHX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:07:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34986 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0WHX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 18:07:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id d188so3802234pfd.2
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 15:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lGFmsfpmP1LvxqwpCX7vdhM/VjA4HywoeDLN1d97U/Y=;
        b=s+E3FvemYI5PayeQi+Hht/C11n4r2cv4vVW2pP7FIZ+eFsvaxtVyGa/Ky6dy8hquLY
         F4Ro4RFjFnozGFygaor8kulSrejYo8UQfsXfk8eVQcH8Kx5VAc9jtgqVY3w7FjVWjDGr
         hoNBFKVkhI5y/iTIF6KuOttzxi4I9DpmBOBCok5RVyjxSPRpwDN2vvHIuwVPy2EtARdI
         QVpiqnUZn2wK1ADH618sIk2X0Ix8M3RnV4DVrtwldtaxhg+iBVw4mVYMzNBCO0qC3UWK
         LAPrks6x5OdaLNGE03dkaWZ6c66bhQaIVLRKF4qiif2ChlnvoRzMIWsOfSt/91SKJWi9
         Rruw==
X-Gm-Message-State: AOAM5306VGzrTWBh8An89L98pgZYyMNAdVWhuIfmxQOvb8XxHNyxoDa6
        zuCc/94n6ktUxvTZXkIGSRk=
X-Google-Smtp-Source: ABdhPJzuDeMj0q/suaY9WEziGI3xiE+NvrLUxYpSNGDvlnh8u19J/jpAnrSeRuRwL4vxj8m9KDhP5A==
X-Received: by 2002:a63:515a:: with SMTP id r26mr23126086pgl.204.1595887642531;
        Mon, 27 Jul 2020 15:07:22 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id s4sm2309519pfh.128.2020.07.27.15.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 15:07:21 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Subject: [PATCH v4 2/2] nvme: improve quiesce time for large amount of namespaces
Date:   Mon, 27 Jul 2020 15:07:17 -0700
Message-Id: <20200727220717.278116-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727220717.278116-1-sagi@grimberg.me>
References: <20200727220717.278116-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvme currently will synchronize queue quiesce for each namespace at once.
This can slow down failover time (which first quiesce all ns queues) if we
have a large amount of namespaces. Instead, we want to use an async interface
and do the namespaces quiesce in parallel rather than serially.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05aa568a60af..e8cc728dee46 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4561,7 +4561,9 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_quiesce_queue(ns->queue);
+		blk_mq_quiesce_queue_async(ns->queue);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_mq_quiesce_queue_async_wait(ns->queue);
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
-- 
2.25.1

