Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587E6C04EBF
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD8920878
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="r3FGAdka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD8920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeLEPeM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:34:12 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45944 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeLEPeM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 10:34:12 -0500
Received: by mail-yb1-f195.google.com with SMTP id f6-v6so8551372ybg.12
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 07:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=52WJ2Cz4Mo5QsIj5798m+wuQX4YBxhTQAraOz340Igc=;
        b=r3FGAdkatH6CtVP/BP31wsSyroNtVPSZW6HW6PkmJrNJ5th7oCadAWdYVHCr5nJTKw
         pKflLPmkonNwYZu5HYxcjXquyfktkH3MqzBQp1fKHNqwM5CZoXdPiMQWDjK8kez0t1qF
         TLH3eOYLgaj4ilat3nY8F0IgCoZnrA9oB8/qp6GlNmJA099a/5roWRB2/REk6uZ+boEX
         4qfZsxMTJKjEem1bh3cTgKLGgnNcFS9RnISA7bSKNbLlIH2tQpvoIQDUxjRd/WDAVn4i
         ThCd4HPOeYUwh4IiAmMcgoEqyN4c8FKL+H7FC8Iy0m/01IFHz5GVVSBE5TfGi8qt5bF/
         IQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=52WJ2Cz4Mo5QsIj5798m+wuQX4YBxhTQAraOz340Igc=;
        b=FYHRf4I4KVPS6Yqh8QmliCeOkWAvXBsMK9ZW3k3CJjBPQNkikQwv9iUzR0bfgVKZv5
         /RO8MM4ePogqCcn+mAdeH/8tuymA4HevB255kwqBIUS54v2m1aZP0BpsOi3CXBB99XCR
         00pJmTS6OqmH/MHvj7n2F6UbPZ4VUYNMDB5uQSlqs+v4MCiI8ux0PAwDME/uLy3pFNAi
         cdHyEdKDsIQmry0vFpXjdK3ea2ECneKk9eT3sp1YnSOGtTdQdqj6m9h+lnMlaF7P4lXq
         vI7E7LcwsuiWNDpDASsUVhbEPwrsi5LHMg7OzY13+tF3pwOIyEMy0a9993d4+8qnKyY6
         hMfA==
X-Gm-Message-State: AA+aEWZRLutiKNeOToG4RfiJ5KFJRfV30VrOXAFi8wZCTyV+HuKffqJh
        BhiwQbaUjov3YiOFoMxuq8dyrPIqYWo=
X-Google-Smtp-Source: AFSGD/Wq4N+BywS9mz//gyIJksbXWPX8BIxZyeAa5x9BMfM2Dry43fNPr4IZe/yDyZYJ2J3XQVLtRg==
X-Received: by 2002:a25:ef10:: with SMTP id g16-v6mr23220098ybd.164.1544024050618;
        Wed, 05 Dec 2018 07:34:10 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m3sm6103398ywe.90.2018.12.05.07.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 07:34:09 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-block@vger.kernel.org, kernel-team@fb.com, osandov@fb.com
Subject: [PATCH 2/2] blktests: block/025: an io.latency test
Date:   Wed,  5 Dec 2018 10:34:04 -0500
Message-Id: <20181205153404.26634-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181205153404.26634-1-josef@toxicpanda.com>
References: <20181205153404.26634-1-josef@toxicpanda.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a test to verify io.latency is working properly.  It does this
by first running a fio job by itself to figure out how fast it runs.
Then we calculate some thresholds, set up 2 cgroups, a fast and a slow
cgroup, and then run the same job in both groups simultaneously.  We
should see the slow group get throttled until the first cgroup is able
to finish, and then the slow cgroup will be allowed to finish.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/block/025     | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/025.out |   1 +
 2 files changed, 134 insertions(+)
 create mode 100644 tests/block/025
 create mode 100644 tests/block/025.out

