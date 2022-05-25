Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0EBC433F5
	for <linux-block@archiver.kernel.org>; Wed, 25 May 2022 02:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbiEYCEa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 May 2022 22:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiEYCE3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 22:04:29 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBB465D0F
        for <linux-block@vger.kernel.org>; Tue, 24 May 2022 19:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653444266; x=1684980266;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KZM07RY8R7TJL8TXxAm3bk1AEBSgW+2XuBoWe7vUwxY=;
  b=pSP+vMo2TvnAI38PAgSMRduZZsCJMv6Z0eME6SE5iZNBEezobF1x3t0e
   GSvn6JjmeDu4VIcRcQAH5T7tkOSevMJEOJ8gv9tJ+fTQaXGkLaJHJ5GyH
   RAqY0p3jeNpjGV3LwHfKBoISXBJ3olYbzKwV+HclOGBn4CsB8NiN8R4e/
   VQEJb+2/CReoUX5RW5CbwovZrhu0JTl6MFwWpDs3rQld+o0A73U/HrY2Y
   +bhBiBgnrE0cthfO9Ktms7s+79Y8X5mzjep8v5laWWDM/08NZVOOzUzj9
   vDQQd+y8CZ8DFgMOVMZBedvrzbqV0nlgyGunk3kWfh5Q5bcM2Bz9utXI6
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,250,1647273600"; 
   d="scan'208";a="305580358"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2022 10:04:25 +0800
IronPort-SDR: +rBbGJYgmNNdkyzXETNuueWuEVbgCDk9ROINAvnvMN8I+p/PYUABuw9NTy/zm8D9mjlqZcf3BE
 QBGfh5N//NiKvKHoZtYqfvzyrU9VLwK3bdl+NBGpDGNIlVu78+TIX2lLi4lmrYT20RpBSrJyzG
 T1CDR9GcuwNm+oNRE9GFMYePOmhDuR9W+kXU9UPLMp4PU06kdqMputQvMIVMT/+WMDavEW+fMG
 p/jUErcpZ5DYMJxNEVb/o/ffgeCef3ULYPJv3ddvNkJ7H5yRpZlDt6vfSsX5b7bjfherqTtYEm
 rh8491x9rZmtfsh/Ulk0GBnx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 May 2022 18:28:23 -0700
IronPort-SDR: /rLNFK1hpm716AMjDcCoJcB5SdbJdh/2Wizthu3bnQO3FzAh5a26kq2/Kn/BJ0JiyhXdHEQUCd
 XNHm+SMY1CHjODK1i0Ck+wXzCNNy6F6w4idyHPuXfvc45F4U62grNDTwdSFCkRw8p1qcSxmZX0
 aTIaUk4XOi47wAbuEn7JcknaUpgH63t/Gl99v8C/vSBeCGyGvBBMgGW4QEgxluPyfT3uppJUyK
 k2PZ5EXVSBaWbuElq0593CsT8jqTS0jIQxk2qCiHdr5SpH7cQFHReo+f+CdHYY90m0HOHCEucw
 SNE=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 May 2022 19:04:24 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] CONTIRIBUTING, README: transfer maintainer role
Date:   Wed, 25 May 2022 11:04:24 +0900
Message-Id: <20220525020424.14131-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To offload blktests maintenance overhead from Omar, I volunteer to take
the blktests maintainer role. Replace Omar's name and e-mail address in
CONTRIBUTING.md with mine. Also note his original authorship in
README.md.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 CONTRIBUTING.md | 4 ++--
 README.md       | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 9bda2c4..fd232b7 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -2,8 +2,8 @@
 
 You can contribute to blktests by opening a pull request to the [blktests
 GitHub repository](https://github.com/osandov/blktests) or by sending patches
-to the <linux-block@vger.kernel.org> mailing list and Omar Sandoval
-<osandov@fb.com>. If sending patches, please generate the patch with `git
+to the <linux-block@vger.kernel.org> mailing list and Shin'ichiro Kawasaki
+<shinichiro.kawasaki@wdc.com>. If sending patches, please generate the patch with `git
 format-patch --subject-prefix="PATCH blktests"`. Consider configuring git to do
 this for you with `git config --local format.subjectPrefix "PATCH blktests"`.
 
diff --git a/README.md b/README.md
index fcf07ff..4a1d73f 100644
--- a/README.md
+++ b/README.md
@@ -4,7 +4,8 @@
 
 blktests is a test framework for the Linux kernel block layer and storage
 stack. It is inspired by the [xfstests](https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/)
-filesystem testing framework.
+filesystem testing framework. It was originally written by Omar Sandoval
+<osandov@fb.com> and [announced in 2017](https://lore.kernel.org/linux-block/20170512184905.GA15267@vader.DHCP.thefacebook.com/).
 
 ## Getting Started
 
-- 
2.36.1

