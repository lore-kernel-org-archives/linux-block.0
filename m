Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056F9C10F1B
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 14:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiLUOz4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 09:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiLUOzs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 09:55:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B0F140C9
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 06:55:45 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso2509926pjp.4
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 06:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIgIdejzi7kfMhcYcxmjgpZ21/ag/3NGf2L7s06JKrM=;
        b=fhsx/Eglgb14WGP+LMD47jzl2H2vn5PJC5spDY9blUZ5D2SbIyHphhQx4kerdbIUWt
         03YaYqmASeaji5b6McX/HF490B1Z43sdpb0rxAkZLsP4I5zhH29ztmysaFk2ijIxmvam
         gdXuGLCXePT9XP9lI6HwS13UltM3PjXFqRTxFiZKKi7sCZ2vfpzik+a+dJxS7CQ4DdL9
         fJ5XsJHzswJGjRNKekUUquZcRWu/S3AkJXDGaBP7AnmicJSsrFcj6KoYYDh2YcaQgvGq
         88JYaSWwN5bQkjBEm/sVe+iOj985oNkmBZw8UA0FjAldQP0xN9VoF+/zpwTWiLNjrKqJ
         cT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIgIdejzi7kfMhcYcxmjgpZ21/ag/3NGf2L7s06JKrM=;
        b=cM8niv4jmwJqLcGMPnwyJjdUrRrc+yocePwPLWRzTp91/2kj5om45KD2o/Hf7Q/PCF
         zxnm5cPKKYBBXBQOWTiAYXcrBp1nwKWAkVy92kW7DC/YrQFC+xqaxO1g6CVfy88OfS8z
         ijgrzbL8sGtCGCZP+8dcFwiENwYhOIMGcV3RhKrzP3oCKO1mOrzxgzxaNUxnTZjL4X+7
         KZ2dHdQzvOJHPIcB+kXUD+AFGLD9/ejwy0CgUnuvCZRy74xchEDTxgOGapUPDT+DCzo/
         Dl+QkHhd3pVlgdxALTer8VqjlgRAX/Op01mTvIcpgoNA6jtbHP54hfWr8a75RRc+xv8m
         EITQ==
X-Gm-Message-State: AFqh2koi2+vrnu1XKKdX97/FVLFi4RzCMx7YWNke9lr5LY3OAD3l1Q0j
        rLgsOAJWdeUfPfflXKpRPn8=
X-Google-Smtp-Source: AMrXdXtaN42XXjnWwlUAOAs2jxqdf7XWBSUtSAcXvD+xayLtvLOx4uggx8Bu8CU2QJEBBxPDn4tA7g==
X-Received: by 2002:a17:902:7c95:b0:190:ee85:b25f with SMTP id y21-20020a1709027c9500b00190ee85b25fmr2023713pll.48.1671634545341;
        Wed, 21 Dec 2022 06:55:45 -0800 (PST)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id d9-20020a170903230900b00176dc67df44sm11573994plh.132.2022.12.21.06.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:55:44 -0800 (PST)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, hch@infradead.org, axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/2] virtio-blk: set req->state to MQ_RQ_COMPLETE after polling I/O is finished
Date:   Wed, 21 Dec 2022 23:54:55 +0900
Message-Id: <20221221145456.281218-2-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20221221145456.281218-1-suwan.kim027@gmail.com>
References: <20221221145456.281218-1-suwan.kim027@gmail.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

