Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05CCC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8061E2081B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="Lo5jgy7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8061E2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbeLDRrn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:47:43 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41534 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeLDRrn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 12:47:43 -0500
Received: by mail-yw1-f67.google.com with SMTP id f65so7322216ywc.8
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 09:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=9sSAI94rKwlTvPeeHqFhwpCg8kW+5V6l/J9eOc/rNm0=;
        b=Lo5jgy7zACJGq/VoS8U1xbPA6//TwlnlpBSacWAro4o0AKPMNXloD9gdjFcqSIO0OL
         8ru7ynJUExzGRV8rFXLNLL2UlyFJ6XiteqwgezIkZDh01Z4we2AEppqXVdKPRgdsvxmq
         FLrJAqasQWP/eKxvuyTFZi88LvubB3LgWrK5p/KyCIqjVy6wWMs0R+AqbFCIz1fx2OxC
         jZgqHJ5wrjdWgUynVb1oT/+GVm/6kKDzkGWusNyfx8FbRB2IZad4H13b9HhjtR2c/7gt
         tVDDJFWYzMN3YR2SwtPZj++9NhIQjxKtXJqk2tIxpQxCzv+klTov5tW3obzth6jJR5JJ
         zO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=9sSAI94rKwlTvPeeHqFhwpCg8kW+5V6l/J9eOc/rNm0=;
        b=iVcX4kIUqQ9QLb2MC70DuWuhBUa3BI56uRYVHrvW957N/TYIfA/ZhgqCA/sXykTuZ9
         FqAt91M4fHaVr6nYUfkt9Wi2XRwj8Hqozvi+URNZYxTTtPlg9RJrdsQl6sejqPNkTmLj
         RsNUk5jKVWKoHEURSc7BqlqIBwEenVSYmy2aUbXQkJ6jY06aH0Y8+d/C5KrRHNphj+q3
         hUsXikJmALlxxDnNkmfGcTSmrojNr7x1gJYQK1kBxJvL7kyu1kmwgTa+e1EDZuixHB6k
         Ru/TCaJvDe1j+iDZyKc2FNwcFkHt52DanyQcCw2OO9aF5nx0kkeI678UO+VIG2Jiu33z
         FdFQ==
X-Gm-Message-State: AA+aEWbOMTJ9NL5GIJ/aqmYLxsJVMoxJW0eHNAhJjMySwDfyfjDOaZil
        d3/UuRiX7THfAQggTeBHIyi0ZDmsDdg=
X-Google-Smtp-Source: AFSGD/XPZOstM28X+BmJshmk5idGoQCDQPumNuy0f9BD03wp7hnr7weEvFWx70B7/dG3QhEXkNqpiw==
X-Received: by 2002:a81:27cc:: with SMTP id n195mr21121801ywn.243.1543945661390;
        Tue, 04 Dec 2018 09:47:41 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x4sm20227295ywj.80.2018.12.04.09.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 09:47:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-block@vger.kernel.org, kernel-team@fb.com, osandov@fb.com
Subject: [PATCH 3/3] blktests: block/025: an io.latency test
Date:   Tue,  4 Dec 2018 12:47:33 -0500
Message-Id: <20181204174733.7423-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181204174733.7423-1-josef@toxicpanda.com>
References: <20181204174733.7423-1-josef@toxicpanda.com>
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
index 000000000000..88ce7cca944e
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
+		_have_program python
+}
+
+_fio_results_key() {
+	_job=$1
+	_key=$2
+	_resultfile=$3
+
+	python src/fio-key-value.py -k $_key -j $_job $_resultfile
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
+	# Create teh cgroup files
+	_dir=$(_cgroup2_base_dir)/blktests
+	echo "+io" > ${_dir}/cgroup.subtree_control
+	mkdir ${_dir}/fast
+	mkdir ${_dir}/slow
+
+	# We set teh target to 1usec because we could have a fast device that is
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

