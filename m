Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19300C636C9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0142461360
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhGOVCf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:02:35 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:36367 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhGOVCb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 17:02:31 -0400
Received: by mail-pf1-f174.google.com with SMTP id 21so6705729pfp.3;
        Thu, 15 Jul 2021 13:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a39bZow5r39OJmiFj2JiMLEBL8HqNlxVqiTVg5TlV8s=;
        b=dFKsRfJyeUAzu6jDw49I+gJbIO8+VANQ4203xKuiEg0BRQafhKK2CDLOIoIHYdE7gG
         xxgsNrBOvjvRxGfYcYtqrcMn3aRZmEtA29AmAW2TYkZqz//ttJuTtS2bSZa8YDaIMnbb
         50DqrvqfSTQeMuc30hzFThD/RIKBl8CjzLVU13vxJwftaEON6VA5Pug8Z23OPKTvRCga
         ihpXmjqmn4NJvFr399gRtGJbfIkFpgEJCbzgGee74XOD3D8RF0O4iqfcFf6xAeY3mtRs
         xWRDte562L0UlHLar1Vrb4aon3ODP/pSdYYvNvbJCm5n0KE1mzvJNGkQowo7pzWBBFnF
         9hEw==
X-Gm-Message-State: AOAM532ySpU/QkbLVP4v7sf6Eyu2KTQRtmTGMwNBPOSCn2VsRDcC1LnU
        sFVRE83HMqWNP8AGRJLLlEY=
X-Google-Smtp-Source: ABdhPJwYgHMr+n3z93fQBhUS/TQB2O0JB0Kyyy4FB/7xwyHvi4vLcSkXpYLPFyTfr7yLlqHzxBfRaQ==
X-Received: by 2002:a62:6c4:0:b029:324:8262:b3aa with SMTP id 187-20020a6206c40000b02903248262b3aamr6479424pfg.25.1626382777712;
        Thu, 15 Jul 2021 13:59:37 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id v9sm7418946pfn.22.2021.07.15.13.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:59:36 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 04/12] scsi/sd: use blk_cleanup_queue() insted of put_disk()
Date:   Thu, 15 Jul 2021 13:59:12 -0700
Message-Id: <20210715205920.2023980-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715205920.2023980-1-mcgrof@kernel.org>
References: <20210715205920.2023980-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The single put_disk() is useful if you know you're not doing
a cleanup after add_disk(), but since we want to add support
for that, just use the normal form of blk_cleanup_disk() to
cleanup the queue and put the disk.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/scsi/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 6d2d63629a90..6d0a82da7131 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3510,7 +3510,7 @@ static int sd_probe(struct device *dev)
  out_free_index:
 	ida_free(&sd_index_ida, index);
  out_put:
-	put_disk(gd);
+	blk_cleanup_disk(gd);
  out_free:
 	sd_zbc_release_disk(sdkp);
 	kfree(sdkp);
-- 
2.27.0

