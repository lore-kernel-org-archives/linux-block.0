Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1698BC433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 01:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbiC3BeM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241652AbiC3BeI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 21:34:08 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC28A1717AD
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 18:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648603943; x=1680139943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XAzmX4xniyZx8Scc22JYtqeWDtZGs52+W/w6pzMtJjA=;
  b=JmsT9qEXrsllnl1nwNIc6M4OuRE58xF9OFYtB5iwEOVqmUJUhR8YfrtO
   k9U8TS7n4hPq/h8y1onrxGMJyFSiTPTAXcYZX6azoCzoFgT4lqI+yCvKp
   q6xWyb44hu+up2YQeOSDlkVjU8jV2sXQXYUPVEj8HMjNWMi4tMueQd9n2
   Js2UJRkTAqWwB+efEQ/QVzTpJ76V/dnWosoa7JWr0F8A0Akg2Lg9N15z7
   YQItCQMYzQ2j03QR7CahACCCOIsykiuhebpCRY9J50BZibjhqWYD2Y8aE
   EGH9ec4OMKf0D/clbUBLKPi9JTI3rHJtLmrgPzsl5fmqzkHlEfAUFJSxW
   g==;
X-IronPort-AV: E=Sophos;i="5.90,221,1643644800"; 
   d="scan'208";a="201439171"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2022 09:32:23 +0800
IronPort-SDR: jbVjcVDvc9l4JHJoK9y5wahzSqFAbD7LjAnHwTOje5bYMNWrb9ZMsU70KP7by1Xx9Bxit0ZmLO
 lX8cbFrNp+WObJvGc7Tx2t9sZVAobW6RswHVZtcnCB0vPm9Tf4UO0BPW4vWh3kTIVup/HeXvuu
 j+jijlYvrHJnNVq91uod/VaSkC3nMmsE0rFEjqMXGUmOWDSIKr3K7SinkbrhOTwiCHJMz8Xf//
 QieeGErzQks0R+GWkSaWuz5jy0rJ013pQIrbVk9MRhK1yIxCwXiLxtJIZJ/wUC8GLnppmX9axW
 8zG9rnrTDW+HkJz3eSzpFfFN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 18:03:15 -0700
IronPort-SDR: 5awH9RbjSLkzsVt9+zFO5Hbq7elEwwei6cX1c5WvrXPq31lxslCiQU0ZuUQP4Kab9Ysv12Q4TL
 ovukr5RqvLHSxwn/fNI7Eel7v1y+ub/WguooKxr1XUqrTNOQFS7dUpSkr7Pr9hS9+uEdFGOigQ
 lzB8yYGIhyc4LnSoNJsFFK9w7/ErXMxCd3I9DLHnGjG8uG2vhR//z1PBo6IPI0olE61mbZfvGK
 2oGhAhsoSnnYk9i0iSU/iy5xpMea6FwBn+hUoTiR/Qw3USPEIi7CO9Cg3Ina7nnIkwprNGFZVU
 Gts=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Mar 2022 18:32:23 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 6/6] scsi/003: remove unnecessary out file
Date:   Wed, 30 Mar 2022 10:32:15 +0900
Message-Id: <20220330013215.463555-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
References: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case scsi/003 was removed with the commit 5e803ca0ae99 ("Remove
partition rereading tests for reverted fixes"), but its out file was
left. Remove it.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/scsi/003.out | 7 -------
 1 file changed, 7 deletions(-)
 delete mode 100644 tests/scsi/003.out

diff --git a/tests/scsi/003.out b/tests/scsi/003.out
deleted file mode 100644
index b9c2450..0000000
--- a/tests/scsi/003.out
+++ /dev/null
@@ -1,7 +0,0 @@
-Running scsi/003
-1
-1
-Operation not permitted
-0
-0
-Test complete
-- 
2.34.1