diff --git a/tests/block/025 b/tests/block/025
new file mode 100644
index 000000000000..cdaa35c5e335
--- /dev/null
+++ b/tests/block/025
@@ -0,0 +1,133 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+#
+# Test io.latency to make sure it's protecting the higher priority group
+# properly.
+
+. tests/block/rc
+
+DESCRIPTION="test the io.latency interface to make sure it's working right"
+
+requires() {
+	_have_cgroup2_controller_file io io.latency && _have_fio && \
+		_have_program jq
+}
+
+_fio_results_key() {
+	_job=$1
+	_key=$2
+	_resultfile=$3
+
+	jq '.jobs[] | select(.jobname == "'${_job}'") | .'${_key} ${_resultfile}
+}
+
+test_device() {
+	local fio_config_single fio_config_double fio_results fio_args qd
+
+	fio_config_single=${TMPDIR}/single.fio
+	fio_config_double=${TMPDIR}/double.fio
+	fio_results=${TMPDIR}/025.json
+	fio_args="--output-format=json --output=${fio_results}"
+	qd=$(cat ${TEST_DEV_SYSFS}/queue/nr_requests)
+
+	cat << EOF > "${fio_config_single}"
+	[fast]
+	filename=${TEST_DEV}
+	direct=1
+	allrandrepeat=1
+	readwrite=randrw
+	size=4G
+	ioengine=libaio
+	iodepth=${qd}
+	fallocate=none
+	randseed=12345
+EOF
+
+	cat << EOF > "${fio_config_double}"
+	[global]
+	filename=${TEST_DEV}
+	direct=1
+	allrandrepeat=1
+	readwrite=randrw
+	size=4G
+	ioengine=libaio
+	iodepth=${qd}
+	fallocate=none
+	randseed=12345
+
+	[fast]
+	cgroup=blktests/fast
+
+	[slow]
+	cgroup=blktests/slow
+EOF
+	# We run the test once so we have an idea of how fast this workload will
+	# go with nobody else doing IO on the device.
+	if ! fio ${fio_args} ${fio_config_single}; then
+		echo "fio exited with status $?"
+		return 1
+	fi
+
+	_time_taken=$(_fio_results_key fast job_runtime ${fio_results})
+	if [ "${_time_taken}" = "" ]; then
+		echo "fio doesn't report job_runtime"
+		return 1
+	fi
+
+	echo "normal time taken ${_time_taken}" >> $FULL
+
+	# There's no way to predict how the two workloads are going to affect
+	# each other, so we weant to set thresholds to something reasonable so
+	# we can verify io.latency is doing something.  This means we set 15%
+	# for the fast cgroup, just to give us enough wiggle room as throttling
+	# doesn't happen immediately.  But if we have a super fast disk we could
+	# run both groups really fast and make it under our fast threshold, so
+	# we need to set a threshold for the slow group at 50%.  We assume that
+	# if it was faster than 50% of the fast threshold then we probably
+	# didn't throttle and we can assume io.latency is broken.
+	_fast_thresh=$((${_time_taken} + ${_time_taken} * 15 / 100))
+	_slow_thresh=$((${_time_taken} + ${_time_taken} * 50 / 100))
+	echo "fast threshold time is ${_fast_thresh}" >> $FULL
+	echo "slow threshold time is ${_slow_thresh}" >> $FULL
+
+	# Create the cgroup files
+	_dir=$(_cgroup2_base_dir)/blktests
+	echo "+io" > ${_dir}/cgroup.subtree_control
+	mkdir ${_dir}/fast
+	mkdir ${_dir}/slow
+
+	# We set the target to 1usec because we could have a fast device that is
+	# capable of remarkable IO latencies that would skew the test.  It needs
+	# to be low enough that we do actually throttle the slow group,
+	# otherwise the test will fail when there's nothing wrong.
+	_major=$((0x$(stat -c "%t" ${TEST_DEV})))
+	_minor=$((0x$(stat -c "%T" ${TEST_DEV})))
+	echo "${_major}:${_minor} is our device" >> $FULL
+	if ! echo "${_major}:${_minor} target=1" > ${_dir}/fast/io.latency; then
+		echo "Failed to set our latency target"
+		return 1
+	fi
+
+	if ! fio ${fio_args} ${fio_config_double}; then
+		echo "fio exited with status $?"
+		return 1
+	fi
+
+	_fast_time=$(_fio_results_key fast job_runtime ${fio_results})
+	echo "Fast time ${_fast_time}" >> $FULL
+	_slow_time=$(_fio_results_key slow job_runtime ${fio_results})
+	echo "Slow time ${_slow_time}" >> $FULL
+
+	if [ ${_fast_thresh} -lt ${_fast_time} ]; then
+		echo "Too much of a performance drop for the protected workload"
+		return 1
+	fi
+
+	if [ ${_slow_thresh} -gt ${_slow_time} ]; then
+		echo "The slow group does not appear to have been throttled"
+		return 1
+	fi
+
+	echo "Silence is golden"
+	return 0
+}
diff --git a/tests/block/025.out b/tests/block/025.out
new file mode 100644
index 000000000000..c19ff631b9b5
--- /dev/null
+++ b/tests/block/025.out
@@ -0,0 +1 @@
+Silence is golden
-- 
2.14.3

