Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F336C352A1
	for <linux-block@archiver.kernel.org>; Tue,  6 Dec 2022 14:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiLFOMO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Dec 2022 09:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbiLFOMM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 09:12:12 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF6D627E
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 06:12:10 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g10so14002434plo.11
        for <linux-block@vger.kernel.org>; Tue, 06 Dec 2022 06:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rzdGFzx+TjrS2t/GJ6Iu3kMxv9cIRqVUv64fPauPFm0=;
        b=Lz1smSqjw3O1tyJb4iCD1UpOshI/bdv4hJo3q8zZyDFnghfUHQiCf5x2MuHg1AeagG
         nIABRkVSs0yPjWED+T62/ab1hXv+FQxUNG6L29E40yKvXrTVNSGd4z2/hd/phbd6uskH
         1BthheZRhxp3QO3mxhaPPtmWR6ijeldFRFByg6SIQpj9Er86W/m+XevTuXxeli30tj3N
         Wq2oCRrATFrTu/Decwas7nn79s9dCw7sSoMYY9kvMvULG04oGmNJFbW6UkYRI6NnJXbG
         h05fHNNZXjCuCtRYfTHNidmYc4M18WsgCSsnloLydaqavz5TIcZlMQPzOlL9Bjn4vJ7n
         Oaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzdGFzx+TjrS2t/GJ6Iu3kMxv9cIRqVUv64fPauPFm0=;
        b=zPpqfhhB5TDnKw+X1ZCg989a0S4PuszQa4Nqk8AGLonXMf2Q1o1UJjDqIyG5Rv6Jno
         /q0hKSxmAnd9FZx7houYbsXex7G/uMm/r62FQ/VkS5uvZB3z35Hz1uPGpegYsXVIwFP8
         Bn90CTiHPenhnttd8nhdfWlbma9lTuo+jdUt2JdoUPFUzV/b6KdDQBVqEpcxz1pyz7Au
         f8F/Rapxc5otqyRClgnlyDrSrjZwPh8YbNfgmgR6XqEhjU4FEzT4JAody20w9RR5Z1kK
         oSZg31sR6m0Sc6tHXyb22jG0UuM4bDqs8wGboUjr7bxZXrjXjwlOiYYhao/IMzQJIvoi
         9WAw==
X-Gm-Message-State: ANoB5pnzpdjDzMW5tJxHjbkZOewNsfW146Fh5TbtPc/CTW6vVhr9Ylpt
        lXamXCfyAhqxnJUfsQZOcOo=
X-Google-Smtp-Source: AA0mqf4Zu2Rwt9nMP1c5l7d9AhBgoBWM9jDwqh7RpyGPoVktq/KPK1FXR+kpF6wsT1cl1XVBbbMCzQ==
X-Received: by 2002:a17:90b:3648:b0:219:dc25:d031 with SMTP id nh8-20020a17090b364800b00219dc25d031mr8678668pjb.245.1670335930041;
        Tue, 06 Dec 2022 06:12:10 -0800 (PST)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id nn6-20020a17090b38c600b001df264610c4sm2282978pjb.0.2022.12.06.06.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 06:12:09 -0800 (PST)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, hch@infradead.org, axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH 1/2] virtio-blk: set req->state to MQ_RQ_COMPLETE after polling I/O is finished
Date:   Tue,  6 Dec 2022 23:11:24 +0900
Message-Id: <20221206141125.93055-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Driver should set req->state to MQ_RQ_COMPLETE after it finishes to process
req. But virtio-blk doesn't set MQ_RQ_COMPLETE after virtblk_poll() handles
req and req->state still remains MQ_RQ_IN_FLIGHT. Fortunately so far there
is no issue about it because blk_mq_end_request_batch() sets req->state to
MQ_RQ_IDLE. This patch properly sets req->state after polling I/O is finished.

Fixes: 4e0400525691 ("virtio-blk: support polling I/O")
Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/block/virtio_blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 19da5defd734..cf64d256787e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -839,6 +839,7 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
 	rq_list_for_each(&iob->req_list, req) {
 		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
 		virtblk_cleanup_cmd(req);
+		blk_mq_set_request_complete(req);
 	}
 	blk_mq_end_request_batch(iob);
 }
-- 
2.26.3

