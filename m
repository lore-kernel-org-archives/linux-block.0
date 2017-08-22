Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24498 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbdHVQxW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 12:53:22 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/2] Make I/O timeout failure injection again task-independent
Date: Tue, 22 Aug 2017 09:52:34 -0700
Message-Id: <20170822165236.12275-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Andrew,

A recent change in the fault injection code introduced an undesired change
in the behavior of the I/O timeout failure injection code. This series
restores the original behavior. Please consider these patches for kernel
v4.14.

Thanks,

Bart.

Bart Van Assche (2):
  fault-inject: Restore support for task-independent fault injection
  block: Make I/O timeout failure injection support again
    task-independent

 block/blk-timeout.c          | 2 +-
 include/linux/fault-inject.h | 9 +++++++--
 lib/fault-inject.c           | 4 +++-
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.14.0
