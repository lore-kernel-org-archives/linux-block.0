Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19567C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E066364EDC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhBBFig (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:38:36 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43351 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhBBFif (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244314; x=1643780314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rA9+ridQg7jh92JA0OnVA5Iy1grqYZCG75rmKGzyURM=;
  b=a34jXNczBwsSg1qhDeoZ6wsLI2cFAkmEoWahx6zRAb9Jo6W+EKixOlAw
   6+caQ8L7nXjCvJvlQz3CIUXZ+u6obVij2/BBMn/iL6sqFDsjwWnJrYdjT
   LKulQwhOxUCtRfwAi66GmlxdUJAGKH7wyp/JZi7sBlRpdLs74v2xOopHe
   JjBJ7b8a50PcNBp7ETSdqnCealZfV3vx4CFt+lXIvrru2xKSeBT1ft9uc
   6MA2DfK1BaT+HqVT/gux1KZHA8ta4xHa59BtFQBKxCYPK5HXa/TRRSMdc
   nPbIzDU2nCK5iXnTwpLgqZmTeD2K4svhIrEa0sDyh4+sYhSgHVNsNrwwU
   g==;
IronPort-SDR: K5pkJarrSIWijUQBivBDdng6zz0HM1W5r+sbU6vRRLHB1W+xUIhMCxNZIPYxpLNGK5oWCS3LCr
 Se9S5t6T/1eqhU9LV4MPpZwtaR1OljrCOiyn+lnjfm2ralpFjDkEAuwHS9/1xNlG0rKY+ZU3WF
 Smv7XIk77P6zBXdUlTmhy45wByAbIdBSTbGO898Qy4yzlsGRLi6MBx8zjhwVQj+Hyu2Sq8i+Sp
 RZFV3hp17I8tcn7jC2bFi6BbOidkLl7GOpMe+aGyH0wLtXwQHv9TSx9OKCN9r9aoS7W9w325DN
 gyU=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163334455"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:37:45 +0800
IronPort-SDR: 2dl9FDbesQdFQ+37KYhgkhrVquBImaxdeNuB71Ha9YRh6joQkNr87AZyh2IKzVw714EjrPSTXV
 O8MmP60dtegZXcspK6VhfssD6Nke+IK4z/eZHSqYexG4qewzclHy2dI6pFLEQ7yNaBuH05NbHw
 TMkQ4e3dCcqoph0OK4LrKnNXG7Jmd2n7YrgU6xuLzQpsJOMyzi/01CgaFEBTRYiBUxqZg1u38s
 GW7AdTvC7QZ3HOWcO/vXF3feXd0sqfQf314T7SVkEEq3LQFmgBfVhOaZwzQNtPlUGG5OlnEqR+
 ipi5oDqdILoD0UULgvGQP57c
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:19:55 -0800
IronPort-SDR: sz3UrHErxF3C6b0x4WAwYOG8BLErBVf1DNTHIxnl8mbJ75rulnsBHGwiOFjypjhSOlk7/5Ol+A
 e8dZSTX7vlZekgMrx4AsPs6PecmpZrcG7QofasU7n7uj4/b6Qgr8P967RVO8hL9jQ0v13SL8yk
 uxdDte5zhuFJLTpiDRuRRxaIxRL48gDzP/E5aChFZGqFVQYymfpR3KTZ0bu3IU/YTHO9iS+Vxm
 G4x3+I5C9e/XK/WPFIFJsVn46LksxRvSOdee1gOUes+z4qfTZ6nC3v+Www2d9Qav4xOdO6PJdf
 0FQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:37:46 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 14/20] loop: remove memset in info64 from compat
Date:   Mon,  1 Feb 2021 21:35:46 -0800
Message-Id: <20210202053552.4844-15-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In current code loop_info64_from_compat() is only called from the one
caller loop_set_status_compat(). Initialize the info64 local variable
to zero before we pass it to the loop_info64_compat() so that we can get
rid of the memset in the loop_info64_from_compat().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 667a3945bf39..2029ca399ea3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1731,7 +1731,6 @@ loop_info64_from_compat(const struct compat_loop_info __user *arg,
 	if (copy_from_user(&info, arg, sizeof(info)))
 		return -EFAULT;
 
-	memset(info64, 0, sizeof(*info64));
 	info64->lo_number = info.lo_number;
 	info64->lo_device = info.lo_device;
 	info64->lo_inode = info.lo_inode;
@@ -1794,7 +1793,7 @@ loop_info64_to_compat(const struct loop_info64 *info64,
 static int loop_set_status_compat(struct loop_device *lo,
 				 const struct compat_loop_info __user *arg)
 {
-	struct loop_info64 info64;
+	struct loop_info64 info64 = { };
 	int ret;
 
 	ret = loop_info64_from_compat(arg, &info64);
-- 
2.22.1

