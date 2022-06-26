Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AF1C43334
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 11:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiFZLCp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jun 2022 07:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiFZLCp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 07:02:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2C013E36
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 04:02:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so9776234pjr.0
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 04:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SxwqKcAS5vzfDsfEh1I6SckKRYP0UlwY6aLKNXCdg08=;
        b=EAfAI6oq3T7C39hERy4sM8hlCPcWyocC9Np+zU9ZmhmpThjpOivp/Myv87xYifyRU7
         xdOnIGSx7C9peoZ68P3fJgt/dAgOjI70KxbtGk+/pF28GrDpJz387GXgXNRKx134QJXf
         ykP8bQLicnwlzVbhz0vDeQF2Ubo54B/yLTxvdnUOmJfwpPC1ZCKtwk8bYHXlbI3/b8eB
         dMZqTN7/SG/sfsS/a5CvLpfk2oY2DUZaWjTTkOWVqaVtJ5i82BMu2uMcthzio5u2J84Z
         xsiFRY5qf7kuEfxHeMhCFQOlTOvG3lAlm8eQpisJx1eLlzfBKc+xll1x08WYQaiA240i
         dMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SxwqKcAS5vzfDsfEh1I6SckKRYP0UlwY6aLKNXCdg08=;
        b=a6Nehvp8HyolQ6tDbamGyiorRK2Sej2K4fbOwJm55xFWXS2VT6PGOG9VuwT3vOlsdX
         jTHDt35XD47jDNeQGWMJtNczEQUzwiPKQnhIt20oy/NzqzWNMR2nIjGIhdf0hxjqO8nM
         JlsDXIDaQi6JCrcQD2mjJeK0SGGMjKwMGvtx2adAodfGgXLBAWNJH32ybddfJyKiPkft
         3zAMWNr14scVPoK0mJKPLQ9rLWl9Y5p4GEwWRGSfZczBAsD1pP5AFIG65hUf3ZN7zhE5
         IUkZNKqBxn0EHix3KdVYm47wvn1TAImMvAAr88Aedx1AcSAtBGxKooEi4bBmdRrxpVfz
         ovYQ==
X-Gm-Message-State: AJIora+/VSOAQZO6RC2lv4ybzgRLqcApruU0i2GjRsN057Vcqp6ZLiL6
        70FhLoxIAfcvVQYSlwb9K3GEd0tnQM5cNw==
X-Google-Smtp-Source: AGRyM1sc4pZP/T1TeYfiMBY0Uin7T3GBotSKnu+uPFGXtdmkIQDvRVvGCeXAUty1F5taRfBkIBjpvQ==
X-Received: by 2002:a17:902:d2c4:b0:16a:5c48:8312 with SMTP id n4-20020a170902d2c400b0016a5c488312mr9011239plc.45.1656241363793;
        Sun, 26 Jun 2022 04:02:43 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id 64-20020a17090a09c600b001ec9ae91e30sm7091495pjo.12.2022.06.26.04.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 04:02:43 -0700 (PDT)
Date:   Sun, 26 Jun 2022 04:02:39 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     tim@cyberelk.net, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] paride: Fixed integer overflow in pt_read and pt_write
Message-ID: <20220626110239.GA58252@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In pt_read() and pt_write(), the "size_t count" variable is
assigned to the "int n" variable and then size check is performed.

static ssize_t pt_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
{
	...
        int k, n, r, p, s, t, b;

	...

        while (count > 0) {

                if (!pt_poll_dsc(tape, HZ / 100, PT_TMO, "write"))
                        return -EIO;

                n = count;
                if (n > 32768)
                        n = 32768;      /* max per command */

If the user passes the SIZE_MAX value to the "count" variable,
the "n" value is greater than 32768, but it becomes a negative
number and passes the size check.
In other words, we need to add a negative check as well,
since the size check makes no sense.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/block/paride/pt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
index e815312a00ad..f37aa1349622 100644
--- a/drivers/block/paride/pt.c
+++ b/drivers/block/paride/pt.c
@@ -787,7 +787,7 @@ static ssize_t pt_read(struct file *filp, char __user *buf, size_t count, loff_t
 			return -EIO;
 
 		n = count;
-		if (n > 32768)
+		if (n > 32768 || n < 0)
 			n = 32768;	/* max per command */
 		b = (n - 1 + tape->bs) / tape->bs;
 		n = b * tape->bs;	/* rounded up to even block */
@@ -888,7 +888,7 @@ static ssize_t pt_write(struct file *filp, const char __user *buf, size_t count,
 			return -EIO;
 
 		n = count;
-		if (n > 32768)
+		if (n > 32768 || n < 0)
 			n = 32768;	/* max per command */
 		b = (n - 1 + tape->bs) / tape->bs;
 		n = b * tape->bs;	/* rounded up to even block */
-- 
2.25.1

Dear all,

I submitted this patch a week ago.

Can I get feedback on this patch?

Regards,
Hyunwoo Kim.
