Return-Path: <SRS0=V8DZ=QZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5597C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 18:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889362177E
	for <linux-block@archiver.kernel.org>; Mon, 18 Feb 2019 18:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IHk+UAI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfBRSxo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:53:44 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25285 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfBRSxo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Feb 2019 13:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550516024; x=1582052024;
  h=from:to:cc:subject:date:message-id;
  bh=RI/UcjTxXoodW8F7/nahRKaJ2PRrqYEGUpOzQIHtbAE=;
  b=IHk+UAI2Z++C7qTD1TEUJA6ssTTT/V3yiIK8teBNAtEq4MFL74TGBHoP
   333t1h/+bxvQHGPza0rolfS6K6ndssJcrU3xgCuLgfqVlKrMhoU0fEeST
   Wb/WoW0ETgUGK6eNptP5OblE93ZSKesr9q/33gYTOv7CMC996a4J6lMR5
   /AxmFMtbzhv2e2kIbK1Rwq5I6jzLXEV04dwtiV+GxfuaIEnONtObu955s
   CNGOxw3FZk1pmw/e3p0qUUxaqmt35YNyam3wV64UYEuspm4okfet/PjUt
   XR/6YmB4wVmD2sDdz08CdenmdGNaNDBGSDsygHcx5OOofaY/F/CXtcNlE
   A==;
X-IronPort-AV: E=Sophos;i="5.58,385,1544457600"; 
   d="scan'208";a="103321453"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2019 02:53:43 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 18 Feb 2019 10:32:09 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Feb 2019 10:53:44 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH BLKTESTS 0/3] nvme: fix output formats
Date:   Mon, 18 Feb 2019 10:53:39 -0800
Message-Id: <1550516022-16374-1-git-send-email-chaitanya.kulkarni@wdc.com>
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


Chaitanya Kulkarni (3):
  nvme/002: fix output format
  nvme/016: fix output format
  nvme/017: fix output format

 tests/nvme/002.out | 4996 ++++++++++++++++++++++++++--------------------------
 tests/nvme/016     |    5 +-
 tests/nvme/016.out |   11 -
 tests/nvme/017     |    5 +-
 tests/nvme/017.out |   11 -
 5 files changed, 2506 insertions(+), 2522 deletions(-)

-- 
1.8.3.1

