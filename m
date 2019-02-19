Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE55C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E24321738
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V+TXyqG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfBSX23 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:28:29 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47646 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfBSX23 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 18:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550618909; x=1582154909;
  h=from:to:cc:subject:date:message-id;
  bh=3n0X+YjkqcMNHpFi1a2qee/6jTbAyFN6iLtFc66UG/k=;
  b=V+TXyqG4bw5xxYwRdPWB3LB8zyI7cOwzbImT+Gv0kWqRN2jcZ9EGXiz6
   N4Fj4dHAveoO3fM7EhjfDSA7Qc2Y0vacs9kOn1IANSvfNO+rB0gXpXRac
   SXaDcv0KIgUT/WrCPOVHboQ5ChaJUwtHT7F7F9S/K0VA5D7EkHRSXGKfh
   hFWCqpBKwZIww5RNyLQboDcYnz6RaCzkigGiGXcwNGgQACw6iS9ooRjDl
   OE3lnGC7fPR/TTg8aAGm/EduriIsvnqIURi1OI14c/Vf5YVIrlRzEnN3b
   nvNvU969uqaLdwtKwjx3u2+m5odl6GBbd0ZN8l07mz2DQUvuDrzJ9kKA2
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,388,1544457600"; 
   d="scan'208";a="101666781"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 07:28:28 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 15:06:52 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Feb 2019 15:28:29 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com, bvanassche@acm.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/8] nvme: misc cleanups
Date:   Tue, 19 Feb 2019 15:28:17 -0800
Message-Id: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,
   
   This is a small patch series which follows the blktests codingi
   style format as pointed out by Bart. Also minimizes the overall
   code for the review.

-Regards,
Chaitanya


Chaitanya Kulkarni (8):
  nvme/021: use consistent coding style
  nvme/022: use consistent coding style
  nvme/023: use consistent coding style
  nvme/024: use consistent coding style
  nvme/025: use consistent coding style
  nvme/026: use consistent coding style
  nvme/027: use consistent coding style
  nvme/028: use consistent coding style

 tests/nvme/021     | 15 ++++++---------
 tests/nvme/021.out |  1 -
 tests/nvme/022     | 16 ++++++----------
 tests/nvme/022.out |  1 -
 tests/nvme/023     | 16 ++++++----------
 tests/nvme/023.out |  1 -
 tests/nvme/024     | 16 ++++++----------
 tests/nvme/024.out |  1 -
 tests/nvme/025     | 16 ++++++----------
 tests/nvme/025.out |  1 -
 tests/nvme/026     | 16 ++++++----------
 tests/nvme/026.out |  1 -
 tests/nvme/027     | 16 ++++++----------
 tests/nvme/027.out |  1 -
 tests/nvme/028     | 17 ++++++-----------
 tests/nvme/028.out |  1 -
 16 files changed, 48 insertions(+), 88 deletions(-)

-- 
1.8.3.1

