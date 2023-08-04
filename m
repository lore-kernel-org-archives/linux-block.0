Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9D2C001DF
	for <linux-block@archiver.kernel.org>; Fri,  4 Aug 2023 11:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjHDLqY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Aug 2023 07:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjHDLqV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Aug 2023 07:46:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2832A134
        for <linux-block@vger.kernel.org>; Fri,  4 Aug 2023 04:46:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bccc9ec02so287745066b.2
        for <linux-block@vger.kernel.org>; Fri, 04 Aug 2023 04:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1691149573; x=1691754373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oUmzoS5U5R4lTgYbAptq50tRMqAAmIZWZ/4iyIzFtA=;
        b=jP2+6gufCLdXIUzWnwuWpyLuoq2Yb5cKN7ZHjhp9S1j1tyNhOwoVQawTz385tcS1gM
         T3U5dArVWN/+ooEUGcnlJdVZG9GYvHx7XToELL7c2KkvSOw68fRGu4u0zbrk/j1YV0Rm
         bMyL5ASTkRpmhuMb1cB+vVrXWrd3rHoYr9lg+bH3hmJLD0xUfhz7nL3y7d+MA/qqg8G9
         1zrsN0KccT4TYkKLHYXGX/u0yrEThQstOCkILQrDP2mCvDNCO7V7kuZPKQHiEI2YDzkF
         oviOoEhdv4RJc6aiMtz0Hf3rmqcZAoOW6u9Q/xq2TRKh+VOe2kb8QkkcZ4Zpi97Ay2vd
         lBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691149573; x=1691754373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oUmzoS5U5R4lTgYbAptq50tRMqAAmIZWZ/4iyIzFtA=;
        b=fQ2ISn9LfA2h8RcnOCUi+odgugtp7fmuRcEmcX0CDR6PqZIdwXPgLL/Tuv9HKSRWcO
         rh7Y3MGgRIOOaZzi49A2c3Mh+RAkgK5fuY6a3Yi1nlbVXc0U7BCb+3dvhXAAzOf/Jrnq
         1h67DRxdBMIalz0OClkDOJ6BNF0iwjl4c1CY7FID5fszpKDfrE/E8suQoi/WNvb5OynD
         N3mWLgEypLUJixCt5HKF96zmsQZfcbyJhqlJ0ibhlFLAThWm2cYel/Y5/qc+xtickW6W
         dsrhLhmse4flzjrXMxK2hX74SdxhIImJxeckk2No5YD+CQkveojEU9LmfR/DUP/a8xWU
         Mqww==
X-Gm-Message-State: AOJu0YywnMuOGqwTmM+BFLhjmguapy6Hom7wI/YP3YHebWhGKIyeR8Kx
        Re5OlkjwvdAqKQxvxWE1FcwGBA==
X-Google-Smtp-Source: AGHT+IHD+OuHtzNtnzNr499wcfgIySPTSjsABomYo5uYAYmj1/1aICmH0CIpWrR1Ar0RQ0ktGbEB5w==
X-Received: by 2002:a17:906:18b1:b0:99c:6671:66d7 with SMTP id c17-20020a17090618b100b0099c667166d7mr1129068ejf.39.1691149573597;
        Fri, 04 Aug 2023 04:46:13 -0700 (PDT)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id p27-20020a170906229b00b0099bd8c1f67esm1196013eja.109.2023.08.04.04.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 04:46:13 -0700 (PDT)
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [PATCH v11 2/3] ublk: move check for empty address field on command submission
Date:   Fri,  4 Aug 2023 13:46:09 +0200
Message-ID: <20230804114610.179530-3-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804114610.179530-1-nmi@metaspace.dk>
References: <20230804114610.179530-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

In preparation for zoned storage support, move the check for empty `addr`
field into the command handler case statement. Note that the check makes no
sense for `UBLK_IO_NEED_GET_DATA` because the `addr` field must always be
set for this command.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/ublk_drv.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index db3523e281a6..5dba4b27d820 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1419,11 +1419,6 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
 		goto out;
 
-	if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	ret = ublk_check_cmd_op(cmd_op);
 	if (ret)
 		goto out;
@@ -1450,6 +1445,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			 */
 			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
 				goto out;
+		} else if (ub_cmd->addr) {
+			/* User copy requires addr to be unset */
+			ret = -EINVAL;
+			goto out;
 		}
 
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
@@ -1469,7 +1468,12 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
 						req_op(req) == REQ_OP_READ))
 				goto out;
+		} else if (ub_cmd->addr) {
+			/* User copy requires addr to be unset */
+			ret = -EINVAL;
+			goto out;
 		}
+
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_commit_completion(ub, ub_cmd);
 		break;
-- 
2.41.0

