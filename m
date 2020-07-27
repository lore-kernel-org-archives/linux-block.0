Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32131C433DF
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B04520809
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgG0XK3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:10:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39589 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0XK3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 19:10:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id z188so2070065pfc.6
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 16:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rhPI1AK8s0t5ZglX+PETgazcv0kHzfPuguyROZL/wxE=;
        b=R6m/2SOUAqWOqU4/PywqQ7QSJ6fnhSLTISrumIfRKK7tb6TF2ncjPONlomt+RTwQMX
         G82K9vG6c/fSR/UGsGH5Nf7crSKsZskc3x2rrz+zW4Y9k/XEhprHzRGajx/+aMAObdfK
         L+XFYme/jPsSQ3dCrbcfLOtthgz+L7Np4EJKKy4Rw7cUCzAslXwltIoRRddFKtwoISMm
         h/0McIodx3FNuO1k2GJm/zahWWctq5J7zFjbmGUjBcsMOP0cI7jjZDhEk9/n8wX7AUa9
         ZXwNiI/qR/XJQt+jZFZCpCnedrRwJqL7rXjrL0HiK8MqKogg0xJgv14JF2HwGbi63sm1
         FPXw==
X-Gm-Message-State: AOAM533cMks9OzhP8vMqhnUjkhygBi7a5g8tICqVV57g/SIphs45mm4h
        ILNyOaIIcn+RxPl+BiiKdnw=
X-Google-Smtp-Source: ABdhPJwN/y5+qq3rd5tJTCca6/CBeuaY47jNx6qXZwnx26i6zeOQ5qwwrsmdbrP74v2FNbHJnC+6AA==
X-Received: by 2002:a62:7942:: with SMTP id u63mr21722936pfc.54.1595891428381;
        Mon, 27 Jul 2020 16:10:28 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id z190sm7407171pfz.67.2020.07.27.16.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 16:10:27 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Subject: [PATCH v5 2/2] nvme: use blk_mq_[un]quiesce_tagset
Date:   Mon, 27 Jul 2020 16:10:22 -0700
Message-Id: <20200727231022.307602-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727231022.307602-1-sagi@grimberg.me>
References: <20200727231022.307602-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All controller namespaces share the same tagset, so we
can use this interface which does the optimal operation
for parallel quiesce based on the tagset type (e.g.
blocking tagsets and non-blocking tagsets).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05aa568a60af..c41df20996d7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4557,23 +4557,13 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
-
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_quiesce_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	blk_mq_quiesce_tagset(ctrl->tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
 void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
-
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_unquiesce_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	blk_mq_unquiesce_tagset(ctrl->tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
-- 
2.25.1

