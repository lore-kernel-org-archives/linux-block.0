Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D45C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 15:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CC120839
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 15:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="DMnJ5qNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CC120839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeLLPpz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:45:55 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37308 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLLPpz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 10:45:55 -0500
Received: by mail-yw1-f68.google.com with SMTP id h193so7139836ywc.4
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 07:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=/dzfMI0ou/oZW5ejUFORS/QrjPAze86tmJ7a+lo3X3o=;
        b=DMnJ5qNzSIahvstdspujGNm2ctN5suY6CPhMQhyCWZvlEIqSkjUTtzOlIBnaQNEKZH
         U8Cd8xvMfuLdIvakLb4sFAdt5I/LROq7lObHyZhrvvecQjzZQWtgxHZrSHauph3tuKkP
         TxHoJqXGHewgOrnMLCBzB0kpN2Nnqt3sqAXu1Do4usnS/MGldeHHgg84m9426GN7lBaR
         l7vvOq/R+uf1p0eV5yRfNT4m39Pi1HUbBqPktD3k/m6Mz3aQQliz9jDSj4R17k6pdTT4
         0yablU0mvv4Potsh/zrO55SpqcpkR9an10L0Lpm10Rgn1wr7dMCUHxB0FbTeIt73Ul0f
         6/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=/dzfMI0ou/oZW5ejUFORS/QrjPAze86tmJ7a+lo3X3o=;
        b=NxpFUlhH9vn2frwIM6mG05+5I7SH+7TWpVnbOd1Tm6/oF2X5iR4794uJHfjwS6p6/q
         R/jxDWs+2oeawtGXJ9SbH6lIjo3ZfQmQQdIu6+u5jBrw+2gDWhn++bYE5EOuCmHhzlqW
         mqbU5XtCXEyUYGf4QlTwOgIFIBbA7g0h1xKXwIMKrPqfcqpE8xAA3MGpnl8ZBVqhZv0d
         MTJ7gjcDb33M6qtLTx97wb0yKTGTdmN8krdruNcGryy1XDeVeLuALl1n8C8viMomNFMC
         hfiTP0XfgxCxV+8hIDq2/YYqmymb8DOsAKtClh4uGMDP/ZWb5b+p6VvCTDSFGSeW4KqU
         h5xg==
X-Gm-Message-State: AA+aEWbAH2zTglngm3KM55mNw5eG0aPpebWRchTuQRPD+F/EN2fPZBkm
        3z/sAdpQrlFTjn7B1QWRhxm96tycI6c=
X-Google-Smtp-Source: AFSGD/X0iemLDFZxH+R3hYKmEg3l3fytprZTptyF+ZKHNF4+djBuj3o6OVg5pkV87ZQ/PjxJsMouFw==
X-Received: by 2002:a81:4853:: with SMTP id v80mr21375228ywa.266.1544629553853;
        Wed, 12 Dec 2018 07:45:53 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u127sm5471944ywa.109.2018.12.12.07.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 07:45:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     osandov@fb.com, linux-block@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] blktests: make block/026 run in constant time
Date:   Wed, 12 Dec 2018 10:45:52 -0500
Message-Id: <20181212154552.10422-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The original test just did 4g of IO and figured out how long it took to
determine if io.latency was working properly.  However this can run
really long on slow disks, so instead run for a constant time and check
the bandwidth of the two cgroups to determine if io.latency is doing the
right thing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/block/026 | 77 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/tests/block/026 b/tests/block/026
index d56fabfcd880..88113a99bd28 100644
--- a/tests/block/026
+++ b/tests/block/026
@@ -22,6 +22,16 @@ fio_results_key() {
 	jq '.jobs[] | select(.jobname == "'"$job"'") | .'"$key" "$resultfile"
 }
 
