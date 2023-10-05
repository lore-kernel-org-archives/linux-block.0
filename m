Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA671E92706
	for <linux-block@archiver.kernel.org>; Thu,  5 Oct 2023 15:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjJEPQa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Oct 2023 11:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjJEPPZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Oct 2023 11:15:25 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81131992
        for <linux-block@vger.kernel.org>; Thu,  5 Oct 2023 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696517017; x=1728053017;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XcAujXW4ucxGpO1rPRNmHohcn1w2B4X6WE50bbphgns=;
  b=Lu4UXDYqLfEtLuHEZHU/G0DwD5U3jQK4RWhWCSSmDIGTajALZT6YEH7q
   uHUYR4VAr2RpaBSRRzVgvpocSvUVirQVEu47lyrBBlVe+9p2gDIgeyAml
   1HHE5IdRrz1aTKvn2Hy21FAuW6MOZJv17IivRuSLFxbJHmtVRCiQF69oU
   /k0lLAMGQX6zaTlgxz7M9lgS9OQMLnyALPJ+MUgddFSqOn2BC7AGhOsvE
   ZM+HCSLx8x6cZy1F+CDZjlRZc54jGDNkJ6BFkZH7rGj8zCgsnYHu4kBy+
   ISLapHe56ldJE5ff7hND4I4wf7rZXxCNqSZv/jV8l7vr/MfqU9cajm45k
   A==;
X-CSE-ConnectionGUID: t3hwZhTHTxq5z8MyvzxCUA==
X-CSE-MsgGUID: m2RgssLqTq6o51JxGZZEDw==
X-IronPort-AV: E=Sophos;i="6.03,202,1694707200"; 
   d="scan'208";a="246053129"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2023 16:02:45 +0800
IronPort-SDR: i15wHvW37fZxDGWjrAIDmHhyJ106gUWneWkmu9+OTezxKX2ZL34bDqZ5RzkTy0I17UbZzgdxOe
 +j8t8H5HAVTjqztcPuWsAE0dbgSfrNIB3RgP5XC6a2cQbujDUz2svkd090TSmpl+UhF07RaMK2
 AEwUhBcXSnlyXSKe1UsPHadZR+Ci0dbGhg51fy2CNB2G6rjJl6vtWuD8O7itnVlATk33RK/T6J
 eNKGO5tsSp7K3xVCMnIzFWw3XdYkQMa5keRCgVXVfBTvPZud52dXpafPnjvtJ/QuyNddeXgQjB
 GGg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2023 00:09:20 -0700
IronPort-SDR: L5Cfa9o8BtXKZQ7ZfdIK2DRNEX+z3k+hfnJPVo8DBI6bwvm77IF0gigEbOrJij8Gl2TUpePJ84
 +LefZDSBBatn95fmkqZcGQ2BuIeMp/QmukxiTuEbHe41KvJOZVSHS7onC+HXPjk77Ui96lYdVj
 OP0LZ+T4DHkd1Sf0L1+YPi+ktXIWKBNoQuJfRbpy+g9g4tWkghI32Akk3x0V4+8zMPG1Yb5sZ0
 Uv2LgGYbBHtnsqSQgxqwLKE7VGRXXFJ8LtYKGZSL5XDsGNFDXslmnBsqqeaa6gMFxUFSnu5lZY
 AxY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Oct 2023 01:02:44 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/rc: fix rdma driver check
Date:   Thu,  5 Oct 2023 17:02:42 +0900
Message-ID: <20231005080242.292291-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the commit 4824ac3f5c4a ("Skip tests based on SKIP_REASON, not
return value"), blktests no longer checks return values of _have_foo
helpers. Instead, it checks if _have_foo helpers set SKIP_REASON, which
was renamed to SKIP_REASONS later, to judge test case skip. If two
_have_foo helpers are chained with ||, the skip check does not work as
expected since one of the helper may set SKIP_REASONS even when the
other does not set. Such chain with || is done in _nvme_requires() to
check rdma drivers.

To fix the check, do not chain the helper functions with || operator.
Instead, refer $use_rxe to call only the required function.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1ec9eb6..bac2db7 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -44,7 +44,11 @@ _nvme_requires() {
 		_have_driver nvmet-rdma
 		_have_configfs
 		_have_program rdma
-		_have_driver rdma_rxe || _have_driver siw
+		if [ -n "$use_rxe" ]; then
+			_have_driver rdma_rxe
+		else
+			_have_driver siw
+		fi
 		;;
 	fc)
 		_have_driver nvme-fc
-- 
2.41.0

