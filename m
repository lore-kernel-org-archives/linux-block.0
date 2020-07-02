Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A442C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E572089D
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="FN7XbHQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgGBGzF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgGBGzE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 02:55:04 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443A8C08C5C1
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 23:55:04 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d18so16803825edv.6
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tKRN22hKzeStPgjui2Aao8XmNMEwN3gIdlFGNF8bcf4=;
        b=FN7XbHQo4xyfGORiZbDAiwfaCw/As7tXLMA465wGW51kVtnODvtYjipR9wQxgboJzd
         wXCkztxzx6y8/gowuiSm3AHBtzPsTfoz9n9otceNQ4lDVLPxb2UnF0qp84KptNLIMqj7
         xSGvguJVkAGewqgACIN9/FrDqSMT2sEWTtcjj5i0Sono1FMDkxLN/FaH5F895nqwn3D6
         uC4M6E9gsy2bMJzKETUN0oTuQnjpalqmRzxzHSiwaXizvXNBrU+SPBbX/MtbtpYiLNIZ
         3vhtXADC7XWqNhs3hLpjrLx1CZNxvyiodKcaT1D1ZbPSvqksdldWTaTitN4a4cuM6Dlf
         sPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tKRN22hKzeStPgjui2Aao8XmNMEwN3gIdlFGNF8bcf4=;
        b=Zmy2wiii1RK+HgP0Fx8uhvGaWqZ0C0ZUJQCu2NtgOk28M6YVo3KYOrPQzz58gUrIoJ
         tznu0OiQHTzXsBSUBPupUzr2hBZB/toD0WPbfwL1baL5Zn+YEwIiB2Xqn8l3evueqQWk
         JmLJ2teqzywDFVDRtTC362jk09ncpOyF8KSwJnsWWIL4dJUTQEpwPReP3Kvc84DGtmTX
         1ad6mcciwohbq3/miO1IlG0+rU0cN/j0CBpiwoZ90TpYE+vna4s182FhyjkZKNeo9kSk
         tWvk6NW0F4InJgMQkLFsu1vOfVFy2JvZjwGR0qg6vOT/2tHf2En4912Iel/PPJAGF77n
         arWg==
X-Gm-Message-State: AOAM531DCryqmnBG2myt/qWhMMivhCZKYkON+NUZHYF6heDkErmLSFK2
        qwywcIsVugVeBkmwmRXpHyHMIEdjdHOM25up
X-Google-Smtp-Source: ABdhPJyNaV0mZrV9WTfrMB2Fykl35XKkFhaci5zrL8Xo4QS2a1xUy6GDh/BvSNhowznWRuVYIhoAEA==
X-Received: by 2002:a05:6402:202e:: with SMTP id ay14mr33026426edb.233.1593672902962;
        Wed, 01 Jul 2020 23:55:02 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id cz2sm7912769edb.82.2020.07.01.23.55.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 23:55:02 -0700 (PDT)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, Damien.LeMoal@wdc.com,
        mb@lightnvm.io,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [V2 PATCH 0/4] ZNS: Extra features for current patche
Date:   Thu,  2 Jul 2020 08:54:34 +0200
Message-Id: <20200702065438.46350-1-javier@javigon.com>
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
 include/uapi/linux/blkzoned.h  | 29 +++++++++++++++++++++++-
 11 files changed, 103 insertions(+), 10 deletions(-)

-- 
2.17.1

