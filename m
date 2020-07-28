Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278BDC433E0
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E373C207E8
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VghPiJzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgG1KOz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:14:55 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41078 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgG1KOz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 06:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595931294; x=1627467294;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=35hHjFABrx8NJLI/uGeN2shxdmS3SC/OgTs827fVgbA=;
  b=VghPiJzU8gWfFS/OZt8FCqMzQZH/xwg6OgaiC0bp9l1IaJqyLIvPCXOb
   fZDcs2FmGO37cyO1Rw9V3KiUR8XZZOIJdWfFJgp6d1Wqz1ChJ51zBB95A
   OuxnCHE6umGert1tbqzWH6lI0ZpHbGMJIhlQ7Gk1ehD1hOE/avoh+d72n
   fikXiGE3cSGdmUHdn4/6loTdLmtSA820S67W2OtWNv59ml7LIHL4K2Rbv
   c4ooj3X5z7feChAPeacZwEYS+14LT49WxXgy5ugVelgueTB0dsftCLtl8
   Ba+d+VwH3oT82o4Na5MK+dHv6kMoy3frbEVST3yFx+qLYtxUlmxFOyw7X
   w==;
IronPort-SDR: 3t5x+mkcVRe3j2omElf0mLc4G+/ErgOmk5gLT2Tn8VJfKc8u36ZjyjvVr4Gegtb4hBnOTY7VgF
 XCuB78Q9Ed4wqVYUxj6VVGXKMS3ohERYqsyXKzyRL3QkDNExsyWp2Yd71u1TWgDH0yQE6n1qC9
 ZacLd6msEKgHEfWl26U8LNdNLBdLVmlx1Miu+bRMR1SbEAMCV4HkLd08VyBl1rm8qcL5lLJwiC
 pNJm4HxGyS8URg3MVeyuWlsHXB9XatIMp6J/CzLAmiDnxpeg8aG7aXdQlX/ngtMvqtLqOwnVxW
 ngs=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="143543029"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 18:14:53 +0800
IronPort-SDR: /1CPo+qnZxtAve5E+iSzGQYDpbQ/sb8E5rFpskFj0CmuJOpDA7GIJxCXWz5V4bX6rKLQ+K52uN
 TCHYNybuouxdbYfakTTKWjgniJ3X313Vs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 03:03:03 -0700
IronPort-SDR: RkPRQgHVagjyS5tFYT33UW+fsMFtKSi2PGcIQ2AMkUCvgKKfi0E5FTYJZCksv6QDkfqjEP7lqe
 v399Tnz/NvYg==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.87])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jul 2020 03:14:53 -0700
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/5] Support zone capacity
Date:   Tue, 28 Jul 2020 19:14:47 +0900
Message-Id: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Kernel 5.9 zone descriptor interface adds the new zone capacity field defining
the range of sectors usable within a zone. This patch series adds support for
this new field. This series depends on recent changes in blkzone and fio to
support zone capacity.

The first patch modifies the helper function _get_blkzone_report() to obtain
zone capacity of the test target zones. Following three patches adjust test
cases in zbd group for zone capacity. The last patch fixes a test condition
issue found in this work.

Shin'ichiro Kawasaki (5):
  zbd/rc: Support zone capacity report by blkzone
  zbd/002: Check validity of zone capacity
  zbd/004: Check zone boundary writes using zones without zone capacity
    gap
  zbd/005: Enable zonemode=zbd when zone capacity is less than zone size
  zbd/002: Check write pointers only when zones have valid conditions

 tests/zbd/002 | 16 ++++++++++++++--
 tests/zbd/004 |  6 +++++-
 tests/zbd/005 | 11 ++++++++---
 tests/zbd/rc  | 35 ++++++++++++++++++++++++++++++-----
 4 files changed, 57 insertions(+), 11 deletions(-)

-- 
2.26.2

