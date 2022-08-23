Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B269C32792
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 00:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbiHWANs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 20:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239080AbiHWAMk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 20:12:40 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0280757576
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661213524; x=1692749524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=at2tOZdLHOH8i8ObFqSTHPkq/kSI/3sKjiuvGcoXHcI=;
  b=E53OsWe6aVNFehMob32kkabG43H6O1wnpqN4YfeNdpws8KemEzsCHGXF
   2FRU3+ZSt5I43XqLuiFgX9k+DddCrlYoBXVIsg7UJ99mQkfur7G6yZGB8
   Bqq8XjZnYgaEaq4H+Ifgh4sFuhuUDHoaG9N+xTevtTtvrL+yRkengkRv/
   lIwI0kWnbs32TTkPB9UClbA5IYru7zQkB8FZ/10uom8+2Qsg8MR+dQfNi
   x2dazTY3a2bO+24KuMqMKiN68eZ1f+cOQWxEPjhK9KRYYASPlAp112kZu
   GR3rxgZkRr3kbHOKYdl7yJzyc06qMIQpkCG4RT3tKr3emhDdC0M83aqpp
   g==;
X-IronPort-AV: E=Sophos;i="5.93,255,1654531200"; 
   d="scan'208";a="313645300"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2022 08:12:00 +0800
IronPort-SDR: M8DXVMwGGNaZIP1CUgUyFyQcYqHGgHFDu8koOCckwoVIvy0DPXAOYyBDmh60YCvPnyIZ4JjaLw
 Gw54zdJm6X4GiFgu+XOu7ii5r1Eof9INDglY2QeEe0hIUqEVVdtO2A3Yjafq6NXGubkA31M9E5
 Pprk4QGyYSBwAHBA2bzYiUZbL7APlKW0TA2RxKIUQ/a9Gt8X7/jLm5TR8qefZXS2nzIY/KOJde
 4agdINF7padccQ4DV6E7C44uqtVENC9X4N/Qxak8LidHUjuQW2/VlDA5mhJt5007DaZ9M5V0WM
 KJ2Co2drV6V1eLA5snUf2Nsj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Aug 2022 16:32:40 -0700
IronPort-SDR: 0QpxU9YnYHRPOLEuSe21Ox7qNAkqgJHDxNVvQ8qAO1ArX2umZVC6pJppUm+EEi4j4ASJeEBEZb
 a3pBAbAoXsQmV82ARw3VdsxDCeHeQzTdNtXcihZbNBQX0qIxu4PwvFr/b/mRheCDjIAAYVgCTr
 NvYqaqciNEZSXkowvaD+92eMfyFovsyNxnO+W223lIkRwtxp9LN602zSEnFCoatwljmHvyRl/y
 wn3PZClrF9eCDy+gVcajlySXii640gK/Uw9olJxIEGjSK2cJHvwn+KPaC6KQtbCDuPeLN0GE3D
 JFY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2022 17:11:59 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 4/6] block/001: use _have_driver() in place of _have_modules()
Date:   Tue, 23 Aug 2022 09:11:51 +0900
Message-Id: <20220823001154.114624-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823001154.114624-1-shinichiro.kawasaki@wdc.com>
References: <20220823001154.114624-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The drivers sd_mod and sr_mod do not need to be loadable. Replace the
check with _have_driver() and allow test with built-in modules.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/001 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/block/001 b/tests/block/001
index 5f05fa8..fb93932 100755
--- a/tests/block/001
+++ b/tests/block/001
@@ -13,7 +13,9 @@ DESCRIPTION="stress device hotplugging"
 TIMED=1
 
 requires() {
-	_have_scsi_debug && _have_modules sd_mod sr_mod
+	_have_scsi_debug
+	_have_driver sd_mod
+	_have_driver sr_mod
 }
 
 stress_scsi_debug() {
-- 
2.37.1

