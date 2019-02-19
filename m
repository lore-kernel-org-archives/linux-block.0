Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A220DC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 20:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F822146F
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 20:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F/KAJVs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfBSUX6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:23:58 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2874 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfBSUX6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 15:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550607839; x=1582143839;
  h=from:to:cc:subject:date:message-id;
  bh=OVNFfLI4tSqqABM17JEdNFvn6d79TljR+5KY+3qcCDk=;
  b=F/KAJVs3Ae6bopKjOTy4sLYoafF3uN+3lh7VICD8JrO/K5oScosM8MA2
   8Kf/VPY6jgAMJxzaanKh0xWH4czSQvIz2h+g+PhsgsaSTMMHqXUBXPU20
   +4WvuwrbShVmXwl9RsEcExJnXxv7mPRKIgenBlRYCbOyglKdlmekCfzzg
   eV7Tyoi+7N/Mm/Ol0k348tOjebkCuORAVSgLPtmEVhOLWkYC6qHTgDd09
   77rmTPv0qu0fj351xv8bhHo8Cr4QmHcZaHNq7Hu8dIfF1reKJ8hVbIpK3
   gdQrmQF72j9Gez6DbdkPh9TNDB4sYEOtY8fiQfFt8/JzpvXAczHE1e6+K
   A==;
X-IronPort-AV: E=Sophos;i="5.58,388,1544457600"; 
   d="scan'208";a="103418570"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 04:23:59 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 12:02:22 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Feb 2019 12:23:58 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH BLKTESTS V2 0/3] nvme: fix output formats
Date:   Tue, 19 Feb 2019 12:23:52 -0800
Message-Id: <1550607835-11755-1-git-send-email-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,

This is a small patch-series fixes output formats for the the discovery related
testcases. Due to change in the generation counter on the target side
and nvme-cli output we ended up fixing these cases.

-Regards,
Chaitanya

Changes since V1:-
1. Keep the nvme-cli return value check consistent with other blktests.

Chaitanya Kulkarni (3):
  nvme/002: fix output format
  nvme/016: fix output format
  nvme/017: fix output format

 tests/nvme/002.out | 4996 ++++++++++++++++++++++++++--------------------------
 tests/nvme/016     |    4 +-
 tests/nvme/016.out |   11 -
 tests/nvme/017     |    4 +-
 tests/nvme/017.out |   11 -
 5 files changed, 2504 insertions(+), 2522 deletions(-)

-- 
1.8.3.1

