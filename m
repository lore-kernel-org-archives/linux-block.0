Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810E7C433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 06:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510AD2080C
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 06:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Mx9SkxZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgFSG7g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 02:59:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63738 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbgFSG7f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 02:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592549976; x=1624085976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ya/hP6Jo84M8Ygp7A5X9asNm6OaqASd2VKZLES6VwK4=;
  b=Mx9SkxZTrvLHzbwJ7pWVPh8b/tVI7lt/fhM96PXW5NFzaZJDVfaNNzLw
   DfBKh8hdgMDMN09sWPBU9gBJjTtM4vsjQ+Ap4l85a0NMyCcARQxm+tsjI
   pJrAbAGZsKHi9LtsCgP1nS976C9eIMbF+HkvatWozTZv4H2AI8VCEUKF3
   bPQqLNQ72l78oDHSGBgACpBdk5Yr9kzWxybcWUm//Z1vSmYG2o9fwNKYr
   HNEvKZ3x/ywymyK/GWNgnp6dMNIi35SDTC3vL03E7zHz6DlWKLLeH675x
   I/TnXO3X8q9hHmoZGdT/sM373/BqZnmesY68lwsC7BnpwRQ0gUyuqxrJU
   w==;
IronPort-SDR: 1MtIYPEKRbiksB8cQgQ1qkEwihC9ty5D1i7WekkzqF9cWYx1xBxWdJZwoT/CGgZK1X6mjg1Kqn
 CW7/YaYSt0oCSy8dduKYQdrYv9Px2Sv7l0/RFq+X+Btm+WIPCQ+RRar0ikq9vrmgMAOxVjGkrz
 QjjbZ5lwVB31Jgg2u0KepCnD6mVzDE9V+8fdU2tA9Xu3tgMyQKqkQ1/IGgejeT/0DwHC4Rz9of
 ZakpETYs3g3C67H5wyLAf1sFFp9yQ+Pdd7oDu2QyXrrS5KcCkk2/VjrHd4e75DWKkr2sgnO1FY
 OmQ=
X-IronPort-AV: E=Sophos;i="5.75,254,1589212800"; 
   d="scan'208";a="144725644"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:59:36 +0800
IronPort-SDR: v1S7lSvSWq9S22H7ivEhXKEHGRwXGLlp2/o//+3RhnxnWkJVZlCWdMknRtgjHOl0Y8MXauNujS
 EGWdyr404TfxtqKRtN5zb1GOHEgGZATzE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 23:48:46 -0700
IronPort-SDR: n+oGSiGE6dPo7ZVMpchPQYKRjNmayWVvVXe1xP8BXTvGz3RVnh8UM9B0o0vvj2h3CIk4Roq0J5
 0FyyCOP8vFWA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Jun 2020 23:59:33 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] Two fixes for device-mapper with REQ_OP_ZONE_APPEND
Date:   Fri, 19 Jun 2020 15:59:03 +0900
Message-Id: <20200619065905.22228-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Two small fixes for issuing REQ_OP_ZONE_APPEND writes to device-mapper. The
first one is an issue reported by Naohiro and fixes a write failure. For
number two I'm not certain if it's the correct fix, hence the RFC tag.

Johannes Thumshirn (2):
  dm: update original bio sector on Zone Append
  dm: don't try to split REQ_OP_ZONE_APPEND bios

 drivers/md/dm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.26.2

