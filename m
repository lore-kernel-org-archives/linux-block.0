Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587D1C04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 08:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiG0Iwz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 04:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiG0Iwy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 04:52:54 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E6B46D85
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 01:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658911973; x=1690447973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IWLR1g3gyyOQWwRgtYR7ZIvnhzZdlVrRAWjdFXTIgZI=;
  b=ZpWNBHu74HpTFpJm8JLsbmBL/XyzlwuloHtNecef+h9NUzo1QbbpFDwE
   4y7J8zA2g1ODTSXY9Q0VVoSiP9COBGX908LyNzH8b3yW2d4r9s4mNiozh
   O2qnCfQJG8+veEWvSjrQnA7yLk4PrP+GmYuYz3nkSOpsYOBUrmmSNEmul
   MTdXzi2HzEFxrj3L/q8npJrYjGeMPROfx8pPxDWYBSylF2Ii+OJVxowC/
   u6zE0XbJ6Biobte+Y3qRn8N9mi8EWVIwXOEY14ZyF17cotjDZNLTHfzeI
   bxuMev467aoR4wX8TFyIqfD+JwGR2fPUrGFYZhv9vxPruHoLHJ10aDf3c
   w==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654531200"; 
   d="scan'208";a="205584971"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2022 16:52:52 +0800
IronPort-SDR: 1DWiTocEd9e9IbFMFDuQrYr2tKY0ZhjrpkLcMNqBLCBvHA/Oa61SnBnf85D4clt47JGPyIAWjr
 cPM+/Ad4kvdIRzVi5fVYbFTHmoSFgcvIVf3ODSMLKnC97vd18HppDJlPSKDx38HANvJGoGnfoQ
 c2HlmO/xtggZ8wHJmNCzcLYFP/Uts/0VfvGgvWPxMlUIFLEz/Y67pGAJ2gWn3wsg9FlIXz2Z0q
 NlhnGLFeQ1+LZt8yOrxEUV2QNUlLEjTx+IblUEOp/VFZ6PNvWRU17480UrBgHebioMsKxHVuun
 uUWl8aJeWKuXUCwoWKo/Xw5k
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 01:14:05 -0700
IronPort-SDR: dv0ulmactOAofRTR3gMz03nn3aMP7vgAasq5HsEU9nJC+sqlbbpssfemw4c4wP5WQYveoYGJtr
 MAEr2gYMeYEv8uZgjFVkdyyJvIyy5dm06dmZmbjliOqu4aWW25Wnc6zKMzEdDyCqb/yp1E6+Hc
 rZ7KFZ3E/EJmH0zI+9HteSIFZCMoMCTnvjqxC5hcpS1Pmw8+/8XjTJBYS5uC8IIxUF9fB/jAiJ
 J8hGdlfNrbXBQMcFtpWVBkDNLAYzWzxoD6JXyEJCE7yOaceT2PAE2MNhoEfYWck04AQyy12mCm
 n5c=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jul 2022 01:52:53 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/6] fix module check issues
Date:   Wed, 27 Jul 2022 17:52:45 +0900
Message-Id: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
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
 7 files changed, 62 insertions(+), 24 deletions(-)

-- 
2.36.1

