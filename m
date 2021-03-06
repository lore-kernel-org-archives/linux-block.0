Return-Path: <SRS0=+JuZ=IE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19BDC433DB
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 22:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5621C64FF0
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 22:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhCFWqf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Mar 2021 17:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhCFWqf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Mar 2021 17:46:35 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37891C06174A
        for <linux-block@vger.kernel.org>; Sat,  6 Mar 2021 14:46:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h98so7010018wrh.11
        for <linux-block@vger.kernel.org>; Sat, 06 Mar 2021 14:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:mime-version:content-language
         :content-transfer-encoding;
        bh=3N43K5i5K2H7r2Nt1FUw4nSeM7pjUTtXg8LS/Jw2058=;
        b=UmcrF9zxiTfcUsTPACEg9E52ylvQH/gMmSUbu77JQS7JuuoctWOLnEL1n/qjlIMMjm
         rm7F2fhhZRX3ZIP5Xy94VGU5PtFf3zUYj69Vel0sIgp8ppWFjQ6Pm9V2X7QZJjos5GM4
         hS4mUpZYdoCF3ZT/nNINWcdAfqcXiU/MkRhVe7jjxbxkWG+oaHaxe+rMj4YfWMWsi0pI
         NtmMXE0QVrei+40DP/L5+IQ0+QQio64dAvd0LOQ582GdZduKe6Af8OhIfWIcgYmAeRRZ
         MuOMVk6ZWIgtKLhSeDRfZCc2B6nG5SGIHX6agKYKdcI6QBWyYklw6n4K43Hu+4hnxdkp
         Irpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:mime-version
         :content-language:content-transfer-encoding;
        bh=3N43K5i5K2H7r2Nt1FUw4nSeM7pjUTtXg8LS/Jw2058=;
        b=bk2DDa7m6mDd5JnIxgeRCYLUsYT6t96+6nwx+m/2DRtZa6UpCImFBnvMPuThiiwhhd
         FPz85RnIPX0uPc4et74PjFyAoGKmYYEaebz6E9ByJ4Usgl6KAiUKJdo7j6Ty361Hw97X
         gOG34j9sBrsWlj09H7L5ygeVWGDwVHC6VHlNw3Asvs1mShJmgemm0AIdnH2d27uFuGQx
         iFwIuWVq/Zl0fLoxikFKFUS808vTUENvWG1A1JGT4zI1O7n/v8YexBud4+s0q1S1D798
         Zbs2YkoV/xc7awI9t3d7ir2QiKp9L7KaYokIOffStLSiTcYyh4tSVKKjzb61Exyv0SzZ
         SoKA==
X-Gm-Message-State: AOAM530P8ghI+yKwz1VpnJNBW+JpHjMd5dEQ3sfW7jRopWTyMj3yS53j
        JX2pgrHe1B9Xo0zwCw9xEf09BV0s1A==
X-Google-Smtp-Source: ABdhPJxQd9DzkmIUQhjmmqWhjdH+ppEl1wEDunef81gv9CQ1h1yjuKLQp4iPhRZPp3TPOiJMTNo6Aw==
X-Received: by 2002:a5d:6307:: with SMTP id i7mr15938667wru.305.1615070793799;
        Sat, 06 Mar 2021 14:46:33 -0800 (PST)
Received: from localhost (215.red-81-43-178.staticip.rima-tde.net. [81.43.178.215])
        by smtp.gmail.com with ESMTPSA id j125sm10639755wmb.44.2021.03.06.14.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 14:46:33 -0800 (PST)
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        BLOCK ML <linux-block@vger.kernel.org>
From:   Xose Vazquez Perez <xose.vazquez@gmail.com>
Subject: [RFC] iosched: add cfq -> bfq alias
Message-ID: <7962131d-12c5-0862-483f-e8873cac8ba0@gmail.com>
Date:   Sat, 6 Mar 2021 23:46:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Avoid break old scrips and udev rules.

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 95586137194e..8c6c82860a45 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6914,6 +6914,7 @@ static struct elevator_type iosched_bfq_mq = {
  	.icq_align =		__alignof__(struct bfq_io_cq),
  	.elevator_attrs =	bfq_attrs,
  	.elevator_name =	"bfq",
+	.elevator_alias =	"cfq",
  	.elevator_owner =	THIS_MODULE,
  };
  MODULE_ALIAS("bfq-iosched");
