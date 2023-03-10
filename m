Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BA9C6FA99
	for <linux-block@archiver.kernel.org>; Fri, 10 Mar 2023 17:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCJRfq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Mar 2023 12:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCJRfq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Mar 2023 12:35:46 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7582127118
        for <linux-block@vger.kernel.org>; Fri, 10 Mar 2023 09:35:03 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id l9so222821iln.1
        for <linux-block@vger.kernel.org>; Fri, 10 Mar 2023 09:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678469703;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1KVN5hamTLEHp9oZAw3RnL0SxBhFjVTnrSNgPE19QI=;
        b=qxnMjZgvjbwDaKhvkTL3N2AQDqZ2k/r4J7R0kZFomMS6uM5qeA85plxEZZVXBil0BB
         PVHbbmVR1a3aM+kUtS6qsvCR9g//DlmsRjYSIl+bSfX+oaI2pz29YaAj8G3F2CA2VzSr
         Z2vBBSOT1T0LpAKi9n1zWjtmhjN4qhzvDTYqJhMVE4PQuJO3LurjmaFHWCh82p8KlBhd
         KNc9onSSySCDl0UP16iVi5blZNEUtwCsMjc0H+TqNIJ5SzYVa7lqgC3N8fkFJ1sO1X/5
         PpQXqWt30pjxU0h90369pqd56jmK6oPbXq+QiiX3ZIid8Ba8kayiPTXa9M74CnA7KP1d
         pySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678469703;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m1KVN5hamTLEHp9oZAw3RnL0SxBhFjVTnrSNgPE19QI=;
        b=7tVFT0Ijj6aYQXna+6e35Q2KWpj0g/vW7a1KTjSosEnKExhTbKKfN14sD3DGK1eTeu
         3srIAOzKiRff9ChlwJQieLjASnRKQu4oyEGCcHoUYv052jQUMc9ylXoy+FUwX4hmlv6L
         OoyxXESw/a0AvbvqN2JBVOYqAgZfw57u6MtbITZXX8FEnpDBvxb5Vyb9yqQtVhHvA0Y5
         XqDno2ZZkODRbCFQx3rULcnEklsDs4jJ8MmNASFgh4KsRW7A+EHUbm7DBg94sbOwwuGf
         mUszVH8deysvbsovpsRqBwxMcbZW/7kvzWgJci+w7g4aMM17czOlZSh3Y33yYXg5bUHL
         XZzg==
X-Gm-Message-State: AO0yUKV2cj5d0O/FAsUNwDifAgRR+Jwn3qmmFi1lF5JgE8/SfkCoLwiJ
        74Rp6Ot5zRy4/JkvmCuPvxDXVHGVop8f/8078EBWVQ==
X-Google-Smtp-Source: AK7set9tyszDOyrrHVW+jmTV9Tj9uHEyAeZGc0KKgICm7PB6U0LHQRo+3Ny74YgtOngVLkhjIQMqww==
X-Received: by 2002:a05:6e02:6c2:b0:317:94ad:a724 with SMTP id p2-20020a056e0206c200b0031794ada724mr4349194ils.2.1678469703047;
        Fri, 10 Mar 2023 09:35:03 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m3-20020a92d703000000b003157696c04esm147357iln.46.2023.03.10.09.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 09:35:02 -0800 (PST)
Message-ID: <2d435dfb-178e-5055-e0d1-f53a72232465@kernel.dk>
Date:   Fri, 10 Mar 2023 10:35:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.3-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes for the 6.3 release:

- Fix a regression in exclusive mode handling of the partition code,
  introduced in this merge windoe (Yu)

- Fix for a use-after-free in BFQ (Yu)

- Add sysfs documentation for the 'hidden' attribute (Sagi)

Please pull!


The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.3-2023-03-09

for you to fetch changes up to e2f2a39452c43b64ea3191642a2661cb8d03827a:

  block, bfq: fix uaf for 'stable_merge_bfqq' (2023-03-08 07:34:50 -0700)

----------------------------------------------------------------
block-6.3-2023-03-09

----------------------------------------------------------------
Sagi Grimberg (1):
      docs: sysfs-block: document hidden sysfs entry

Yu Kuai (2):
      block: fix wrong mode for blkdev_put() from disk_scan_partitions()
      block, bfq: fix uaf for 'stable_merge_bfqq'

 Documentation/ABI/stable/sysfs-block |  9 +++++++++
 block/bfq-iosched.c                  | 18 +++++++++---------
 block/genhd.c                        |  2 +-
 3 files changed, 19 insertions(+), 10 deletions(-)
-- 
Jens Axboe

