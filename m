Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EEAC4332F
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 18:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJQSOL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiJQSOL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 14:14:11 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE7F74CC5
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 11:14:10 -0700 (PDT)
Received: by dev1180.prn1.facebook.com (Postfix, from userid 425415)
        id 0E33E39C99B2; Mon, 17 Oct 2022 11:13:56 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     shr@devkernel.io, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: [RFC PATCH v2 00/14] mm/block: add bdi sysfs knobs
Date:   Mon, 17 Oct 2022 11:13:23 -0700
Message-Id: <20221017181337.3884657-1-shr@devkernel.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

At meta network block devices (nbd) are used to implement remote block
storage. In testing and during production it has been observed that
these network block devices can consume a huge portion of the dirty
writeback cache and writeback can take a considerable time.

To be able to give stricter limits, I'm proposing the following changes:

1) introduce strictlimit knob

  Currently the max_ratio knob exists to limit the dirty_memory. However
  this knob only applies once (dirty_ratio + dirty_background_ratio) / 2
  has been reached.
  With the BDI_CAP_STRICTLIMIT flag, the max_ratio can be applied without
  reaching that limit. This change exposes that knob.

  This knob can also be useful for NFS, fuse filesystems and USB devices.

2) Use part of 1000 internal calculation

  The max_ratio is based on percentage. With the current machine sizes
  percentage values can be very high (1% of a 256GB main memory is alread=
y
  2.5GB). This change uses part of 1000 instead of percentages for the
  internal calculations.

3) Introduce two new sysfs knobs: min_bytes and max_bytes.

  Currently all calculations are based on ratio, but for a user it often
  more convenient to specify a limit in bytes. The new knobs will not
  store bytes values, instead they will translate the byte value to a
  corresponding ratio. As the internal values are now part of 1000, the
  ratio is closer to the specified value. However the value should be mor=
e
  seen as an approximation as it can fluctuate over time.



Changes:
  - Refreshed to 6.1-rc1
  - Use part of 1000, instead of part of 10000
  - Reformat cover letter


Stefan Roesch (14):
  mm: add bdi_set_strict_limit() function
  mm: add knob /sys/class/bdi/<bdi>/strict_limit
  mm: document /sys/class/bdi/<bdi>/strict_limit knob
  mm: use part per 1000 for bdi ratios.
  mm: add bdi_get_max_bytes() function
  mm: split off __bdi_set_max_ratio() function
  mm: add bdi_set_max_bytes() function.
  mm: add knob /sys/class/bdi/<bdi>/max_bytes
  mm: document /sys/class/bdi/<bdi>/max_bytes knob
  mm: add bdi_get_min_bytes() function.
  mm: split off __bdi_set_min_ratio() function
  mm: add bdi_set_min_bytes() function
  mm: add /sys/class/bdi/<bdi>/min_bytes knob
  mm: document /sys/class/bdi/<bdi>/min_bytes knob

 Documentation/ABI/testing/sysfs-class-bdi |  40 +++++++
 include/linux/backing-dev.h               |   8 ++
 mm/backing-dev.c                          |  93 +++++++++++++++-
 mm/page-writeback.c                       | 126 ++++++++++++++++++++--
 4 files changed, 253 insertions(+), 14 deletions(-)


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
--=20
2.30.2

