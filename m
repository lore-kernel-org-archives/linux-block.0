Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CECBC433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 01:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241645AbiC3BeE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241652AbiC3BeD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 21:34:03 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E121717AB
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 18:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648603939; x=1680139939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EszxiDgHYnH7YwyJ/BX+MIYqC4XsD+CrlqTw634rB8U=;
  b=TXrBb9flvXKT5y0h9XlMSusA2t/bMQAyULJz1ozWLz6UgB1Pk83kWfav
   jg8/O9zYRFHXyCboMt7hw8T9XxpUwWwSqkMhFDpxGhgAWWrqEwteccfnQ
   4Drq4WzGb51J4FnMb6TGpiGejKrSPPpqDyq6KRsXkJzFYESMVb/Zf4gW3
   /X0ycKen6zG8Qzf8mldItvWg5d/02E4FLTC1pLZxhMrUbTqqT7rXxdrDd
   fOsvISm4ba3CI6fatGx1A1tOXNtocfTjk/GtstWOttbs/As0LwdbuTxr/
   i2c7p0KCA8WbPtumJ1m7ks2g7xvwo9+55bVnEMAdevy6tyen4qdrSvx4F
   g==;
X-IronPort-AV: E=Sophos;i="5.90,221,1643644800"; 
   d="scan'208";a="201439149"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2022 09:32:18 +0800
IronPort-SDR: jLwZJ2AA0zx1JUQuuR253Msox1S9vV83DKUF7C9kUqbGwsL72NYgwOe/mvb/5CK8GCDXlqVmG/
 mZStDnpStOui2j77bRG55CW6UpKeLh8c+4zaRmIvogZAQEbx7BuvyRy6+CexRrf3CKWgsQIvbZ
 DW1IYw+tgcy0QA4MdE/joWkY3ln+GkGdRO1B86pSz90b7bqcXJgVwOCfcU3INoVLiJic3TR1aL
 e/25SZugxshZjKc2poz9zisHYpHyd51l9iosgGPr7PoDEp1/hWOn5QFIfmj2VGOw32gq45Pwp9
 t2GMYCAmO07Y/Ur5afa66pkX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 18:03:10 -0700
IronPort-SDR: TaltYC6Bmpu6SXysYiqCGQNUu1Ehv7TxfWx/uWgkz9nX7NrofFWZ+zV6MtrGNL9lwvPImRvjGG
 3ziHtjz69Ut4wqlHusNekyzjrskd99QzQYLjwzHG8G1TDITcMGlZ6MaUCj0cYcdaTxdg88V0pA
 sLsIer/1/Ei0YjY5GT2dEyezSyYVfccOhYBEjjKvgJ7lyybocLrCdNU9/OEha+19Cvxz6KDitY
 ThdMSshLg20t8CTNSB5NZLTiGXQ63JXLBoXJCGeZxt/20M+O+g3xCYjzTw2HHSvnUWGLdr0CsD
 BBs=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Mar 2022 18:32:19 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/6] common/scsi_debug: prepare scsi_debug in zoned mode
Date:   Wed, 30 Mar 2022 10:32:11 +0900
Message-Id: <20220330013215.463555-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
References: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To allow running tests using scsi_debug device with the zoned mode
disabled (current setup) as well as enabled, modify the _init_scsi_debug
helper function. When RUN_FOR_ZONED is set, specify zbc=host-managed
parameter to scsi_debug module so that the scsi_debug devices are
prepared in zoned mode.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/scsi_debug | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/common/scsi_debug b/common/scsi_debug
index b48cdc9..95da14e 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -9,7 +9,16 @@ _have_scsi_debug() {
 }
 
 _init_scsi_debug() {
-	if ! modprobe -r scsi_debug || ! modprobe scsi_debug "$@"; then
+	local -a args=("$@")
+
+	if (( RUN_FOR_ZONED )); then
+		if ! _have_module_param scsi_debug zbc; then
+			return
+		fi
+		args+=(zbc=host-managed zone_nr_conv=0)
+	fi
+
+	if ! modprobe -r scsi_debug || ! modprobe scsi_debug "${args[@]}"; then
 		return 1
 	fi
 
-- 
2.34.1

