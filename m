Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41223 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1Wr3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Sep 2018 18:47:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id m77-v6so4653223pfi.8
        for <linux-block@vger.kernel.org>; Fri, 28 Sep 2018 09:22:58 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] kyber: fix integer overflow of latency targets on 32-bit
Date: Fri, 28 Sep 2018 09:22:50 -0700
Message-Id: <56a03261ec32ef67a8ce36106bf2f2f7638600ca.1538151757.git.osandov@fb.com>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

NSEC_PER_SEC has type long, so 5 * NSEC_PER_SEC is calculated as a long.
However, 5 seconds is 5,000,000,000 nanoseconds, which overflows a
32-bit long. Make sure all of the targets are calculated as 64-bit
values.

Fixes: 6e25cb01ea20 ("kyber: implement improved heuristics")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/kyber-iosched.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 2b62e362fb36..eccac01a10b6 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -79,9 +79,9 @@ static const unsigned int kyber_depth[] = {
  * Default latency targets for each scheduling domain.
  */
 static const u64 kyber_latency_targets[] = {
-	[KYBER_READ] = 2 * NSEC_PER_MSEC,
-	[KYBER_WRITE] = 10 * NSEC_PER_MSEC,
-	[KYBER_DISCARD] = 5 * NSEC_PER_SEC,
+	[KYBER_READ] = 2ULL * NSEC_PER_MSEC,
+	[KYBER_WRITE] = 10ULL * NSEC_PER_MSEC,
+	[KYBER_DISCARD] = 5ULL * NSEC_PER_SEC,
 };
 
 /*
-- 
2.19.0
