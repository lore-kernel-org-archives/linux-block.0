Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18467 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdHVXBl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Aug 2017 19:01:41 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v2 0/2] Make I/O timeout failure injection again task-independent
Date: Tue, 22 Aug 2017 16:00:41 -0700
Message-Id: <20170822230043.9968-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Andrew,

A recent change in the fault injection code introduced an undesired change
in the behavior of the I/O timeout failure injection code. This series
restores the original behavior. Please consider these patches for kernel
v4.14.

Thanks,

Bart.

Changes compared to v1:
- Fixed build with CONFIG_FAIL_PAGE_ALLOC, CONFIG_FAIL_IO_TIMEOUT and/or
  CONFIG_FAIL_FUTEX enabled.

Bart Van Assche (2):
  fault-inject: Restore support for task-independent fault injection
  block: Make I/O timeout failure injection again task-independent

 block/blk-timeout.c          |  2 +-
 include/linux/fault-inject.h | 11 +++++++++--
 lib/fault-inject.c           |  4 +++-
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.14.0
