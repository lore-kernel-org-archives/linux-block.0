Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7826C636CB
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C8F613DA
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhGOUde (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:33:34 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:38748 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbhGOUdd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 16:33:33 -0400
Received: by mail-pf1-f175.google.com with SMTP id j9so6619492pfc.5;
        Thu, 15 Jul 2021 13:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ZSsPlES8wtechOPsFeaRMPI+2Ymf0gvenf8aJZbhkQ=;
        b=qLEgHcnASAtKCY67YAJWYUQtjrnf9lsaos9yEPJu3zdr9Fev+HD3OgWOHo+khmc6OG
         tzeFR2y3yKjEr6qpVKn48lZfoQvBs2QzoMBIsTSR3PiEwh+lAel0NdfgjKSfB9lATXA3
         UfD8N+9NmPudjlTPR2n/l7iSq9ZJpqMGBEKt8qAHrYFD7izF/EI87+97rizCnED3972m
         INutJc5WmwBBDwy8uIT+JCGQToHFoHPZMQu964SSIVOI87xtbIJ9SmjliGL7wWAZbUNn
         dTBAWhbinvgdeflEJSUm1wk398ecOUtdkRLyaYzc4QEsIvZbVvL68q/UftocWKht8ful
         5Y0Q==
X-Gm-Message-State: AOAM530dKw+MfsQSON5QRjhKpAquBBQxUgzWIsyIu8C2i/ugnInZ/tRp
        zqYJf/t85QexxgwZWmx6zHQ=
X-Google-Smtp-Source: ABdhPJwke9MZ0bVbY61wQvbLfKytF/emjIoPBypP8LzJQjKbj+pmn33Jr05ksLINaKZ/tf+A1ayQHA==
X-Received: by 2002:a63:450e:: with SMTP id s14mr6302666pga.312.1626381038490;
        Thu, 15 Jul 2021 13:30:38 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id u23sm9039820pgk.38.2021.07.15.13.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:30:37 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 3/5] block/sx8: remove the GENHD_FL_UP check before del_gendisk()
Date:   Thu, 15 Jul 2021 13:30:23 -0700
Message-Id: <20210715203025.2018218-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715203025.2018218-1-mcgrof@kernel.org>
References: <20210715203025.2018218-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is no longer required, given the block layer adds a flag
now for us on a disk once add_disk() completes successfully,
and so del_gendisk() will only really run if that flag is set.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/sx8.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 7b54353ee92b..e4dfee5acf08 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1373,8 +1373,7 @@ static void carm_free_disk(struct carm_host *host, unsigned int port_no)
 	if (!disk)
 		return;
 
-	if (disk->flags & GENHD_FL_UP)
-		del_gendisk(disk);
+	del_gendisk(disk);
 	blk_cleanup_disk(disk);
 }
 
-- 
2.27.0

