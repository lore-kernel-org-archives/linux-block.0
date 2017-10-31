Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:31790 "EHLO
        BJEXCAS003.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751595AbdJaKhj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Oct 2017 06:37:39 -0400
Date: Tue, 31 Oct 2017 18:37:32 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <jack@suse.cz>
CC: <linux-block@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v2 0/3] add error handle for bdi debugfs register
Message-ID: <cover.1509415695.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

Change since V1:
 * remove the patch for bdi_debug_init(), because patch1 add a check
   for bdi_debug_root
 * remove bdi_put in bdi_register, this functions has two callers:
caller1: mtd_bdi_init->bdi_register, bdi_put if register fail
caller2: device_add_disk->bdi_register_owner->bdi_register, this call
stack need more safety cleanup, so patch3 add an WARN_ON.

weiping zhang (3):
  bdi: convert bdi_debug_register to int
  bdi: add error handle for bdi_debug_register
  block: add WARN_ON if bdi register fail

 block/genhd.c    |  2 +-
 mm/backing-dev.c | 22 +++++++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.14.2
