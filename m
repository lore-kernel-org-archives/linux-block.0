Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A34C04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 08:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiG0IxA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 04:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiG0Iw6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 04:52:58 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9FB46D83
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 01:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658911977; x=1690447977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e2KohEWTMAXisI4mz3YJiUD4xuDwO4eqXzG6jXsMgtU=;
  b=dq2yQYqMMEPxyFhsJ3Kl472OQcO0sNLl5LMN2Vds/ga+7Sa6cCQoGVRV
   UlXkPYuK4BBplBL0h8CrzQxpeV+D8qBNYdHA3B9/aaHfm269hAP5qkOV3
   0Tz9AvQI9zI99Fp4IUe8+Q4S15fobbmMOtM7iqdfgoeBwtU/dhcL8sx4/
   mapIyBGosIdRgoSyZYcH9tAYqV3YD2LQn8oPbQrx41dhx5TIA2nxuB++i
   NyVdV1Oy948o7arqQZnYiYBhHFbMMcyzqvElW5i4/tN4acBL87lInYAXn
   fYEOkzRGmsBapZdZhkoBPnodBRMD4bsA+5THJPPrNohpK7t6lhO5aacJ/
   w==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654531200"; 
   d="scan'208";a="205584987"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2022 16:52:57 +0800
IronPort-SDR: 4PFjASfWVAlFyIRv/3JxMlms4n49YcNcV394XHsnF++XEHUrIeVxrR4gPFNK24vB+gcG5vgztw
 fTJvZ9GdcNLJcpheO4V6CqWaERlSqEnunI+JvlU5NLLooXrrwH8UF7eBcwGsfzuGuz1JQzROA/
 ibatqIkukIJCYGepIGczsNI8rNuLq7oxtPzCoZiL+mC6MLieqHVLt89Fcj7aTKdVFtKW1tpApU
 3Z0Muaw6yQoy1aqxboDopDgrN3EADRXtAVsMr90orpiw3lsbaeklm8EWw/2I0bjyF9kogrDy9F
 iGVG5AO5pTe8oZY+ZLry0eff
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 01:14:09 -0700
IronPort-SDR: /H5f5xQM5YhnmJBLf6lnEHgVi30YmOAVuDO/hxmRDwhNENx4FCdY+MPKy5zf0+L0RNY828tygz
 cNk93kiEWjSid0ElCrDVVhHqaH+jNYH8WB1yDHZpNLvhQw90hhOaDC9c2muflhLjHLqlJ3l7nn
 buL4+mc1Jnq69L1trfLvAA+I2NdgsC8qzkZdW/gemQjd8DUtt/LQaDPQ7MNfbmFNLq9O+5VVdN
 98iPkHGacFk+MiwLXOYdHCYuxAkXT78cpoHpfLpoZe2eKxse4Q8dGkL/V7hYh63Q8YwDFfLmJI
 F9c=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Jul 2022 01:52:57 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 5/6] block/001: use _have_drivers() in place of _have_modules()
Date:   Wed, 27 Jul 2022 17:52:50 +0900
Message-Id: <20220727085251.1474340-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com>
References: <20220727085251.1474340-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The drivers sd_mod and sr_mod do not need to be loadable. Replace the
check with _have_drivers() and allow test with built-in modules.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/001 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/block/001 b/tests/block/001
index 5f05fa8..a84d0a1 100755
--- a/tests/block/001
+++ b/tests/block/001
@@ -13,7 +13,8 @@ DESCRIPTION="stress device hotplugging"
 TIMED=1
 
 requires() {
-	_have_scsi_debug && _have_modules sd_mod sr_mod
+	_have_scsi_debug
+	_have_drivers sd_mod sr_mod
 }
 
 stress_scsi_debug() {
-- 
2.36.1

