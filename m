Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87078C433EF
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 18:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6095A60F6B
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 18:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhJISrz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Oct 2021 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhJISrw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Oct 2021 14:47:52 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90AFC06176E
        for <linux-block@vger.kernel.org>; Sat,  9 Oct 2021 11:45:54 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p68so14728967iof.6
        for <linux-block@vger.kernel.org>; Sat, 09 Oct 2021 11:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dV48hvlB99K+223BH31yURqUqwYP9RoNYknOhqEDlBQ=;
        b=jlEz8t7m8yxOm3cdJnpkPHfSBXhJ+cunGpHnOfsveg494qTNguS/3n873RijSZ45/2
         ua8EmNdCkdVEu9hO4rLhf490Co4rfzR3Rq8+xLz7BnAINTQ33vYW5rVXsMXldjETLCEC
         I+4yXqEDJPSQ8fU2Jah65i10jDgLW3Z1U2sIayBkaxbgli82Ez0Qce/+W8s6oUQMMILX
         9UWlYsRdyVGcEZoel17luBIbEL9Nxuh8DAc0tkWbBe4xMeJ+JHddWPbK2BTnp/qYUgpg
         U8PbZckY9VnSHKAqtTRBL8jE7Dr88Q2YeWTTeIhBP0ci4BHV2XkmwxkEGto/TAAzDt/q
         HMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dV48hvlB99K+223BH31yURqUqwYP9RoNYknOhqEDlBQ=;
        b=RP4UUWmeFiFfkhZLQTSMjVqcYJb+tfuVvT0JrGbZOU3Bm5MH9cd1w+jzjnbimmCBsR
         r+ZskYIbJAV7s7Qa6eilyDmRrQeFTF3pGQ0yhl3yh5bEEkMlvkay0DsttDQX+c6mLrxg
         91XRV2gr0bzzmbp60SeuzBPVLgtP1WKFf6ql+I1EIM8g8RSmfntpCAAGcBV8j1/2kuaG
         vVwwBtW94qZYkGXLupqMztJomYXUpFlOh1ksR3WGxRwivYjwR5BsEmh3KFERNEYPCu+g
         1IhylxhFdA46whIfaX5Q0YPnw6B4msonnbXycho+CqXjp5SgxAGnjYkFddc6WZsRWlI/
         jaFA==
X-Gm-Message-State: AOAM532zOW8p8fDO/aFW6RxB4dR8PNhats7l2fHaE1w2u5Z1+ZLfukPI
        LDKWraa+G3kZMtDkgbH1nha3Ye5Ovx5f5A==
X-Google-Smtp-Source: ABdhPJymYZtYljRrNmXJ4Pp7LQR+yJQ0NLhLaZ70y5Xe3lSZVVcBkc2J6npaxJsrmuOQ+a16atOKEA==
X-Received: by 2002:a05:6638:538:: with SMTP id j24mr12802628jar.39.1633805152504;
        Sat, 09 Oct 2021 11:45:52 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id w15sm164504ill.23.2021.10.09.11.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 11:45:51 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.15-rc5
Message-ID: <05521e6b-9f74-0949-43eb-5029f27d9061@kernel.dk>
Date:   Sat, 9 Oct 2021 12:45:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Two small fixes for tihs release:

- Add missing QUEUE_FLAG_HCTX_ACTIVE in the debugfs handling (Johannes)

- Fix double free / UAF issue in __alloc_disk_node (Tetsuo)

Please pull!


The following changes since commit 41e76c6a3c83c85e849f10754b8632ea763d9be4:

  nbd: use shifts rather than multiplies (2021-09-29 20:31:41 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.15-2021-10-09

for you to fetch changes up to 1dbdd99b511c966be9147ad72991a2856ac76f22:

  block: decode QUEUE_FLAG_HCTX_ACTIVE in debugfs output (2021-10-04 06:58:39 -0600)

----------------------------------------------------------------
block-5.15-2021-10-09

----------------------------------------------------------------
Johannes Thumshirn (1):
      block: decode QUEUE_FLAG_HCTX_ACTIVE in debugfs output

Tetsuo Handa (1):
      block: genhd: fix double kfree() in __alloc_disk_node()

 block/bdev.c           | 2 +-
 block/blk-mq-debugfs.c | 1 +
 block/genhd.c          | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

-- 
Jens Axboe

