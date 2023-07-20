Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4109CEB64DC
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 14:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjGTObZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 10:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjGTObY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 10:31:24 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFD6269A
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 07:31:23 -0700 (PDT)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AD9073FA79
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 14:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689863480;
        bh=dX0gdS7Q2We9TaNHB8mJJ4IN1V2vkmHDizv0iutc55w=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PAilmyIMPIDnOQ4yG6/OvtHeADlU3oV1n4m36P6JiWTeg55j6PvHCUAQHy5So/UKj
         rnkhzLvEHjWaZKVdmwzYdDV4C/Za8MzJFYp8hXMrzBFUaCBSgILI7MhhSxge1BR35/
         u9jSQAKPPQ1+qTy3y5Kt8620tQ446MTrNS8QH5BMwdqnRqPQDkUlD5WosULmCSAzrS
         pydpdZ86+g9NWPAeehZC/bncq0GxCCiWie9OZryjamA3CBI/pBMQk1od4W27+urQAl
         75brzSlwaF1tploWOj5w1WgohIvNtCbjjTB9eITeABHduujx7CQhXBHSQ3gwl9N/wI
         epQt6RC2vKv8g==
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a337ddff03so1588196b6e.0
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 07:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689863479; x=1690468279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dX0gdS7Q2We9TaNHB8mJJ4IN1V2vkmHDizv0iutc55w=;
        b=aDXQ+auaAzjfBLKH4PI2VEz2O4Tf8eXVTaYbJl3dVebdz0a/bFR8luGIAbiDhvGY3I
         zXbcf7neSOfO/o1kTejalVqJj+oZdJwMNW5wZvLN4mjnxOKyGugy8EHwi2HHuoBTcgLA
         cuPpNmRnRwpCV0ISwOtLWXvMt8auN883+r71WXaqfyYB7ROs4SvjKhGK6kTqsUC00vY+
         rLqMqZHSYwxsPlY39qWexqKiqnRXuLPwj4mByyhOnRx7qbmIVoEi7Ibnkrl1JbW+ts3c
         Vg+qSiUUYKgWgShkGuoVruZlYphtX1zxpsEF81hFFwkIWypqrxrg8L88oop/ZpdFbxhs
         pBzg==
X-Gm-Message-State: ABy/qLb7XzCT3VZ95GajgT8rxITpt3+zG+SPFE16g2mqarKJGZWuwSzz
        pbRnXTI5jwe3t9vJyB7FFjA/louYX5QrPgBeE4L5QkjdjyXL2HScpJut82NCkkBg/jknRETBEpW
        S0EZA2lFg0xsYtOWs6tJYh1EuNO1zACCvuT3c/G/i
X-Received: by 2002:a05:6808:2118:b0:3a4:1ac0:48ce with SMTP id r24-20020a056808211800b003a41ac048cemr2236552oiw.57.1689863479378;
        Thu, 20 Jul 2023 07:31:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH6YeVhhZFE+cZwzUzjUrqZEjI7yCuiGbXhVtzhtp8poFOeX23F+0EvDDyjtexLjG9HGZLaaQ==
X-Received: by 2002:a05:6808:2118:b0:3a4:1ac0:48ce with SMTP id r24-20020a056808211800b003a41ac048cemr2236524oiw.57.1689863479097;
        Thu, 20 Jul 2023 07:31:19 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4e1:8296:c121:4d01:95b0:7009])
        by smtp.gmail.com with ESMTPSA id bg28-20020a056808179c00b003a4646e0896sm415543oib.32.2023.07.20.07.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:31:18 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
Subject: [PATCH v2 1/2] loop: deprecate autoloading callback loop_probe()
Date:   Thu, 20 Jul 2023 11:30:32 -0300
Message-Id: <20230720143033.841001-2-mfo@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720143033.841001-1-mfo@canonical.com>
References: <20230720143033.841001-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 'probe' callback in __register_blkdev() is only used
under the CONFIG_BLOCK_LEGACY_AUTOLOAD deprecation guard.

The loop_probe() function is only used for that callback,
so guard it too, accordingly.

See commit fbdee71bb5d8 ("block: deprecate autoloading based on dev_t").

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>

---
v2:
 - do not remove loop_probe / have two calls for (__)register_blkdev(),
   instead define it as NULL, keep one call for __register_blkdev(),
   (thanks: Christoph Hellwig)

 drivers/block/loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 37511d2b2caf..6e56c3faacac 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2093,6 +2093,7 @@ static void loop_remove(struct loop_device *lo)
 	put_disk(lo->lo_disk);
 }
 
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
 static void loop_probe(dev_t dev)
 {
 	int idx = MINOR(dev) >> part_shift;
@@ -2101,6 +2102,9 @@ static void loop_probe(dev_t dev)
 		return;
 	loop_add(idx);
 }
+#else
+#define loop_probe NULL
+#endif /* !CONFIG_BLOCK_LEGACY_AUTOLOAD */
 
 static int loop_control_remove(int idx)
 {
-- 
2.39.2

