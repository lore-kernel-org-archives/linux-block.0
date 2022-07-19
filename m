Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A53C43334
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 03:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiGSDxd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 23:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbiGSDxd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 23:53:33 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E958205F2
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 20:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658202812; x=1689738812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xsVAJxoRZxxVCFy5C7Du/OCU7ofeOrRv7EkuR8/0cF8=;
  b=I3zDdJoxvYGqydUbo2ftp1z/qxd/p2/IPHUPqcDM5V7OeGX4Vyn3pvzy
   HLoTkFTsodZ/CbznmevgvLC4ZcnG1yqlQTqAsZjXp4KEcsm1IbgfOgX7S
   kSHd138azq0X+3chiQS6FoBxmd4to2Ga7YWZ+7Q3bW4RDQg8y5aeKX+HR
   zOHQqeHf7HDgkTZt1zCSlrPHrQNEau1eaCjEQG4GKdRnZwj5GnMsjfvJf
   SJQgnPttu8hU17Q9sLDhlxXzsixMM0BvprQeXQSpWgLgttuHWnUbKpWRF
   +XksPkks6kp4XOoKCTjxvgbNo5s0Y6ZTj6nlCQqsStogBqTF4+47Nupo5
   A==;
X-IronPort-AV: E=Sophos;i="5.92,282,1650902400"; 
   d="scan'208";a="206905833"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2022 11:10:37 +0800
IronPort-SDR: 86UpkK+ud62OlZyNIapK3HOlwij4anZFBma4R4ByUKr7Z+/P4C+GdoZ3xZh7dgqdTBHD6W/8LP
 vnr8v9eWLfV1T7R/SK2JcOKFmZqFClrNdBcu5eGnoigvqNf2nOaZ6EiWnsaCiFlWJS1Kg4/gdB
 Qy/MDI2Nwo/hVYeqItXpm/cpSSyIJn2261Y9Gam1qmd/mXFuadtxezfBk4V66j3nJ99Il/v1WZ
 1sErXZ+fThaK61cQUhs+Lh2njA0bwcviymHC0vHKg9S8ApV4yCdNopR6P1QDPYR/Ksod5NNT/h
 sZswLf/qDRtQfMk8KlEzm7f7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2022 19:27:21 -0700
IronPort-SDR: jj5jYkvSOwwid5c3y2p5jEQpR4gamTcFpbn0sMIIw0BnE3nAxR7qI3oNcDsh6EsnIwsjLoxJHk
 9B/XW3lIvVyZGn9/LtMspZ0iCyhedICgHZwyeyVNDDzTogvsoRrOFpXsfPLcp7ok26cXGBj0aL
 wpzyvgzgM9+6G0/aicz49U/K97L1D1csP0mbIw/G0L3QXRAIkkJKMCHtdbMQqLX3tVGibjjCwU
 vx2G2/ccBFDRWb3XdzBJGKFSyxn+yfSlzfhaRwvVRR4F5zKNVj1cjGHXTEUud9ROmdIfITyjWH
 mrc=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jul 2022 20:10:37 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] new: fix test case addition to new test group
Date:   Tue, 19 Jul 2022 12:10:36 +0900
Message-Id: <20220719031036.1395823-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The "new" script adds script files for a new test case to the specified
test group. However, this file addition fails when the user specifies
non-existing new test group name as the target test group. The failure
happens because the "new" script assumes the target test group directory
has at least one test case, but this is not true when a new group is
created. Fix this by checking the existence of the test cases in the
target test group.

Fixes: b1e29e775872 ("Create test name from most recently used test number")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 new | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/new b/new
index 8f63831..e8ee5a0 100755
--- a/new
+++ b/new
@@ -98,10 +98,13 @@ EOF
 	echo "Created tests/${group}/rc"
 fi
 
+seq=0
 for test in tests/"$group"/+([0-9]); do
-	:
+	if [[ -e $test ]]; then
+		seq=${test##tests/"${group}"/+(0)}
+	fi
 done
-seq=${test##tests/"${group}"/+(0)}
+
 test_name="${group}/$(printf "%03d" $((seq + 1)))"
 
 cat << EOF > "tests/${test_name}"
-- 
2.36.1

