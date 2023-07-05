Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D54EB64DA
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 10:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjGEKf0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 06:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjGEKfZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 06:35:25 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F170DD
        for <linux-block@vger.kernel.org>; Wed,  5 Jul 2023 03:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688553324; x=1720089324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hRz7EOsh46CdPhiBYms1J/wAfbB6kT7JWaKY8eBnyos=;
  b=JoKHPz4gnafpwq4k0a4bNLjF8Z+kTsaUKNyGXSDnOYQbKGKdEYMeNtpz
   h+7Hls/j24ZjM5wdqgULME77s+qsZwErvvFP0thBli4uIWNlR2hFpWLSI
   5kGefY08A04fnQSw8qmh1RYdGnWvHWtZm61rVhYZCpwVu2UBAoNEiCWsE
   7bHD/2xH3tGlxI1yrUXVNO8Iq3ugr7hDOImULV5vwUxUDxg6r6msPe+z9
   Jq8XsdsR/lwXPGKmXZkUtOzuArv9FONKc4ExZ6AvwShoMB9fvYoqzL4Jy
   oz1jIOTqcHaODIEI82wyYZQ2TJvPWAksXCBNzZiTe4lnTmUC1IhCeCdAv
   g==;
X-IronPort-AV: E=Sophos;i="6.01,182,1684771200"; 
   d="scan'208";a="237577993"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2023 18:35:23 +0800
IronPort-SDR: 8YEc2GFCd/jxkSJ0rcJrsOlKrDQHtQkDeLVROeujS5cQdg2qn6bhv2+OoRUCwtcxEaEu35hM+3
 C0PahQwnsfChLKRZhv2PLBBFyExCb7GpzuFLN5DIQaZOWykhoqKPi6Jtsftrrcjk/2gEUx8vrj
 VPQlx427Dc0T/MhidcAVz2BbpLurtixao/99IdC361kGfpez024GOX5zHooFE6pXi0Qfu7ihPd
 ZpOilDM+JqAuZ2qTkpdumQ3kSawJuMEW+A4RaAvjojX6qOaLBsCGsMqs+DlnWrwsrPY9x7F4Zb
 Pe0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jul 2023 02:49:33 -0700
IronPort-SDR: 8UDBdQOThTa8TCC24AttF18Z3sRJPmwPjUsCgIyAAs3p1KZ+REkmL4QQIpTxdGczq79a6hcQAY
 4lZ2TxH9xCGF7FmQiM0VdRXE9IapNMspXXoJro8eU1n37p8iLLh6mxKKyxOgCFjyCo9qVWI0Ng
 UbcH6Ka8IXrRi77bb4zlAFUDDY2DqaoKlKMglP6Imnao2HjiorenypsRDVKvylL6X9OkFLMCU0
 dQcZeywZFbIe2ggLfEYokrmQiUOP51SrZr2QStIiwxnmwAk6WMcj+S/UhmFOe4Wvzdu/Ht3gvT
 DDQ=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Jul 2023 03:35:23 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] common/ublk: avoid modprobe failure for built-in ublk_drv
Date:   Wed,  5 Jul 2023 19:35:22 +0900
Message-Id: <20230705103522.3383196-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When ublk_drv driver is not a loadable module but a built-in module,
modprobe for the driver fails in _init_ublk. This results in unexpected
test case skips with the message "requires ublk_drv".

To not skip the test cases with built-in ublk_drv, call modprobe only
when the driver is loadable and its module file exists. Also, do not set
SKIP_REASONS to handle modprobe failure as test case failure.

Fixes: 840ccf1fc33e ("block/033: add test to cover gendisk leak")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/ublk | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/common/ublk b/common/ublk
index 198c4db..8278d56 100644
--- a/common/ublk
+++ b/common/ublk
@@ -27,8 +27,7 @@ _init_ublk() {
 	_remove_ublk_devices > /dev/null 2>&1
 
 	modprobe -rq ublk_drv
-	if ! modprobe ublk_drv; then
-		SKIP_REASONS+=("requires ublk_drv")
+	if _module_file_exists ublk_drv && ! modprobe ublk_drv; then
 		return 1
 	fi
 
-- 
2.40.1

