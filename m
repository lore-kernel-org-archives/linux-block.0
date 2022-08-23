Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1E4C32774
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 00:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbiHWANa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 20:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239058AbiHWAMi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 20:12:38 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD205755C
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 17:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661213517; x=1692749517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J1w/86XmIqvOXwxEi/D/Lt7LbKGIN84rtG5VGV8hn1A=;
  b=pua2wYNRCtYr7yzp/kXySSIjlJwDhcrWEGA0uqeMT+/ESEw5A4zr3noG
   q91DScXO7/YvU+bDz/wWTopjlXZ4Pj/BHZjw8gbIZ96IrqNLmGHjXWgUD
   T5w9cIeJkG7IW0miaWQ3VywCyl2jiPjHbfshdTLKyhmm30TGSt9mDfLWN
   Nhx92vaP7I9IBNo7VHJEPdzTKne0ZKVt1ozjOBjryX/MyW2A8HMFA51fn
   q12T6pPHg4IVeJeP9jX5S/G01j73cskpjIGoHaHycMco88tdVAhcHse6g
   Hw6k0BEjBlIKj3GLdv6H6lgf+TZrX1PnEC9rb/VOnBoo7q6FutYtRDlRM
   A==;
X-IronPort-AV: E=Sophos;i="5.93,255,1654531200"; 
   d="scan'208";a="313645294"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2022 08:11:55 +0800
IronPort-SDR: J1VrChCDVT2FCf8t/BVLsQhidvo8D12uyGA7XC7Miccdix5TeK7uGMAooGYf5hER6RMow+BVZs
 RBKWoeE9hZpEy+S9T9RKysAfeSMOeG5/NbOjNsdUbjtVMI5piiGpnvPo+OZahhFznDLUkhlQM6
 990mhC6FAGoQlQzK6qhcuuqfDJle4VcT0iyWlw+7zIt7urrm9RlnOCCCMMKf3rXiRIfvCKAMZ4
 osZ2iZkG1dCyp+4Et2vCYz6RAZiYsXXIiolSf9sVr9r1yBr/DfFJjmg2j26+ELaaFSOHhSuRc4
 7k7xVTcGCynk7mDe2YYz0LFc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Aug 2022 16:32:35 -0700
IronPort-SDR: OKONwNO4zSGxTa02jaydNVWIg16hta7wCWCEit+GNYH6dWfEYI7MVpQKl7Xr7JK5YdqyxX0ZQd
 BiziGDT1+gkV50+p7VFGw+x1x9x0Lq9574jyEaot1oKTwO/2ld44G04p7ocje6/5QcFD3t+BHD
 zWIpALZAG28A6rSHsbqd1oTThDeKK0rysnknXCDSzCAnE9DNY/dSwgbTnROLbyMTpbAxh93KRf
 wHI7xmMMEsnSrwHVdQ0CH5is6+nlgeRAVMVXLeMRmp7hsD0ikzuVv9aC5IRnlUR5Uz/kJToUge
 gxM=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2022 17:11:54 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 0/6] fix module check issues
Date:   Tue, 23 Aug 2022 09:11:47 +0900
Message-Id: <20220823001154.114624-1-shinichiro.kawasaki@wdc.com>
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
exactly same check as _have_driver(). The third patch fixes _have_modules() to
work as expected. This change makes block/001 and srp test group skipped.
Following two patches adjust skip conditions not to skip the test cases.

The last patch is an additional clean up to change _have_modules() to
_have_module() to make its usage consistent with _have_driver().

Changes from v3:
* Dropped 4th patch and added new 6th patch
* Added Reviewed-by tags

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
  block/001: use _have_driver() in place of _have_modules()
  srp/rc: allow test with built-in sd_mod and sg drivers
  common,tests: replace _have_modules() with _have_module()

 common/rc          | 40 ++++++++++++++++++++++++----------------
 common/scsi_debug  |  2 +-
 tests/block/001    |  4 +++-
 tests/nbd/004      |  2 +-
 tests/nbd/rc       | 12 ++++++++++--
 tests/nvmeof-mp/rc | 32 +++++++++++++++-----------------
 tests/srp/015      |  2 +-
 tests/srp/rc       | 45 +++++++++++++++++++++------------------------
 tests/zbd/010      |  2 +-
 9 files changed, 77 insertions(+), 64 deletions(-)

-- 
2.37.1

