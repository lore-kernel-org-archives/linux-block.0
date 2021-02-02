Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E14C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A8264EAC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhBBFjB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:39:01 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14239 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhBBFi7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244339; x=1643780339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eNON0hxAzYtFyH9oqwN+bwV/btPzvN0uc/SZgJwurdw=;
  b=r3oBlrcPLFSdDGyEEhdvJEpEUJqwlEotvOxQFlBIM+jrZjD9zyYhfQIp
   IP6E4NzGOMIkjjrEXqc30K96+53YT3z98cXfMGjh3cfnDwMSdR+hrjyAt
   /LMCXNCWlaHFDFg2SNKbwNOjv6HPS1ItCdhCOO2HEhIVPcXs4mQfrz26X
   PvjRAP3OGKref/N7dqxpoZMyRkfZhN5B7qI7Q4m7qspXqZRQ5LDbJK697
   orpfRA3JgYQHoZVP83lAuqAjW1nKGGNPgZ6kRsjWngOig3JVum5GThA3G
   OvbZZGUpTXeB/0UEsFZONPmzROgDKLSGWW+mRlwJgq67vfj/IJ4Wgr4ld
   w==;
IronPort-SDR: sw42MJ0ADhJLtx14v/sjzy1LHIMVs6ohM+QGE6Dsxz9E7zpfKM+cLHAgIVt8dZVEwX50MdK/ZF
 tkMuWVhxbIrwSrxoiioOtXt+vClBb8txqTWbwcSyCrOnlbja8NU/LdAoqcl5sgC0HPMstsbvc6
 2b3PIvhXgTcRrkB3jPmlx2S1b2jNWwqfLSkBtGKuPRtl008LFtO9z7oPxmJTRyCrz03HZfUZEc
 QKMhHcPX/h6ax51PaIlarklDQkoEXw9DYH8QtFcbEbp8VyvZxkUbIR2I6XL4mQW6VQvsTld9l5
 aSA=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158885864"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:37:53 +0800
IronPort-SDR: UeL+bcB4VQHZb8HeQi5uaFBEOFElYMRXQavrc1OUPFA3OsFhdjfD/k9/ZLykHOsqAYfAfay//q
 FofTHMHhQGSMrVGGhS+wOa1GDkcBFOkSjWpdObPPO53nqkKqsEDVoppCZbwVFp0lQqVNgUog7/
 ztdlt2kXHI0NcZn0FyR1T1rn+MMww4yIz84VNFAgDVkY0Ufw6VA99hUlZNtXNLtTatpcbTa4Gb
 rTbPeo6Cv9uemtvXSVgL1MH1J8G7Dg9INiy0yCbutADKRjK0GMFOA55WSfGWfNBojxyMnbMMae
 c56G6y2O9S9omnHMTaJMqt+U
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:22:03 -0800
IronPort-SDR: UEzaKyFqz/3mWQH94JnkW+Dfu/9qmUj5jkaFV3YOPAGfw8wL/YpBy5Oc06YiaDBLgIbmdEbgvQ
 gfx6xUMjpOlyDKEkSnKwQwWmrfLhVGJFKumgVslPW5W7ZZY+EX9tdRlWnLtVc7T6hLsMDeFjHt
 bcoxqP15VLoXXCNBJEQM/MKMv8HhpwkPOg39VeKb1bPik03+vkPN/4T4/UEINWvEf+YPb3rx9n
 rbPpF6BGR3yaXzIed9gmeE9ragdJHyDisV+cBubxUVUjIjJpClFEHYsJTAbFulD6um5a94WzRg
 2tU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:37:54 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 15/20] loop: remove memset in loop_info64_from_old()
Date:   Mon,  1 Feb 2021 21:35:47 -0800
Message-Id: <20210202053552.4844-16-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In current code loop_info64_from_old() is only called from the one
caller loop_set_status_old(). Initialize the info64 local variable to
zero before we pass it to the loop_info64_from_old() so that we can get
rid of the memset in the loop_info64_from_old().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2029ca399ea3..62f622791fb5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1460,7 +1460,6 @@ static int loop_get_status(struct loop_device *lo,
 static void loop_info64_from_old(const struct loop_info *info,
 				 struct loop_info64 *info64)
 {
-	memset(info64, 0, sizeof(*info64));
 	info64->lo_number = info->lo_number;
 	info64->lo_device = info->lo_device;
 	info64->lo_inode = info->lo_inode;
@@ -1513,7 +1512,7 @@ static int loop_set_status_old(struct loop_device *lo,
 			       const struct loop_info __user *arg)
 {
 	struct loop_info info;
-	struct loop_info64 info64;
+	struct loop_info64 info64 = { };
 
 	if (copy_from_user(&info, arg, sizeof (struct loop_info)))
 		return -EFAULT;
-- 
2.22.1

