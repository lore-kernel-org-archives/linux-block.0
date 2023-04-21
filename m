Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467BEC7618E
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 15:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjDUPB6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Apr 2023 11:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjDUPB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 11:01:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B31F6584
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 08:01:56 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a6684fd760so3228065ad.0
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682089316; x=1684681316;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/3ZGzlb2mzTeIHWTlKM085CX8jpj4XHUVIgCrqH61I=;
        b=uoZ6opjH4h4nxy6GOQvcxOJJECYZflgtN5Sh3jDOhrUUZ0n+Vi+Iiqm68RkQWeFEJP
         +wHI42IWLu0IRnHwUw6K9736QHF3a11MbWY1VdElPG4drG3xKqJ9f0d443OJZS8VenWm
         /hzztsfKOoQwq+pbqr0YvG0ncyDz92Hj6eAOb2FuKKbbL5WEjs+d3d7XjY5LqFKSLHvB
         ebC2pTR86vcJ+FrY3Vh/jU1u91SjafLeWyBPgKQ1cCMwGM7qbHHEK6KB2+qAcYfCY8N1
         c98d1IJ9dYooWeaaLmvkBMAnAtT1i7YcBMeDYgI1Owo1gG4tus4fAN64YGmFgwxq8mpw
         Io3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682089316; x=1684681316;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j/3ZGzlb2mzTeIHWTlKM085CX8jpj4XHUVIgCrqH61I=;
        b=k588NpoeIS+I9jdaTBgQAX6D/FWlZscUjoglepUY8/YlhuyiBETbT4w4AFQjnMYIiR
         wC5OwOWnj5iIPqF45Q60yCCiQA6bIoaXLn9t0Gv7Vk/yJle+bmq7O3JDuZXcsSjKvRKE
         fsqVC/0YfLRWg4bd+Oj6pEmIGRqjxAw7iulUKZQuTYEfuZC16771xSN3qL9b/pSmDO8T
         eFDpbfzvV1/25/8q/wokIiicaoidopf3bQWAHF/o0hdx25W1p/Gj/jNUAc+D8Quobu2p
         fQ5v/ZKkS+AnXJ1jjuMokDUlkwP1e3nP70YdHsRavMnnzXRb42SOeLuRGbDDdKZMepmE
         ufbw==
X-Gm-Message-State: AAQBX9dwV68VTXPZi1uRpdoyaiYNyR56cLtnoBNKsw3mLKNKazrZRUDM
        fj4jMQXiw+BJ/AcKs+p58rj1T8L0KdsKCv+cOog=
X-Google-Smtp-Source: AKy350aKpTxdlF1iiMN2Q1gxVW7eY9lgtbejHVl84lzFqJluwjzue0nqNFMyrDNK1udueYsA9aYd3w==
X-Received: by 2002:a17:902:d4ca:b0:1a6:6edd:d143 with SMTP id o10-20020a170902d4ca00b001a66eddd143mr6208036plg.6.1682089315831;
        Fri, 21 Apr 2023 08:01:55 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902bd8700b001a6ff7bd4d9sm2887651pls.15.2023.04.21.08.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 08:01:55 -0700 (PDT)
Message-ID: <0afbb007-a1d5-ed34-9304-04bb91264d7c@kernel.dk>
Date:   Fri, 21 Apr 2023 09:01:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 6.3-final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a single revert of a patch from the 6.3 series, please pull!


The following changes since commit f7ca1ae32bd89ab035568c63b4443eb55420b423:

  Merge branch 'nvme-6.3' of git://git.infradead.org/nvme into block-6.3 (2023-04-14 06:29:00 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.3-2023-04-21

for you to fetch changes up to 81ea1222f2fa5006f4b9759c2fe1ec154109622d:

  Revert "block: Merge bio before checking ->cached_rq" (2023-04-20 06:54:17 -0600)

----------------------------------------------------------------
block-6.3-2023-04-21

----------------------------------------------------------------
Ming Lei (1):
      Revert "block: Merge bio before checking ->cached_rq"

 block/blk-mq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
Jens Axboe

