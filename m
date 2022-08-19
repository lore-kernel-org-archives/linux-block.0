Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10D5C32773
	for <linux-block@archiver.kernel.org>; Fri, 19 Aug 2022 09:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348141AbiHSJj3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348169AbiHSJjZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Aug 2022 05:39:25 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A0779EC6
        for <linux-block@vger.kernel.org>; Fri, 19 Aug 2022 02:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660901963; x=1692437963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rpz/zcomyJM90Cd8YUsVLDGWob4pxyNxaHt5xngOfi8=;
  b=bbK8wLM/a3vnPEnI0ulhrlltaBshNmxz/IG0mpyTchrN07YceuiryZcb
   TDQGywwpEReeI5sbljJNbSTNVnBduH12kj+Cw0wyl/s9Pip1n3DnCf0J7
   R1HiCuBGVDaddAcIvobNwL0M/RNG083vINFxQAI62sHGCKZOWXZ21+HLy
   Pdyp5Ti/712+h9SwG4e+hGJam+kUTs65oYZ1ofCM1fVr+auRDtd2ex7JO
   ZQMD6tJzhv0QR3kOJNOKqvtYPAteeclV+15cSyL3eZvSrZ86veCMA8cxX
   EaR7//kRGJvEhgjuhhG/e/TLEGrFtQ1eDngoQgzu5Iz9PSx9WJyZ9EAEM
   A==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654531200"; 
   d="scan'208";a="313411534"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2022 17:39:23 +0800
IronPort-SDR: n4K0J2PVT9j+g2R83peiTyvW4eOh1NxXsx2yEJW1NnjaxuRKECExjPU7Bs1MRf3hsl1silaRhb
 B1u1H6zF6f77bEb0vV7S3odT4sRtZ/ydI6CXKwJL1QFnHKOezP3mRpo54i/83IVAtzQmkEEkun
 AtNwIb+RrvFU7ssOwrEM1yW7t9V7Cdqo9oPMWE4ta75uB2IzyKKV5waUh7nvJCVJsIOvNfYl0F
 WvYuIdf5dn5VzU+AilLGQavW1yXD4LKJP05jKFJImKcSZD3cX79wY+XNAqVep36sWqXc3+hwlG
 A1lzo2JuUugtbiZxDcewWlTp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Aug 2022 01:54:47 -0700
IronPort-SDR: pQvy5ARyUbUuijPzX7xIIT05nSnutOlSfhkL/YlvbbUadacogUD5l8LMwXQMow5CKwT3k5wYy3
 s+ir2LuN9ZGRqeBhtiwLSlgIbj04Irnbx0NVurCvh0MxcsAmgA42tO84Lo5rSSVFpvkepzT1gE
 LGkQQ7GE12rOTqxftNMnWRED+IW4BqkhK9caiWrleU2q4qWSy0wHpDDTax1mJdf92b6eJ8cvPs
 GChKBU7Vw0NWDFEfMY/b+9VvCpMjmmmOQ2gT1tJQGJNitqMtMi26Z8svY1DOYMzAY1UUOOvqXk
 5zg=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Aug 2022 02:39:22 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 1/6] common/rc: avoid module load in _have_driver()
Date:   Fri, 19 Aug 2022 18:39:15 +0900
Message-Id: <20220819093920.84992-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
References: <20220819093920.84992-1-shinichiro.kawasaki@wdc.com>
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
index 01df6fa..5b34c60 100644
--- a/common/rc
+++ b/common/rc
@@ -30,9 +30,10 @@ _have_root() {
 
 _have_driver()
 {
-	local modname="${1/-/_}"
+	local modname="${1//-/_}"
 
-	if [ ! -d "/sys/module/${modname}" ] && ! modprobe -q "${modname}"; then
+	if [ ! -d "/sys/module/${modname}" ] &&
+		   ! modprobe -qn "${modname}"; then
 		SKIP_REASONS+=("driver ${modname} is not available")
 		return 1
 	fi
-- 
2.37.1

