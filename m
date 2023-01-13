Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3CEC677F1
	for <linux-block@archiver.kernel.org>; Fri, 13 Jan 2023 19:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjAMTiD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Jan 2023 14:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjAMTha (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2023 14:37:30 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D73889BF7
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 11:33:57 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id jl4so24416385plb.8
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 11:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej+Vbuo8R7RPvMelIEyuS3sxus6so3ykmcpy+hkZfjI=;
        b=xuXD+FoNlIq0cDf6CN3v3aP+q6vGDuYmmGvqDLXUk86NVkkyui+1mvPjXTeUPtRwIs
         b3l/djS7z2mDTaM6OQaLgiCH3xsd0IRSmDU6+vdWBuW/gSds65hG5B3QshbxPamvB1zT
         8Kuv+G1CRNDSCpYUpS+DHv5yrSN5Vt+acP3J/duZ5ddHbs5KNq7rF/QFtlzuSqJOn6NO
         1ons8l5iQRjL4BJovItDD8EFmSPV2adZEF799sL30+sLpEKooByB5KQmVE17kVOtET94
         wkMZShpWVnAsZAWgBnftOPwfXmNH6GsRT2WKoHao1ETPhSvPDkV3LrRig/Ie+Hq9W3jM
         eyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ej+Vbuo8R7RPvMelIEyuS3sxus6so3ykmcpy+hkZfjI=;
        b=G38OeRO9zpu//TSUbWDgP0aFRN9WzcIDI3/PT5KRmiZh2DdkJ3SFWy3u5fRq7vsl58
         /5NgwMzgW2k/44YOfdo7ax4xKG0bFh7z0nlcqFFtIAHeegkQXMXTyE01ZuPBezgMzflx
         8SHYuO1gAUeUgHsm6YUaTsaa4/slbUArKmThTaS/nifY65+ja/6YedceTjpVcmPbBUUN
         u9gXFzqksmVlqoyeRsIlwn8fIbR3xyeMD9SDYvZoyWyfL71GTcNOqrCRWa/+yWgFynAm
         6VRxgQ+J9VrEUQ+NGOfJBz99qr7ZovE7fx74D6uMpG6vhDvv0k4fcHpY1zhPCA0FY3Ci
         fbmw==
X-Gm-Message-State: AFqh2krPJ/Wx0G83ocHT6bl+zdTglDeK2EDjhTaXjNawWn1vvDe4rWrm
        j7Iq50gTKomh20J2ZlLBIvT4FMpc0j6g6n1+
X-Google-Smtp-Source: AMrXdXtuRPbcCae1z2rFwIwBoa8PBgFuKtC8kkpc9YU06RIVidkq3bOHygmeZBpR8AUPD4VIZI3AgQ==
X-Received: by 2002:a17:902:b611:b0:189:f277:3834 with SMTP id b17-20020a170902b61100b00189f2773834mr168681pls.6.1673638429719;
        Fri, 13 Jan 2023 11:33:49 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b00186c3afb49esm14464095ple.209.2023.01.13.11.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 11:33:49 -0800 (PST)
Message-ID: <2ccb1b3a-ea42-134c-b906-4a3ecdd6f29b@kernel.dk>
Date:   Fri, 13 Jan 2023 12:33:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.2-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Nothing major in here, just a collection of NVMe fixes and dropping a
wrong might_sleep() that static checkers tripped over but which isn't
valid.

Please pull!


The following changes since commit b2b50d572135c5c6e10c2ff79cd828d5a8141ef6:

  block: Remove "select SRCU" (2023-01-05 08:50:10 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.2-2023-01-13

for you to fetch changes up to 3d25b1e8369273d76f5f2634f164236ba9e40d32:

  Merge tag 'nvme-6.2-2023-01-12' of git://git.infradead.org/nvme into block-6.2 (2023-01-12 10:36:35 -0700)

----------------------------------------------------------------
block-6.2-2023-01-13

----------------------------------------------------------------
Christoph Hellwig (3):
      nvme: remove __nvme_ioctl
      nvme: replace the "bool vec" arguments with flags in the ioctl path
      nvme: don't allow unprivileged passthrough on partitions

Hector Martin (2):
      nvme-apple: add NVME_QUIRK_IDENTIFY_CNS quirk to fix regression
      nvme-pci: add NVME_QUIRK_IDENTIFY_CNS quirk to Apple T2 controllers

Jens Axboe (1):
      Merge tag 'nvme-6.2-2023-01-12' of git://git.infradead.org/nvme into block-6.2

Russell King (Oracle) (1):
      MAINTAINERS: stop nvme matching for nvmem files

Tejun Heo (1):
      block: Drop spurious might_sleep() from blk_put_queue()

Tong Zhang (1):
      nvme-pci: fix error handling in nvme_pci_enable()

 MAINTAINERS               |   3 +-
 block/blk-core.c          |   3 --
 drivers/nvme/host/apple.c |   2 +-
 drivers/nvme/host/ioctl.c | 110 ++++++++++++++++++++++++++--------------------
 drivers/nvme/host/pci.c   |  12 +++--
 5 files changed, 75 insertions(+), 55 deletions(-)

-- 
Jens Axboe

