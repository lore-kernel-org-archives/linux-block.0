Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53716C433F5
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 01:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241651AbiC3BeD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239656AbiC3BeB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 21:34:01 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E5F1717AB
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 18:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648603937; x=1680139937;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6b/QaunUfe1E2AnMyAVvv9lYvwy2DpvaeF/DHg4mypA=;
  b=R5S59c809Mqfln/PIAzVrOGBycJDE/PPC6RpRFZV3fZhX/mGcwxhNNpi
   ARU2JHb14zMJwchVBbRqNZl+BOCz1IqAXZ9pXBPe7GksO6Gqvrb1eslx2
   R+/Ex9tQQCKM9djVSgNGmm+AdpurcNsCMI8c6DW25tJLqAZjo+zuwd78V
   JQ99cbwvTqniUqzzAy9m761XteVBM+VTq9j+JafpqZJNx3tIcyC7l0nf3
   YPBH4s+J8SpEuj9h9nrXAAFSwvTNocpqRTWXmKSj7JIUP/Rt4oEDGLUBU
   OWLR0b+W4pUvmBih+Fc/KYMUREfGfo8EwfzHH54UxIJhFpuBCupkGaShC
   A==;
X-IronPort-AV: E=Sophos;i="5.90,221,1643644800"; 
   d="scan'208";a="201439137"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2022 09:32:16 +0800
IronPort-SDR: 3XjmtRVgr81bklez8TBX/8dSTLSqeVCsEIWSsmZHoa6pLy4efRigcZX0hLtxSCEi7z17ltfBO5
 0qE82Rph4uI21IFCyAb+umpSJYtkkHoCQ412CqQ7hkxXtdGo2amw5lbwVqm2OEuvdIXF7Y9rjm
 trfBvrBWf0sjvgPsQYK01SQ2hH2rDvcR1oPX/SNv5juFYuqqX3SG5UK2GxysxfqUy0XMQprHlt
 Ox6V+JYv9e7Hi8erLmdPbxs7T2O2Yp25Pclgttc12HSLNuqWz4P1EwgsV0X/6k0G6+JpWSb7IV
 4s2TXsxqOarajuvjjJXMd4Fh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 18:03:08 -0700
IronPort-SDR: JaOfbvR/8pMehbe8bdhZMEHdOO6OxKMzTzpVCcXl8xrXJQqGR6MEySpy2AC+tRfrIhi3uKOHRd
 D3jYbX30aKu7xCwkE/Z6KAFKD5gx1jRFYCLSOiJa57Qj1Bzlp+6X/xVpcaRUHTcFb3J3HDfvbS
 VrljETgOOELqBYkLZbz/pgT+phRY4Vq9ZpjYw19rOPraZ+QaLQsOVUdy7uCgUJjuqz4F+/GVRJ
 NyqIPDcRuEEupZQIJ4GM1ac5jlh1W6jXOWWLsQ82o5xbUc4ASSvp6o9XuKZyTj3bJAl9ykL2MO
 N30=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Mar 2022 18:32:16 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/6] extend zoned mode coverage for scsi devices
Date:   Wed, 30 Mar 2022 10:32:09 +0900
Message-Id: <20220330013215.463555-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch series extends blktests coverage in zoned mode on scsi devices.
Recently scsi_debug introduced ZBC support and can work in zoned mode. The first
patch adds a new test case zbd/008 using scsi_debug in zoned mode. The second
and third patches allow test cases block/027 and scsi/004 to run in zoned mode
using scsi_debug. Following three patches are scsi test group improvements
unrelated to scsi_debug. The fourth patch allows scsi/006 to run on SCSI devices
in zoned mode. The fifth patch is a bug fix in scsi/006. The last patch removes
an unnecessary scsi/003 out file.

Shin'ichiro Kawasaki (6):
  zbd/008: check no stale page cache after BLKRESETZONE ioctl
  common/scsi_debug: prepare scsi_debug in zoned mode
  block/027, scsi/004: whitelist scsi_debug test cases for zoned mode
  scsi/006: whitelist for zoned mode
  scsi/006: skip cache types which disable read cache for SATA drives
  scsi/003: remove unnecessary out file

 common/scsi_debug  | 11 +++++++++-
 tests/block/027    |  1 +
 tests/scsi/003.out |  7 ------
 tests/scsi/004     |  1 +
 tests/scsi/006     |  5 +++++
 tests/scsi/rc      |  4 ++++
 tests/zbd/008      | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/zbd/008.out  |  2 ++
 8 files changed, 77 insertions(+), 8 deletions(-)
 delete mode 100644 tests/scsi/003.out
 create mode 100755 tests/zbd/008
 create mode 100644 tests/zbd/008.out

-- 
2.34.1

