Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87450C41513
	for <linux-block@archiver.kernel.org>; Fri, 28 Jul 2023 11:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjG1LH1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jul 2023 07:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbjG1LH0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jul 2023 07:07:26 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020C62701
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690542441; x=1722078441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8AhSLLQl4ixAuVk+EJj1DMSH5r5hTz2QyAq2ZvUykHE=;
  b=P7kGbIno7IxRDUTJ53PZdhPnb2+UZf9amRAjo7RRhB1PMp4bBvn27vnT
   4E8xEaIRRHC+nMzyphgIQOPVE4X/qx4FxnUWLwwetfGtoHV6Spl0PBvWQ
   vgq4sadT3FaBhqPivMNu1RwU9+nzoz4FxvI8F9ZrF4Se8if8KiZtyiVIL
   x1FKKfnA+xO4+rYSNJ0L+FQUzVF+v+tXO13qviFJmTVeBFXI1DWiEAiR7
   5ZgoXs+HsCtlAkSzivElaPs4KWGpDmtxMIc+/x5/74HHE3D2gl28DQRse
   MkLkPHMz0T6f0YD9VieTLjmhA9srJKD6Lbr05/TDF9rL4YDEJVumWUUBX
   A==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684771200"; 
   d="scan'208";a="244001781"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2023 19:07:21 +0800
IronPort-SDR: V/nKdWq8fjwn09N8pa4LS2qfQXvRQsSepRQlsTIDrMHk/glHkxoIKUyjPGRJTbh0jMXDHwIvv4
 Zox1YAJHGey7InWtO2bghDqFq/AyXv3AF91ZcvUAg1WMCd0sDXlrZ8MTf/ky4GEz1IVHxEsfHp
 Cq4RSF6dszQppDEiAcJImLOQzEIQcl95AF3179TK3i4Ru6eni/xxHpzbALfS0jbJjlX4nc2t+y
 3O8gi0CgSW30f7BT0whOtRxdOMfouznQoeOZDEKjU7b7KLc7Cy3AXS0otgHYoPLZNWXQT63poy
 D28=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jul 2023 03:15:21 -0700
IronPort-SDR: yqTvIG1rhA72KYMaLLqVmoqTPCCCD+A+hrdj3DOVrKcjxHbPCd+s0i2ILbOqokx7211xMX+HUH
 xdg+M67B/a0Ss/P0QSb7dFaU7WAYcm1AYjeN2Rn4mysCJkKqk4+cOAgs3bRRMlE2+HKnq3E5+5
 85Ej0ngeTirftuKLRBU6UUfuIOw3Ad1J0xdjgbs5Ip31D23Iu6RCTFexVorw4VdF7e9O5ij9Wd
 N2NnKRfzs25+g5d3uzU/OHasAmjGzjQ4A+/yKQTJco/B88/Wzw6KpviXFVd8GxdMivmrsC6ySU
 3Hs=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jul 2023 04:07:21 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/4] clarify confusions in blktests contributions
Date:   Fri, 28 Jul 2023 20:07:16 +0900
Message-Id: <20230728110720.1280124-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I hear some confusions from blktests contributors. This series try to address
them based on my thoughts. Comments will be welcomed.

Shin'ichiro Kawasaki (4):
  new: don't mandate double square brackets
  README: describe what './new' script documents
  CONTRIBUTING, README: recommend patch post for contributions
  README: clarify motivations to add new test cases

 CONTRIBUTING.md | 14 ++++++++------
 README.md       | 15 +++++++++++++--
 new             |  4 ++--
 3 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.40.1

