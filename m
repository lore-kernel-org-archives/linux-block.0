Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A79CDB474
	for <linux-block@archiver.kernel.org>; Fri, 13 Oct 2023 01:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjJMBJj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Oct 2023 21:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJMBJj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2023 21:09:39 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B03DA
        for <linux-block@vger.kernel.org>; Thu, 12 Oct 2023 18:09:37 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3af59a017a5so270900b6e.1
        for <linux-block@vger.kernel.org>; Thu, 12 Oct 2023 18:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697159376; x=1697764176; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5dqUmiFZPJkcxYkl0KHgEoYEqf8V98xixTgt3U9WN8=;
        b=EqIiifNT8l+9oYXo/0QgkSAuTcxQD3vV/bG79y6l1XL5W0sCtd9svZsYJEQntvO1y2
         QE8aaaYEYBRTgpfqo5N9bThOHpc+aJHRKd2U/t0SkzTbQP0oB3qhB/tZlvFnB2ljIxkI
         9hpSf5M9G6aFq5FVx6FkjCFS61/+k0rk7zkxkaD38aYS5nbCpccFn0iJ/c5SFCTOp0gn
         s81eIe25CplwuUZBoyAXc0O2fQXvYsA3n6fDg2tebMcxz/1Ew1KPm5MiUG6VOyhpHSmS
         mlHgGnwBgiBFQIh2ZrbBVxqi3dLlEJ0mXws7LABN5gk84VB3HWTIduAUyXW39Cl8sR4j
         FKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697159376; x=1697764176;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y5dqUmiFZPJkcxYkl0KHgEoYEqf8V98xixTgt3U9WN8=;
        b=o4BtMUwcepujOXlTv4yRppc7s8szq9ZieFrRSz3Q2s1KaXp4NByW+E1Asewa3gJTT3
         0rRvjMCtPMqA0O9Jkx8sxfJ3Sn94rwgQXkW5LMHzPb7NmOqac8IslJlrSBBLQOEMw2yU
         +Qy6UsPCpqIZtHwzYeL+F2iDUdDv1oRebQpLzv85jvk/uvXqWkn8q1lWlLY66qBBbIg2
         hh7fbqfTcaHbRxq3wpqwybfLBC0TJgemWxh4X1ufpGb0a3iMUcja5ErvgB7UABJ8Q3B0
         5sxO7xOH9wS/ZxNC5x9vgYwlY+LZRZdklS8oHCIWT6bumh7C1H1wo7eKMD2M/PDL1ouQ
         erTQ==
X-Gm-Message-State: AOJu0YyAqT/aSN9+0VNzwjecjN3UsbG8aKYlALypTUrR0+WsPa65AbMH
        L33PaQ0A1zanD5LORzw/MXlEg25CwTgkcv8tWd8uKA==
X-Google-Smtp-Source: AGHT+IEpNOVisKhQ2cNDSmxSFsO2hXZL9bWg7ydgoHBqZ77zT3/HnGPnkzQ0pcC7Auyp8kDtxRYxUQ==
X-Received: by 2002:a05:6358:e908:b0:147:47f2:2d54 with SMTP id gk8-20020a056358e90800b0014747f22d54mr22175424rwb.0.1697159376575;
        Thu, 12 Oct 2023 18:09:36 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id v13-20020aa7808d000000b0068ffd4eb66dsm12379658pff.35.2023.10.12.18.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 18:09:36 -0700 (PDT)
Message-ID: <e211ae0d-0231-4087-ab0a-fb9bc24940c6@kernel.dk>
Date:   Thu, 12 Oct 2023 19:09:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 6.6-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a single fix for a longstanding regression with using fallocate on
a block device. Please pull!


The following changes since commit 07a1141ff170ff5d4f9c4fbb0453727ab48096e5:

  nbd: don't call blk_mark_disk_dead nbd_clear_sock_ioctl (2023-10-03 18:27:44 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.6-2023-10-12

for you to fetch changes up to 1364a3c391aedfeb32aa025303ead3d7c91cdf9d:

  block: Don't invalidate pagecache for invalid falloc modes (2023-10-11 15:53:17 -0600)

----------------------------------------------------------------
block-6.6-2023-10-12

----------------------------------------------------------------
Sarthak Kukreti (1):
      block: Don't invalidate pagecache for invalid falloc modes

 block/fops.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

-- 
Jens Axboe

