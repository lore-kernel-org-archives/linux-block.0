Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9039AC49EA5
	for <linux-block@archiver.kernel.org>; Sat, 26 Jun 2021 08:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F0061920
	for <linux-block@archiver.kernel.org>; Sat, 26 Jun 2021 08:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFZI0g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Jun 2021 04:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZI0g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Jun 2021 04:26:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1390BC061574;
        Sat, 26 Jun 2021 01:24:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso8416096pjx.1;
        Sat, 26 Jun 2021 01:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ocF7LIpSwj3vsZpHqVHvaq9IL3YwB/xApDMByqK67ds=;
        b=Ok6ehZ3ywSEcP84JHiXhZnSr6kLHfiTzdhMbOwlbhFnO9JmqUDic3JM4CSYCs5yx3l
         3UVfAKtH25NmZ48EcJgC5jMTnn0f/oKkD2rbRwzUz3OfbhLPPQeBT3Cnh7Lakx0AdL2h
         CjHM6qYnHGKNYS3uZMGroZC+7ezaXW3DbDXETdNqR3vZUhiIN9NKqkOyR3mcVdF9JKlA
         xC0nUeLcDrGklkcGMEFqvVAFC0YOvZ12bTYwoIDObSK4zxYJOtShYfVRn8WI3OmV7cQq
         WhoynDe40Nwyrtww/YWL5JfBfrDhE9TzlKu3NvGs1nd3v/45PAxWZQ8VU/sb9MyWNvOt
         wo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ocF7LIpSwj3vsZpHqVHvaq9IL3YwB/xApDMByqK67ds=;
        b=C/xjNCSkLyAF3Rdoa7GX3m9bNWaVZ/zm7nLL+Vk+Pw0R/8RwWHukdYuOIayMvfNlTf
         8E4GWZd8NyAhXHHe/RNyMujpo/axXFKdlAbxInqj7bQ6vL/+6FWl3kqXRSIR522DKIkF
         ZOM4//lo7+uf6ABrcs4sYodkdk5MguCRrOcdOC/8s9XXdHUVEM2zU8LTlNEBYLMlZiDz
         ANzVYXJUIbT3L/yADx8ISP/gISJHKPS+aseVyGyJ3Efvru7o7XMrHhYpuPEBKXrS4jq3
         7sQ6qNW3VoCZHOVIl7cZMbSdicE5DgaRAheXxx4yzfG+en8Y4XvQEBTf9fBObxxjwbSp
         AFMg==
X-Gm-Message-State: AOAM5311uQOXT5bK+eNmbGx9pRIGNIaEjxVZdC08uHvRmo4U39Z2AePd
        DZfhZ6zuX2bBKhDcMsVhEBQ=
X-Google-Smtp-Source: ABdhPJyXzXcAr0JT1E0Xnx8dUGgzY6WxtABUW/NHoZY8c2ZH8/gIcc0pHDu/rbEPJttRTk/mVga8GQ==
X-Received: by 2002:a17:90b:3449:: with SMTP id lj9mr26237121pjb.123.1624695853420;
        Sat, 26 Jun 2021 01:24:13 -0700 (PDT)
Received: from fedora.. ([2405:201:6008:6d7c:6bfd:dac8:eafe:7bde])
        by smtp.googlemail.com with ESMTPSA id h8sm8064995pfn.0.2021.06.26.01.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 01:24:12 -0700 (PDT)
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     axboe@kernel.dk, hch@infradead.org
Cc:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+cf89d662483d6a1a0790@syzkaller.appspotmail.com
Subject: [PATCH v2] loop: fix setting arbitrarily large block size
Date:   Sat, 26 Jun 2021 13:54:06 +0530
Message-Id: <20210626082406.348821-1-chouhan.shreyansh630@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623050933.140572-1-chouhan.shreyansh630@gmail.com>
References: <20210623050933.140572-1-chouhan.shreyansh630@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

loop_validate_block_size took an unsigned short argument. Passing an
argument with size greater than the size of unsigned short would cause
an overflow and could potentially render the upper bound check on the
block size useless, allowing to set an arbitrarily large block size.

Reported-by: syzbot+cf89d662483d6a1a0790@syzkaller.appspotmail.com
Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
---

Changes from v1: Fixed the spelling of reported-by tag. Fixed the
commit message.

 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9a758cf66507..635baff0dd66 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -236,7 +236,7 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
  * @bsize: size to validate
  */
 static int
-loop_validate_block_size(unsigned short bsize)
+loop_validate_block_size(unsigned long bsize)
 {
 	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
 		return -EINVAL;
-- 
2.31.1

