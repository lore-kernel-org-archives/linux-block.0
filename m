Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC3AC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B16320866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KdlJGJK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfEAE3b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:29:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27525 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfEAE3b (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685052; x=1588221052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Htdj/Q7bSm/sNYH+XW98L4WOo8z3fOjC+VVICuh8HE=;
  b=KdlJGJK6aj8VrvqcnFotxdPbn+83wYBrx2QgBkiMfdQFN/yAq2vAyEgB
   HZbWCvTIOUjWTwdaUUZn6gNqjbhpkODXvZtnsiTgr49hdY8kyziHz5S3r
   XhILUwcqDqp52mZuY+G384XnTNGNZ0bH8utA1ESoGiYCXnCZSOl8HkcN5
   oei6T3NZsD/f9EIKaiXV1veD2/990Hun4J9LZF35ONTroLkeUhcNA8DEu
   SWl5UhRwxHQON9yux5Evh8g7vne5iECI0/ixSZjsLZ0bTzVvt3Ly3iDk8
   IxdTwhkB99ySLxgITwdB/Hvr8gNlrq2MKjqFc8LC1BSIij3xsnXpv4Mti
   w==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="206432298"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:30:52 +0800
IronPort-SDR: VJhiCsKrCsDqaNxFP1c+gOJf49xP9uJi6OeAebCw4z8zmPC02y5r4E1Cl9m9DA0hPtgE1l8nGI
 P7k+qmJStU76TCIL+cGDVHDaURjD/FFniZh1mjKGkiko61Ub3r7YxJb6z8JKdMs7Q9l4Xuljgo
 DFumqlOBbBgs2tmDKZ9Tgr9qVm1rA3reyAsLeqKzgUHWiT94LYoc2o5WnHX4SRbzDJwZy4oEyN
 r4qJ+cR67UpgPYxTgp1ikIbpTJfgZVGbwG3uG+GI3DUFLcWLK2kdp8x0vYO9naPpXD9J0dPEQ1
 nzLNVvr8K35ZF0YJtzq+gW+L
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:08:00 -0700
IronPort-SDR: sdskmMAYw8OZMpL1Lp6gEZ4WQ/N0cOJxXZ4f9vgnEyPRr3O2O1RdrdjMVob8Yz91uJgGtRCOKm
 vVmon/+j4+mzwLdD1yEk4vnu84cLmDE3H68o9Eqh3HVDvdLrkSjMZYnFnZScfVy9CUsFKRUGw1
 Gsm2CP0LKZ8ao1Eg3vacd0AHkS8kTrVPiUVml7E93dXUnFzBV96t3xbFzsRelMldxm6KDglzwO
 1GJ1RKYIJ5GTBC1VUKu7BS3ZDdTihgQYF6WwaZm8g8kOUuNxiYiVnviiqluNZ26RQYhdBuIgD5
 cVE=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:29:31 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 15/18] power/swap: set bio iopriority field
Date:   Tue, 30 Apr 2019 21:28:28 -0700
Message-Id: <20190501042831.5313-16-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/power/swap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index d7f6c1a288d3..74b6d11fabe2 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -33,6 +33,7 @@
 #include <linux/kthread.h>
 #include <linux/crc32.h>
 #include <linux/ktime.h>
+#include <linux/ioprio.h>
 
 #include "power.h"
 
@@ -273,6 +274,7 @@ static int hib_submit_io(int op, int op_flags, pgoff_t page_off, void *addr,
 	bio->bi_iter.bi_sector = page_off * (PAGE_SIZE >> 9);
 	bio_set_dev(bio, hib_resume_bdev);
 	bio_set_op_attrs(bio, op, op_flags);
+	bio_set_prio(bio, get_current_ioprio());
 
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
 		pr_err("Adding page to bio failed at %llu\n",
-- 
2.19.1

