Return-Path: <SRS0=Afl4=BZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9986C433DF
	for <linux-block@archiver.kernel.org>; Sat, 15 Aug 2020 23:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C667D2068E
	for <linux-block@archiver.kernel.org>; Sat, 15 Aug 2020 23:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NjxXGo+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgHOXbP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Aug 2020 19:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgHOXbN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Aug 2020 19:31:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4D7C061786
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2020 16:31:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t11so5740764plr.5
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2020 16:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=MuXdqbuT0/oHj9rROzOQW88XnOHaz9N7lrCK4rwe864=;
        b=NjxXGo+iXgkT6q9mybLjY3NGxeRkS9R2O4+nbFCiFOGwWUo8WzCur26CTx1CAT0faS
         xv8yIoDR75V7jL3OHb72LCFA6yOpHrWpc47UhfqNh8tycEK+cXw3U9gXh8XklWinqgy0
         ujQYpAEuIbzi3jvtMW4AIAeOtpzH3JhnohoCXfCEwrI2jBKg7l2vKqNwHYmLs6FLFPAC
         A3WCWqdnBCTG04Z6Fv3M/0029eMFTVUg371D6EwolKRhsRZTZGpv7oIEr2O309k+HTpU
         fb9n7EGdy+lop/wzw0ojrPur0qJkIeSAYTLQUSC2RkwbIOcAQNJq+6jbTe7n1mez72bJ
         DSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=MuXdqbuT0/oHj9rROzOQW88XnOHaz9N7lrCK4rwe864=;
        b=uaH8rnd0Td8I4OV6BgQeM0sO0FukGmGxgdC9nviJgLymjroLijp1DFibEoOG6wA6ex
         nKFJRh425Ag+1GwTTfeuWB7sVMA0zsPRwXLiKW1u8F4H0R10PCZ6fFstU8iGYZr7ILK1
         J1+/Qv01lO3A8GOp+saGWBZeFJOqG+HayciVz75xlmmh6xEZOQcg/8ThljO6ZQFsTJOY
         7ZsPpGeFpgx+1aKhMBlDB9Kjx7bAHyik0XK0ru76g3PrvGeF2xEpZ9kGnuVNBVEwns6K
         10PK+tQ6MlBFItyObeOV9ZzE4wZVYljamQgjVe1HUbtpkAZvXl+/y+lbEVbJeONi4E5i
         L3EA==
X-Gm-Message-State: AOAM532TOh9V2w9hIczbEQqbAVPdnTaTVNElUkudZ+gUwqmbbwbOwFrI
        mOJke/FvsKVTeRw3l6nyPwmIPVVG8Y0bDw==
X-Google-Smtp-Source: ABdhPJwtPkohLiHisPK6gGtbaOQHR9onYKv0JTBElldv7rGbtxGZUvR3YtqaBvKR68+qVBjOFREpPQ==
X-Received: by 2002:a17:902:6f01:: with SMTP id w1mr6519938plk.49.1597534270490;
        Sat, 15 Aug 2020 16:31:10 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:6299:2df1:e468:6351? ([2605:e000:100e:8c61:6299:2df1:e468:6351])
        by smtp.gmail.com with ESMTPSA id u21sm11946051pjn.27.2020.08.15.16.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2020 16:31:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Final block fixes for 5.9-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <fcaf3dc8-5065-30ff-f831-17db615c162d@kernel.dk>
Date:   Sat, 15 Aug 2020 16:31:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes on the block side of things:

- Discard granularity fix (Coly)

- rnbd cleanups (Guoqing)

- md error handling fix (Dan)

- md sysfs fix (Junxiao)

- Fix flush request accounting, which caused an IO slowdown for some
  configurations (Ming)

- Properly propagate loop flag for partition scanning (Lennart)

Please pull!


The following changes since commit fffe3ae0ee84e25d2befe2ae59bc32aa2b6bc77b:

  Merge tag 'for-linus-hmm' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2020-08-05 13:28:50 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.9-2020-08-14

for you to fetch changes up to c1e2b8422bf946c80e832cee22b3399634f87a2c:

  block: fix double account of flush request's driver tag (2020-08-11 13:53:32 -0600)

----------------------------------------------------------------
block-5.9-2020-08-14

----------------------------------------------------------------
Coly Li (1):
      block: check queue's limits.discard_granularity in __blkdev_issue_discard()

Dan Carpenter (1):
      md-cluster: Fix potential error pointer dereference in resize_bitmaps()

Guoqing Jiang (2):
      rnbd: remove rnbd_dev_submit_io
      rnbd: no need to set bi_end_io in rnbd_bio_map_kern

Jens Axboe (1):
      Merge branch 'md-next' of https://git.kernel.org/.../song/md into block-5.9

Junxiao Bi (1):
      md: get sysfs entry after redundancy attr group create

Lennart Poettering (1):
      loop: unset GENHD_FL_NO_PART_SCAN on LOOP_CONFIGURE

Ming Lei (1):
      block: fix double account of flush request's driver tag

 block/blk-flush.c                 | 11 +++++++++--
 block/blk-lib.c                   |  9 +++++++++
 drivers/block/loop.c              |  2 ++
 drivers/block/rnbd/rnbd-srv-dev.c | 37 +++----------------------------------
 drivers/block/rnbd/rnbd-srv-dev.h | 19 +++++--------------
 drivers/block/rnbd/rnbd-srv.c     | 32 +++++++++++++++++++++++---------
 drivers/md/md-cluster.c           |  1 +
 drivers/md/md.c                   | 17 ++++++++++-------
 8 files changed, 62 insertions(+), 66 deletions(-)

-- 
Jens Axboe

