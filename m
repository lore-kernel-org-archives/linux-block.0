Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812BFC43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 04:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358620AbiFPEMS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240761AbiFPEMS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 00:12:18 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26AA56F9B
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 21:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655352736; x=1686888736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PqOuDjBiWDS+d6NaE8lu1Sj2MQvB9ExgCgYBBiZASVc=;
  b=iGKFyA2hGjEWTaWD5wmRzKXYymsEeQm+RkN9cyVuRmFGQS37z8w/1yKx
   pKG0nHbwm+I+UdR/nb+if1Z+nQc52r94YRsSswWuvotPhuKCa0ipyFKqk
   GloB4LPjfVCwc/O39lAE3+6LYLgvUCJ8bXnb6U3+3wUGewAt/QlhEUj6b
   rhVOKDLwow63JotMDt1lRAPP1yw6pNzOdZQZUb/bOGqPzBFW3m2ckkr74
   2bKi5Yx0tBIR84lmuPHLzL5bAPqvAJnSeIMN2kVZPrYcodmRevmho3+ig
   JIpbi3cMKy+8Hlfm7EBr+oBjj77bKi0VktNdIcEy4vxKwONxLn3/+fGdi
   A==;
X-IronPort-AV: E=Sophos;i="5.91,304,1647273600"; 
   d="scan'208";a="202000134"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 12:12:15 +0800
IronPort-SDR: xnJfb5slAEe/oMyq1kIICxALBPT8VcW7epou98qZG/egpJB/GappAXHugYOrgWbk8hMqNu0s9j
 cPnXGIraxtCP9EooUzjYoFLC9YcyLKWweCUnCqEebVA7kSmYr6qMZDd3lbFiVUbYDb4a04EtOz
 8SWXLnIewxGdQJjkNEIGZ+u9kHb8mpuudCT68WYBO3V+Y3znldUddso+EE9YqgIubwMYFbhgS9
 r5giXgFQkt3dphg9NAG6IQjD3Zunblp1aVT/FW4xXhdEORjj/16LwF/SPu6JxKdM2gJdP8oPq2
 k+7LHp7FbtyV4Ez+WEPYhrXy
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 20:34:51 -0700
IronPort-SDR: kRib+2sbZLYtDcHAxG9dmNLzye3pi7SC7TYnFfy9/1ZBkEi9x+i1uSzJCc78wREP2zK3BdtrDC
 veNjZhBfbPgc+8qRYRcC8mDCnoOCkwTnIi79DRFr2nMWo5soWGgiJOR8r8Ed09n3OdceS+/86X
 CF30kSsuCI6ft9vlGi/3z3NsUXNwaR+xN2wsmxIIbRj30YRGYeP5MAmtPrX9HLKmikYtnpp/lA
 NhDcScLskI6bhMuvMmRtar6g62qaLDf6qsgFwklA7iNfv6GR6WcWbHKchJ/ndisN19nw796gks
 jeg=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jun 2022 21:12:15 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] check: ensure to suppress job status output
Date:   Thu, 16 Jun 2022 13:12:14 +0900
Message-Id: <20220616041214.612087-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unexpected job status output by wait commands was observed on openSUSE
15.3 and it made some test cases fail. To avoid the job status output
during test case runs, ensure to turn off job control monitor in sub-
shell for test case runs.

Reported-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/linux-block/20220613151721.18664-1-jack@suse.cz/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/check b/check
index 7037d88..a0c27d9 100755
--- a/check
+++ b/check
@@ -440,6 +440,10 @@ _run_test() {
 	RUN_FOR_ZONED=0
 	FALLBACK_DEVICE=0
 
+	# Ensure job control monitor mode is off in the sub-shell for test case
+	# runs to suppress job status output.
+	set +m
+
 	# shellcheck disable=SC1090
 	. "tests/${TEST_NAME}"
 
-- 
2.36.1

