Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECA4E81E19
	for <linux-block@archiver.kernel.org>; Fri,  6 Oct 2023 16:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjJFQgp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Oct 2023 12:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjJFQgp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Oct 2023 12:36:45 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AE1BF
        for <linux-block@vger.kernel.org>; Fri,  6 Oct 2023 09:36:43 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34f69780037so2702355ab.1
        for <linux-block@vger.kernel.org>; Fri, 06 Oct 2023 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696610203; x=1697215003; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6OAaMLRqRbojQa3stLytOCZgGRMHQsj6V+wxJ7LTBY=;
        b=DldNDL9pJzs6WHz6CDnfanH8zJ+l1iqVfrThJ6z7XovjH2SDtEvCglhfp4weaStMXd
         gh1ZOqv8a3TtnyiKVeh8LRzdAprG9m61eMFGQ7TW/EOEBFcNJppA1vWQ8C4TZRbefqyO
         u6TTt6Py1A5NjNYfRPl7epO+EgdFM3WgMq57RXM1lwyFXS/Ka2LH72OW0OZUxQwIy+mL
         +mjEl3xIVtF32qSQmzGjkD6KfiwPfwLYYEoyTa/n34wXNhc/1BpaaWrIdUdDcDYgnPuV
         yCJmnaPsHCOMW/aV5xRKpIyFflE4xVeIAxWcSgXXOxoHVUTreZutFK01etA2+NDBYORp
         +kXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696610203; x=1697215003;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P6OAaMLRqRbojQa3stLytOCZgGRMHQsj6V+wxJ7LTBY=;
        b=CSxBEMgYBlvYaY3jXptQ97Ta1Z+zsjWh15Jp1FkMpoDt4UqH9xKqpNXo5+FdCbkeMl
         kyvF4W0l7DM6VFSJTU4mtctR3hd+kT3mB7NOp9K0F0ooZTugJGVbM6Ze9NvLZFYLMypH
         thhx7raump1S8v7qUPAAolIpGNjMDQSWQD+YBTdaNrvT0omgx/DoPCFg868Db+6M3mzY
         YA+0UFjQpBoxtjmp7kdDcv8+H/fRzaaZv51qiUtuCrDyRgoQGcZFyPuM5XvTx6gaZ2XR
         wIM899fyKnPzHqk2bfxH9BXpf5e1ttU/H+Wixnp4hfUb/3ndvvJ+yAFIZvV4mcc5Txcq
         uP0g==
X-Gm-Message-State: AOJu0YwfEGbApq/69lmJ2kTq36Xzk58l8YOvzNxkyP2p8B7F+gICY3wO
        rDwQ49OguAM9xl0kvoQTPXoYS5V/tUlkTgdANzA=
X-Google-Smtp-Source: AGHT+IGu8CquZ/MpybBgQRHN7uJ0rL1ePX9Z3TEUUEKZsoLE8XhkGVQB9kVVOh7+2Y1mobTvsnY2aA==
X-Received: by 2002:a6b:5d01:0:b0:794:cbb8:725e with SMTP id r1-20020a6b5d01000000b00794cbb8725emr8563921iob.2.1696610202834;
        Fri, 06 Oct 2023 09:36:42 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y24-20020a6bd818000000b0079fdbe2be51sm629272iob.2.2023.10.06.09.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 09:36:42 -0700 (PDT)
Message-ID: <d7b8f468-d533-4658-b185-256c89756fe2@kernel.dk>
Date:   Fri, 6 Oct 2023 10:36:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.6-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just two minor fixes, for nbd and md. Please pull!


The following changes since commit a578a25339aca38e23bb5af6e3fc6c2c51f0215c:

  block: fix kernel-doc for disk_force_media_change() (2023-09-26 00:43:34 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.6-2023-10-06

for you to fetch changes up to 07a1141ff170ff5d4f9c4fbb0453727ab48096e5:

  nbd: don't call blk_mark_disk_dead nbd_clear_sock_ioctl (2023-10-03 18:27:44 -0600)

----------------------------------------------------------------
block-6.6-2023-10-06

----------------------------------------------------------------
Christoph Hellwig (1):
      nbd: don't call blk_mark_disk_dead nbd_clear_sock_ioctl

David Jeffery (1):
      md/raid5: release batch_last before waiting for another stripe_head

Jens Axboe (1):
      Merge tag 'md-fixes-20231003' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.6

 drivers/block/nbd.c | 3 ++-
 drivers/md/raid5.c  | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
Jens Axboe

