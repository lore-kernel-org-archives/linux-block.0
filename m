Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71C528DC3;
	Wed, 14 Aug 2024 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650998; cv=none; b=un7hZQEt9+DDdV5pIBlSYbwv6TTKAvlD4R2svHDPRXQkpyYdMEInmFaWADbIwCW8J5fJdsoIUlcgaHTAEU9MtxDBrGcv9ds52GpMDyQWRJ2DsF9G2CStm/RrWUcDL2JFEInC5ewUo4bxXM6QJqewwEIRJZmLCKXMtVoojkk0ZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650998; c=relaxed/simple;
	bh=NSlCO+Fl8x/1r0naKZ357n9c8u82qCXoKXbjxnnJsV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aWu9o2nOiqOetYo74nvoBH+xU1gETHfGhG2ahg6feDJXYYOeJckL5oNAhkUvJhCxNvv2fFOTeF4jDHof3EpszudZdUNDa51AWW+qxxpR3OUKInkCwsKJO3e+buicpXgDqZUfCHAtuxFDTOxDdLsFV0JFVg1UmYtIr1YXMfA30FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gijmh+rg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gijmh+rg"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a9e25008aso8038666b.0;
        Wed, 14 Aug 2024 08:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723650995; x=1724255795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xxsll+pVZRGn0FzujmorAmwoz7cMXghuBXxivoABDNU=;
        b=gijmh+rgB+OvQz5EzsvzpN80mfysqvmfXNpcDUXvO++905EVaUuTyapiSgLJF3d549
         9xPftLfA6pBtzL2CdzihqwzEZRvwHATQoxTxBVypGD137MX7FpdMTlNzvO3dPManDhix
         GfgJ7xfgHTD+6ehm9bn7UvusR2MbWAOmvt1apHrIsbY1TyeCNn/CnACv8aKGwdPfghAR
         eITVJ0hdLVVASmLaLR36FSI4SkLCio31QdCK+MoO+mK657tlWK8ODk+U/LTV0YxqZtLp
         B0oxw3JXxFKevanPb5fz9UMhbX7sxzvwuhDajn8o9w5juLDGMV9Ktlze28QgeBLFV2wo
         /hSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650995; x=1724255795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xxsll+pVZRGn0FzujmorAmwoz7cMXghuBXxivoABDNU=;
        b=rPmWw9PN2UHWxf2Ilw3GaSZ69tM5eiM2sK5yMi6RSpTsN/D0WO/oWtR2B9FZvalX0m
         3DF5U/sfD4E9LUCt3lBAA09pog6ipcoidMXUEwejNkpNMd/JpF8Iz4C/gw7NLsmsN+lA
         QqovCYdbMCTZHGeFCTQ8liciCRd0MLmFKVJxlp2lK6c7PsJLcmeARrZ2stCw4Hhw99R1
         CESJDbU4HZuCaUS1U+rHRk89wzVpDYB9u2ZRv9k49SaaBM+EyosuihfOLsN+2VYTE2X8
         BF0J3qGV9bIkf57SMqDar/hm8XjQCmbd6megGzLnwkby6p7CVBW5znnFwuTaAS1A4EfK
         wreA==
X-Forwarded-Encrypted: i=1; AJvYcCXENEcYEioN+BNnTDqFG75qJrrW3tXOad9P8N+djnwX5SIwqIsj4GGvhrtyEAKeDFTnCsJjzaz/NZmXurw3zBId7Jebpoe2mHVrhob7FXehyN14uYHbptDK3u5hdzoqNPEi6I79qz0bMUi8/UzCMHoPPvjbjI/9BkxZn06K/oXB28B+Dig=
X-Gm-Message-State: AOJu0YyaO7TKWSOOdsXTlEVlo/1YihcXSte+rM/ulAV+slewb4/EtQkC
	TKXDCrVolk4RMqHsdlFbmYcjHMs057ek4WufXeDCL/Sc6dEoV5IO
X-Google-Smtp-Source: AGHT+IHSIDF2o/ri01Axg1dKEB5B8X1t+NpBeJVpHYvhAjtWEIMFA65LKKgFjiSfXMFmfZS45OGHQw==
X-Received: by 2002:a17:907:d3c4:b0:a80:f7a7:5e39 with SMTP id a640c23a62f3a-a8366c1fb14mr235005866b.3.1723650994273;
        Wed, 14 Aug 2024 08:56:34 -0700 (PDT)
