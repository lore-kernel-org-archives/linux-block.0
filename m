Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4842C41513
	for <linux-block@archiver.kernel.org>; Thu, 12 Oct 2023 02:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjJLCMG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Oct 2023 22:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjJLCME (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 22:12:04 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B47B6
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 19:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697076722; x=1728612722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W2EAhHNi2XIUk7YopdZRhwdUiav0UH6yaUvRGqcZzWg=;
  b=OjHkY2/hyzF/FhSjWapf10l6z/MphwsvL2QS+AXvdUbWqYEeQ444xI6h
   5ARUQmVSlT2NvL9KUCJefhdiL9nO5lqBbGEsWVSuBhZDyQpFmCx1jlYR1
   gXI3mxBAJBQTZLAUKVw7HhTQxj1Op0YmAM4eJPB5bFI2bishmN9rSBdNz
   ZBHmTJukBKzvZExXOvZBNMFzXYq7NG44boLnV8jAwseifvqFXZqTplFCh
   YHZ4Ui9OtgnXfYGdFoqB5B3Kp5OxNHkUMqhSdOPz/GDh1cmZx2Ezx3JTD
   5kT2vx3hdNIo5wH37rRSUiEtyxYeliKmCgXelTDZVdi2GImZxkXAQxEnW
   w==;
X-CSE-ConnectionGUID: mUleecLbTaGUNI3rOm7n6Q==
X-CSE-MsgGUID: LxL/lkqkSx+5+/YeQ1sxGg==
X-IronPort-AV: E=Sophos;i="6.03,217,1694707200"; 
   d="scan'208";a="250798293"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2023 10:11:57 +0800
IronPort-SDR: 4clBepSOZWXHJcZM9RxGhrPmiBTS+XzikxucmRXBI9rBSFerwLmtUEk+lCs3YFO24hLupirt5s
 xiLko1l1ydvRl7iyQPPoIKjqDGvJ5kKdNl9vbIQRnZoDRKk9pxY6t6xHcW5K00kknlRHOSvIS0
 T51ouJGtSIrmroc9BFpAqO+Usc5ZLPJiqdgkVOBI6KRf8+blonJlvTEE4nniLHxq5iGXCsssyz
 4ihuHZ/DzUj5qkPYNqd87w9Xf/Jp7Ixtqy8xGDq3/QuIg+AdxiwNgsKLlHxGOYacNpJkxaGtu1
 8xA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Oct 2023 18:24:04 -0700
IronPort-SDR: LIkYx0AwSZY4Wom+Sc5DqIZ85XTJb/TUaclNdO8bUyD7+qq2VLe7JMV2uvs8zoFl9pD2K6rulF
 8JlmdwZjnEfi62zrTi50AQSHPDM7E0feRHh06ry+hjXL7H/P2m+UrWkU3r2iOKsvtB3auZBqN9
 mZK4thA2B3kbRAG7G3nHqnruGUvKh1Na3sDwG/nD982KIMngjzFAXLwvTUBxpPKEC7mmnzzDOY
 vRYXDsUhMCWBdanpTPy8i0/74T0U7y8crAmEmnOrP/Q/ZzXGKJVtyXEiByv3RuHqMySuAlEAgI
 8lE=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Oct 2023 19:11:56 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <dwagner@suse.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/2] block/002: fix TMPDIR path
Date:   Thu, 12 Oct 2023 11:11:52 +0900
Message-ID: <20231012021152.832553-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012021152.832553-1-shinichiro.kawasaki@wdc.com>
References: <20231012021152.832553-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There has been a typo of TMPDIR variable. This resulted in blktrace
files created at unexpected place. Fix the typo.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/002 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/block/002 b/tests/block/002
index ee8b0bc..65b0fbd 100755
--- a/tests/block/002
+++ b/tests/block/002
@@ -23,7 +23,7 @@ test() {
 		return 1
 	fi
 
-	blktrace -D "$TMP_DIR" "/dev/${SCSI_DEBUG_DEVICES[0]}" >"$FULL" 2>&1 &
+	blktrace -D "$TMPDIR" "/dev/${SCSI_DEBUG_DEVICES[0]}" >"$FULL" 2>&1 &
 	sleep 0.5
 	echo 1 > "/sys/block/${SCSI_DEBUG_DEVICES[0]}/device/delete"
 	{ kill $!; wait; } >/dev/null 2>/dev/null
-- 
2.41.0

