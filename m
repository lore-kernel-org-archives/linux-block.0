Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C72EC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 14:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD3560F46
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 14:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhJYO1r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 10:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbhJYO1q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 10:27:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5069AC061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 07:25:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id lx5-20020a17090b4b0500b001a262880e99so107958pjb.5
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqXG0/tzAMme0lqJcgyNBNW84HzqzOSloOMxwNDMqnk=;
        b=ci5vKvt7MPVkFEOn/vdkYki+HHpreHpMUojahpuEUMkbCwTji7lH6Vg3wrB7GgUMEB
         Pbft2KjLVDtLw+SaufMtTrDdh752x/eNenzHDSkp9Z86nXZOEYia/FSnnqXnQasWpeXX
         iGobot9Ge/UjPYLrKVrSveN3w/51aVWafnYZznqhbYkklsZCDhEJCd8hKjEFs71P1+ZM
         NwMKY9w43ZqCGs5981N7CdtgaOvWQAeV61HGNQ3TFKpXicjEeunTj5kKiZhNUnIuF36G
         P1mgt4VNT0KsnqTKqcN9a900U+bFba/aedd1voCItjyvKk6HKPW0EM6elCe99FkrrRDW
         drEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqXG0/tzAMme0lqJcgyNBNW84HzqzOSloOMxwNDMqnk=;
        b=rgRDSy0WvhfKrxV/jW8evr8mEJxGbrNB9Lc0E3gEBWZxydOcv+1RWpszpnty3/Fzer
         JU5g8hCmmQgb2HmQhYm8pd2nuxkP2B2mVNXhQq2pQ3tKvSwXlywjt5t/w7UWVCG0ChwF
         QTY3jSbjyEdY19SQI4HYGEtX5/coKCQTGG1OxFl2RPhDc6t/WOJVMG42UgUPsgm1YYwB
         VgEYX/IVZymvZwmM8JUSgE43LhGP5LsmpqIa6+lt/KrIhmulMEybT4rI04KGBNiBWWsb
         IkXfzxNAqOd8FHce4CU78HSrpSqvBhmKIayJvNZ1DP95VCBqv0lgnQa1RtVOGuNhVLDP
         WJhw==
X-Gm-Message-State: AOAM530yx5vRQUTH9d6+U5Ynswij+w0omPR+xY2KcSzjPuuwJN58LJ17
        rwNQ/HTX3LHUL8klFJIi3oFE
X-Google-Smtp-Source: ABdhPJzQBWheUx42D4ZY8nK9BboMGGe2OJYiojH/SBj6h2EEIRDnE81SpikbXuVrnIafRrI2f90kZA==
X-Received: by 2002:a17:902:9b8a:b0:13f:c286:a060 with SMTP id y10-20020a1709029b8a00b0013fc286a060mr16366368plp.66.1635171923857;
        Mon, 25 Oct 2021 07:25:23 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id t3sm16393327pgo.51.2021.10.25.07.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:25:22 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/4] block: Add a helper to validate the block size
Date:   Mon, 25 Oct 2021 22:25:03 +0800
Message-Id: <20211025142506.167-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025142506.167-1-xieyongji@bytedance.com>
References: <20211025142506.167-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are some duplicated codes to validate the block
size in block drivers. This limitation actually comes
from block layer, so this patch tries to add a new block
layer helper for that.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 include/linux/blkdev.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 12b9dbcc980e..805cd02d7914 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -235,6 +235,14 @@ struct request {
 	void *end_io_data;
 };
 
+static inline int blk_validate_block_size(unsigned int bsize)
+{
+	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
+		return -EINVAL;
+
+	return 0;
+}
+
 static inline bool blk_op_is_passthrough(unsigned int op)
 {
 	op &= REQ_OP_MASK;
-- 
2.11.0

