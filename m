Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A894BECAAD2
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 03:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiIBDp0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 23:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiIBDpX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 23:45:23 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7771EAD6
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 20:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662090320; x=1693626320;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Xg2twERZf8VQ5EQr3UEn1lYBqldRIsW5jD1cS2dOVk=;
  b=O1k1fziFcKzQyDUiG1C+BztfYXQkqV1gMkLUwBZ2N2y5q8sICFFlLmki
   7IqFU20YO1ChXu+WgP0oi4bfr/YO0F7Ieq0acQZuHSRej+8/qSexdKALD
   7p6pLTjOoM6/N9oiXI/Zj8+lrWRbUX7wJr3ZPt2dROOHsj6Gn7UurMO7j
   BaFqmQWKcQnHRzNQWFZC5y31SvzTXOUqDY//aKPw678BSHY3lRPTPfrFH
   cvshRTJmbh2bu0Ncqz8FV2POHuMe19eosdGpQymuOPFQDHvH2KUlvaIwO
   UCrWXOauK5oKQcW+z+OEGUGocTQzvuQ9sCnNPIKFwU2yC64uMA04D7Ier
   g==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654531200"; 
   d="scan'208";a="322404151"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2022 11:45:18 +0800
IronPort-SDR: 4LQYEkZV/cCCWekU8zPsHw78EafEKxNn5AY7grwLQgJtLTzUB78wBElOPuFkPJo8WRrQCHe4ln
 fRuoOxsanqmctctm3EGcIwn4/rW1f39TMmbyXm3L+J9+jVa5XwKh/WNRttxs5jhO1yozVctz0F
 z435uML8nLNEYCwXBL8GcGajmEBaU3N1ipjnshjEhbeWh0YwAV970Sg27lAT3UHH3ylD6sN3mJ
 p/WCR2eDKGxkk7W0wa76Dr6UkGCXLvwUOh53wzOw6nW8O0uu8uvvaGqRDg6MvGABMxD6M2EAbn
 TyBLEa8REnM0xz6LtI/5E9Ax
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 20:05:46 -0700
IronPort-SDR: WN076x+vL8SdsA7t6BZLvRV5rPYFrHcrEXK1uOZ3fThU2Dij3oE9jY/qS//ueIQPRS2KYWAtTr
 Pbunkh+G2uW7f3cQ/m6oLBFB/Ufpz/jAjR6gl5Lve/FfBdIOec1JJaJOGaVWuNjZ3DPQc5Ua6g
 pIB63Ku2qMUtAgWsj8V0aVZWHs9Kv9wuR4qtDL12+pHn1smzxu+6pDH06Ny5cROPWwgmiGV/Ai
 w4Frfhowr71VKeavTgwcaH1muHc2IPsgh0nVIy3NhsMBn29y7OCXRk/UWpQU3rQXSz/QTCpo6l
 1iY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Sep 2022 20:45:17 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/5] improve _have_driver() module load issue solution
Date:   Fri,  2 Sep 2022 12:45:11 +0900
Message-Id: <20220902034516.223173-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit 06a0ba866d90 ("common/rc: avoid module load in _have_driver()")
removed module load from _have_driver(). However, it turned out that it was not
a good solution. In the recent discussion for module load preparation for nvme
test cases, it was pointed out no module load in _have_driver() is confusing and
adding complexity [1]:

 - Without module load in _have_driver(), explicit module load and unload are
   required in number of test cases. Boiler plates.
 - The module unload is not always safe. Need care if the module unload is
   expected or not.
 - The module load needs error handling.

I can think of a new helper function to address the comments above, but it will
look like _have_driver() with module load. Hence, I suggest to revert back some
part of the the commit 06a0ba866d90 to load modules in _have_driver() (Sorry
Christoph, Bart for doing this on the commit you reviewed). As a better
solution, I propose to record the modules loaded in _have_driver() and unload
them at each test case end, regardless of the test case is skipped or executed.
I confirmed this fix avoids the issue that the commit 06a0ba866d90 tried to fix.

In this series, 4th patch is the core change in _have_driver. 1st, 2nd and 3rd
patches are clean-up preparation patches for the 4th patch. 5th patch reverts
changes in nbd/rc, which is no longer required after the 4th patch.

[1] https://lore.kernel.org/linux-block/89aedf1d-ae08-adef-db29-17e5bf85d054@grimberg.me/

Shin'ichiro Kawasaki (5):
  check: clean up _run_test()
  common,tests: rename unload_module() to _unload_module()
  check,common/rc: move _unload_module() from common/rc to check
  check,common/rc: load module in _have_driver() and unload after test
  Revert "nbd/rc: load nbd module explicitly"

 check                      | 36 +++++++++++++++++++++++++++++++-----
 common/multipath-over-rdma |  4 ++--
 common/rc                  | 26 ++++++++++----------------
 tests/nbd/rc               | 12 ++----------
 tests/nvmeof-mp/rc         | 12 ++++++------
 tests/srp/rc               |  8 ++++----
 6 files changed, 55 insertions(+), 43 deletions(-)

-- 
2.37.1

