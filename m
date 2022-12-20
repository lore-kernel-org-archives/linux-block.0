Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3877EC4332F
	for <linux-block@archiver.kernel.org>; Tue, 20 Dec 2022 15:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiLTPgu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 10:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLTPgr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 10:36:47 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1EAE0
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 07:36:46 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so393561pjh.5
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 07:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emwOUyPltKXg/aKyppbBCgqU9XOUQKm90CUhNcXT5OQ=;
        b=kXWSNt5jeqG7oBTW1DcqvEhDcwdXT+hvL3JUvhhbFcKL6HYxfoI5m+BTg5nWaQH1dv
         BBTtrPewVTnq1I1ohCPmbjCBLjXwCg7AuWbJWVjvi1agrCnayH+gWzzelncjOl2F0S47
         fxBtTLsgJxaQxQbaKHKKYW0Lf6ByGy/5hDS/Wsuw3NrU+UdxmuNnmYfqhR25GE0wqFme
         RDHp66uD4SM8Pe1NUs/wfJYBKJ1jYzj0bwsxSGuxEhQM2x5pRohABcQ4NNxQxlDfXyIF
         +qeZ9NSBJuEWiLlzJCe4sHrETJMA7hlwVkIWyANfGSMPjqLdI8ia+L/2OZuEPRc68SIN
         5r3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emwOUyPltKXg/aKyppbBCgqU9XOUQKm90CUhNcXT5OQ=;
        b=APeFuU7iEqGuijrx1wK4dTIM7kdX7eCUs4fNKKevtCO/OdO3O7LXIzic3bUKHGDZkr
         EH1zsI2q6dd7HyUOjcaWpxkszIJDS+6JI0Bp3DfDYWfF6hbRQi8e+nPhFHLFq3XtRiTl
         ScdMt/7FapuPzXvedfUhBqqqmHEJRyVpNRMcItTwNhhYFxdvivEc4v5/Qkxadhd7E/ar
         R69alxNlZ3RpJm3zqyh8Zbkgk8MfFD7RW30mXlEZohJBHaMwcXlTscmw2XD9OmZ4qNZz
         yHctbdcZ/0uplw99E6UmPZCoEZhaAiBXNG7aMWlibCCJAciuMaSl1gGoEDnY36Oc06UV
         2Qxw==
X-Gm-Message-State: AFqh2kpsisKMgtdhWLzGGlgJZV+3kyDMbRpZZxR1m9PxaE07UafvquM9
        r3ihuVnWCCRvGxFTlIt0xYA=
X-Google-Smtp-Source: AMrXdXtUcJwQRX/Y3VLgRcixfzIuDwbCkHasu9eRZ38jNkp8qhp3oa8LZG6ZMQz2+6g4xL9HnNYycg==
X-Received: by 2002:a17:902:cf01:b0:18b:3389:2caf with SMTP id i1-20020a170902cf0100b0018b33892cafmr15390836plg.59.1671550606290;
        Tue, 20 Dec 2022 07:36:46 -0800 (PST)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id jf3-20020a170903268300b001811a197797sm9558084plb.194.2022.12.20.07.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 07:36:45 -0800 (PST)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, hch@infradead.org, axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v2 1/2] virtio-blk: set req->state to MQ_RQ_COMPLETE after polling I/O is finished
Date:   Wed, 21 Dec 2022 00:36:12 +0900
Message-Id: <20221220153613.21675-2-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20221220153613.21675-1-suwan.kim027@gmail.com>
References: <20221220153613.21675-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Driver should set req->state to MQ_RQ_COMPLETE after it finishes to process
req. But virtio-blk doesn't set MQ_RQ_COMPLETE after virtblk_poll() handles
req and req->state still remains MQ_RQ_IN_FLIGHT. Fortunately so far there
is no issue about it because blk_mq_end_request_batch() sets req->state to
MQ_RQ_IDLE.

In this patch, virblk_poll() calls blk_mq_complete_request_remote() to set
req->state to MQ_RQ_COMPLETE before it adds req to a batch completion list.
So it properly sets req->state after polling I/O is finished.

Fixes: 4e0400525691 ("virtio-blk: support polling I/O")
Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/block/virtio_blk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 19da5defd734..75ee51aba964 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -858,9 +858,10 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 		struct request *req = blk_mq_rq_from_pdu(vbr);
 
 		found++;
-		if (!blk_mq_add_to_batch(req, iob, vbr->status,
+		if (!blk_mq_complete_request_remote(req) &&
+		    !blk_mq_add_to_batch(req, iob, vbr->status,
 						virtblk_complete_batch))
-			blk_mq_complete_request(req);
+			virtblk_request_done(req);
 	}
 
 	if (found)
-- 
2.26.3

