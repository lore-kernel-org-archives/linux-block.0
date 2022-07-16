Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA38C433EF
	for <linux-block@archiver.kernel.org>; Sat, 16 Jul 2022 13:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiGPNQD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Jul 2022 09:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiGPNQD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jul 2022 09:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DC931FCED
        for <linux-block@vger.kernel.org>; Sat, 16 Jul 2022 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657977361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gnHdMkzLi00tNGCUGHal6nCmNk9iiTh/Qem2M8JBxB0=;
        b=EEAdtlOZbGjluEvH2Eb8YISGCVz3+vXVNmpfDtbEfLztOeJT1ccdh7jTl21ohteHSAbj1b
        npsLLCHF3evgSgZzydyRy+srBIfU1k9sk6hb3wvvuQmeK+7awpc6TPPCtzbxfxoVwnAJNT
        LsXrnaBrrPf/Xs6qxjKgeZxjfMUPT2E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-7qJDqBrPMy-jDLfsgICLkg-1; Sat, 16 Jul 2022 09:16:00 -0400
X-MC-Unique: 7qJDqBrPMy-jDLfsgICLkg-1
Received: by mail-qt1-f197.google.com with SMTP id r5-20020ac85c85000000b0031ecf611c64so5572828qta.23
        for <linux-block@vger.kernel.org>; Sat, 16 Jul 2022 06:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gnHdMkzLi00tNGCUGHal6nCmNk9iiTh/Qem2M8JBxB0=;
        b=LMjwVSesjv7+/a3szMypeeFVSbelibeR5C4HPPKcKDEU4SvNJA8PINZ/o+F2yliHW6
         qZ8PCKDoCQP04OqlIMCV7ACuINgXg2nvZZDcNcEmRih2mh39KCEDV5yZGUW7x9qIsdo3
         x1CkuxIaeydWuz881tj6SfOPuIGmYxJbJIsGVmiRR6uIi3s/A5rwVErI1MshK9b8YutP
         RF59EhjheTiCjZA1ZJEZTxUHEXQQAnDByMxje9LNjW14sZK0jhNIQtg9TRpyutT4D2jT
         xZatbvdsqEHOHE9e6WA4c5nIr5cqP1sMFN2WGSEY6+yida7R2MYvRvxQhac2mP+srL9W
         9GJQ==
X-Gm-Message-State: AJIora98IY0PrsTAYxcWG9FG2t65rwwDMJ3ShOT+csiWBp2qg5TgG9mU
        3MSjGFkd23TA6Ecfk/hkcqfakm9OMj88vYvPK/94GgefdCKIHbff6/OvtfqJ58KRenXPX08YlEW
        DfiV72K89jmKth0lidX8n04M=
X-Received: by 2002:ac8:594e:0:b0:31d:410f:8b56 with SMTP id 14-20020ac8594e000000b0031d410f8b56mr15567520qtz.574.1657977359658;
        Sat, 16 Jul 2022 06:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t0hlikaPC0mBP+PR0j6EJBA0q7qPSPcc2vLVEczOdQynomZ3XMyGd4vyQYhwE9REYZkwJhWA==
X-Received: by 2002:ac8:594e:0:b0:31d:410f:8b56 with SMTP id 14-20020ac8594e000000b0031d410f8b56mr15567502qtz.574.1657977359393;
        Sat, 16 Jul 2022 06:15:59 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006b5905999easm6122095qkl.121.2022.07.16.06.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 06:15:59 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     axboe@kernel.dk, nathan@kernel.org, ndesaulniers@google.com,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] ublk_drv: initialize ret variable
Date:   Sat, 16 Jul 2022 09:15:55 -0400
Message-Id: <20220716131555.2014270-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

clang build fails with
drivers/block/ublk_drv.c:1304:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]

When the call to ublk_get_device_from_id() fails, ret is used without being
initized.  So initialize.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 52fd0af8a4f2..4d1199c98026 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1298,7 +1298,7 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
 	struct ublk_device *ub;
 	unsigned long queue;
 	unsigned int retlen;
-	int ret;
+	int ret = -ENODEV;
 
 	ub = ublk_get_device_from_id(header->dev_id);
 	if (!ub)
-- 
2.27.0

