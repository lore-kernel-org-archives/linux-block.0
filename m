Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53216 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422860AbeCBPV4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Mar 2018 10:21:56 -0500
Received: by mail-wm0-f65.google.com with SMTP id t3so3816804wmc.2
        for <linux-block@vger.kernel.org>; Fri, 02 Mar 2018 07:21:55 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH V5 00/12] lightnvm: pblk: implement 2.0 support
Date: Fri,  2 Mar 2018 16:21:08 +0100
Message-Id: <1520004080-27760-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patchet applies on top of Matias' for-17/core, with the following
patches applied:
  lightnvm: pblk: refactor init/exit sequences (V2)
  nvme: implement log page low/high offset and dwords (V2)

# Changes since V4
- Remove init/exit sequences as it has been sent separately
-Rebase on top of latest for-4.17/core

>From Matias:
- Fix pblk sysfs
- squash related patches
- remove capabilities patch - Matias will take this later on
- Various renamings

# Changes since V3.1

- Rebase on top of Matias' for-4.17/core
- Fix pblk's write buffer size when using mw_cuints
- Remove chunk information from pblk's sysfs. We intend to clean up
  sysfs, as it is messy as it is now, and use trace points instead. So,
    avoid an extra refactoring in the near future.

>From Matias:
- Squash geometry patches
- Squash chunk support in lightnvm core
- Use core structure for chunk metadata
- Remove intermediate values for csecs and sos before disk
  revalidation.
- Various renamings

# Changes since V3
>From Matias:
- Remove nvm_common_geo
- Do appropriate renames when having a single geometry for device and
    targets

# Changes since V2:

Apply Matias' feedback:
 - Remove generic nvm_id identify structure.
 - Do not remap capabilities (cap) to media and controlled capabilities
   (mccap). Instead, add a comment to prevent confusion when
   crosschecking with 2.0 spec.
 - Change maxoc and maxocpu defaults from 1 block to the max number of
   blocks.
 - Re-implement the generic geometry to use nvm_geo on both device and
   targets. Maintain nvm_common_geo to make it easier to copy the common
   part of the geometry (without having to overwrite target-specific
   fields, which is ugly and error prone). Matias, if you still want to
   get rid of this, we can do it.
 - Re-order patches with renaming to make them more meaningful. These
   belong to the series, since the name changes are motivated by 2.0
   inclusions. The only exception would be 36d10bfd3234, but I hope it
   is OK I include it here.

Also,
 - Eliminate a dependency between luns and lines in the init/exit
   refactoring.
 - Use the global address format when possible to avoid defaulting on
   the 1.2 path. This will safe headaches if the address format changes
   at some point.

I took out the patch allowing to do bit shifts on non power-of-2 media
formats on pblk's mapping since it requires touching many places that
are not 2.0 related. I'll submit this separately.

# Changes since V1:

Apply Matias' feedback:
 - Rebase on top of Matias' latest patches.
 - Use nvme_get_log_ext to submit report chunk and export it.
 - Re-write report chunk based on Matias' suggestions. Here, I
   maintained the lba interface, but it was necessary to redo the
   address formatting to match the chunk log page format. For pblk,
   this means a double address transformation, but it enables the
   standard path to use lbas, plus, this is not in the fast path.
 - Fold address format together with address transformations.
 - Split the generic geometry patch in different patches.
 - Remove refactoring of ligthnvm's core sysfs.

Feedback not applied:
 - Not letting pblk know about 1.2 and 2.0 bad block paths.
   Since the interfaces for get/set bad block and report chunk are so
   different, moving this logic to core adds assumptions on how the
   targets would want to get the data back. A way of doing this is
   creating a logical report chunk on the 1.2 path, but this would
   mean that values like the wear-index are invalid, which requires
   the target knowledge. I'm open to suggestions here.

Also:
 - Do some further renamings
 - Create a generic address format to make it explicit where we share
   1.2 and 2.0 fields to avoid address formatting in the fast path.
 - Add new fields to sysfs to complete spec and show major/minor
   versions (version and subversion to respect current interface).

Implement 2.0 support in pblk. This includes the address formatting and
mapping paths, as well as the sysfs entries for them.

Javier


Javier González (12):
  lightnvm: simplify geometry structure.
  lightnvm: add minor version to generic geometry
  lightnvm: add shorten OCSSD version in geo
  lightnvm: complete geo structure with maxoc*
  lightnvm: normalize geometry nomenclature
  lightnvm: add support for 2.0 address format
  lightnvm: make address conversions depend on generic device
  lightnvm: implement get log report chunk helpers
  lightnvm: pblk: check for supported version
  lightnvm: pblk: rename ppaf* to addrf*
  lightnvm: pblk: implement get log report chunk
  lightnvm: pblk: implement 2.0 support

 drivers/lightnvm/core.c          | 178 +++++++---------
 drivers/lightnvm/pblk-core.c     | 168 ++++++++++++---
 drivers/lightnvm/pblk-gc.c       |   2 +-
 drivers/lightnvm/pblk-init.c     | 413 +++++++++++++++++++++++------------
 drivers/lightnvm/pblk-map.c      |   4 +-
 drivers/lightnvm/pblk-read.c     |   2 +-
 drivers/lightnvm/pblk-recovery.c |  14 +-
 drivers/lightnvm/pblk-rl.c       |   2 +-
 drivers/lightnvm/pblk-sysfs.c    |  63 ++++--
 drivers/lightnvm/pblk-write.c    |   2 +-
 drivers/lightnvm/pblk.h          | 240 +++++++++++++++------
 drivers/nvme/host/core.c         |   6 +-
 drivers/nvme/host/lightnvm.c     | 449 +++++++++++++++++++++++++++------------
 drivers/nvme/host/nvme.h         |   3 +
 include/linux/lightnvm.h         | 327 ++++++++++++++++++----------
 15 files changed, 1251 insertions(+), 622 deletions(-)

-- 
2.7.4
