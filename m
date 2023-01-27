Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC66C38142
	for <linux-block@archiver.kernel.org>; Fri, 27 Jan 2023 20:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjA0UEF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Jan 2023 15:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjA0UDp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2023 15:03:45 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D7B79F2F
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 12:01:36 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 78so3902699pgb.8
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 12:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rkxx6c0uvRNJ4MQmkhpMOnJkk4U2Gsf5JcyyGMBSkk=;
        b=rE1swZrMh5M4cTTyWO6Ml2LHps7XyH6aHMGszulSbonsUhg0sV0NC4h9XjIUzjJJlI
         MLbzR++odETtOY1+TMv3rIXCiUuCTU0PfgUXmHTUDegTjdxwnwhhQ/wgK9VpMyqJ3Zoi
         fZLCazlD2Tvrfx2fa/P+nNwaxWNO7LPFJPgCoCSvyh67orAZcfL0S/SRgTjEJWyu4LkI
         G2/8+sVmUfSMzM3GsOXtlvvEzfJGqzicU4hbmagt7fdzOl1sRg7UTO9JsLRoLL75iwv3
         FQXvmw6xermMwBnMzHH8btPyKlUmVMfytvv6YaRy2yD/e6X4f/HgkDRFUVZvc658lfJv
         L0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5rkxx6c0uvRNJ4MQmkhpMOnJkk4U2Gsf5JcyyGMBSkk=;
        b=VZmpTp49DNzMjRlgHteyEgyUuC9b1+Ml6bycEmUX55OuNRyJfFahbgt7Djd/cC4Y4I
         +FbV7K8nv8dcOogrx21rR5xhJTGuQnjvtoBjR0OadGwx8UL5eMmcGMN/2VmT2pCAlcWF
         VdIirhwPYVBeMciVdcGnfd9nKNHXW+rfgWZbmwLDqrCpMD2vZu9bAt18xrtCFXgCbL9+
         sm4VRW6Dg2uvqTf1oKZnOo0F+aSih0pViggsdgU4CFqhsHYUG7yZ/dsKX4eiBAKmvlcv
         lJjWIc0Od1BMDP9xv7V0F7cXoCmcBefjaDvZGxGPR+ellWJCuowGb2oxGU2+jJVPVnnb
         gVRw==
X-Gm-Message-State: AO0yUKUpEnk0F92ivtHU0f89dURUOCgcub/XTujW+UUl2Pk+U7cH3RTc
        ZR5R+C0W+ktNdBhF8aGGsilAsM3Pl06xPDBz
X-Google-Smtp-Source: AK7set9khu1TGKqp1UZIS0UfbGkJDEjBcPNRyNWWuegLqelwm20j2mEiKea/xwEEMywptkA3+qkw5w==
X-Received: by 2002:aa7:8a58:0:b0:592:6203:d920 with SMTP id n24-20020aa78a58000000b005926203d920mr737925pfa.0.1674849695536;
        Fri, 27 Jan 2023 12:01:35 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t13-20020a056a00138d00b0058d9730ede0sm2980583pfg.210.2023.01.27.12.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 12:01:34 -0800 (PST)
Message-ID: <7f1de3c6-eab1-4e3c-a5df-e81fde4c5336@kernel.dk>
Date:   Fri, 27 Jan 2023 13:01:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.2-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Minor tweaks for this release:

- NVMe pull request via Christoph
	- Flush initial scan_work for async probe (Keith Busch)
	- Fix passthrough csi check (Keith Busch)
	- Fix nvme-fc initialization order (Ross Lagerwall)

- Fix for tearing down non-started device in ublk (Ming)

Please pull!


The following changes since commit 955bc12299b17aa60325e1748336e1fd1e664ed0:

  Merge tag 'nvme-6.2-2023-01-20' of git://git.infradead.org/nvme into block-6.2 (2023-01-20 08:08:29 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.2-2023-01-27

for you to fetch changes up to db3ba974c2bc895ba39689a364cb7a49c0fe779f:

  Merge tag 'nvme-6.2-2023-01-26' of git://git.infradead.org/nvme into block-6.2 (2023-01-26 11:43:33 -0700)

----------------------------------------------------------------
block-6.2-2023-01-27

----------------------------------------------------------------
Jens Axboe (1):
      Merge tag 'nvme-6.2-2023-01-26' of git://git.infradead.org/nvme into block-6.2

Keith Busch (2):
      nvme-pci: flush initial scan_work for async probe
      nvme: fix passthrough csi check

Ming Lei (1):
      block: ublk: move ublk_chr_class destroying after devices are removed

Ross Lagerwall (1):
      nvme-fc: fix initialization order

 drivers/block/ublk_drv.c |  7 +++----
 drivers/nvme/host/core.c |  2 +-
 drivers/nvme/host/fc.c   | 18 ++++++++----------
 drivers/nvme/host/pci.c  |  1 +
 4 files changed, 13 insertions(+), 15 deletions(-)

-- 
Jens Axboe

