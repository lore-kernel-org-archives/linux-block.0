Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83830C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45EF02147A
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZThBeexO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfBUEmy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:42:54 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38322 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfBUEmy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 23:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550724233; x=1582260233;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=30tolErKBqwz+2+58lRJU+06SwpZx9B4tKjxk/e2VBI=;
  b=ZThBeexOADVLWS55Y9f9HbbEWOZKGlUJ/7Rs8aYSL2xTsmxtOOpYvtLp
   C6LcUAsJXwT8E0Enlp2UxEJC00BwSwF5IKfhsfru+nKjJOety7NDEDN98
   J831O8iYiZKuJjiPlosZBsOnCw/K4dOxC7Tw1chnCrLf9IN3FovlPO2/t
   yodu2APms12t1PutXfoVrw97NgYmWF0cjpxQj2BN6t7huMLoKK33AmKqV
   p//fXe2522OpQQJzHAWRucyx3cevr6bKpl/yG4ezkLBv+0k7rHJFzyEv0
   YrW49AIE4t+7vFxTzVIJBu8pWtih/Tmudo2GoE0nCoPfnXXK6C5MdiJAQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,393,1544457600"; 
   d="scan'208";a="200133582"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2019 12:43:53 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 20 Feb 2019 20:23:16 -0800
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Feb 2019 20:42:54 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@osandov.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 0/8] nvme: misc cleanups
Date:   Wed, 20 Feb 2019 20:42:40 -0800
Message-Id: <20190221044248.11096-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,
This is a small patch series which follows the blktests coding
style format as pointed out by Bart. Also minimizes the overall
code for the review.

-Regards,
Chaitanya

Changes since V1:-
1. Add testcase specific error message on failure.

Chaitanya Kulkarni (8):
  nvme/021: use consistent coding style
  nvme/022: use consistent coding style
  nvme/023: use consistent coding style
  nvme/024: use consistent coding style
  nvme/025: use consistent coding style
  nvme/026: use consistent coding style
  nvme/027: use consistent coding style
  nvme/028: use consistent coding style

 tests/nvme/021     | 14 +++++---------
 tests/nvme/021.out |  1 -
 tests/nvme/022     | 14 +++++---------
 tests/nvme/022.out |  1 -
 tests/nvme/023     | 14 +++++---------
 tests/nvme/023.out |  1 -
 tests/nvme/024     | 15 +++++----------
 tests/nvme/024.out |  1 -
 tests/nvme/025     | 14 +++++---------
 tests/nvme/025.out |  1 -
 tests/nvme/026     | 14 +++++---------
 tests/nvme/026.out |  1 -
 tests/nvme/027     | 15 +++++----------
 tests/nvme/027.out |  1 -
 tests/nvme/028     | 15 +++++----------
 tests/nvme/028.out |  1 -
 16 files changed, 40 insertions(+), 83 deletions(-)

-- 
2.19.1

