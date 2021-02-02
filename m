Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048A9C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B693364EDC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhBBFh0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:37:26 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3355 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhBBFhW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244242; x=1643780242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iayCvKe5PGe1IxVpKjmhNT1nCQLl7vpaxlMfc9BxqY8=;
  b=F5laaNBFqZZ87jzl1Tf+BCn+xqKwFw34uuTTAy0nUvVcAaNU8zLMqY1q
   cTCKV3j/AB82nnaPr+0bvLidmfLHdvbY1I80rdA3ntvwsa4zI0JnO+gJd
   H24M9lz7qeFONmo9ZlQ+6tQpTz8MtDjAShXuMWBgM17vuYxjNl/lSIetU
   uDsNxJ3ORBN4gPspAhas3+f0d7moN+SrnNUB+nmTq8aJmLWn4HbiY42Yz
   AVO20LQWhEj0gwbI0BCatMpLze6O39FeKjNcsRrLSI1l7gDTdHNa/sE3F
   QqiDiuT2ZfgAw8i9wDrXTkHqNhbrvn02PpuXuP3r3wI8fZ9YzhlLjiHwb
   w==;
IronPort-SDR: HkDL2k266RmX87pGsGHCK6JBAaTMHHWk1gUKOCD6OtSJLEwXx4k1iikaEMmih3gAkgt93xsOcK
 ZiqNBb3zNbhSVCAU8bu5YlQpO60Rf5Za1eE3+GcfkYp1LabIRJSpZZdNC8RQz41fRe4lnc+GqL
 KP6T5GZ1zmZkqEbKAw3q1J98LSBxCUi3DAWftaW5bzpbTTjn85FnOoPcTKfuTCTVOzH5/ytRJE
 jGw1w3Mod74Tut8hQ/g3s65BoY/L3YwWkwWG9ADqvrt0p/1ri/1eqwh3h7pBDJBoyigDzloaIY
 E4w=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163334285"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:36:16 +0800
IronPort-SDR: UFxUWSBNwPa2ewJzoqbNOyREVjimpsPQrkbNkqUFTBlZ2oJdTCW1xEwRNezGwwUPbZ6Nh7fFrZ
 tpgse/bv7arKNuLaCNmZOMDWVVox6C+fLWcLKYFcSa5nQ7zRI7wzF/UVN5RmiadzPZ/lb704Dz
 BOVuXcba/EjR4+MGLWAmOn6Fo7oJM9x41dnxPaZ41GfDnwqKpsdepYh9SDEQLmVFNlLi0gB2CM
 XfwE2G4dxxuU9NTxUdbp1MeXHwmsR/x5U4XwuuDL5lRTNeRhdiyBwi4AoFxqDbNQh0kU04xKIp
 fCnLPNswosIB7IGvDTbyqenS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:18:25 -0800
IronPort-SDR: cO4/ITRpEmcncXAoSh12qq+T6kurAguvd5gN2Zs2TDT1tZhQSXB7CU6hu4H5EDA6gHwXc2aWam
 ccUzAoqtxlyH0PRCAhr3S9EADxbowp5JhUqnaEs7zAlsJx5lTIddOS9J6gDSTzDRZUWjcRNZf5
 Lkjl2PBXl4yFj+QUA4E5Hw7EPHQYFkr+IhXaBi5AbbFiB7OFsJgLQntctFts21bbR89BjoLHgh
 IQg8ZJyITzt+bhZ24lq3x9WFpgja0BF4X+3hNiYAo6Pt0rCO0FtVOOsGvRNqmdQqp4ObTWtSlZ
 W6k=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:36:16 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 03/20] loop: add lockdep assert in loop_lookup()
Date:   Mon,  1 Feb 2021 21:35:35 -0800
Message-Id: <20210202053552.4844-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In current code loop_lookup() is called from loop_probe(),
and loop_control_ioctl(). Each of these functions hold global
mutex lock loop_ctrl_mutex with two variants mutex_lock() and
mutex_lock_killable().

Add lockdep_asset_lock_held() in loop_lookup() to make sure it will
generate an appropriate error message in case of misuse.  

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3bfdcabaf6b1..0a8cee66c622 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2211,6 +2211,8 @@ static int loop_lookup(struct loop_device **l, int i)
 	struct loop_device *lo;
 	int ret = -ENODEV;
 
+	lockdep_assert_held(&loop_ctl_mutex);
+
 	if (i < 0) {
 		int err;
 
-- 
2.22.1

