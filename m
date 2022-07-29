Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FD9C00140
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 00:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiG2APK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 20:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiG2APK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 20:15:10 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEFE2B5
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 17:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659053707; x=1690589707;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M0OTHg3mgDq2E6UeBsOaBGDK3TLVs1l1xo3oPf+ova4=;
  b=Bq2VbevT1Sahg7+iXGPcuISHApQRxbsNGkNcerfj/PhlTgM9j0rKm2HX
   8XialgEzt2uarxA3VYQoxR8TBrJHlxhpbr3fwqr4z5K3B48rA3tlmv4gl
   97tH3Fn/7pibnYwkWmV0S3JUlJVEPtjTrqySxkZ25lSHIfjDWantzntgU
   2OBnn2TsjaG6Z6p3aTbDwqbZOoxDJf4DnA5mDBFT8maCtIqTehfryuG2P
   5R92wM/Lzr7DM47DJr+zXiYqM2CZcj/Y7FtONOwTaT5vICJyGoUNgkgCV
   sYaAhtdAM9qT0YI+Fnfx7yPnjoEZv3aSdDsjfTaOyRppdTyFCYuz7IKdj
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,199,1654531200"; 
   d="scan'208";a="212167327"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2022 08:15:06 +0800
IronPort-SDR: +Dae1WmMhJW9RxedGdIG+nuTqYlfo9+yK3qt+UwZTfW169OiyXC/inYtbSVFT2R1gPDaiHOVYN
 f84m0WjWU8XMlv4EbF4DwEhv2lQ0E+ChPnkVqiom20gSYDVj4VQ13KRhnfGcbOxFhnLgEB0Yrl
 1NDXRwoh8U1RhiXtDCsF9Pr33G1kvPuLnYr/PXSml51m9qFHE7Nj/nX1P8WlTpOXFSxmcprgkJ
 p4GT92U+90xEhBnotBSlFS2jdIPMOFWi+McIYMdccb8S1g060m8rA85nNsOmmq1kddt3LrDDKB
 w+B28uYArn/yQwh28tzKzUlR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2022 16:31:09 -0700
IronPort-SDR: +W23HH/uZqUDBhTO+P00zSxzi/8pKqo8PiyUwQ0fypmFymf0a6nuFSx/W4NVUbvo7wMct3BVd7
 4GLbSR2p3TA1WWSKpk6KhRGKWGd2754YTKd9FmQ6p7dJKD7l3fpdRLy3KPUkkXWUkWv9Cwo4cV
 7CXnqdivChyQb2s3WSSwNkTj8vZHY3x/DxTBNXeK8+rli+e1Q3gEsvwSj9NOMHK8XypvAr5Pxw
 a83vL2osCHFH9QEg1peW6Cj9GigiAk235fXtjcjNlHTuTrVdEXkJgWmRx584k/4NFGkgFDVod9
 Vz0=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Jul 2022 17:15:06 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests] nvme/040: fix write file path
Date:   Fri, 29 Jul 2022 09:15:05 +0900
Message-Id: <20220729001505.1489933-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case nvme/040 performs I/O to a nvmf device file. However, it
specifies wrong path to the device file then the I/O is done to a
regular file. Hence fix the path.

Fixes: ebf197d1aea4 ("nvme: add nvmf reset/disconnect during traffic test")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/040 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/040 b/tests/nvme/040
index 10c1815..04bd726 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -37,7 +37,7 @@ test() {
 
 	# start fio job
 	echo "starting background fio"
-	_run_fio_rand_io --filename="${nvmedev}n1" --size=1g \
+	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size=1g \
 		--group_reporting --ramp_time=5  &> /dev/null &
 	sleep 5
 
-- 
2.36.1