Received: from localhost.localdomain ([83.168.79.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411ae44sm188977966b.117.2024.08.14.08.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:56:33 -0700 (PDT)
From: Karol Przybylski <karprzy7@gmail.com>
To: paolo.valente@unimore.it,
	axboe@kernel.dk,
	corbet@lwn.net
Cc: Karol Przybylski <karprzy7@gmail.com>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: block: Fix grammar and spelling mistakes in bfq-iosched.rst
Date: Wed, 14 Aug 2024 17:55:58 +0200
Message-Id: <20240814155558.3672833-1-karprzy7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch corrects several grammar and spelling errors in the
Documentation/block/bfq-iosched.rst file. These changes improve
the clarity and readability of the documentation.

Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
---
 Documentation/block/bfq-iosched.rst | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/block/bfq-iosched.rst b/Documentation/block/bfq-iosched.rst
index df3a8a47f58c..a0ff0eb11e7f 100644
--- a/Documentation/block/bfq-iosched.rst
+++ b/Documentation/block/bfq-iosched.rst
@@ -9,7 +9,7 @@ controllers), BFQ's main features are:
 - BFQ guarantees a high system and application responsiveness, and a
   low latency for time-sensitive applications, such as audio or video
   players;
-- BFQ distributes bandwidth, and not just time, among processes or
+- BFQ distributes bandwidth, not just time, among processes or
   groups (switching back to time distribution when needed to keep
   throughput high).
 
@@ -111,7 +111,7 @@ Higher speed for code-development tasks
 
 If some additional workload happens to be executed in parallel, then
 BFQ executes the I/O-related components of typical code-development
-tasks (compilation, checkout, merge, ...) much more quickly than CFQ,
+tasks (compilation, checkout, merge, etc.) much more quickly than CFQ,
 NOOP or DEADLINE.
 
 High throughput
@@ -127,9 +127,9 @@ Strong fairness, bandwidth and delay guarantees
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 BFQ distributes the device throughput, and not just the device time,
-among I/O-bound applications in proportion their weights, with any
+among I/O-bound applications in proportion to their weights, with any
 workload and regardless of the device parameters. From these bandwidth
-guarantees, it is possible to compute tight per-I/O-request delay
+guarantees, it is possible to compute a tight per-I/O-request delay
 guarantees by a simple formula. If not configured for strict service
 guarantees, BFQ switches to time-based resource sharing (only) for
 applications that would otherwise cause a throughput loss.
@@ -199,7 +199,7 @@ plus a lot of code, are borrowed from CFQ.
 
      - On flash-based storage with internal queueing of commands
        (typically NCQ), device idling happens to be always detrimental
-       for throughput. So, with these devices, BFQ performs idling
+       to throughput. So, with these devices, BFQ performs idling
        only when strictly needed for service guarantees, i.e., for
        guaranteeing low latency or fairness. In these cases, overall
        throughput may be sub-optimal. No solution currently exists to
@@ -212,7 +212,7 @@ plus a lot of code, are borrowed from CFQ.
     and to reduce their latency. The most important action taken to
     achieve this goal is to give to the queues associated with these
     applications more than their fair share of the device
-    throughput. For brevity, we call just "weight-raising" the whole
+    throughput. For brevity, we call it just "weight-raising" the whole
     sets of actions taken by BFQ to privilege these queues. In
     particular, BFQ provides a milder form of weight-raising for
     interactive applications, and a stronger form for soft real-time
@@ -231,7 +231,7 @@ plus a lot of code, are borrowed from CFQ.
     responsive in detecting interleaved I/O (cooperating processes),
     that it enables BFQ to achieve a high throughput, by queue
     merging, even for queues for which CFQ needs a different
-    mechanism, preemption, to get a high throughput. As such EQM is a
+    mechanism, preemption, to get a high throughput. As such, EQM is a
     unified mechanism to achieve a high throughput with interleaved
     I/O.
 
@@ -254,7 +254,7 @@ plus a lot of code, are borrowed from CFQ.
     - First, with any proportional-share scheduler, the maximum
       deviation with respect to an ideal service is proportional to
       the maximum budget (slice) assigned to queues. As a consequence,
-      BFQ can keep this deviation tight not only because of the
+      BFQ can keep this deviation tight, not only because of the
       accurate service of B-WF2Q+, but also because BFQ *does not*
       need to assign a larger budget to a queue to let the queue
       receive a higher fraction of the device throughput.
@@ -327,7 +327,7 @@ applications. Unset this tunable if you need/want to control weights.
 slice_idle
 ----------
 
-This parameter specifies how long BFQ should idle for next I/O
+This parameter specifies how long BFQ should idle for the next I/O
 request, when certain sync BFQ queues become empty. By default
 slice_idle is a non-zero value. Idling has a double purpose: boosting
 throughput and making sure that the desired throughput distribution is
@@ -365,7 +365,7 @@ terms of I/O-request dispatches. To guarantee that the actual service
 order then corresponds to the dispatch order, the strict_guarantees
 tunable must be set too.
 
-There is an important flipside for idling: apart from the above cases
+There is an important flip side to idling: apart from the above cases
 where it is beneficial also for throughput, idling can severely impact
 throughput. One important case is random workload. Because of this
 issue, BFQ tends to avoid idling as much as possible, when it is not
@@ -475,7 +475,7 @@ max_budget
 
 Maximum amount of service, measured in sectors, that can be provided
 to a BFQ queue once it is set in service (of course within the limits
-of the above timeout). According to what said in the description of
+of the above timeout). According to what was said in the description of
 the algorithm, larger values increase the throughput in proportion to
 the percentage of sequential I/O requests issued. The price of larger
 values is that they coarsen the granularity of short-term bandwidth
-- 
2.34.1

