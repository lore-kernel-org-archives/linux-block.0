Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAD0C433EF
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 19:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E0961053
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 19:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhKATox (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhKATov (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 15:44:51 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8D2C061714
        for <linux-block@vger.kernel.org>; Mon,  1 Nov 2021 12:42:18 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r194so22902219iod.7
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SXS5BeSCNTzQoE9Sro7+pSKTW9UOhz2EeDahCPvEpJo=;
        b=0d41FruYFOkqyRyz3PH/OvFVwbzqwmGMvjH9kACfkBZ5EDQt0LN9OEW+Ea0HW1UYnl
         Kj2gQqIIRe9Q4JltBmsExIup/FBf1hU0AQM7N9Ymgt7J25sl1GC5ZDP0L6MXwM2YYGY3
         hLdjC0KWzOBOLFHFXn4dSBK/3i3BhMd40QTpp0C16erjzvjgrAaA8rD1UhVhA8e9iN8H
         3r3eqQY4vmRwMrdC6p/OCUti4IPX0VpFfON6MLM/dx5TemEqnxhvfA9RM+LfWwe8WLLp
         NDAl7ITuX3WUws4sc37q9/ERJyO3mRJKm5f6PVY1cZaxUOt2R3QmKBPiYOVHWcByHAAf
         DG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SXS5BeSCNTzQoE9Sro7+pSKTW9UOhz2EeDahCPvEpJo=;
        b=3dfWHa3pdOuJEieHgvokUffltrJ/o236GNDJ+g8u1Se1HVzTh8f+cHgadyLCUk8tEg
         +De8G7F0qHClUJziMbTUQQEWQbmQstnLKmfRA0pRp+0nEDDZ+Q9ynbobeCuIR+PBFFMZ
         2d3ORgg3J81Qob9F66yh49aMcNOGdpdNQNTSF5NX7u6qtUx3h06KTzgGtF/4SplUMdj7
         y9TRjyMSIMxSUpNb2RLiMPEWot+Y8VmkHTNtt9wlg1MzyDyOn5RknjH9+VjJz6yDf+pm
         o4DSalnR5Z5eUqqe3oBiveYSEqpV3Ah4rKED+cmf6s1Fc/qTuKZRSq1/onAVvfXS3/Ux
         X49A==
X-Gm-Message-State: AOAM533hjRO0OW/lrvg9FAL4BXBM3XL2jr0CCs1tcqYDE/7mfG+FHpwg
        sT6NUmGDo7r1ZxoAu0U/4iL8srK4iyLHSw==
X-Google-Smtp-Source: ABdhPJwPT4ACmw5M28/kfqP2w88nF6HyPNjPf3lN688EHfMmJh5kxBqB+Tq5R2A3cWHhT+WlR6HYeg==
X-Received: by 2002:a5d:9493:: with SMTP id v19mr21977570ioj.34.1635795737162;
        Mon, 01 Nov 2021 12:42:17 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k16sm8335046ior.50.2021.11.01.12.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 12:42:16 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: replace always false argument with 'false'
Message-ID: <7d6a5cde-1a98-55ef-4094-d9286d51fecd@kernel.dk>
Date:   Mon, 1 Nov 2021 13:42:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A previous commit fixed up the condition for doing direct issue, but that
left the 'from_schedule' argument dead inside the branch. Replace it with
'false'.

Fixes: ff1552232b36 ("blk-mq: don't issue request directly in case that current is to be blocked")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4787d5b74aa3..8aed6cea3a34 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2227,7 +2227,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	plug->rq_count = 0;
 
 	if (!plug->multiple_queues && !plug->has_elevator && !from_schedule) {
-		blk_mq_plug_issue_direct(plug, from_schedule);
+		blk_mq_plug_issue_direct(plug, false);
 		if (rq_list_empty(plug->mq_list))
 			return;
 	}

-- 
Jens Axboe