+sum_read_write_bytes() {
+	local job=$1
+	local resultfile=$2
+	local readbytes writebytes
+
+	readbytes=$(fio_results_key "$job" read.io_bytes "$resultfile")
+	writebytes=$(fio_results_key "$job" write.io_bytes "$resultfile")
+	echo $((readbytes + writebytes))
+}
+
 test_device() {
 	echo "Running ${TEST_NAME}"
 
@@ -41,10 +51,9 @@ test_device() {
 	direct=1
 	allrandrepeat=1
 	readwrite=randrw
-	size=4G
+	runtime=60
 	ioengine=libaio
 	iodepth=$qd
-	fallocate=none
 	randseed=12345
 EOF
 
@@ -54,10 +63,9 @@ EOF
 	direct=1
 	allrandrepeat=1
 	readwrite=randrw
-	size=4G
+	runtime=60
 	ioengine=libaio
 	iodepth=$qd
-	fallocate=none
 	randseed=12345
 
 	[fast]
@@ -73,28 +81,19 @@ EOF
 		return 1
 	fi
 
-	local time_taken
-	time_taken=$(fio_results_key fast job_runtime "$fio_results")
-	if [ "$time_taken" = "" ]; then
-		echo "fio doesn't report job_runtime"
-		return 1
-	fi
+	local total_io
+	total_io=$(sum_read_write_bytes fast "$fio_results")
 
-	echo "normal time taken $time_taken" >> "$FULL"
+	echo "normal io done $total_io" >> "$FULL"
 
 	# There's no way to predict how the two workloads are going to affect
-	# each other, so we weant to set thresholds to something reasonable so
-	# we can verify io.latency is doing something.  This means we set 15%
-	# for the fast cgroup, just to give us enough wiggle room as throttling
-	# doesn't happen immediately.  But if we have a super fast disk we could
-	# run both groups really fast and make it under our fast threshold, so
-	# we need to set a threshold for the slow group at 50%.  We assume that
-	# if it was faster than 50% of the fast threshold then we probably
-	# didn't throttle and we can assume io.latency is broken.
-	local fast_thresh=$((time_taken + time_taken * 15 / 100))
-	local slow_thresh=$((time_taken + time_taken * 50 / 100))
-	echo "fast threshold time is $fast_thresh" >> "$FULL"
-	echo "slow threshold time is $slow_thresh" >> "$FULL"
+	# each other, so we want to set thresholds to something reasonable so we
+	# can verify io.latency is doing something.  Since throttling doesn't
+	# kick in immediately we'll assume that being able to do at least 85% of
+	# our normal IO in the same time that we are properly protected.
+	local thresh=$((total_io - total_io * 15 / 100))
+
+	echo "threshold is $thresh" >> "$FULL"
 
 	# Create the cgroup files
 	echo "+io" > "$CGROUP2_DIR/cgroup.subtree_control"
@@ -118,18 +117,36 @@ EOF
 		return 1
 	fi
 
-	local fast_time slow_time
-	fast_time=$(fio_results_key fast job_runtime "$fio_results")
-	echo "Fast time $fast_time" >> "$FULL"
-	slow_time=$(fio_results_key slow job_runtime "$fio_results")
-	echo "Slow time $slow_time" >> "$FULL"
+	local fast_io slow_io
+	fast_io=$(sum_read_write_bytes fast "$fio_results")
+	echo "Fast io $fast_io" >> "$FULL"
+	slow_io=$(sum_read_write_bytes slow "$fio_results")
+	echo "Slow io $slow_io" >> "$FULL"
 
-	if [[ $fast_thresh < $fast_time ]]; then
+	# First make sure we did at least 85% of our uncontested IO
+	if [[ $thresh -gt $fast_io ]]; then
 		echo "Too much of a performance drop for the protected workload"
 		return 1
 	fi
 
-	if [[ $slow_thresh > $slow_time ]]; then
+	# Now make sure we didn't do more IO in our slow group than we did in
+	# our fast group.
+	if [[ $fast_io -lt $slow_io ]]; then
+		echo "The slow group does not appear to have been throttled"
+		return 1
+	fi
+
+	# Now caculate the percent difference between the slow io and fast io.
+	# If io.latency isn't doing anything then these two groups would compete
+	# essentially fairly, so they would be within a few single percentage
+	# points of each other.  So assume anything less than a 15% difference
+	# means we didn't throttle the slow group properly.
+	local pct_diff
+	pct_diff=$(((fast_io - slow_io) * 100 / ((fast_io + slow_io) / 2)))
+
+	echo "Percent difference is $pct_diff" >> "$FULL"
+
+	if [[ $pct_diff -lt "15" ]]; then
 		echo "The slow group does not appear to have been throttled"
 		return 1
 	fi
-- 
2.14.3

