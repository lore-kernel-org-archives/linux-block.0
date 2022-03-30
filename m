Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCE4C433F5
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 01:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbiC3BeH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241653AbiC3BeF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 21:34:05 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4908B1717AB
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 18:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648603940; x=1680139940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4u3x3WEZDAD7nrSRLb+xiUKSPA5GHnKsjf85y8UlC+Y=;
  b=VDwy83CRfilQ9rW8lursIMdMzeDeyOAJBPpzR2q+ZI1a9Ae1ssu+5KKe
   LOOl9sUNmlXr+XLaJ2is0pKJaSYavJK9bGAb0c6pxahit1UAuRW+Rriuu
   UusasWfe0U7UDAtY24tMu6St5UIJWiWjkLgQbfucMhibdp6exTRR1Nq3m
   iaKGb0sQtrkbgQF2W51979DOoovbCH+miBTHgqBhyg4Ret7WTqO4KCtYh
   7ThklLQPwoLK12QPcLY+4Tom1UnlfUoxXrFa7qMPUd17KcnH0Qj7yg4YK
   5+XlWeeBbpKkwzmqXXE3Ntx/qcFhRbeCZyHTGRPa2iwmpVL7QTH08SvBs
   w==;
X-IronPort-AV: E=Sophos;i="5.90,221,1643644800"; 
   d="scan'208";a="201439154"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2022 09:32:20 +0800
IronPort-SDR: ZuExiDpTcxkpUI0J24Q5lX939QuXKjuJBVSTkIFrqj17oq0P5jTAwBydIMjWMyKn0DDz9I8DyD
 J2QF+EcV2NFgqZgqu6+tjQ6VN1O0OEkfiysrorYLTl83v+xe0yQgmWlNt9yYHv21EB3r3mLRbF
 OFmK8eUXojAMfTGVklYZrjsFCfcPWxnmW+IYU+jPLhb/CtlRynUq7dLHjtiYd8tKghSUyhjtt1
 NYN8ZDUzXud5y+/24awQcEqd56bOk23Cvo3ckp1HnwcxbE4IhYFSjVJLBPSv5OvkBnbHS4jTVz
 iiRit2PmX0prctKm/x0PAmZH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 18:03:12 -0700
IronPort-SDR: VGJLJ5wcsQ5ckXajnNuJ2hIv5X5RVLQXLcz7QOgxTy7fLQ8aumTJLztIO3QwrxWDu6xKKt7xrn
 fsHhWmz8ARDy6/idNBWtBw5PNGvqh6mHdcQfSHydXxCRcKPAHXNafzP17muPu0B4UiYL6hm105
 zGzE9HnblY+bflwajqyNG4/xEnH4/SybaiQ7yaXPzE5NWWdoQxYXd+ORvckj3AP4gSqDO+sHN4
 Qc753iuA4+JaHj2CEJk5bkyUmkVrNpbcM7xYsG3QvksuZst/1Ak+fCTw01IL5d/KB3WGDWCS/h
 V2U=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Mar 2022 18:32:20 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/6] block/027, scsi/004: whitelist scsi_debug test cases for zoned mode
Date:   Wed, 30 Mar 2022 10:32:12 +0900
Message-Id: <20220330013215.463555-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
References: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Define CAN_BE_ZONED=1 in block/027 and scsi/004. These test cases can be
executed in zoned mode without problem against scsi_debug devices in
zoned mode.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/027 | 1 +
 tests/scsi/004  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/block/027 b/tests/block/027
index e818bf7..b60f62c 100755
--- a/tests/block/027
+++ b/tests/block/027
@@ -16,6 +16,7 @@
 
 DESCRIPTION="stress device hotplugging with running fio jobs and different schedulers"
 QUICK=1
+CAN_BE_ZONED=1
 
 requires() {
 	_have_cgroup2_controller io && _have_scsi_debug && _have_fio
diff --git a/tests/scsi/004 b/tests/scsi/004
index 416117a..b5ef2dd 100755
--- a/tests/scsi/004
+++ b/tests/scsi/004
@@ -15,6 +15,7 @@
 . common/scsi_debug
 
 DESCRIPTION="ensure repeated TASK SET FULL results in EIO on timing out command"
+CAN_BE_ZONED=1
 
 requires() {
 	_have_scsi_debug
-- 
2.34.1

