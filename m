Return-Path: <SRS0=19b2=UG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9ECC2BCA1
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 12:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67FE20665
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 12:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nGFYVnKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfFGMT6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:19:58 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58140 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfFGMT5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jun 2019 08:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559909997; x=1591445997;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sSJ2c3D8RfitzMYtJFEcolSU++vKaIMbVsP3seaV4Vk=;
  b=nGFYVnKmLfUvYOWDZlzzOHoq4RHSBs3hlOrmNdlVsqP7EO7UEVvKUY2L
   PPRx9mKCXBS7M9VZBpfbi//voGa4g9yxfu8+Kb2dVdYk1sDD3xZvovnDr
   BdS+WVvupVvgPyvQ7QcHguLeDMs+7ShIi2Q8V8uraX9VaxKa2CXWcQiOl
   kviAzDxMTJn8NPScudhjGb7lQ+qf2KvazKmGgj6lIL0NumDnLCS73j9KI
   Rfgdszr2LG4wOPNLpqY0UhfindpK/cUgP27mKeJi4T1XLOLLWkGJ6EBUi
   qEWoH0J92NsxbtJNpRLz+SmlmNKyFqXg8E4i2mflBouLkBCHVJqCzKHyZ
   g==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="216339836"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 20:19:57 +0800
IronPort-SDR: aPW9rGGxeDbs5Pfet7xEy9oUw8N8F5qBIRGyvNusDEkqKfEEGZoaOHV1Y+g8fdLQ1CXO8+pYxA
 IrHU4g3FzrtKfDbjhexswo000XuKYPLD8OgZDDJLEGdwSL2tF9Rb/b2J7l4bcjIxDjamhiyuO5
 SXUfUfi9hozB5vwckO8443yEReGpDw9GH9t14A/Ahh/E3HQGCZi7u76eL1ZZeRLe/1DU+ZsEow
 18UmBbHJS6wKrA7tLcc32j+J4R6HZPVgFsJB/VVerUWWAzXYXaRMHRQqohkkK02+N8lCDdcpR3
 LT43M/qKvmlSKbFtIOfDmauQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 07 Jun 2019 04:54:49 -0700
IronPort-SDR: rvvPg4kH/OHtyLuonWtxiiT8wXtvgcKxu3eXZcgKfrtAkwSMCODdDD2Pn7hV+h6ssg/P+xbwO+
 GM7/J7M3GkqI7delnR2qFSpvK0KeqOzW0WqXkR08W0SS1RB+JOLIy9HmT4VTzgK4PZZT7kX0kK
 Kkmfkg4C7hGk/GhCLOz+ug+/NdiTMrZWHtrjehsPozTbLNrklhKqR8MquslRR62sT7ZVH4a8xg
 IC/qd4Hua0Nk6BExZYwCCECyeLnhsXSrLFc6LBvgIA74PwnfuRDdI5XYnuAuWlNa37MQUgSvaf
 fqk=
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.166])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 05:19:56 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Omar Sandoval <osandov@osandov.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH blktests v3 0/2] Test zone mapping of logical devices
Date:   Fri,  7 Jun 2019 21:19:53 +0900
Message-Id: <20190607121955.9368-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a test case to zbd group to check that zones sector mapping correctness for
zoned block devices that are not an entire full device (null_block device or
physical device). These logical devices are for now partition devices or
device-mapper devices (dm-linear or dm-flakey). It catches regressions of
complex zone remapping problem fixed by commit 9864cd5dc54c "dm: fix report zone
remapping to account for partition offset".

Changes from v2:
* Reflected review comments on the list
* Modified _get_dev_path_by_id() to get device paths of partition devices

Changes from v1:
* Reflected Chaitanya's review comments on the list
* Separated helper functions in zbd/rc into a preparation patch

Shin'ichiro Kawasaki (2):
  zbd/rc: Introduce helper functions for zone mapping test
  zbd/007: Add zone mapping test for logical devices

 tests/zbd/007     | 110 ++++++++++++++++++++++++++++++++++++
 tests/zbd/007.out |   2 +
 tests/zbd/rc      | 140 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 252 insertions(+)
 create mode 100755 tests/zbd/007
 create mode 100644 tests/zbd/007.out

-- 
2.21.0

