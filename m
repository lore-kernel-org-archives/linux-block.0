Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEDAC001DE
	for <linux-block@archiver.kernel.org>; Fri, 28 Jul 2023 11:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbjG1LHh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jul 2023 07:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbjG1LH3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jul 2023 07:07:29 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD55D30C2
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 04:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690542448; x=1722078448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=URedivequX3b0zm/DhRlNP3wmBxItgwD4zhZNL0Z6Ts=;
  b=mm8gO/w4XUH+vXMSohe9zs7ZJjUqsNzV/oek9TPrg47wMZFQMT5QIBbL
   AbapXwe2e8w7ZMkar5q7sToj0za5TBrxNNspvLo88WiMlk+I8TqPm8e0S
   jVSB0/lOBNpxTv5BP11q85lyvgjbwwkiIzsYFKt9WtWegsTVoKvVaiCWF
   joYoke3R2bmuYBLemP/hr1UWuO1hraOWsoK1mSYs0SeWvnfLcsPyS5RxV
   T/qrTRNHT//KldRS1W3jpR8o51fMvRW+bQZ85hW+fqCOm9++d8M7hJc9z
   /TuNr7x+g1K0zyH+MKB3EFLoXpLFkTqkRdEnVNb6iJX0f9a9EWOuxuKVJ
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684771200"; 
   d="scan'208";a="244001788"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2023 19:07:28 +0800
IronPort-SDR: A48ZoRyWXVPuLWQZal2fGPDWCvtulsgmzz6QogKIyIfRnVDUsAHvBzU0zw+Eu9nObMUlA1Mlhk
 svxGbgN51I53vLSmfEr9MxxYqNC7IfBO6RZTVS+OPwU53tH9xsxsS4DXpOwkG61c9+QY0GkaA7
 Ab7YjGeMPPntmsDE1yL89h9rSK9BBimH4BZQWr5LwAT87brhQuUHjti2OiCG5K1XqEqzlTWqq8
 Sd7tgSQC6tMhLZU9fGaMc402x4QLyuWQJFMTAz99ykgdQWVKza9CUV0REbWnKi627ufV1QfeQs
 YHs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2023 03:15:28 -0700
IronPort-SDR: dmIZYIP9CWyLpWeWRFhX3yl/hchTSfAo9D2w2x7z+Qf1CyLxWPs39S/zT1c3VVMPWYPAl4YUy5
 a4khgAG/6f58aYvpCFPC9Dwgb0TKDrIqJg+OylBjc4B+gPNAI7udDZqhYaN0xtrdNfWZt23iwk
 qLAnwBu1aA+sC42w7P9q28eNg1ey7Enfuf5GSz8tgtT4c/xOrTqB7luBTnF88DgOUcgQEPJJ8r
 YcBrP8Na91kxOThN6c5Km7I18GacSrNjcs+P3+wSyIfg5qZsFcI4etm9yjgAuDM/5V+Caemb4p
 8v8=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jul 2023 04:07:24 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/4] CONTRIBUTING, README: recommend patch post for contributions
Date:   Fri, 28 Jul 2023 20:07:19 +0900
Message-Id: <20230728110720.1280124-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
References: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are voices that blktests changes through GitHub pull requests are
not visible to relevant block sub-system kernel developers who
communicate through linux-block mailing list. Some GitHub pull requests
in the past needed additional discussion in the linux-block mailing list
again to confirm that the changes were good for the kernel developers.

To reduce the repeated discussion in the mailing list and GitHub,
clarify that contribution by patch post to linux-block is preferred to
GitHub pull request. Still GitHub pull requests are open mainly for
quick, minor fixes.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 CONTRIBUTING.md | 14 ++++++++------
 README.md       |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index fd232b7..74d9771 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -1,11 +1,13 @@
 # Contributing to blktests
 
-You can contribute to blktests by opening a pull request to the [blktests
-GitHub repository](https://github.com/osandov/blktests) or by sending patches
-to the <linux-block@vger.kernel.org> mailing list and Shin'ichiro Kawasaki
-<shinichiro.kawasaki@wdc.com>. If sending patches, please generate the patch with `git
-format-patch --subject-prefix="PATCH blktests"`. Consider configuring git to do
-this for you with `git config --local format.subjectPrefix "PATCH blktests"`.
+You can contribute to blktests by sending patches to the
+<linux-block@vger.kernel.org> mailing list and Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
+or by opening a pull request to the [blktests GitHub
+repository](https://github.com/osandov/blktests). Patch post is more recommended
+since it will be visible to more kernel developers and easier to gather
+feedback. If sending patches, please generate the patch with `git format-patch
+--subject-prefix="PATCH blktests"`. Consider configuring git to do this for you
+with `git config --local format.subjectPrefix "PATCH blktests"`.
 
 All commits must be signed off (i.e., `Signed-off-by: Jane Doe <janedoe@example.org>`)
 as per the [Developer Certificate of Origin](https://developercertificate.org/).
diff --git a/README.md b/README.md
index 1324159..201d11c 100644
--- a/README.md
+++ b/README.md
@@ -54,5 +54,5 @@ referred as a document. It describes variables and functions that test cases
 should implement, global variables that test cases can refer and coding
 guidelines.
 
-Pull requests on GitHub and patches to <linux-block@vger.kernel.org> are both
+Patches to <linux-block@vger.kernel.org> and pull requests on GitHub are both
 accepted. See [here](CONTRIBUTING.md) for more information on contributing.
-- 
2.40.1

