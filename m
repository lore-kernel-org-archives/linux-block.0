Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF953C48BC2
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 05:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC8261107
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 05:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFWFL5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 01:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWFL5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 01:11:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580DFC061574;
        Tue, 22 Jun 2021 22:09:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o21so533638pll.6;
        Tue, 22 Jun 2021 22:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VqGeL42RTOC+E9+SQYGTfGiCaSotCi3VvO6rfkKcNPM=;
        b=IFrz/YEUJopX8c+nwgr5e7kHD4d3/0DLR664YUFXmllUS8s/XAICU1COB9WhfGKg1F
         6kzPJ4H5hyRXiPGrIORjx2exRf001o6nb8cZpp5ZMOqyS+3KrTCYuKHaT6EAmtFSu5Y4
         NcMIzlITwTHPZ7HqmoGVM5qBUruP/cdScjP60NpqfgcwxonQjZqQMfJDwx/v4yO8mwdb
         vjI0iPjkwqSRGIodJjbUrd+Y4+y7R0gb2UgNV4wmsZ5DBjbQSAb9k+KuWWtTprxSppKC
         94RCrahpqrITPMyvOkbC1Cf/MrxGulpQQAeTe2ZbPNw2KGicdE2EiOoEIp1HfCkHuaNT
         6UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VqGeL42RTOC+E9+SQYGTfGiCaSotCi3VvO6rfkKcNPM=;
        b=T/xJHQI4X9IinUqHsEQAgMJKDdlhqfY567nTHoValNouO2lF8Dm6lA0E4iWX0QNsMd
         7aBMnrxJaJ5EaJfwp9YfjgCV9GtMrbgsuHLzeQhxL9FN/V2SLHKehISlsf8HdV6H73nI
         3GrzBZ5E9dcEoJDbOHzsjeIRgvMnwkBd1Wu3ed7UsHU0fMqImt4iZlPQeJCGY+K0yBAg
         mBWdfz16lRBaHan4+p+fWVA/D3E78uS5JL+/3RCnErivq9UGc7l2ZZxPpdpY1lNa9Hbu
         LHm5MzNFmKBZwtkZ6Qgt39x+4TqgcMiqV45Gu2kUu+5yRKXMzHmmfoh4/kQG4Qy96QCv
         wKGA==
X-Gm-Message-State: AOAM532uLLwRhxk5b1WE4rgVPpPSLz889bIS4V6Di+qaiTy0NdIE8mEm
        Jn6oC+cYx1PKZwdWNEssydY=
X-Google-Smtp-Source: ABdhPJyepRMiToVIa65MqmqIfNUEkTCS63UBkYEv6GnRARgtAghdWOminemkvTx8NeNFgw5AYe4SUg==
X-Received: by 2002:a17:90a:5889:: with SMTP id j9mr3674221pji.234.1624424979646;
        Tue, 22 Jun 2021 22:09:39 -0700 (PDT)
Received: from fedora.. ([2405:201:6008:6d7c:6bfd:dac8:eafe:7bde])
        by smtp.googlemail.com with ESMTPSA id h8sm22340998pgr.43.2021.06.22.22.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 22:09:39 -0700 (PDT)
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     axboe@kernel.dk
Cc:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+cf89d662483d6a1a0790@syzkaller.appspotmail.com
Subject: [RESEND PATCH] loop: fix setting arbitrarily large block size
Date:   Wed, 23 Jun 2021 10:39:33 +0530
Message-Id: <20210623050933.140572-1-chouhan.shreyansh630@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622161019.130090-1-chouhan.shreyansh630@gmail.com>
References: <20210622161019.130090-1-chouhan.shreyansh630@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

REASON FOR RESEND: Fixed spelling of the Reported-by tag.

loop_validate_block_size took an unsigned short argument. Passing an
argument with size greater than the size of unsigned short would cause
an overflow and could potentially render the upper bound check on the
block size useless, allowing to set an arbitrarily large block size.

Reported-by: syzbot+cf89d662483d6a1a0790@syzkaller.appspotmail.com
Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
---
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

