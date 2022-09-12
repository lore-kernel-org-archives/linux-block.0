Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD395ECAAA1
	for <linux-block@archiver.kernel.org>; Mon, 12 Sep 2022 05:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiILFqK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Sep 2022 01:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiILFqJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Sep 2022 01:46:09 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C781CB00
        for <linux-block@vger.kernel.org>; Sun, 11 Sep 2022 22:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662961563; x=1694497563;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XpPy4bTOe2MsRyBsKXzx6AeMXQTRzfO8zyfgvbfOt44=;
  b=CQVpC+k5eB8ooGSNM9JReZ3U8JueT9zq4Kq/X4sx3ecM3d95lJTYfT2x
   qrE2tV56zVu6fVpcRFzZkgUEUHE2Ucyotr2ZOF6s3UH9gMERFGJkomkKJ
   NJuwokt1TBgluy3R/jRQIZpM1hQ0dvxgF3TUWaoc7YvkrZMjTx16l7LK3
   kDM3pvkxQrYWTOjlqVqqb9eEC0P47+MlnlAKXfEq562bnfvdwGqvYNQKH
   1F42Fcw5HJt+Ou60cSuD90uRipCSLDAx4JiQcxP2oZK8uc/C8AHZHboPO
   b8t9BxLhzHRDCpjdHoQMEAHCOHw/+JQra53jmL1TkJBl4EkC/xsUiUef2
   g==;
X-IronPort-AV: E=Sophos;i="5.93,308,1654531200"; 
   d="scan'208";a="209505681"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2022 13:46:02 +0800
IronPort-SDR: PZ6OT9NER5BBX0qWjzHpDFPgCTc+6IVrcQ6Xx5FNur2/1sqYW0Y9GOuz1n32yUn7X9nkb87ECh
 OWyIYHdtZqYcKvltravydc2AKvpH2r4uD+RmsNPy2YNU4JLWjoYiWs3Fy2szDzlfdKdju9Kpd1
 NdPkjYHTsjm69pQdReIFsUS7wt1Gb+OyvO2fEseiok48S/BLAaxBlR1aULbmgDuIdZERzrBSa8
 +ZUAKGYPnahKdkan2qURk7KVEPcigpGHBVDuZG/eZVevUgrsx8eb36DhNra7mDacijUHaAbyAv
 UPoMoN3Oy9JnFXMYvsAepU6D
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2022 22:06:18 -0700
IronPort-SDR: 0LP4e5T152G4LPzN7rTcREWumfNt9Q7/aqLSLSMY1IBj0fCp46pZ3OMdJeHaeVYEEU8P4t1h1G
 3nim3UkOVQdYy19chZhvN6Sh9SMEFas/sw2AqvKPTbhM2p9N8/4lsK3j/QVk1z+26NRr+pFcrX
 strV4TjX/YUo38A6UjzbLiIJ9Lb0S7AO4/1BhVgl20u+lARbazxRld/KUl1chIaDUwoK2o//d7
 E66Lh6Im5gOBPAEfL7vob63FaGoisFyOx2JUIoqI/uyvoEhEBr1XhjMa4od/tKkyF5hnEzIRqt
 BRo=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Sep 2022 22:46:02 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] common/rc: support compressed module files
Date:   Mon, 12 Sep 2022 14:46:00 +0900
Message-Id: <20220912054600.310858-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit 8017ea524367 ("common/rc: ensure modules are loadable in
_have_modules()") introduced a helper function _module_file_exists()
which assumes module files have extension ".ko". However, the assumption
is not true when module files are compressed. In this case, extensions
of modules files have abbreviations of compression algorithm such as
".ko.xz",".ko.gz" or ".ko.zstd". This results in module file existence
check failure and unexpected test skips.

Fix this by changing module file search condition to cover module file
extensions with the compression algorithm abbreviations.

Fixes: 8017ea524367 ("common/rc: ensure modules are loadable in _have_modules()")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://github.com/osandov/blktests/issues/101
---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index a764b57..e490041 100644
--- a/common/rc
+++ b/common/rc
@@ -36,8 +36,8 @@ _module_file_exists()
 	local -i count
 
 	libpath="/lib/modules/$(uname -r)/kernel"
-	count=$(find "$libpath" -name "$ko_underscore" -o \
-		     -name "$ko_hyphen" | wc -l)
+	count=$(find "$libpath" -name "$ko_underscore*" -o \
+		     -name "$ko_hyphen*" | wc -l)
 	((count)) && return 0
 	return 1
 }
-- 
2.37.1

