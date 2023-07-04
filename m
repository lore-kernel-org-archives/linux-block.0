Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFC7EB64DA
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 16:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGDQwR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjGDQwQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 12:52:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0061B6
        for <linux-block@vger.kernel.org>; Tue,  4 Jul 2023 09:52:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51d9c71fb4bso5587932a12.2
        for <linux-block@vger.kernel.org>; Tue, 04 Jul 2023 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688489534; x=1691081534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ajr5DYl9C6qOy7ts63BGAnBwuXR1t1xb9L8MNCWnMcM=;
        b=ELcA0gKS9JSx9R9qjiLpvMhVbjMHSmx5lrUB94ix+gOFrnfps5pbmDmG98waBqqayS
         sLoP2JP1w+4strsaZol5otwIl+x73ByHuDTl8YyYMUo1JtdU2L35bZ/kT05v1brDrLRe
         ti7ETokvmT6vw18s0039eK6WcpQDJJr2INKRskGSKJlDmXWuuJVkddx3a/UWeCzFZdbX
         tWG5CFlpFMEtkW+uDiHE4vudJtbGje3FJdJCF0uF3hYb7opZ0R3yrW9t9fRGYkK35U0Q
         cZKgwmhLsxE61ALTpNq6fEXjuXvY5Irpg8bh0XCYxl+Bu1B/xeKt8jF/kS/JawRlNZBu
         YZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688489534; x=1691081534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ajr5DYl9C6qOy7ts63BGAnBwuXR1t1xb9L8MNCWnMcM=;
        b=l7MHpTZp222mwERlvv8Jjn25zThaEMqkW0Q1DApkDNSOlIZmqr7cXkYC4puGA3A1Y8
         f71sxa3wL9hHbIRu1diYWFKi4LL/oncfzxipqMxqrr6fM6axnvCEBE8crzwi8ePagc8x
         UugKk7kv7xMRBvGDsGGnWA8V0+xOZOBA0ir+spL4OiypcWXgTmRcgaa+0uwHJ1K6wY73
         hb5E/JZNNDcwJ+cxOT5zj+3Ln2JfTJVmEcPBp6r5EBZPL5PL7VCzRa7wFTkL0ER6phEF
         qkQaCPDYFfr+8+4ZLHT5flkAcycqaTKY3mSaO6CzNO/7zKb2q1dxMqgVtGL8FyTo2nPV
         Kuhg==
X-Gm-Message-State: ABy/qLYdjs18fcUcgbopTnqWDm05Pvttdkcg0yOSJnL3hcNo8wtDI7+s
        TU2vbMjwEpm27xAfQCqy++MckA==
X-Google-Smtp-Source: APBJJlFz6Xe2Hj0nxvRbK0CLfvKR4XM2o1nfI59+G1ZVlz8tj7mNlJHEAgX/91uBZEwxcZ6oOmN3yw==
X-Received: by 2002:a17:906:b294:b0:991:d05c:f065 with SMTP id q20-20020a170906b29400b00991d05cf065mr10489010ejz.52.1688489533683;
        Tue, 04 Jul 2023 09:52:13 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906725400b0099275c59bc9sm8510947ejk.33.2023.07.04.09.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:52:13 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org (open list),
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>, gost.dev@samsung.com,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v5 1/5] ublk: add opcode offsets for DRV_IN/DRV_OUT
Date:   Tue,  4 Jul 2023 18:52:05 +0200
Message-ID: <20230704165209.514591-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704165209.514591-1-nmi@metaspace.dk>
References: <20230704165209.514591-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Ublk zoned storage support relies on DRV_IN handling for zone report.
Prepare for this change by adding offsets for the DRV_IN/DRV_OUT commands.

Also add parenthesis to existing opcodes for better macro hygiene.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 include/uapi/linux/ublk_cmd.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 4b8558db90e1..a32810c8ef2b 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -229,12 +229,16 @@ struct ublksrv_ctrl_dev_info {
 	__u64   reserved2;
 };
 
-#define		UBLK_IO_OP_READ		0
-#define		UBLK_IO_OP_WRITE		1
-#define		UBLK_IO_OP_FLUSH		2
-#define		UBLK_IO_OP_DISCARD	3
-#define		UBLK_IO_OP_WRITE_SAME	4
-#define		UBLK_IO_OP_WRITE_ZEROES	5
+#define		UBLK_IO_OP_READ			(0)
+#define		UBLK_IO_OP_WRITE		(1)
+#define		UBLK_IO_OP_FLUSH		(2)
+#define		UBLK_IO_OP_DISCARD		(3)
+#define		UBLK_IO_OP_WRITE_SAME		(4)
+#define		UBLK_IO_OP_WRITE_ZEROES		(5)
+#define		__UBLK_IO_OP_DRV_IN_START	(32)
+#define		__UBLK_IO_OP_DRV_IN_END		(96)
+#define		__UBLK_IO_OP_DRV_OUT_START	(__UBLK_IO_OP_DRV_IN_END)
+#define		__UBLK_IO_OP_DRV_OUT_END	(160)
 
 #define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
 #define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)
-- 
2.41.0

