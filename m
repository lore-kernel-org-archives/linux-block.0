Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44585 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbeBUJ1L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:11 -0500
Received: by mail-wr0-f196.google.com with SMTP id v65so2420385wrc.11
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 01:27:10 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH V2 00/20] lightnvm: pblk: implement 2.0 support
Date: Wed, 21 Feb 2018 10:26:38 +0100
Message-Id: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Changes since V1:

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
  - Not letting pblk know about 1.2 and 2.0 bad block paths. Since the
    interfaces for get/set bad block and report chunk are so different,
    moving this logic to core adds assumptions on how the targets would
    want to get the data back. A way of doing this is creating a logical
    report chunk on the 1.2 path, but this would mean that values like
    the wear-index are invalid, which requires the target knowledge. I'm
    open to suggestions here.

Also:
  - Do some further renamings
  - Create a generic address format to make it explicit where we share
    1.2 and 2.0 fields to avoid address formatting in the fast path.
  - Add new fields to sysfs to complete spec and show major/minor
    versions (version and subversion to respect current interface).

Implement 2.0 support in pblk. This includes the address formatting and
mapping paths, as well as the sysfs entries for them.

Javier

Javier González (20):
  lightnvm: simplify geometry structure.
  lightnvm: add controller capabilities to 2.0
  lightnvm: fix capabilities for 2.0 sysfs
  lightnvm: add minor version to generic geometry
  lightnvm: rename number of channels and luns
  lightnvm: add shorten OCSSD version in geo
  lightnvm: rename sect_* to sec_*
  lightnvm: complete geo structure with maxoc*
  lightnvm: use generic identify structure
  lightnvm: pblk: rename ppaf* to addrf*
  lightnvm: pblk: check for supported version
  lightnvm: complete 2.0 values in sysfs
  lightnvm: add support for 2.0 address format
  lightnvm: make address conversions depend on generic device
  nvme: make nvme_get_log_ext available
  lightnvm: implement get log report chunk helpers
  lightnvm: define chunk states
  lightnvm: pblk: implement get log report chunk
  lightnvm: pblk: refactor init/exit sequences
  lightnvm: pblk: implement 2.0 support

 drivers/lightnvm/core.c          | 205 +++++-----
 drivers/lightnvm/pblk-core.c     | 141 +++++--
 drivers/lightnvm/pblk-gc.c       |   2 +-
 drivers/lightnvm/pblk-init.c     | 787 +++++++++++++++++++++++----------------
 drivers/lightnvm/pblk-read.c     |   2 +-
 drivers/lightnvm/pblk-recovery.c |  14 +-
 drivers/lightnvm/pblk-rl.c       |   2 +-
 drivers/lightnvm/pblk-sysfs.c    | 130 ++++++-
 drivers/lightnvm/pblk-write.c    |   2 +-
 drivers/lightnvm/pblk.h          | 253 +++++++++----
 drivers/nvme/host/lightnvm.c     | 480 ++++++++++++++++--------
 drivers/nvme/host/nvme.h         |   3 +
 include/linux/lightnvm.h         | 338 +++++++++++------
 13 files changed, 1546 insertions(+), 813 deletions(-)

-- 
2.7.4
