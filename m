Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8669DC46CA1
	for <linux-block@archiver.kernel.org>; Fri, 15 Sep 2023 20:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbjIOUpH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbjIOUox (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2023 16:44:53 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9A5E58
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 13:44:03 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-79a10807b4fso1082301241.2
        for <linux-block@vger.kernel.org>; Fri, 15 Sep 2023 13:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694810642; x=1695415442;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RaheZZ3aWH4dfOldn9ZCeIYAt4mkA7cmMxZmrmD0nnI=;
        b=pWVi0+xXnAmT6WzDGVbaOXR5SRVOgYRxikoQiexVOL26hAScxu9T4dYj5b89yco2Fb
         unVk9+YF0eHPbPYvBCoMZtye2/bUdpDTvkMTaKilb3jt6Vu5x7J5ywX/S0YGACIgD9vL
         ZoUMBy46rKg9AyUbD6MVzqVy5w9Czr/XoLs7vEjOIoP07sVzsBomb8bs2ANwSyULAfko
         s0AOf2ROZMw/LQg7ZHqkpgZdWQhcxForD4Bbw9kv5Njal1PzqKCdL6TNSyPVXQiXIClF
         tAExdCm7Zm05ktZd+FrMuQFIfyQcOINAYhjDOHareZXnbn3p7UKRPvY7mOcxhg/8AG0E
         SHfw==
X-Gm-Message-State: AOJu0YzXYBZV0MjCJkqn76juojZGY+pqXmMpDcjb7nhWuXrHcm2GjDPt
        CqEgoSyrEoscXLPrYFPLjZrq
X-Google-Smtp-Source: AGHT+IHh+CGQ1LQ9+nYV2h3rP3/WaZ66pFpMDO8YYt+Q4kieKGfGbDhPXKVAhMW8KfLvX71gD/W7IQ==
X-Received: by 2002:a67:f7da:0:b0:44d:5c61:e473 with SMTP id a26-20020a67f7da000000b0044d5c61e473mr2854709vsp.22.1694810642718;
        Fri, 15 Sep 2023 13:44:02 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id h15-20020a0cf44f000000b0064f5d70d072sm1525969qvm.37.2023.09.15.13.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:44:02 -0700 (PDT)
Date:   Fri, 15 Sep 2023 16:44:00 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [git pull] device mapper fixes for 6.6-rc2
Message-ID: <ZQTCEOrIV+JmvfIE@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.6/dm-fixes

for you to fetch changes up to a9ce385344f916cd1c36a33905e564f5581beae9:

  dm: don't attempt to queue IO under RCU protection (2023-09-15 15:39:59 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM core retrieve_deps() UAF race due to missing locking of a DM
  table's list of devices that is managed using dm_{get,put}_device.

- Revert DM core's half-baked RCU optimization if IO submitter has set
  REQ_NOWAIT. Can be revisited, and properly justified, after
  comprehensively auditing all of DM to also pass GFP_NOWAIT for any
  allocations if REQ_NOWAIT used.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmUEt7wACgkQxSPxCi2d
A1prNwf/RB4EyKiSx7XS3ysM6mh/BPGO5FNjWwHebkrSFzAkEowo4i0cY9lRD0N4
x9Wbd5bcV8HarH/fiyffQxgdfXspAIrMt8z5hRnfElkBLzg6hHixxg/3sFCwg+U3
LG6AZFNLil7VmDeca9Pd8MCyXoy1u4ErWjkz3fU8pzzT+NDwRZPZhUMd/MFCWag6
q22S8KMXkYKiAHqKauF52CeDH77XsO66G70t/AElemZ66PpyKpasg2p99RCuHgTg
7jNuMTM6qXYWSWw8OswVXCPZEVfCp4zTFv1ebu9bagfDKR4ppNxwzyz7/CMkir14
4uKKzQ/cy8QND6OR/05zKh4U3ctqyA==
=rVpu
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Jens Axboe (1):
      dm: don't attempt to queue IO under RCU protection

Mikulas Patocka (1):
      dm: fix a race condition in retrieve_deps

 drivers/md/dm-core.h  |  1 +
 drivers/md/dm-ioctl.c |  7 ++++++-
 drivers/md/dm-table.c | 32 ++++++++++++++++++++++++--------
 drivers/md/dm.c       | 23 ++---------------------
 4 files changed, 33 insertions(+), 30 deletions(-)
