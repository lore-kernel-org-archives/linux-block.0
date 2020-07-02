Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17138C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E689920771
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="jdUUOzes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgGBJZS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgGBJZR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 05:25:17 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E575C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 02:25:17 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so22862273edq.8
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 02:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dh0cAN0tCAhAhB/CRVYwfSOkE6VN85xMjc2R7od/DSU=;
        b=jdUUOzes/8whsQdIjZxLbY4pNmZtGSNLcWl6sQbTXJvHixYZjuuWnsVs1nnXRPTpRJ
         +HZxIvyfmGTF3G2tT7ULo2iN3AM/jKg4kYU4xx3dtJfgfekTYh/t+FqYCwNbaW5/maC1
         wzEyBD+g/2R/DiA5Yb8qwQ/mpMHxTCeaXcz6nGB8LGG2hfHYbfPIudueKdJBcmHk3t7y
         jfH3V+eFH4bLdUF+CXgZ4mvhJ7HW5qxYI9CoCkU2OQGLyTEN9Eh2JQioB3vFDr14REsI
         Gp3BMM3bydRPQm2S0XxUWxpB3slNy4Xp63xif7a7wE930dOruAQnuei1WZIUhFB+Bxjo
         KX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dh0cAN0tCAhAhB/CRVYwfSOkE6VN85xMjc2R7od/DSU=;
        b=D+7OflC7SXhT+j32higjAnQ70hhb8sLuFwhCZ0wfEk1yV+bfUEYEGmmY7jyTeFHnTe
         ZNdTeswqkGmmxVSKdsSY7JlYHdP6NoyqPbES7qA7xzW1DIG7DbgoErMU97X6sOe2E9NZ
         Us1e/8FLzfk3x/LQkwl90lrGyKsmpKF1i/g6bXvQlcKUmiz2XcDA63G7+nYTuCxy3NaW
         Rl/VyqIvuv/Nh/3CXR6PRwiOXabyd3mjbW16r/ZX6bVlLdIHIy3q0XmW3ufnRY6bqOGf
         MYMoXW1e8q4t49g3eDnGJhhH8nP3Xjr8KIna4Pi/Qjb/b832LRA7fOHlPwmGHQs8THOI
         VoqA==
X-Gm-Message-State: AOAM531dpGsdTyeDszxH4+QJWHRs5g60TZ1TslQH/U4KDKTXVv/niVkD
        1WFmv8om5bTNLErinq5hQrhlpg==
X-Google-Smtp-Source: ABdhPJwbUgBlqWZ8Bv+GRN6+E17pyzzFdFFYXKVD+gNN8hPiigqPcpUUHUAmw4q0d7PyejHCnJ6XKw==
X-Received: by 2002:a05:6402:1687:: with SMTP id a7mr33297542edv.358.1593681915998;
        Thu, 02 Jul 2020 02:25:15 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id b18sm6569464ejl.52.2020.07.02.02.25.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 02:25:15 -0700 (PDT)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, Damien.LeMoal@wdc.com,
        mb@lightnvm.io, Johannes.Thumshirn@wdc.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH v3 0/4]  ZNS: Extra features for current patches
Date:   Thu,  2 Jul 2020 11:24:34 +0200
Message-Id: <20200702092438.63717-1-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

This patchset extends zoned device functionality on top of the existing
ZNS patchset that Keith sent.

Changes since V2
  - Remove debug code added by mistake
  - Address return value and constant naming by Damien
  - Leave rest of the comments for a V4, after discussion in the mailing
    list

Changes since V1
  - Remove new IOCTLs for zone management and zone values. I believe we
    will need the zone management IOCTL to support new ZNS features in
    the near future, but we will wait until we upstream these too. In
    the meantime, feedback on the IOCTL is welcome. We drop the zone
    values IOCTL completely - Niklas send a patch to expose mar / mor
    through sysfs already - we will extend on this if needed.

  - Reimplement zone offline transition to be a IOCTL in itself, as the
    rest of the existing zone transitions. In the process, implement a
    way for drivers to report zone feature support in the newly added
    feature flags. Refactor support for capacity to adopt this model.
    Here, note that we have maintained behaviour for the scsi driver,
    even though zone_size == zone_capacity

  - Reimplement the zone count consistency check to do a correct zone
    calculation. Move this logic to the initialization logic, instead of
    doing it each time we report zones.

Thanks,
Javier

--- V1 cover letter ---

Patches 1-5 are zoned block interface and IOCTL additions to expose ZNS
values to user-space. One major change is the addition of a new zone
management IOCTL that allows to extend zone management commands with
flags. I recall a conversation in the mailing list from early this year
where a similar approach was proposed by Matias, but never made it
upstream. We extended the IOCTL here to align with the comments in that
thread. Here, we are happy to get sign-offs by anyone that contributed
to the thread - just comment here or on the patch.

Patch 6 is nvme-only and adds an extra check to the ZNS report code to
ensure consistency on the zone count.

The patches apply on top of Jens' block-5.8 + Keith's V3 ZNS patches.

Thanks,
Javier



Javier González (4):
  block: Add zone flags to queue zone prop.
  block: add support for zone offline transition
  nvme: Add consistency check for zone count
  block: add attributes to zone report

 block/blk-core.c               |  2 ++
 block/blk-zoned.c              | 11 +++++++--
 drivers/block/null_blk_zoned.c |  2 ++
 drivers/nvme/host/core.c       |  5 ++++-
 drivers/nvme/host/nvme.h       |  6 +++--
 drivers/nvme/host/zns.c        | 41 +++++++++++++++++++++++++++++++++-
 drivers/scsi/sd.c              |  2 ++
 drivers/scsi/sd_zbc.c          |  8 +++++--
 include/linux/blk_types.h      |  3 +++
 include/linux/blkdev.h         |  4 +++-
 include/uapi/linux/blkzoned.h  | 32 +++++++++++++++++++++++++-
 11 files changed, 106 insertions(+), 10 deletions(-)

-- 
2.17.1

