Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82EFC4332F
	for <linux-block@archiver.kernel.org>; Fri,  2 Dec 2022 21:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbiLBViL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Dec 2022 16:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiLBViK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Dec 2022 16:38:10 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF8F2FFE7
        for <linux-block@vger.kernel.org>; Fri,  2 Dec 2022 13:38:08 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r18so5385109pgr.12
        for <linux-block@vger.kernel.org>; Fri, 02 Dec 2022 13:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o51UdSgW5p1UOpzXzQVtTrMetP4WMQB1N88gN1rMn3k=;
        b=N93kIKb1NwZDhJlgW8vvA4yD/r4CkK0nQQYFqnP8jKJot3sxdz5XPOoOJ3dVbAZafA
         5Wz3u0fTOPTWWUAj3ngAEhc6g7cfqOxy5zpTedQqcjQp/gjvUTb3JYvSNRP4eT6GEtGk
         LwqEynJCFO1YD3E9ZetAUubN69WBV13/UEz/e+st7PLB1xzibseoohjxN3/i++jU92NS
         mFcDzAUvChoW62qlUAWB3eAfIVTLjHAfy7ERIoXZaALLirL5hAmxvLOeuto33LID4Goe
         M44UlnwYU94Ghy3r3t2bSR+jiOhNM+JYDrmdoa7qK2Mlzwd2QLQgTN/CqtQKFSzlQbNC
         rj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o51UdSgW5p1UOpzXzQVtTrMetP4WMQB1N88gN1rMn3k=;
        b=d2VBveISI/eGt7sOjrZPXogWOTjpovS5viGWpNJhZVzrBw7Bl2jQSRTBQFa3mn85hc
         0D1mYixoc7T6/0F6NO9fIQ33dVUWYDKQyc3MgGGXjzvoMZwFH+QPb6O6ltzPfeoLGoF9
         fUOKizC10Sinxa7M339qHsZFxchZD7628w24gfzuOP73pgPNMHV3g+LJ3qaBfL69/4c/
         L6vcxY2uf8mWRod9VdmNKCSFapheYrGaeUYk56HIAQdt6AgUOrLqLyJ3ubcO14udZu6d
         Jf7QA/qxHWP4fTfIt2xo5Dt4tYLPEeieGPuAjYxEWMJm+wEIeFVzp4ZswvkGX048mEAj
         jzVA==
X-Gm-Message-State: ANoB5pk3R7HhhoccyOFVQ8vJiv9Bzvb8Xf5BZdo5t4BW+m4UFm7+LHXQ
        cSiNkfOLTp/Ec4LfCW0YyVCQpxcJukRMCfxaooY=
X-Google-Smtp-Source: AA0mqf7bLBIvOmuvI+VTB63B1PdRB6xjdtvPIpARyybytMQHhlHFdtOQNqr6bdFd6BxVLC4L6Su5Mg==
X-Received: by 2002:a63:f50b:0:b0:477:96e1:fa72 with SMTP id w11-20020a63f50b000000b0047796e1fa72mr47176054pgh.523.1670017088075;
        Fri, 02 Dec 2022 13:38:08 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i92-20020a17090a3de500b00218ec4ff0d4sm7125250pjc.6.2022.12.02.13.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 13:38:07 -0800 (PST)
Message-ID: <0429607c-d5b1-6d6f-2cff-7b35f02a562d@kernel.dk>
Date:   Fri, 2 Dec 2022 14:38:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.1-rc8/final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a small NVMe merge for this week, fixing protection of the name
space list, and a missing clear of a reserved field when unused.

Please pull!


The following changes since commit 7d4a93176e0142ce16d23c849a47d5b00b856296:

  ublk_drv: don't forward io commands in reserve order (2022-11-23 20:36:57 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.1-2022-12-02

for you to fetch changes up to d0f411c0b9bdef85f647e15a2fcc790b29891f2c:

  Merge tag 'nvme-6.1-2022-01-02' of git://git.infradead.org/nvme into block-6.1 (2022-12-02 08:01:06 -0700)

----------------------------------------------------------------
block-6.1-2022-12-02

----------------------------------------------------------------
Caleb Sander (1):
      nvme: fix SRCU protection of nvme_ns_head list

Jens Axboe (1):
      Merge tag 'nvme-6.1-2022-01-02' of git://git.infradead.org/nvme into block-6.1

Lei Rao (1):
      nvme-pci: clear the prp2 field when not used

 drivers/nvme/host/core.c      | 2 +-
 drivers/nvme/host/multipath.c | 3 +++
 drivers/nvme/host/pci.c       | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

-- 
Jens Axboe
