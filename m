Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F02C43334
	for <linux-block@archiver.kernel.org>; Fri,  1 Jul 2022 15:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiGAPd6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Jul 2022 11:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiGAPd5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2022 11:33:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5BF2AE1E
        for <linux-block@vger.kernel.org>; Fri,  1 Jul 2022 08:33:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o18so2713480plg.2
        for <linux-block@vger.kernel.org>; Fri, 01 Jul 2022 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=TAiud9bth+Vn/Ix+sQ7rYUwBod+ZK28GgOiWCnP3Ggc=;
        b=jFp+jlneo7KoC73KNF7Shl8fc+lyVCvyx/FRahAN0eRiTnpm2YnmB0r4C0NXddOV7l
         No15ENo9G6Wamkx2ZTISJ4cdWAA8bC0vw9BZWc8EF0s8Lfsv3KGEzEcYBb3vpTK6OYL2
         gXMhbNqA+eQi/TqrcTx451dq1dxoY0J0wv6xdQ8SUlUy48H5n9yngJ+AkuvXXuI6ZXJo
         UvJ2G4df9I6Ro+BeAe0dAtWYXDpY6w3Ew7jBw5XBdZadOWzs9aB/5FqjeE2s9J1ec3wh
         liIX4YuyIZdIF/BtjLHtGNoDBx0qqkwaJIeS+OHBGrKhRAijCPxO0+KvZ97qMvSBVXVf
         gQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=TAiud9bth+Vn/Ix+sQ7rYUwBod+ZK28GgOiWCnP3Ggc=;
        b=XBMkDtSFO/+BnCLkS+bX7tM4lS4FLleEbb2N6fRMcRpor/1GlavksyK31vD/2XpzUy
         bglpFtICCvo0PRzWiQJj5eX+czr7Wq48SU9zXmX9zvgUI6osFUufiTjuPkl62GdUDFLk
         ZX1uJVo3ATi5FR+Q0HdjhQgJdmesEe17cPxX4h9OfrQb7uzbTfAJWzyZIZzMVoaIP1+G
         zWcFMOnf6UfunlehMGV/FC8Jltp+iDCdGWVtxNqI2p9LTkOiBWONVOHw3p8E6EpEFn+A
         vups6606vOZ8Hp7QD2VN+VB4j0ar6vkEQ/2+LJRMVzk4qzU54auiu2DiVedf+dmsDjlq
         pnRA==
X-Gm-Message-State: AJIora8E1S+Yib29dLNDvSSnNzx5oHBBLux276T3bJ6a1UNb/O/JOYVR
        LH0XAYk2wrAJRFJpEsyrVpQKMDyaxO2swA==
X-Google-Smtp-Source: AGRyM1tQXaQC5TIMR5FDx3K4lIsKnnei8ofucq88bSsihlTuh6Qapt4rrmjH4PGWdfq8iNB+h35/7w==
X-Received: by 2002:a17:902:f543:b0:16a:54c6:78c0 with SMTP id h3-20020a170902f54300b0016a54c678c0mr20830399plf.22.1656689634563;
        Fri, 01 Jul 2022 08:33:54 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i11-20020a1709026acb00b001640aad2f71sm15675952plt.180.2022.07.01.08.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 08:33:54 -0700 (PDT)
Message-ID: <12cce414-ca5b-3787-5cc3-956ab75d7155@kernel.dk>
Date:   Fri, 1 Jul 2022 09:33:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.19-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

- Fix for batch getting of tags in sbitmap (wuchi)

- NVMe pull request via Christoph
	- More quirks (Lamarque Vieira Souza, Pablo Greco)
	- Fix a fabrics disconnect regression (Ruozhu Li)
	- Fix a nvmet-tcp data_digest calculation regression
	  (Sagi Grimberg)
	- Fix nvme-tcp send failure handling (Sagi Grimberg)
	- Fix a regression with nvmet-loop and passthrough controllers
	  (Alan Adamson)

Please pull!


The following changes since commit e531485a0a0e0a06644de1b639502471415d5e12:

  Merge tag 'nvme-5.19-2022-06-23' of git://git.infradead.org/nvme into block-5.19 (2022-06-23 07:55:07 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.19-2022-07-01

for you to fetch changes up to f3163d8567adbfebe574fb22c647ce5b829c5971:

  Merge tag 'nvme-5.19-2022-06-30' of git://git.infradead.org/nvme into block-5.19 (2022-06-30 14:00:11 -0600)

----------------------------------------------------------------
block-5.19-2022-07-01

----------------------------------------------------------------
Alan Adamson (1):
      nvmet: add a clear_ids attribute for passthru targets

Jens Axboe (1):
      Merge tag 'nvme-5.19-2022-06-30' of git://git.infradead.org/nvme into block-5.19

Lamarque Vieira Souza (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA IM2P33F8ABR1

Pablo Greco (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG SX6000LNP (AKA SPECTRIX S40G)

Ruozhu Li (1):
      nvme: fix regression when disconnect a recovering ctrl

Sagi Grimberg (2):
      nvmet-tcp: fix regression in data_digest calculation
      nvme-tcp: always fail a request when sending it failed

wuchi (1):
      lib/sbitmap: Fix invalid loop in __sbitmap_queue_get_batch()

 drivers/nvme/host/core.c       |  2 ++
 drivers/nvme/host/nvme.h       |  1 +
 drivers/nvme/host/pci.c        |  5 +++-
 drivers/nvme/host/rdma.c       | 12 ++++++---
 drivers/nvme/host/tcp.c        | 13 ++++++----
 drivers/nvme/target/configfs.c | 20 +++++++++++++++
 drivers/nvme/target/core.c     |  6 +++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 55 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/tcp.c      | 23 +++---------------
 lib/sbitmap.c                  |  5 +++-
 11 files changed, 113 insertions(+), 30 deletions(-)

-- 
Jens Axboe

