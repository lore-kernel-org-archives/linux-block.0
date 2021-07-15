Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4211EC636CB
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B98613F5
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhGOVCf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:02:35 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:45951 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhGOVCf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 17:02:35 -0400
Received: by mail-pl1-f179.google.com with SMTP id p17so4062368plf.12;
        Thu, 15 Jul 2021 13:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1e/4AsgG4GwfF1IctxosNcfjCE1cPWukX3Y+DFA9aXg=;
        b=TXDR7KN89jVE0JngLi1ZTf2SL70P8Y2QYd38VXOXs/eePYfvAjndgS63Ubv/EjAxZC
         7+8eLr8AfoM2VgP/uW/w3qJVsdjXa/8LX20dyeqUsoNMao7MvYsZ6ZePz6GXEjBhYwjz
         3GIJNSNn86rsPFgIAMqslrbpdpwxfR9rwp1mQYetZOtz/11Elu2z12lUlmexJ7cvrTtL
         QvLdk4/+nyKxh5bcuqq8n3+ZDBSeh1+SMc0+fePsYBh79SivT9h/KpSBvEXN7fw3MLHj
         lzwKMVlszV7SzxI0dY2+cMmy5kZD6iok68j4RAO04B88LyWXTwxn2hZDQ0mKKnW0YRpl
         /nJQ==
X-Gm-Message-State: AOAM531nYzlYMZvNVz+VjzO2VxXfDH0ED1myY0djVwDP6QIULPFbBDBZ
        95b2tg346u53WcZZdlC0w6w=
X-Google-Smtp-Source: ABdhPJy8RHfBW0i5B3ccfD3b82WfYTT1uGGiUcu47aakD5DJKqFK4G5+Stc1vz1Ioh6a605cKQnKPw==
X-Received: by 2002:a17:902:9685:b029:ef:70fd:a5a2 with SMTP id n5-20020a1709029685b02900ef70fda5a2mr5001363plp.20.1626382780110;
        Thu, 15 Jul 2021 13:59:40 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id b7sm7416455pfl.195.2021.07.15.13.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:59:39 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 05/12] scsi/sd: add error handling support for add_disk()
Date:   Thu, 15 Jul 2021 13:59:13 -0700
Message-Id: <20210715205920.2023980-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715205920.2023980-1-mcgrof@kernel.org>
References: <20210715205920.2023980-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/scsi/sd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 6d0a82da7131..01af61a38e4e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3489,7 +3489,11 @@ static int sd_probe(struct device *dev)
 		pm_runtime_set_autosuspend_delay(dev,
 			sdp->host->hostt->rpm_autosuspend_delay);
 	}
-	device_add_disk(dev, gd, NULL);
+
+	error = device_add_disk(dev, gd, NULL);
+	if (error)
+		goto out_free_index;
+
 	if (sdkp->capacity)
 		sd_dif_config_host(sdkp);
 
-- 
2.27.0

