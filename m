Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7A1EB64DD
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 20:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjG0Um2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 16:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjG0Um2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 16:42:28 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6806930D6
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 13:41:41 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-76ad842d12fso118690685a.3
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 13:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690490500; x=1691095300;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=imzr9gf0e2pNdaKE7K17eEPetoldcbtASO5vqhQPuOs=;
        b=bArHeoGRQ9aM68UzN/IWhCCm8vm/YqCc1SFQJcdsLrQeCXc1AiMoy8wNrfEoAEd/4W
         51USIncHHhZUpQ5EOguJ1X5skWryDEyJLk9LUwMbkwGivoB54yuvVCBGRl3R5Kcq70kv
         Zzrjmw/m+Fpx01Z2ZgdIbvHZIQs0+1yukFEsh11SgAgSdaWLJiYc17a2vlvD8xTXlwxl
         ZR1k55bXjgtXze7g2Stjd0rMHTi/oTBihgFVHxaQ6MyHqzJsY/cVlbEoVFRLcEzFcm+G
         VZtcp3R9Yhv3+hCkNIZkFEuUd+4OPNbtUkwJmtUUeWk0qnzGu9eCn+uVLAv5Wrrq3s9b
         CWgw==
X-Gm-Message-State: ABy/qLZd9TpgOWgKaUNaLZMnouJwHID6DYoi/v8x7gVVHSAI7+stpL5Z
        Elpn4HhOE9qkTo9Fu1JUMyTL
X-Google-Smtp-Source: APBJJlEdn+lfgl6m0z4xO9GaLOCk+43ZMDakR8zQH9o7S3KDV1QulUPjcSb2rs+mdlhI4WHm+HVceA==
X-Received: by 2002:a05:620a:46a5:b0:769:542:b3fd with SMTP id bq37-20020a05620a46a500b007690542b3fdmr705916qkb.8.1690490500539;
        Thu, 27 Jul 2023 13:41:40 -0700 (PDT)
Received: from localhost ([185.202.220.182])
        by smtp.gmail.com with ESMTPSA id ow34-20020a05620a822200b00767c61ee342sm656143qkn.48.2023.07.27.13.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:41:39 -0700 (PDT)
Date:   Thu, 27 Jul 2023 16:41:38 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Joe Thornber <ejt@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Yu Kuai <yukuai3@huawei.com>
Subject: [git pull] device mapper fixes for 6.5-rc4
Message-ID: <ZMLWgk816vYI3j11@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.5/dm-fixes

for you to fetch changes up to 1e4ab7b4c881cf26c1c72b3f56519e03475486fb:

  dm cache policy smq: ensure IO doesn't prevent cleaner policy progress (2023-07-25 11:55:50 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix double free on memory allocation failure in DM integrity
  target's integrity_recalc()

- Fix locking in DM raid target's raid_ctr() and around call to
  md_stop()

- Fix DM cache target's cleaner policy to always allow work to be
  queued for writeback; even if cache isn't idle.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmTC1UoACgkQxSPxCi2d
A1pIGAgAhQjlNQ83DexvmMUoNDRGFxOBiOcL9DnVtiXsLd/wTXZTEDIDXJaH9hCq
MAj7aqadBeHlWT+vNMOYH9ePPtySEKGs8VM/4/fwNtT6wMyqxZZk4JyN7z+YBVJV
d/9lryVZYRWK7ICgRenR/VSxv8/JgVTBGZZqyl20SXhtlYxndxGcLeV0X8fP3G1Q
pxdsNuE7TBclB8qrXiPIOlIK0HcSikz6CfQIar3zgip6fO+Wwb92CZ1DOGGi1RJz
bsTmZXn08l3d1tMJ+y4umZm+Izq8gvWSgDBywRdWq/D6Ao1ScVqY4TExFSSkjDk0
PUY49vMF/FsKfNt5/VK0/i2U7QAKDQ==
=92HI
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Joe Thornber (1):
      dm cache policy smq: ensure IO doesn't prevent cleaner policy progress

Mikulas Patocka (1):
      dm integrity: fix double free on memory allocation failure

Yu Kuai (3):
      dm raid: fix missing reconfig_mutex unlock in raid_ctr() error paths
      dm raid: clean up four equivalent goto tags in raid_ctr()
      dm raid: protect md_stop() with 'reconfig_mutex'

 drivers/md/dm-cache-policy-smq.c | 28 ++++++++++++++++++----------
 drivers/md/dm-integrity.c        |  1 +
 drivers/md/dm-raid.c             | 20 +++++++++-----------
 drivers/md/md.c                  |  2 ++
 4 files changed, 30 insertions(+), 21 deletions(-)
