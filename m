Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:17279 "EHLO
        BJEXCAS007.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752436AbdKWNh6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Nov 2017 08:37:58 -0500
Date: Thu, 23 Nov 2017 21:37:44 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH 0/5] cleanup for blk-wbt
Message-ID: <cover.1511444141.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

several cleanup for blk-wbt, no function change, thanks

weiping zhang (5):
  blk-wbt: remove duplicated setting in wbt_init
  blk-wbt: cleanup comments to one line
  blk-sysfs: remove NULL pointer checking in queue_wb_lat_store
  blk-wbt: move wbt_clear_stat to common place in wbt_done
  blk-wbt: fix comments typo

 block/blk-sysfs.c |  5 +----
 block/blk-wbt.c   | 11 +++--------
 2 files changed, 4 insertions(+), 12 deletions(-)

-- 
2.9.4
