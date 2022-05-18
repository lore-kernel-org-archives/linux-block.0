Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED3DC433FE
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 23:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiERXM3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 May 2022 19:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiERXMX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 19:12:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD89E8BBC
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 16:11:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n10so3505673pjh.5
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 16:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=MBPncIlFOXvkTGNPZJICk/oWths+qrWCsRNpiokT3hc=;
        b=XQch2AEVIDY+89vMFgLSQtd/IMHL0dD3Cev5FoxvBtcbNKrbYLr2Tu7gWD5WvxCG7D
         ZFqiD9fNh4crDeI8IpHubQmzIrrPCD7aEBOpfnzITAB0cDTfeVMixccVTWJk0nhrTSh3
         T7QNofGzBvJGKCnBqXwnOCMuK/kRr1sHcXqsOrupTQuDSsz2ohSuyIBPwjKwsqSjN06e
         E5rODUKFODRe/8NzN+uGcYWAnCSCKTE3+DqzQ5N6Ja4Dg0c34Zxw2s9hmQoWV9rBggmr
         Fe+UDKbeG5g1Xz3iWKzp7ZduLlcGFI1BotJiZ7zWcZIZmdOpVjQfvNWEfK0rWRCf+1bq
         Lpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=MBPncIlFOXvkTGNPZJICk/oWths+qrWCsRNpiokT3hc=;
        b=gWNMiaBsEj9Nr8CwvtNF5stj9oxX6hlyCZTQeu6KM3y8lqreTr7/YSwqKWH1jnjCyp
         nFlDrrACmVzOO0kJSmQWadZta4yz/fgYdltjw70nbkInuol15JSOMaJu6J2NQQr7m1mA
         a8PzVIeHLk0QQfo+VNQHcnT7BXaLOptLa3lQv7fZUH7lsXNt5lE6uqoEc5Kp6DAjgkOy
         hYo2LRQRgjv4z9cORcutTQved/oDtxnjGH1ovhe+ZJgaJvwBlQNuAqrAltXJIKwt0xfg
         Vha5e6xyzFVN4q769Vr0S7+KqmTez4pnmnI451LywUD2gPEY4hOrlJEMa9IEiu76965F
         4GfQ==
X-Gm-Message-State: AOAM532k7m1q+GpkZmpWNAS2haRTTdK5d3PQQtFFUYW287srL7uej7Nw
        0du7E5ORa1hWIU7wI26iT/FuKt0LHYSBQg==
X-Google-Smtp-Source: ABdhPJyUWc4L13trbgUNVZ5OgaXukzWx4X0dVk6g8yar0aCzUkXsfCjWEMNRCo5iaDJ2W486Xq6ltA==
X-Received: by 2002:a17:903:244d:b0:161:ac9e:60ce with SMTP id l13-20020a170903244d00b00161ac9e60cemr1958651pls.160.1652915512142;
        Wed, 18 May 2022 16:11:52 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b0015eab1b097dsm2269909plb.22.2022.05.18.16.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 16:11:51 -0700 (PDT)
Message-ID: <9adae644-3856-a84e-b3d4-47106c91e09f@kernel.dk>
Date:   Wed, 18 May 2022 17:11:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 5.18-final
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a small fix for a missing fifo time assigment for the head
insertion case in mq-deadline.

Please pull!


The following changes since commit f1c8781ac9d87650ccf45a354c0bbfa3f9230371:

  s390/dasd: Use kzalloc instead of kmalloc/memset (2022-05-05 20:08:27 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.18-2022-05-18

for you to fetch changes up to 725f22a1477c9c15aa67ad3af96fe28ec4fe72d2:

  block/mq-deadline: Set the fifo_time member also if inserting at head (2022-05-13 17:02:46 -0600)

----------------------------------------------------------------
block-5.18-2022-05-18

----------------------------------------------------------------
Bart Van Assche (1):
      block/mq-deadline: Set the fifo_time member also if inserting at head

 block/mq-deadline.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Jens Axboe

