Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05934C001DE
	for <linux-block@archiver.kernel.org>; Fri, 28 Jul 2023 11:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbjG1LHZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jul 2023 07:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjG1LHY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jul 2023 07:07:24 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDCA2703
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 04:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690542443; x=1722078443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yCNF3JeuVZxf0ne5Pr482n//cL5sopctZx3QYJ+p9h4=;
  b=B+DcJOwj3cg6rAbX+IbzS0di12vgwjyZF7nd6B2Vo1qPBQ7NH5mgMc/N
   pml/1m4HBX9zRom4sd/Y1D/tur/xrrg0wTAsIZ1KluKUeEkt3u9bOXWJA
   BK4VBlY57H0Fv6HOLNhgtWHAZB8PPfpFJ8bQrmeVTCJHNJ/JrKFj+f+m7
   RTIWrc7NcBDdOepswcUyPDwvgPfA+uSne+LFGit3JKaXeq0Sx2yYvgxui
   3b24rc/eaofjbMySz2VKQ3ABVDEb5xWWsKNPWMRW7Nj57WL34QbfISjEg
   f8LTTIXnI0vvOgaMlCBbUoiWyh2eSwO0uCrOVI+8S0l0dwQjnShkv9Z3/
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684771200"; 
   d="scan'208";a="244001782"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2023 19:07:22 +0800
IronPort-SDR: RX2LtLkxEgtWRvhmCDsfl7xp5pjMqUQP6nDfHjbK9sAzmptSestKPvNEXqLz5xao0lv5+nldA1
 y6yya10DuW2gpyNo2XG5F/nG/ayoxAt45y8yIGBpSd7cfTSNLog7NK3FijNrnz/YIh9wcV7yER
 JhfuemLehIPLSPxMp98pyXG22IuaCgub6wBu7qPL/KLNn4bgezwBpSIFiZPzfTbZHVfRxx4iZ+
 GGucnl9/quLPzXNZQUHqKBwvrldfB/YCW2gbLl3zWQnfT6ajFturx1QlR82kfZveOCZuPi6OVl
 iyM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2023 03:15:22 -0700
IronPort-SDR: Q0nOgS7Eotq66p/yzdwdQ5wl6iqTYjdpxh9QYHA04crJazodW8T9KXuATSJsmS5I7jlqWWenQZ
 Fn37M6mvSLKl4r5GLRHOlnQ9CGqPKkpSe20CZhCK661R65yrcHCnQ5GUfigVU9rka+kibrFDAI
 +QBtrN9UrGOfXAqVufQQ3Gj3NijKWzJJMAoZJgkAT/kEvMkf5w+ZSEWkFwxRwDCdZ7YV1djoEm
 sFVVPuhjqAB1t4UdQlScmBpDc6D1UIc2+7eFuP8sGpdZRqA28OpXSQKwnniYbQgRPeH4N6M5BK
 h0M=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jul 2023 04:07:22 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/4] new: don't mandate double square brackets
Date:   Fri, 28 Jul 2023 20:07:17 +0900
Message-Id: <20230728110720.1280124-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
References: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It was guided for test statements in blktests scripts to use double
square brackets [[ ]] form instead of single square brackets [ ] form.
However, a number of patch contributors use [ ]. It is not productive to
replace them with [[ ]] and discouraging contributions. To avoid those
drawbacks, allow both forms and still keep [[ ]] as the preferred form.
While at it, fix a typo.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 new | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/new b/new
index e8ee5a0..574d8b4 100755
--- a/new
+++ b/new
@@ -232,7 +232,7 @@ test() {
 	echo "Test complete"
 }
 
-# Finally, some coding style guidlines:
+# Finally, some coding style guidelines:
 # - Indent with tabs.
 # - Don't add a space before the parentheses or a newline before the curly brace
 #   in function definitions.
@@ -242,7 +242,7 @@ test() {
 # - Functions defined by the testing framework or group scripts, including
 #   helpers, have a leading underscore. E.g., _have_scsi_debug. Functions local
 #   to the test should not have a leading underscore.
-# - Use the bash [[ ]] form of tests instead of [ ].
+# - Both [[ ]] form and [ ] form are fine for tests. [[ ]] is preferred.
 # - Always quote variable expansions unless the variable is a number or inside of
 #   a [[ ]] test.
 # - Use the \$() form of command substitution instead of backticks.
-- 
2.40.1

