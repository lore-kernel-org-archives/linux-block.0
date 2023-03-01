Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50930C64ED6
	for <linux-block@archiver.kernel.org>; Wed,  1 Mar 2023 08:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCAIDF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Mar 2023 03:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCAIDE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Mar 2023 03:03:04 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2FDCDC7
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 00:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677657783; x=1709193783;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MBP9UTpwWocVFbAb9+tOcgrRCm0YXmIo8PdZRPkJTyY=;
  b=Ev+Du2/tBKE8nl2VhOvBAgnFrKQ07TCzVoUcrNotiAGSWRb8q1VPu/ys
   VOBmADS8laFMVV5JETkwpuPQ8OEMttjI2Pku/Cu+nT+JjU3mBu++AMy/j
   Aj5dPcLYY/Jv1dX8SxNjRolBWGfv65pyjln0VoylzNkuDelOLbsDv2KYk
   MG/iQNTgPi4CGKT1ElYa8laC+ux6B6ioVnXN0xgGKnHgyGgxuSepGfVRv
   ZBBeHviOj97GEwnxnO1PoK41u7LPVZ66g3X+QF93s8pNV21ueKkItOj8R
   /VFV/VBqG/rXwJ/H6/8EiLS/IeNKDnu5JD2yBFXA2+QhYJ5+5JktRdfLn
   g==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673884800"; 
   d="scan'208";a="222792413"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2023 16:03:02 +0800
IronPort-SDR: S6qVtIauY8QAKyrG/lGUZVlIG/gndeswxC2M67pHuVmvK9tpqCxAgyp1XvfScy+0ZKIFJJ8UJM
 hwfM4M6JTTWXZBxpGwooBKeIzi2LmklNVt9YxNmkx6XnhoHRr3YhmlhDpHGeAp8ziCSTX80Wsl
 DBRZkTcU5Q+nh8uS+LCcSipBrrJG7r+jGvERli/shr8r7gUX2ZqykAoMyOg2MmB0/C37IpvM66
 YdyjRC8xSfaBragZ7nLcUf7I6VI/8TbIZ+UOwAMbaQDd24LWeiX3nWj5353pISRVIoK33n5cq4
 YMA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2023 23:19:52 -0800
IronPort-SDR: 7FurnNHebozrL82CJX15P0DUP71yO0t7bfCdKp+7/1AbdH0rY2AkrIMsoEd/NjOW+8Sw5XXlZN
 TtNd/wEer/U/Y4JTT2jLwkTWq8vjnWD1JXm/DaJrVsaS3w9X/XG8WzqI3kczPI0m3TZRPDXs1t
 FkhNU0Ux7ejD+IKG022IgQ1wqCyHs5VG7KnwazofB6xfPBAky4iONFQ/5xQKOCnC2Zd3NU0NQh
 D7edW0sqYoo+IFpGogOyrFHCh6/JXzsxGBeZUls44hiHxVdwBhL2tQ+YXuwzIeC6/jyqUZmwtS
 5xc=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Mar 2023 00:03:02 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] src/Makefile: fix number sign handling in macro
Date:   Wed,  1 Mar 2023 17:03:01 +0900
Message-Id: <20230301080301.2410060-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

GNU make version 4.3 introduced a backward-incompatible change. The
number sign '#' now should not have preceding backslash in a macro [1].
To make macros with number signs work regardless of make versions,
assign the number sign to a variable.

[1] https://lwn.net/Articles/810071/

Reported-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Link: https://lore.kernel.org/linux-block/cfccc895-5a9b-f45b-5851-74c94219d743@linux.alibaba.com/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
This patch can be applied on top of Ming Lei's series for miniublk [2].

[2] https://lore.kernel.org/linux-block/20230224124502.1720278-1-ming.lei@redhat.com/

 src/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index 81c6541..cbb0b25 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -1,8 +1,10 @@
-HAVE_C_HEADER = $(shell if echo "\#include <$(1)>" |		\
+H := \#
+
+HAVE_C_HEADER = $(shell if echo "$(H)include <$(1)>" |		\
 		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
 		else echo "$(3)"; fi)
 
-HAVE_C_MACRO = $(shell if echo "#include <$(1)>" |	\
+HAVE_C_MACRO = $(shell if echo "$(H)include <$(1)>" |	\
 		$(CC) -E - 2>&1 /dev/null | grep $(2) > /dev/null 2>&1; \
 		then echo 1;else echo 0; fi)
 
-- 
2.38.1

