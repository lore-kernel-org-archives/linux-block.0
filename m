Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E5AE743D5
	for <linux-block@archiver.kernel.org>; Fri, 29 Sep 2023 01:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjI2BQp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Sep 2023 21:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjI2BQo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Sep 2023 21:16:44 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98310B4
        for <linux-block@vger.kernel.org>; Thu, 28 Sep 2023 18:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695950202; x=1727486202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=whBOzBz+yGWkg3THf0EQZbZgwka0BFqnT8nloooG0dw=;
  b=jPU2ZAR5PxQH9lPFxAtvLq6IplTyRzbwSxUY+3qF2R6J4JJOqdKuMCEf
   Rf04zjrFwRcMAs4tvE/39VGjBa2UTKCu74K6LDVrA2q+J8rrFZrZDrkuE
   uAmziDnaKqmE5n3giKgPGcVt82jMjesd2Cgn8DY84lZ9wPllXtBfEZpNO
   vk4AKGFRdYWUF7RWKSQ7WZI6hYaXy0YWhhWJKPQuVtcF38QVe5iEsRGLv
   mUmPHwyMolQcfCZCTob+J1Ln2/IKeKrNmrlKpok4SStDc14sALesNG0R+
   ss/lwwoaOQxOiqrPvI3B0GLReJl4Ujx9lECLW5teTiFqerYTgY8rvmAe2
   g==;
X-CSE-ConnectionGUID: 2/d1LTNQSDqyoNGZmohaCw==
X-CSE-MsgGUID: zredFBEtQVKGw66rAPmmrg==
X-IronPort-AV: E=Sophos;i="6.03,185,1694707200"; 
   d="scan'208";a="357351485"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2023 09:16:42 +0800
IronPort-SDR: P0WlGT1SqMwYlQavsEjAj+hsw4tAMPcE7NXRNlTOxzbsT2a+wFeP5ju5hMeVTFwQJONmIEVL2k
 L86jE/KpoSXLQx/PhacfWO7J7nXCIwZjbIkW5oXuwIenMg9yJ1vCJxfpOqKz+tSMTp/woN4yJH
 0jZHy0/VHv3gvabcTCs0Bkt+m/kGM7G//X7M27GKO5y87RAwPFD1pDEeJm2gIpko0k7/Iojx1e
 GPlOnUmGCsiErtzhvJ3U4QoT6zK+509EEvEzutAdZ5nV6MrtdNebi3yXackihwdg3bkZeuEftB
 0FI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2023 17:29:06 -0700
IronPort-SDR: MYAlexYW2EJXMX0lItD8gNt8QO+AbU6KOuZU5j9qdL3vOCAsBhdtVA8AmH+5XaH7dEX0Fl8MFx
 mRg34mgSjkwTrilKc08WqssGG82Oe8r6ZFYB5TGt3ocxz2cQC7fCe/Yuh7BiMDv7MPdvB6vJrv
 Et2hqnul1LMpEulte+SwrhL6ltf+k4wG3tdl6GUwr7LnijGLcZsQJC28QdyNbfjGaIAGz4bvrO
 WEcWmW1xExIsEi3foXGrPw7ldqAIXBImJP/d9QZ5VWHs2buN3144HuZZFMiFyQow1z6FfOG3PA
 SAo=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Sep 2023 18:16:41 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Sun Ke <sunke32@huawei.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nbd/004: avoid left connection
Date:   Fri, 29 Sep 2023 10:16:40 +0900
Message-ID: <20230929011640.3847109-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case nbd/004 disconnects /dev/nbd0 in most cases, but sometimes
leaves it in connected status. The test case stops the nbd server then
/dev/nbd0 does not work even when it is in connected status. This makes
"udevadm settle" command to wait for nbd udev events infinitely and
causes failures of following test cases.

There are two causes of the left connection. The first cause is left
nbd-client process. The test case waits for completion of its child
process connect_and_disconnect. However, it does not wait for completion
of nbd-client process that connect_and_disconnect spawns. After the test
case end, the left nbd-client process establishes the connection of
/dev/nbd0. The second cause is missing disconnect operation. The
connect_and_disconnect process repeats _netlink_connect and
_netlink_disconnect. When this process is killed after _netlink_connect
and before _netlink_disconnect, the connected status is left.

To avoid the left connection, wait for nbd-client process completion
and call _netlink_disconnect at the test case end.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nbd/004 | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/nbd/004 b/tests/nbd/004
index deb9673..1758859 100755
--- a/tests/nbd/004
+++ b/tests/nbd/004
@@ -31,6 +31,8 @@ connect_and_disconnect() {
 test() {
 	echo "Running ${TEST_NAME}"
 
+	local pid1 pid2 i=0
+
 	_start_nbd_server_netlink
 
 	module_load_and_unload &
@@ -53,6 +55,18 @@ test() {
 			echo "Fail"
 	fi
 
+	# Ensure nbd-client completion and clean up left connection
+	# shellcheck disable=SC2009
+	while ps | grep -qe nbd-client; do
+		sleep .5
+		if ((i == 10)); then
+			echo "nbd-client process is left"
+			break
+		fi
+		i=$((i + 1))
+	done
+	_netlink_disconnect
+
 	echo "Test complete"
 }
 
-- 
2.41.0

