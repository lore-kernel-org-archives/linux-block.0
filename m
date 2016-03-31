Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:9126 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932077AbcCaUZj (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 31 Mar 2016 16:25:39 -0400
From: Jon Derrick <jonathan.derrick@intel.com>
To: axboe@fb.com
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	keith.busch@intel.com, hch@infradead.org,
	stephen.bates@microsemi.com
Subject: [PATCH 0/2] Block: Give option to force io polling
Date: Thu, 31 Mar 2016 14:19:12 -0600
Message-Id: <1459455554-2794-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In 4.6, enabling io polling in direct-io was switched to a per-io flag.
This had an unintended result of giving a significant difference when
doing benchmarks between 4.5 and 4.6, using fio's sync engine.

I was able to regain the performance by getting the pvsync2 engine
working with the new p{read,write}v2 syscalls, but this patchset allows
polling to be tried in the direct-io path with the other syscalls.

Rather than having to convert applications to prwv2 syscalls, users can
enable this knob that let's them see the same performance as they may
have seen in 4.5 when it always polled.

Jon Derrick (2):
  block: add queue flag to always poll
  block: add forced polling sysfs controls

 block/blk-core.c       |  8 ++++++++
 block/blk-sysfs.c      | 38 ++++++++++++++++++++++++++++++++++++++
 fs/direct-io.c         |  7 ++++++-
 include/linux/blkdev.h |  2 ++
 4 files changed, 54 insertions(+), 1 deletion(-)

-- 
2.5.0

