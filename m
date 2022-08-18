Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A879C32771
	for <linux-block@archiver.kernel.org>; Thu, 18 Aug 2022 01:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiHRB03 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Aug 2022 21:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242571AbiHRB02 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Aug 2022 21:26:28 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BADA1D00
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 18:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660785987; x=1692321987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hHWcbUOR/4p2YcGBqG8IYm6E/IJGBYbUG1/LuV/jTHg=;
  b=rw9JjhuB6kpfrLk5MDroXFFqDLKjvOjc4Vd40CMtH+t6l05vHbYeTqKY
   3E36dTYMu0I6P9VyJG/BExfmqHonarZpjIPDOaDu6P7JKbUdEnzsoHj/J
   rehc+d4I07cW7zT2lFX+VRuITWALHeMHiFsA8Rw4/pmxUduX2vBZ/thwn
   tUAIA6AMeBtlGJWDgPi9oHCIZv/NTAfs+sS3AmC00SDcf9ZBVKtJwXNaB
   zmj0QCE3DkQ7GzNV0bjhYHV5x4lPTnzW56aN7kLANBthPdx6eICS0DRc6
   Nxpxf7YzUELD5lqOWpe1e4rt77cia91v24ERV5RnFNLWxPzkgYl6e12+q
   A==;
X-IronPort-AV: E=Sophos;i="5.93,244,1654531200"; 
   d="scan'208";a="321085638"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2022 09:26:27 +0800
IronPort-SDR: G4pj9Ch2cNiA/zxT5v/dSe0bHn/Em5urpfMAg06Hupz8OM3n9j6YR+UEJSWY1DLqovc6bBraCQ
 bL4lmk58Nc6njfuATvDVzM60MJsZn7AMu5vTYt+idr5WKHopWqzS2NeIlVhdZKtFIs/u9CYcP3
 EWJ7hA9g2DeVB/WGH1BzfoB7jfCx1uxylGfQhtyJ+75qhHFgqpDQcOHcqZ340RXV/JbJKE/BuJ
 bFpqZmco+gLHOeUTBKN2pp7Fxq8zNEO9Wwe2a9uZx5SFqcAVwWlQqxA4V2NvNdhYO+O8V0FJV/
 pLNQm3bPSBw0CuPY0rxpHZLk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 17:41:54 -0700
IronPort-SDR: s7z9nYVDic+XBz7eElNs25jCbloUMbvid7gft4NyVd1wrrsd6QXnFIuVWRBicHvvdKUGAE5pC7
 gCP54tXcXWB07mp0VyyO2jWhL3bhUly4TvHXaqc5qdm9RklyKxwpOmsXIiS68bRX1pA9KdCQg2
 wwDgRyAiRf2UhfuuApqT0pWnb86yxY9m07TVxMaS20gVqK2Sl9N+A+7JxljuXvWiDLqsLHU2FI
 /lbxKkgwN+Y6IrZzAHxWINRWw/4dh7b2JAOQctYJVGbX1fIxgM5MeIGFlpLWky1oZuTdttbXKH
 2WU=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Aug 2022 18:26:27 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 1/6] common/rc: avoid module load in _have_driver()
Date:   Thu, 18 Aug 2022 10:26:19 +0900
Message-Id: <20220818012624.71544-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
References: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The helper function _have_driver() checks availability of the specified
driver, or module, regardless whether it is loadable or not. When the
driver is loadable, it loads the module for checking, but does not
unload it. This makes following test cases fail.

Such failure happens when nvmeof-mp test group is executed after nvme
test group with tcp transport. _have_driver() for tcp transport loads
nvmet and nvmet-tcp modules. nvmeof-mp test group tries to unload the
nvmet module but it fails because of dependency to the nvmet-tcp module.

To avoid the failure, do not load module in _have_driver() using -n
dry run option of the modprobe command. While at it, fix a minor problem
of modname '-' replacement. Currently, only the first '-' in modname is
replaced with '_'. Replace all '-'s.

Fixes: e9645877fbf0 ("common: add a helper if a driver is available")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 common/rc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 01df6fa..8150fee 100644
--- a/common/rc
+++ b/common/rc
@@ -30,9 +30,10 @@ _have_root() {
 
 _have_driver()
 {
-	local modname="${1/-/_}"
+	local modname="${1//-/_}"
 
-	if [ ! -d "/sys/module/${modname}" ] && ! modprobe -q "${modname}"; then
+	if [[ ! -d "/sys/module/${modname}" ]] &&
+		   ! modprobe -qn "${modname}"; then
 		SKIP_REASONS+=("driver ${modname} is not available")
 		return 1
 	fi
-- 
2.37.1

