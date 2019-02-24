Return-Path: <SRS0=0UXK=Q7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5366EC43381
	for <linux-block@archiver.kernel.org>; Sun, 24 Feb 2019 14:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226BD20652
	for <linux-block@archiver.kernel.org>; Sun, 24 Feb 2019 14:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3+RXfPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfBXOT7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Feb 2019 09:19:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37448 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfBXOT7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Feb 2019 09:19:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id q3so3255586pll.4;
        Sun, 24 Feb 2019 06:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kAyHt58DVE9hh2oPjT8JMjK4jKk/dc2SmFBds3zP/zA=;
        b=E3+RXfPiw4+g9+mtxR672o4eHrffYX2PipqOv7KWzXYFhWEfR7JIVEvEGYKc8S1RSk
         4N3cmctUqyrct7xBV/OcO5rx9SGa57tHjgMtRwkO0rAws2hwN31ufQjoBgTyKPxsKIeG
         lg/NdHzJZzet5nSW8dHkESdkX8SHkKwHFJuKTcdoR5S/dN7wyNO8oUJCaSmUGVtwDxYZ
         GeCoAFKl8TUTvUpMatk8SnBeAsacj9edsK6iiHXymWsTjq5/rXJVo9d0/gJcUWCRCjlY
         7PTjET6EDRQaxLt6yeK58CtT2j+DQ8ED7e3Dou1J0E0o8QFH7jV3AxlaiJ16isjC3LyP
         9Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kAyHt58DVE9hh2oPjT8JMjK4jKk/dc2SmFBds3zP/zA=;
        b=VJ2u2dsG7CqZxFKpDbfPHQkwm4n7YJorurLd+h1+scLS9ahsOfqY2TsJEqIFLAQaIF
         HpQUd28dt2fx8q5+lCHgmpayUVmmjKGCeGbQDcVfpFabR3AO3xtYCeE0/fcSn0Nshbvx
         K8EckAuj0wNo/Z5jCQR4OqLlIjvKQfZFz6uoJNqu0FfRhWxqvaQ6tLKepwsxTzKi9Boj
         YdIfqW771Ko+Hfmpn2kZ0IcVH7DOeBu6/ei5CWCRNgWa8+zTl59quatQwAe8RmxS+wrT
         z8PG6yqqbMXREpM0EMtjnT5do8paidvQ1W1SctNZkLHooZyGxlN+UBK79vw0o0g02nWH
         Yr8w==
X-Gm-Message-State: AHQUAubqozcAo6olrlQgw7OgFt7oMIkFrybefk+M8khxlntYYsQWE1NF
        i3YLNscV55pzMvMTlx2IzdOcdZnK
X-Google-Smtp-Source: AHgI3Ia/sbshLrsSRi56iTZBVtuNLen/TzXSb0/NNnIbKIMRh8P+0GcFv8sWKab7fYi5eV4TnOUjDg==
X-Received: by 2002:a17:902:6b46:: with SMTP id g6mr14414662plt.21.1551017998849;
        Sun, 24 Feb 2019 06:19:58 -0800 (PST)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id r28sm15645460pgl.72.2019.02.24.06.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 06:19:58 -0800 (PST)
Date:   Sun, 24 Feb 2019 19:49:52 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] badblocks: Prefer unsigned int over unsigned
Message-ID: <20190224141952.GA3653@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace unsigned with unsigned int to improve readability.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 block/badblocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 91f7bcf..e3f90c9 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -66,7 +66,7 @@ int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 	u64 *p = bb->page;
 	int rv;
 	sector_t target = s + sectors;
-	unsigned seq;
+	unsigned int seq;
 
 	if (bb->shift > 0) {
 		/* round the start down, and the end up */
-- 
2.7.4

