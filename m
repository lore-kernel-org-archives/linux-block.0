Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CD1C32771
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 09:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347163AbiHSJj1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348153AbiHSJjY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 05:39:24 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2766B79A61
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 02:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660901963; x=1692437963;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nz/8wg904XiJrYs2wtXUoCpDGetdvT5UODVRh4aZvPM=;
  b=QOr6tXHwdtOgYi2LPacpJ9XT/7+B8IAFEMJTVn38/sqM4Ma7sdsRq6jh
   wVYak/Mj75AGeoIkhw7Q3ewHz7ke0PB2KhAnK88fiuWRiUyKhkNeMsVOy
   C79rHphsJHv/VNY7BQ06vBPQ40UVOWpXOevwWm1RpytiTF9p3kTmCYNC7
   Q+LnbBZ+0kMVmrzKEZopvTR16kKUO+TsKkUZZ6++DocqPYF/MzNhKOkwK
   M22Me+s9P6pdAPfEKMzPW4U7T7wJ66Eem8cfPak24ZZwd/Hvuj5alcFFV
   DE8nvcouVE6xGtMpYwuRIyhLL2gJKN1fXDMU+T7hDjy5OCxRIfw0KaiXg
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654531200"; 
   d="scan'208";a="313411526"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2022 17:39:22 +0800
IronPort-SDR: S+2ftA6PYseJuQDxDltacaTKRugSX/Vmm1bihxCbT/p+ljaV4OAa/Q0vi0555UaU6QYAVV161v
 JHsv8Vb9QLvu8sf914EeuhdN/8DQsm+cabckU2fvAgwvCRXJm3OpO8WvJxsMk2NdWGrSnzQoHz
 Oo4U7RiXbX+sTo7jBrEY0elBsC0g+tWY1zX73Y5YWXWLEL/gzSlLB51y2NcbY2qKyJGOLMub/o
 a/sYWqMz3IWE8DBaOmyJyPiCufVOe/3UwvoJi6/HFPkjphrdLYcKjfX40A9ehGZAcDncs0eQn1
 ZzGX0nJ6gAaz9zwSkGXfVrSI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Aug 2022 01:54:46 -0700
IronPort-SDR: tgvypSPxYsWfYj6ZWsP9hSjyad+7zBQl20Oc3Lq9RQMdCYscRU8/nhxcTRA501FJRT5CIdZnUt
 NvjIgL+nCvPE7ivDKgMh2hFR7rzTQD3FrkJYN/ekbjDKmbCZNNswE2nCHdzQo22N3ZY+2mOSa5
 LGY9LpSPiIslZf3kkQKDbQSKzXZpZPuTNuQTC7gg/QUv+jgV+QF312xGT0zDMhOmcMYxm0Sf4H
 Z+JAOJlYlVe4IOvJ/klGN4X+vqVhLS/GjpvWvWB0vpREmgHfUQ7kyq9ww77txpFmLkFSGhH2RO
 SJQ=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Aug 2022 02:39:21 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 0/6] fix module check issues
Date:   Fri, 19 Aug 2022 18:39:14 +0900
Message-Id: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Current blktests have unexpected test case failures caused by module
availability checks. This series addresses two issues related to module check
and fix the failures.

The first issue is caused by module load by _have_driver(). When this helper
function checks the specified module (or driver) is available, it loads the
module using modprobe command. It leaves the module loaded and affects following
test cases. The first patch addresses this issue. The second patch avoids side
affects of the first patch on nbd test cases.

The second issue is in _have_modules(). Recently, _have_driver() helper function
was introduced to provide similar but different feature from _have_modules().
However, it turned out that _have_modules() is not working as expected and does
exactly same check as _have_driver(). The third patch fixes _have_module() to
work as expected. This change makes block/001 and srp test group skipped.
Following three patches adjust skip conditions not to skip the test cases.

Changes from v2:
* 1st patch: kept single bracket style
* 3rd patch: replaced find -or option with -o
* 4th patch: adjusted to the 1st patch change
* 6th patch: simplified _have_drivers() arguments

Changes from v1:
* 1st patch: added Reviewed-by tag
* 4th patch: added changes in new test cases

Shin'ichiro Kawasaki (6):
  common/rc: avoid module load in _have_driver()
  nbd/rc: load nbd module explicitly
  common/rc: ensure modules are loadable in _have_modules()
  common,tests: replace _have_driver() with _have_drivers()
  block/001: use _have_drivers() in place of _have_modules()
  srp/rc: allow test with built-in sd_mod and sg drivers

 common/null_blk |  2 +-
 common/rc       | 43 ++++++++++++++++++++++++++++++++++++-------
 tests/block/001 |  3 ++-
 tests/nbd/rc    | 14 +++++++++++---
 tests/nvme/rc   | 12 +++++-------
 tests/scsi/rc   |  2 +-
 tests/srp/rc    |  4 +---
 tests/zbd/009   |  2 +-
 tests/zbd/010   |  2 +-
 9 files changed, 59 insertions(+), 25 deletions(-)

-- 
2.37.1

