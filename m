Return-Path: <SRS0=9ghM=BF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF54C433E1
	for <linux-block@archiver.kernel.org>; Sun, 26 Jul 2020 00:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75ED720719
	for <linux-block@archiver.kernel.org>; Sun, 26 Jul 2020 00:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgGZAXI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:23:08 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:32913 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgGZAXI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jul 2020 20:23:08 -0400
Received: by mail-pj1-f65.google.com with SMTP id i92so375814pje.0
        for <linux-block@vger.kernel.org>; Sat, 25 Jul 2020 17:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kzUvv4wu5ssPzXeGgDw5vla87R2Q2Tzs154QAybre/M=;
        b=owREO797K3+RyiiAPpOI8gkW5adQyoKHiXguZWsYKxFSmG3+1mFsddjX2J0Xq5kXv+
         b7bivw2Jjae4Uf9rEUmDx6hRboQ0oclrHO8t7m50oMudfuAM/VN/76oMTKRd4TGB7UYE
         rpcJZctCJVLOSHXsnJ7zaa+k1m1AcRb0zf8IPqRgAwVqk+zxhJAVEDv2blxA3cyklweA
         9YptZ39BJkll7RwoQ4MMZA7UN+cGYD+YOGfag6H99fjNiALCrEj6NfWYh5jbpIjlxFrT
         Zxk5u7n0oh5MEIo9KiKh+W6d1b/jt5J8S5ajc/yYqL8OEzyj2UC04FjCueCEXeBq/xt1
         FNKw==
X-Gm-Message-State: AOAM530HHZuZyGFshq860PcOgalMVupzauGFM69gog//RzbpCXmuShpV
        rJ1Qk91g4ZaNZnS+MvglK2wSImR2
X-Google-Smtp-Source: ABdhPJxWwkAga5zev8d9iBVMpMFXDowL+DPZC5cPQP4ZuayCuRCNYPruAe2i4Gxr6EezIsi/LlOcFQ==
X-Received: by 2002:a17:90a:7441:: with SMTP id o1mr12401882pjk.71.1595722987816;
        Sat, 25 Jul 2020 17:23:07 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:c428:8d39:30dd:38a5])
        by smtp.gmail.com with ESMTPSA id z62sm10185620pfb.47.2020.07.25.17.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 17:23:07 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>
Subject: [PATCH v3 2/2] nvme: improve quiesce time for large amount of namespaces
Date:   Sat, 25 Jul 2020 17:23:01 -0700
Message-Id: <20200726002301.145627-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200726002301.145627-1-sagi@grimberg.me>
References: <20200726002301.145627-1-sagi@grimberg.me>
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
index c16bfdff2953..45f1559ee160 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4535,7 +4535,9 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 
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

