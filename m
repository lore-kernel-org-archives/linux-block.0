Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FE1CCA480
	for <linux-block@archiver.kernel.org>; Fri, 10 Jun 2022 12:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344520AbiFJMP0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jun 2022 08:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245662AbiFJMP0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jun 2022 08:15:26 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6A522CEDE
        for <linux-block@vger.kernel.org>; Fri, 10 Jun 2022 05:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654863321; x=1686399321;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NRvTo4xriIjZRPuzweXRN+adnzdcjWKj+3jKMRo876k=;
  b=gb70n4mm5Vir2zKdlumFMGFuflpd/d6bIQTQdpgivliK2FVCeJNidGP5
   r2aGHC0cOCi3eCjcYTFWI+Wuk7kI8AkJTdB0he/jpZ3RIPQ14IJBqU02p
   FCk3vJMs30M2e10UCpTvZMzRLFzkyvn56TvjV5IzB6P9mOM3/AIDPzjTd
   sWU60eqxVTZNuxIIqIgznnoO5UyaGRQrGmh4u7E5PwUkVO8NN9hn/lJ9d
   AjGcm7ihMMjm+HqcicwJ4pA4v9oVb+17MI/hq3W5sRaCTasFrCCFUZaeZ
   YTJPeQIFJX1KVtR//kCRte/WOxZ9CGPfAHR9eYcQHgdlXNJK41td42z5h
   w==;
X-IronPort-AV: E=Sophos;i="5.91,290,1647273600"; 
   d="scan'208";a="201520182"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2022 20:15:19 +0800
IronPort-SDR: Z/cC7VUmHUsDA4GPlx+jz/wNYX/lIKHX0kavH38SiceDkiY4ndykfMDKlWK/t8oYmDtbTjdCOm
 snNB55LDeh0nr53hGYSzQoCDmpDjZ6IiTDbwiaowoxkEqs/ODuLlNiqFvP5iSNoqSuVlOxtZtk
 Y/z6+TuEtf0uLBGUc19qoqI1imoSjofvv0eN2n5RRwJTzOmbkduXes1z3s21u6Ti5Xtc1NUGX1
 TectmIH5Las5f7OPCd+YwUWCZw3pLsHuF/G9XSoj7msYWwn1QQUPO0+41dWe8Y/x1dGamErMSD
 NsSfjUPZvonfLwuGpJ8lcQq9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2022 04:38:27 -0700
IronPort-SDR: 247upAS2s2FMRRNJvZLoi1+GlNjTcQ85/v7EG8GBFXug4HZbt/JCEGnu74TgsGEMXU/k4XOs3w
 rntHO3wUQRkeq6yO6Qe9kgaKfzWINL6ycWe1BxDxU+D0uo+O+a9Hx2i+2oI5Whh3EDnltH1yIb
 DaHdQwpFJR8NtT8AnAzjcbe/vEXZ8GA6ZpRRNqpypmkVu0HzcFJ5LiHfb6J/ThweYj0s36YOdz
 PuMfeeEHkUuVuOAa6SFyhuabY6CNHMEaD4dKbKQjfAiwuIfUAOirlWOvwA3VNzt4oeJv1YFC3D
 ZSU=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Jun 2022 05:15:19 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Alan Adamson <alan.adamson@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/039: avoid module loads for various transport types
Date:   Fri, 10 Jun 2022 21:15:18 +0900
Message-Id: <20220610121518.548549-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The test case nvme/039 does not depend on nvme transport type and does
not require modules for the transport types. The _nvme_requires call in
requires() loads the modules and those modules are left unloaded after
the test case run. This causes failures of following nvmeof-mp test runs
with message:

  modprobe: FATAL: Module nvmet is in use.

To avoid the unnecessary module loads, remove _nvme_requires call.
Instead, just check existence of nvme command.

Fixes: 9accb5f86670 ("tests/nvme: add tests for error logging")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/039 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/039 b/tests/nvme/039
index 9ed5059..85827fa 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -13,7 +13,7 @@ DESCRIPTION="test error logging"
 QUICK=1
 
 requires() {
-	_nvme_requires
+	_have_program nvme
 	_have_kernel_option FAULT_INJECTION && \
 	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
 }
-- 
2.36.1

