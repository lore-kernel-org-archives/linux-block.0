Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:12390 "EHLO
        BJEXCAS003.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S932309AbdJZRfX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Oct 2017 13:35:23 -0400
Date: Fri, 27 Oct 2017 01:35:12 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <jack@suse.cz>
CC: <linux-block@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH 0/4] add error handle for bdi debugfs register
Message-ID: <cover.1509038624.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


this series add error handle for bdi debugfs register flow, the first
three patches try to convert void function to int and do some cleanup
if create dir or file fail.

the fourth patch only add a WARN_ON in device_add_disk, no function change.

weiping zhang (4):
  bdi: add check for bdi_debug_root
  bdi: convert bdi_debug_register to int
  bdi: add error handle for bdi_debug_register
  block: add WARN_ON if bdi register fail

 block/genhd.c    |  4 +++-
 mm/backing-dev.c | 41 +++++++++++++++++++++++++++++++++++------
 2 files changed, 38 insertions(+), 7 deletions(-)

-- 
2.14.2
