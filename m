Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725FAC6FD20
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 17:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjCXRWd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 13:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCXRWc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 13:22:32 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1F215891
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:21:44 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id jl13so2021442qvb.10
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678504;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kwnm6koRyZsuVSW+Az3H6XqTn7kU9JKm0T+d6j/RM48=;
        b=mceUMb1C6scC6lSdr9e4CMbyAGxG45MQXlf+jLdRZCjOnnF4INs9iK9uKg9S4YU4b1
         XKtwr+GmSyg82tZYYgg4asOO4bTxw9DOtVDjw/FAPZxYQFZMmWuxXy2ENiUoDFuyDq0v
         FMBYTSepRSyNbIQRaQHLDll4YDtjIw8Kewt4MAgM+K43Y4WRR4fiD8FDqUt2VTVCouZ3
         Jnp0bhQnuzOpFAH3Fkox22lus6vGcga/lod9mRRU2Na+vwPEN9yexJmIllSu1x6ONIV8
         OgrJzlQ9dYl4/uFpMkOMX4dVkbMTlogm1q5BRKkuayIsD0HhB1RzXSO6gyy1F+i/ea9A
         eUQg==
X-Gm-Message-State: AAQBX9dA+QcJUVLob8aRkq7tVJKpl6KE2X5EFntzpQRKHig8HKz3CGvH
        N2y9mluwUXMKVK/3udN37YYO
X-Google-Smtp-Source: AKy350ZPBR6gKJIpdo1yhww1E6SmBvJu6FU7dEkIGsTFs9iPPnfWzl1le1BYrU4Non3FKStr6ndGwA==
X-Received: by 2002:a05:6214:2622:b0:5a9:129:c704 with SMTP id gv2-20020a056214262200b005a90129c704mr6090931qvb.9.1679678503837;
        Fri, 24 Mar 2023 10:21:43 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id g11-20020ad457ab000000b005dd8b9345c2sm833945qvx.90.2023.03.24.10.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:21:43 -0700 (PDT)
Date:   Fri, 24 Mar 2023 13:21:42 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Coly Li <colyli@suse.de>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [git pull] device mapper fixes for 6.3-rc4
Message-ID: <ZB3cJuV78aKnnWrO@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit d695e44157c8da8d298295d1905428fb2495bc8b:

  dm: remove unnecessary (void*) conversion in event_callback() (2023-02-20 11:52:49 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.3/dm-fixes

for you to fetch changes up to d3aa3e060c4a80827eb801fc448debc9daa7c46b:

  dm stats: check for and propagate alloc_percpu failure (2023-03-16 13:37:06 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM thin to work as a swap device by using 'limit_swap_bios' DM
  target flag (initially added to allow swap to dm-crypt) to throttle
  the amount of outstanding swap bios.

- Fix DM crypt soft lockup warnings by calling cond_resched() from the
  cpu intensive loop in dmcrypt_write().

- Fix DM crypt to not access an uninitialized tasklet. This fix allows
  for consistent handling of IO completion, by _not_ needlessly punting
  to a workqueue when tasklets are not needed.

- Fix DM core's alloc_dev() initialization for DM stats to check for
  and propagate alloc_percpu() failure.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmQd2p0ACgkQxSPxCi2d
A1qvXAf/WCMNXRbFhO35QqukBqS7sUOMfWl1hIEdABRu+3Ul1KHBWzXVYWuWgebw
kr79V3LZG63cLvhreCy64X/0tXLZa0c0AGWZI6rJ/QAozSCs9R8BqOrJnB5GT1o9
/lvmOL31MloMnIKArWseIQViNM97gEHmFpuj0saqitcvNTjjipzxq/wOyhmDQwnE
8rxJpKSHBJXs9X/VyM9FTWxtijTQw3c8wxJJo7eV6TTuLyrErm46tyI1cBQ4vDoa
ogMVWVrf51uTsqL6DqGenDc+kO7CH5lipIJij1bTtKgs3aBNlaiZQC1nPkMST9Ue
hpH61ixAg+bsWi4/xLFafCl6QAGMlA==
=71ya
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Coly Li (1):
      dm thin: fix deadlock when swapping to thin device

Jiasheng Jiang (1):
      dm stats: check for and propagate alloc_percpu failure

Mike Snitzer (1):
      dm crypt: avoid accessing uninitialized tasklet

Mikulas Patocka (1):
      dm crypt: add cond_resched() to dmcrypt_write()

 drivers/md/dm-crypt.c | 16 ++++++++++------
 drivers/md/dm-stats.c |  7 ++++++-
 drivers/md/dm-stats.h |  2 +-
 drivers/md/dm-thin.c  |  2 ++
 drivers/md/dm.c       |  4 +++-
 5 files changed, 22 insertions(+), 9 deletions(-)
