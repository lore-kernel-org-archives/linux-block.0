Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3E4C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F179264EDC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhBBFiy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:38:54 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8090 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhBBFiw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612244332; x=1643780332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jnkcazWpDtA8Y/1t9LF2AY34gS9NTjFtP15AuXyA4aY=;
  b=YvjydcCaoR8GFAsLQXa2FJ65CYDsjfRmVs/N5jZr0kqipOd7qx2u/nQ6
   1IWi7bYSma0OKfn2/PRyOtq+OZXGo8HZ6Xwjjq587rYMmQ5dYZtJyqrFH
   hRXQnKTnzm+FSX+Lo0mHzrtjRDDRpn+tVhIBtxtgGwPLpPahgKWybE2rW
   4KKk7xRrpCkV61jjkxZAcchwvhaicpdm5wxXJ2g7sEoPxaDCBDbGhac7J
   desZDeRsiJdGEOylRz1UE0t7z7b4Vv4DOR6xSb3lK5oinMtUMwYSC8CJm
   a4yep606pFR92W+qq6CqmAK9CdwUfJM5/T/H19nCsWxEjbNgMFQ3LKDD9
   g==;
IronPort-SDR: tx3uaULpnFcHkTBfI+jhXTKnH46bXZ59e7rRU8Sn2X3qBRumPzd4tdTnw6mMA+GDczhAJ5SuOI
 nyGo1XdtZjOx7mUpPYiRqZr68wHbc1vK6RR8ZkLieMcpZWL1mPrcEWMAg8iiFKl9F/XgRUuKtm
 RFeT8f4S5iQ2Jp1UNjXucNlcTtlRGWe7y2IrUzVnUX3e9vVqkDg4SGCCtTwMwcGckbdgiIf/yA
 TefrZJYPgPlgs+6BDtFZNgvcpDlaxQbDWRPF5DHFogCAXZB+FJc6AWQIUof0oReFM7surzOk1Q
 CAg=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="160067278"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:38:12 +0800
IronPort-SDR: pik/+1ZHAisv2neR3qyRg9vzWTKgkP0JCB5TkZCOE7ykbm3sFIFU4mc++lNod1YTLKYS7j3v44
 nt2a98qvht4XXTYBdayrf3xBmq9Snvw1kjNSTO6a/z4G6kETg5WA1cTwtt8z6HSxuctcg2rkyO
 RhIY6Srk9Zl+Ed56aYUy66a47KlUSo/ixxDl4VLivzXTQPzkzYDkcMlKGpigsbMl18jLzLAeOm
 vA64DIHZlUanvvdnwwrbW8t38vhSai7Q6waRGXPpQSOJBcXRoM993vNj3O9cZxunCKWk3LV+o5
 irHO/ywe0uerU79M97XHn7pk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:22:20 -0800
IronPort-SDR: +5mOU5TXeULAnc7u0ZFohTur92kAZA/7wh4ZTTmc1l31xYEr64rTKX2bApvecARDLbQeIWk6cz
 PyxlSQsW6qYIO9oTWQle47AtZ4ELoTyjuPgV3IdtfeYAoOar4Wqa2LrK+BcWBYw/X90lNe3WGt
 NbrxCgLAkDoUY8gCtEHrFZZT9PWJZMn0YZfwofIWEVutZt3QYNDgOSmYo94BmQYfMpUJaI033n
 rJ6RcqYk/giWbpB5aFxkUe4U7b7f5mdrMWmDXI3EVY9PCGejzNKlvxuFzkjKHeD+59IQK99woq
 mgo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:38:12 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 17/20] loop: change fd set err at actual error condition
Date:   Mon,  1 Feb 2021 21:35:49 -0800
Message-Id: <20210202053552.4844-18-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
References: <20210202053552.4844-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function loop_change_fd() set error = -ENXIO before checking loop
state, error = -EINVAL before checking loop flags, error = -EBADF
before calling fget and error = -EINVAL before comparing the old file
size to the new file file. None of these error values are reused for
the above conditions.

Conditionally set the error after we actually know that error condition
is true instead of setting it before the if check.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index af3e3bcd564d..89f9c73bb2af 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -704,19 +704,22 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	error = mutex_lock_killable(&lo->lo_mutex);
 	if (error)
 		return error;
-	error = -ENXIO;
-	if (lo->lo_state != Lo_bound)
+	if (lo->lo_state != Lo_bound) {
+		error = -ENXIO;
 		goto out_err;
+	}
 
 	/* the loop device has to be read-only */
-	error = -EINVAL;
-	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
+	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY)) {
+		error = -EINVAL;
 		goto out_err;
+	}
 
-	error = -EBADF;
 	file = fget(arg);
-	if (!file)
+	if (!file) {
+		error = -EBADF;
 		goto out_err;
+	}
 
 	error = loop_validate_file(file, bdev);
 	if (error)
@@ -724,11 +727,11 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 
 	old_file = lo->lo_backing_file;
 
-	error = -EINVAL;
-
 	/* size of the new backing store needs to be the same */
-	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
+	if (get_loop_size(lo, file) != get_loop_size(lo, old_file)) {
+		error = -EINVAL;
 		goto out_err;
+	}
 
 	/* and ... switch */
 	blk_mq_freeze_queue(lo->lo_queue);
-- 
2.22.1

