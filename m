Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B07EB64DC
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 06:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjGJGq1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 02:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjGJGqY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 02:46:24 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB84138
        for <linux-block@vger.kernel.org>; Sun,  9 Jul 2023 23:46:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b698937f85so65094151fa.2
        for <linux-block@vger.kernel.org>; Sun, 09 Jul 2023 23:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688971576; x=1691563576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULsnDQO1R7NyZ+kouszec1NukJNpex1WKOoz+5ctk5g=;
        b=iN11EwNuCYJVzKWiNxWAiJm8rJAuhdBLhYn/saKzDSMf6Iea26hmVZxeWxz11kAfrj
         bzVxBg6FQrgjJKE9pmHccMQ8536A+rzOcHkCc4JTDMkodoYrA5pM3MxEtzqluG6SPuC/
         qA5Iq1Yda6HgCr1XKS6kjAeM0hfm+jszEzvEDQnLmTngZB7r3Jd+STnUUGspIV3PbaNU
         KrePbHuRJyp1uM4lNmbiDrc1lAiIQmVD7X9SlEM89JHnia4ZwWwhAqzvB4yqa80ixF3G
         1E4EM6eazl+iQdJwsej084Iyam/8WP8uJ+3NhgJwZALKl81J4c5m73PnxjtxseAmJ8eP
         h2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688971576; x=1691563576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULsnDQO1R7NyZ+kouszec1NukJNpex1WKOoz+5ctk5g=;
        b=MNrh6yaw4y+YKHx0UR3epRlYayFYMfDmYmC4kYXlBf7gnyNSVi9oFpLT1d37t+h5Lz
         dvpdNw4xlDAYd+8Jw6849rLsRrRcuV2IqCZP4G6TIQSCr26OlHY1+Ua2o9wmoLaikrrO
         YraaxGh8fYWByNI0Nld+35E3P+6gz8UlnqCWi1/IMIH+fc9X7Y2vdpWkNfJp0+4lbaxz
         sp8x8XL8ULiqw6gp0wVUp3RZroOR3jInt9qeolSBAm7hyV9R19o3/LefwlQcuIQVdzqb
         vDCe4DIYk7bxApixWu3gwwtRFpYZrlFsN7duZR4YJfxs3LuH2hzNF+h8akK8kRm8Ujoe
         7o3Q==
X-Gm-Message-State: ABy/qLaDnAQt+aKXcimSuzUHpeDtlGIyPPa88bKKomOFrfDwMRV5Wr1L
        tXofwuBw7S0dVB/9AjhNs7lBAA==
X-Google-Smtp-Source: APBJJlH+KwfP0iXrYfC4TF8IXL0FGxEwLXpWZvQPSKOjAD+BoK1B9huhRG10FL4VqbmvqxkKgPY6HQ==
X-Received: by 2002:a05:6512:b8c:b0:4f9:556b:93c2 with SMTP id b12-20020a0565120b8c00b004f9556b93c2mr11304889lfv.1.1688971575928;
        Sun, 09 Jul 2023 23:46:15 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id f15-20020ac251af000000b004fb8668e6cfsm1567079lfk.124.2023.07.09.23.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 23:46:15 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        Johannes Thumshirn <jth@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>, gost.dev@samsung.com,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>
Subject: [PATCH v7 1/3] ublk: add opcode offsets for DRV_IN/DRV_OUT
Date:   Mon, 10 Jul 2023 08:46:04 +0200
Message-ID: <20230710064607.155155-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710064607.155155-1-nmi@metaspace.dk>
References: <20230710064607.155155-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Ublk zoned storage support relies on DRV_IN handling for zone report.
Prepare for this change by adding offsets for the DRV_IN/DRV_OUT commands.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 include/uapi/linux/ublk_cmd.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 4b8558db90e1..521a0d2fbc06 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -229,12 +229,23 @@ struct ublksrv_ctrl_dev_info {
 	__u64   reserved2;
 };
 
-#define		UBLK_IO_OP_READ		0
+#define		UBLK_IO_OP_READ			0
 #define		UBLK_IO_OP_WRITE		1
 #define		UBLK_IO_OP_FLUSH		2
-#define		UBLK_IO_OP_DISCARD	3
-#define		UBLK_IO_OP_WRITE_SAME	4
-#define		UBLK_IO_OP_WRITE_ZEROES	5
+#define		UBLK_IO_OP_DISCARD		3
+#define		UBLK_IO_OP_WRITE_SAME		4
+#define		UBLK_IO_OP_WRITE_ZEROES		5
+/*
+ * Ublk passthrough operation code ranges, and each passthrough operation
+ * provides generic interface between ublk kernel driver and ublk userspace, and
+ * this interface is usually used for handling generic block layer request, such
+ * as command of zoned report zones. Passthrough operation is only needed iff
+ * ublk kernel driver has to be involved for handling this operation.
+ */
+#define		__UBLK_IO_OP_DRV_IN_START	32
+#define		__UBLK_IO_OP_DRV_IN_END		96
+#define		__UBLK_IO_OP_DRV_OUT_START	__UBLK_IO_OP_DRV_IN_END
+#define		__UBLK_IO_OP_DRV_OUT_END	160
 
 #define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
 #define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)
-- 
2.41.0

