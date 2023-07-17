Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA0C001B0
	for <linux-block@archiver.kernel.org>; Mon, 17 Jul 2023 19:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGQTRU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jul 2023 15:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjGQTRT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jul 2023 15:17:19 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E17FE60
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 12:17:16 -0700 (PDT)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 997353F206
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 19:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689621434;
        bh=3eJnxYdk1byylFLppPWETk2/Kb3c2DWBxN/fVjj9FsA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=IV9yT/+GIujQ1LCkUeyfeNycLZ+YjlIsyyIOETBT8t8zixd8qJQMO1a+EpvYDx5J5
         ps1GyMvvSO7NkoE20ZxpNamBGwn4+25HBe2JgmxyPo8Y2Z/RQ1PSPI5vld4RzT+pHp
         xcL6pMqU9c9UuETrGGazDJRT26zIVUGCD4RoFsjtfqJFyxht++UVpq7LCWhwzugvYC
         85f6aLQan7jM+yP8pu9moOH4/mb54l5yHPFzc5jX9kdPzE8DyTaSGyJwlPKBXe+/jK
         +x5cCfDmYmEKITbwPPlPds73EqGQ4nhXhtp4BWp9asK/07pMSCvfAxiNLflgVC6i3u
         co6QXeh5b1osQ==
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b754fa9c34so6963059a34.1
        for <linux-block@vger.kernel.org>; Mon, 17 Jul 2023 12:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689621433; x=1692213433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eJnxYdk1byylFLppPWETk2/Kb3c2DWBxN/fVjj9FsA=;
        b=k6TybxGh0BYvXDMei7dnW4JG4AkjrZq69ANYHo1FXDSoAIQIJQ5HXuBF9c/ssQGWNI
         IlHwwGHZGN5nl66O8Y5gwNJvfPTv5zvME4BGWOODsEuqSYH33k1cb4mCzElvhGltDegV
         NmXmvKPTQ60X9fUiN2n9ss4jRLBX3NA5g6Jh22f7IC4QTf/Tr3zoVoqJOJUi6udEx62j
         EiLlp8N0ikC/LQFn6frmD4TGwqMFNGP/DYFyabYIEA7EYc6JXTzszjFNFAUl1WDI1TaD
         FTBJo6FEnpPI+Ap69wUXnwmQhBbdTaGH6Ife8ejGgani6bX8COQG5ZiQq3QOiVfQhVky
         jOIA==
X-Gm-Message-State: ABy/qLa7obtSN1D3xtFHbTdkKDhcaRdo/tCnuz7Asbi/wBOnNPuJVJSQ
        EI6ffVKcpSa5VcI6u5NJjrvcAdgqHPFQ20Fplc2G9wzsn2GTZQjjix0KX/fVWl7Jugv+L6faY78
        Wd1LSs981DGqz/hIom8adD7WHlNOWKbJcet82/Uc2
X-Received: by 2002:a05:6830:32aa:b0:6b9:27ae:d2fa with SMTP id m42-20020a05683032aa00b006b927aed2famr9159738ott.15.1689621433541;
        Mon, 17 Jul 2023 12:17:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF5W9+xcO3VCxgf/TP+KPSwF+9Dlg+6SO1ZPia9+ogyOO8HBY9rzJ6y905U5U306YlZjTmoJQ==
X-Received: by 2002:a05:6830:32aa:b0:6b9:27ae:d2fa with SMTP id m42-20020a05683032aa00b006b927aed2famr9159730ott.15.1689621433302;
        Mon, 17 Jul 2023 12:17:13 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4e1:8296:70bd:5663:a6f8:b245])
        by smtp.gmail.com with ESMTPSA id y8-20020a056830108800b006b71deb7809sm223087oto.14.2023.07.17.12.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:17:12 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
Subject: [PATCH RESEND 1/2] loop: deprecate autoloading callback loop_probe()
Date:   Mon, 17 Jul 2023 16:16:27 -0300
Message-Id: <20230717191628.582363-2-mfo@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717191628.582363-1-mfo@canonical.com>
References: <20230717191628.582363-1-mfo@canonical.com>
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
 drivers/block/loop.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 37511d2b2caf..7268ff71c92c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2093,6 +2093,7 @@ static void loop_remove(struct loop_device *lo)
 	put_disk(lo->lo_disk);
 }
 
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
 static void loop_probe(dev_t dev)
 {
 	int idx = MINOR(dev) >> part_shift;
@@ -2101,6 +2102,7 @@ static void loop_probe(dev_t dev)
 		return;
 	loop_add(idx);
 }
+#endif
 
 static int loop_control_remove(int idx)
 {
@@ -2235,8 +2237,11 @@ static int __init loop_init(void)
 	if (err < 0)
 		goto err_out;
 
-
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
 	if (__register_blkdev(LOOP_MAJOR, "loop", loop_probe)) {
+#else
+	if (register_blkdev(LOOP_MAJOR, "loop")) {
+#endif
 		err = -EIO;
 		goto misc_out;
 	}
-- 
2.39.2

