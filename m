Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB88C433FE
	for <linux-block@archiver.kernel.org>; Tue, 11 Oct 2022 01:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiJKBX1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiJKBXI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 21:23:08 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC2D83054
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 18:22:46 -0700 (PDT)
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id E1F2834BDD53; Mon, 10 Oct 2022 18:00:58 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com
Subject: [RFC PATCH v1 00/14] mm/block: add bdi sysfs knobs
Date:   Mon, 10 Oct 2022 18:00:30 -0700
Message-Id: <20221011010044.851537-1-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

At meta network block devices (nbd) are used to implement remote block st=
orage. In testing
and during production it has been observed that these network block devic=
es can consume
a huge portion of the dirty writeback and writeback can take a considerab=
le time.

To give stricter limits, I'm proposing the following changes and new sysf=
s knobs:

1) strictlimit knob
  Currently the max_ratio knob exists to limit the dirty_memory. However =
this knob
  only applies once (dirty_ratio + dirty_background_ratio) / 2 has been r=
eached.
  With the BDI_CAP_STRICTLIMIT flag, the max_ratio can be applied without=
 reaching
  that limit. This change exposes that knob.

  This knob can also be useful for NFS, fuse filesystems and USB devices.

2) Part of 10000 internal calculation
  The max_ratio is based on percentage. With the current machine sizes pe=
rcentage
  values can be very high (1% of a 256GB main memory is already 2.5GB). T=
his change
  uses part of 10000 instead of percentages for the internal calculations=
.

3) Introduce two new knobs: min_bytes and max_bytes.
  Currently all calculations are based on ratio, but for a user it often =
more
  convenient to specify a limit in bytes. The new knobs will not store by=
tes values,
  instead they will translate the byte value to a corresponding ratio. As=
 the internal
  values are now part of 10000, the ratio is closer to the specified valu=
e. However
  the value should be more seen as an approximation as it can fluctuate o=
ver time.


Stefan Roesch (14):
  mm: add bdi_set_strict_limit() function
  mm: Add new knob /sys/class/bdi/<bdi>/strict_limit
  mm: document new /sys/class/bdi/<bdi>/strict_limit knob
  mm: Use part per 10000 for bdi ratios.
  mm: add bdi_get_max_bytes() function
  mm: split off __bdi_set_max_ratio() function
  mm: add bdi_set_max_bytes() function.
  mm: Add new knob /sys/class/bdi/<bdi>/max_bytes
  mm: document new /sys/class/bdi/<bdi>/max_bytes knob
  mm: add bdi_get_min_bytes() function.
  mm: split off __bdi_set_min_ratio() function
  mm: add bdi_set_min_bytes() function
  mm: add new /sys/class/bdi/<bdi>/min_bytes knob
  mm: document new /sys/class/bdi/<bdi>/min_bytes knob

 Documentation/ABI/testing/sysfs-class-bdi |  40 +++++++
 include/linux/backing-dev.h               |   8 ++
 mm/backing-dev.c                          |  93 +++++++++++++++-
 mm/page-writeback.c                       | 126 ++++++++++++++++++++--
 4 files changed, 253 insertions(+), 14 deletions(-)


base-commit: e2302539dd4f1c62d96651c07ddb05aa2461d29c
--=20
2.30.2

