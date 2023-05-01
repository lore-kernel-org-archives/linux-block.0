Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856AFC77B61
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 04:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEAEOU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 00:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjEAEOT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 00:14:19 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC37114
        for <linux-block@vger.kernel.org>; Sun, 30 Apr 2023 21:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682914458; x=1714450458;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qJ8kwYckhDRiAu520jEl8W0i23Lw5ccrxfMXTPvnxL4=;
  b=rWyd9eG6cpVzGq1cOEURnEXyMeL5t/SeeSuVrx53SRNhEYrOSksR7qza
   scUqA+ZF62V081DVMnFUBEa7dqyedIbsyRXZaXG7U4tS/6PJtqBfI9pE0
   lCD1XA0pdnwC7+TTIGRIJ/Hri8Chtcwu/TREzhFnN0P3sTjtqg1sPvYR+
   aEdzSbdLETViAQUEFK6xKnNUN+QKi+U/I4ZlzQkUy2YSEd6Ff+KvewKvV
   tDEfBeH6qDyuP4LzIihPzEv0QrHuaCdlFqu6bhKADftR0ODDqm3K5puT8
   iLMED0KV142+xmuL7spihHGvnGvCaJ4KMl3ZK2A01BxiQG3ud2rtY+pDw
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,239,1677513600"; 
   d="scan'208";a="334048226"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2023 12:14:17 +0800
IronPort-SDR: CC2P7MGIIbUfdg/6O1lQl9DUnARTyBsqPao8il5HTyUMN9Cgx6O9SLKSN5j1a1sCQWhoAUILAQ
 idKcFiG57F5s//5+4lRnZkyRZUwHSWAIGGmTmQgm4DexrADgrV/Dz2/QqcoTEEH1BRCCuNTx5Z
 6cnwITOYDNL7+/MqzfIofiSVK7UT6KJ4yP4Ho2ptYVwQ9ogZHCt1CLJmuqr8auuyAZjwNbPIiq
 Bjc5Sfqp9MfyfoMffnVutXIvOaAVxCqsIvDiQF6SR5XCjRM3t4rFI7hLaoxaTmD+SX/2NjLOLS
 +Ps=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Apr 2023 20:29:46 -0700
IronPort-SDR: xd3PU6XnvlgV//5LuVFZd9D1IoT0Nv22fW4KFNvnGeJYCFUyABFlXETxqZRFFvfEL8I6RIa0K7
 CcWLT0WTIKSfNAQ+ct4MK5o1bXl3DscOXYyEpkOGfoCSf50/rjbeQe132lGBcNCznzF6SWRZsb
 gNAgo18e7CRsCiZ9Vit0fZjmPwsFe9ov0p6oYU8gNrigo0gu2MblIZaIPKI6vtLA+r0jScVFCV
 u1ot0OARBac3TlninW2OKn1wiyPRRhtce2v2yBmw23Q9NJ856djQDUiD/BNSRV3vOU/4uFBrHK
 Dn4=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.189])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2023 21:14:15 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] common/rc: fix kernel version parse failure
Date:   Mon,  1 May 2023 13:14:15 +0900
Message-Id: <20230501041415.49939-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When kernel version numbers have postfix letters, _have_fio_ver fail to
parse the version. For example, uname -r returns "6.3.0+", it handles
"0+" as a number and fails to parse. Fix it by dropping all letters
other than numbers or period.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index af4c0b1..525867c 100644
--- a/common/rc
+++ b/common/rc
@@ -207,7 +207,7 @@ _have_kernel_option() {
 _have_kver() {
 	local d=$1 e=$2 f=$3
 
-	IFS='.' read -r a b c < <(uname -r | sed 's/-.*//')
+	IFS='.' read -r a b c < <(uname -r | sed 's/-.*//' | sed 's/[^.0-9]//')
 	if [ $((a * 65536 + b * 256 + c)) -lt $((d * 65536 + e * 256 + f)) ];
 	then
 		SKIP_REASONS+=("Kernel version too old")
-- 
2.40.0

