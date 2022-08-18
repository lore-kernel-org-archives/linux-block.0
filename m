Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6334C25B08
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 01:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242573AbiHRB02 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Aug 2022 21:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiHRB01 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Aug 2022 21:26:27 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC01A1A64
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 18:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660785987; x=1692321987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o7hlT8+mLCjbW3IqeANXZCdmPwcudZha5JZ9LEKR9nI=;
  b=kJGRB7eAvUhccX25Lua3Op+MFmrcoIwVxHzb0nwjFG1oyLNbwHz9W2Ne
   Jvwo9MJX394X5g5s7Ez9kmRPR05rk4wdQbV5ryJ78F8BjISmy3R9VF3aW
   wpue+ayoaLqrOHtHuT6sPssjE/TSRPEuGwvc62uCRoEzDi9GpwjGDvm66
   A3hPLtzl+p19reE5g15/1lRgo4GOtWEx4d+/e/K15Ns0MfF8rFdu5A0Or
   iJriMT2odhtGQZfAsM++IXz8lHK86xlX6M6wX3P4aW6WcN4pjAqzTXWRn
   qXcbsFOWquLmh0OsWF0dQUwK5rPtOr9ZXL0xNyYaMl9HOWoli7zkI2LMI
   w==;
X-IronPort-AV: E=Sophos;i="5.93,244,1654531200"; 
   d="scan'208";a="321085636"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2022 09:26:26 +0800
IronPort-SDR: URK9ocawuvbzMr8lFlaS8k9aGBXtTodDnMXz75y1syIbnZOnzvE6SARY/y5V1bHwOd/ZnwP8H9
 cLiRDWfoMdhHQVy7Xakcqpi6z/5ETA12Z+OL00rCoGEHim9zls/sDQtrIcGNmg/HrKfKEhwR3d
 oR51L3jU7HZ/9cMnPLJYMBu2PcdnWRdFIMolwrAQkGu/nfdfsl/nPqvVl2EhS3wnGSbueePLwz
 LeNpnKI0sjFMzHBqkfHxovg+j9upiaC3n2yl1xH8dTNUnr5xUF/804oQJtLRtYudctIgPEnOUX
 VYBr1Hh0i+8lL3SmlZuI66dL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 17:41:53 -0700
IronPort-SDR: BQ5UylKMkdgdM3ef+GbfnWRXLQTpC8d16OmWrbAdDHRuvwO992cJR1/pkuevUU+yzZyHBC7zNH
 A1Rfo8lBd5xcDS51ukw7VlLWdkXpRD6piDWHoGpr28g7Au2++rCCUvR/tU2oVGjUJsJjNj+YWe
 DsKYo8uP4WJ58Rk4fd+H6q3oyvWEIFd+HpE3Y9xYqZZ3PXBfYfIiGAbKfpXX3+4x4++AzssR5c
 DROkZzTNl2ZRsY4IDTa6RGqapdzj36VVDKMkEieZV9GLsWXJnqEChqlVeMk02x3nt+4N2svicz
 IOU=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Aug 2022 18:26:26 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 0/6] fix module check issues
Date:   Thu, 18 Aug 2022 10:26:18 +0900
Message-Id: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
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
 tests/srp/rc    | 10 ++++++----
 tests/zbd/009   |  2 +-
 tests/zbd/010   |  2 +-
 9 files changed, 64 insertions(+), 26 deletions(-)

-- 
2.37.1

