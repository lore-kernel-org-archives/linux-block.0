Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801300;
	b=BQCGUpSDIZdTCeqbLA9CvRmBbfjrX/5WrKkEohIEUe2SFvTz6f7ioqcTo4672x6Btpd3
	 9Cej1bYc/kcP3RXJGxRUiIRdH/aGFw+xRN1pBAk2jwh/sSU3j1c8o0vhyenRLlC7gRRr+
	 5S7pzEWqpYmEmQt+0pvINJqKsYt3Qw0b2PkhZzeymM4khZZthm3C3MPx3uXDKF1va8ptE
	 e6u2cq6zLIhVwy2bIlhBBBtl0i/2b1IUSZJNOLUfucBL7PU3iKfdZPNBT4PZ8KebAZn0S
	 b9FFKqpCqsNvOdImzgWRuZc0IeoXN+ZsvX7tbThZgoImboFzOSB3zjCfPPRrb3fCbFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ACKUMZkzA/F8ICajPkGBPHU4lMF7NqYKjdefPpK+Nmg=;
	b=XSgPUO5ewviaXLevbs5AawtmYiSW6BX9pjv6u0Zg8N/nR8JhYDLUAme/9xk3kN+Y1kdM
	 Cj4eHKpiXoCjk9XAOeU1sEJDmg/HqAz/epmd/IzMnsaQbp+Bhumyuj34XU/14FkI630nI
	 xkbOMZnkYQub0XguXMnDWvyBeCgj9JQTraecTbFQrZ9dp35vMC5dkNMg3z2nbcuiyyLeM
	 LCpAzAGieg/Vze66l8svLB+xSg91DIFnNmpyInMX0QtfeJmoqTvEQiJ3cOElibZeV89WZ
	 nCIrEWvZ2/S3R3io3F1Xb11cPATjsCXtv+Tq4XObAj7iAKYNldnCJpTwnoYRNUYJsMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crusoe.ai;
	spf=pass smtp.mailfrom=crusoe.ai;
	dkim=pass header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=adAI+41u;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB76606A32C
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 14:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BB76606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crusoe.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=adAI+41u
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35829219da8so2026896eec.0
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 06:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1793801299; x=1794406099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ACKUMZkzA/F8ICajPkGBPHU4lMF7NqYKjdefPpK+Nmg=;
        b=adAI+41uTs96C4CQMqUBQPobl1N3rjbuBdnlkto8gvqNm6b787yAz6tjaoaOdiFmaF
         Im5eRsNa8C9DZ/bg8D++E3g/++mOr9ubkUWmB+ug5awidFhZ3mTxaySWBZtZVWC2gICs
         4X0CaXvnM6WN70ZdzDLaN0f0oJR52ofRCj3ytVIofGlGnzqkpxbmFSUg4iQN8y+/AH3O
         aL7QtMmyZDT9Mjag6s5b3jaJLTYWUJzJPdHwAxwij5Fm03XDuGcqKCkihzLYq9VBIujO
         0zclJJPQAy5d6p9Ij9SAp5V6A6VkX45U7Lh2XPVkslMO0j1AtzpoJI7ez/TvkaBG2cH8
         rAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801299; x=1794406099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ACKUMZkzA/F8ICajPkGBPHU4lMF7NqYKjdefPpK+Nmg=;
        b=gi2E6TmY54V3LgZF4drMSj5p30rqYgioUfnwPGmYzgpWXrOeXXSvLEKLnD4sahJRWx
         NFNbEeuMuMpWC9J3CJYTnn/RHVvuJ/4eLYN7xK4sHQNdFx+q3kG/GiRA2OXJX/4J8m+1
         zhAC4TfQ+UNa54BtTwlXnYSRJazUNWhKQ4Rtw4y2hLficmb97irojxIjpM3F9y+PWJG8
         vImdyew2XscAqrJr9mqTmfPehn+vgh6Fcdm0eLXShyigRJcT0SSjcP4zFhj6m9n7mMih
         Rv/6kHc7TxY4stDWB0OitI+NMAzdq0tVvqEVo7JSijN3lC/vQ8o4Y9liI1wxMC9/cU4a
         bcQg==
X-Gm-Message-State: APuU4Z+tWK51PsyXGXDRepVzXg6XcYlWW09j7eabj/Y+E5V8M8wEBoXy
	FOD0hu0gLk8ywydi+3dufLs67cJBJLAxv+S5BHT6Ii34UVfPaYkd8/yqCy7KSH7y5eDj9OMJZIv
	rtOmrRas=
X-Gm-Gg: AYBFou2IWI6N+Ypak8/vMlX2Llkc9Zisr9HIZbGZBG8JK2Zy8/PXGcrYYU62F4T4Lrr
	jij/bJoyRxvh75AWaFrOFhBnrr8jntBBgquC3yo8X2Of4nqeZu/fSu13bnWykVuwTD0RJh9J2kb
	YanmKBShRkNNmwE0MqYXMUvPUIpMay0BPhpM13EgFmLktHp+CImZ7GK3OP4mb1AHlGu5jkqH+0q
	6vzC0qY4j0d6uj2TfvpUQU89MWvCC5Z6cyjBCmzT6JkKpoqx1H64g+BFzYmhJ/xtEYXK9XNLkV6
	mpgVb+WgZGwUqGjGNdfPhM8noJX/dB5VdIeVcAdABhH4o6XL/krurQA9ILKbLBRuAz8HE8nFDyK
	AOwFP90ASev+dxhxzlHXjRzWAosrppdoOZpQs3AvxrMVUpEtHDvy/VI7/ybzHuGM+02Spdquw+c
	1HrcjpqujzhK61psn8yaFbzShbYcay4xiMytQuhZQK7KaDw6yhd2WJQ+Xrb0AuyzRnrnSGbbJFS
	mNFDAbxUt0o2I0aaHp3YYvtRT2ApwjBfYLNgP5tS6gf0u3eraXCjcx22Cg+NVInCcSZuInxnvuz
	tB2kcC/PrTgYFuGzQEZK6bnUIveSz9p9I69n2CN9w3EiJBrEdW8pEUEmYRLdOETIz5eo4uA9uA=
	=
X-Received: by 2002:a05:7301:152d:b0:36a:79cd:12df with SMTP id 5a478bee46e88-36a79cd1c3bmr8481928eec.9.1793801298473;
        Wed, 04 Nov 2026 06:08:18 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([71.202.170.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3785430sm11812491eec.3.2026.11.04.06.08.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 06:08:18 -0800 (PST)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	hare@suse.de,
	nilay@linux.ibm.com,
	sagi@grimberg.me,
	kbusch@kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai,
	Saravanan D <saravanand@crusoe.ai>
Subject: [PATCH blktests] nvme/077: test the per-queue io_cpu sysfs attribute
Date: Wed,  4 Nov 2026 06:07:21 -0800
Message-ID: <20261104140721.4489-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793800758.git.saravanand@crusoe.ai>
References: <cover.1793800758.git.saravanand@crusoe.ai>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme-tcp exposes /sys/class/nvme/nvmeX/queues/<qid>/io_cpu and managed,
so a control plane can choose the CPU that runs each I/O queue's socket
work [1]. Test that

  - io_cpu reads back a written CPU and rejects invalid values
  - managed is read only and turns 0 once io_cpu is written
  - an assignment survives a controller reset
  - the queue directories follow the queue count as attr_qid_max
    shrinks and grows it
  - removing the controller while io_cpu is written completes

The test skips when the kernel does not have the attribute.

[1] https://lore.kernel.org/linux-nvme/cover.1793800758.git.saravanand@crusoe.ai/

Assisted-by: Claude:claude-opus-5-5 [Claude Code]
Signed-off-by: Saravanan D <saravanand@crusoe.ai>
---
 tests/nvme/077     | 185 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/077.out |   2 +
 2 files changed, 187 insertions(+)
 create mode 100755 tests/nvme/077
 create mode 100644 tests/nvme/077.out

diff --git a/tests/nvme/077 b/tests/nvme/077
new file mode 100755
index 0000000..0b4bce5
--- /dev/null
+++ b/tests/nvme/077
@@ -0,0 +1,185 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Saravanan D <saravanand@crusoe.ai>
+#
+# Test the per-queue io_cpu sysfs attribute of nvme-tcp
+
+. tests/nvme/rc
+
+DESCRIPTION="test the per-queue io_cpu sysfs attribute"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype tcp
+	_require_min_cpus 2
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+# last CPU in the online list, and the first CPU id past the possible ones
+last_online_cpu() {
+	awk -F'[-,]' '{ print $NF }' /sys/devices/system/cpu/online
+}
+
+first_impossible_cpu() {
+	echo $(( $(awk -F'[-,]' '{ print $NF }' /sys/devices/system/cpu/possible) + 1 ))
+}
+
+nr_queue_dirs() {
+	local nvmedev="$1"
+
+	find "/sys/class/nvme/${nvmedev}/queues" -mindepth 1 -maxdepth 1 \
+		-type d 2>/dev/null | wc -l
+}
+
+expect_attr() {
+	local file="$1"
+	local expected="$2"
+	local value
+
+	value=$(cat "${file}")
+	if [[ "${value}" != "${expected}" ]]; then
+		echo "${file}: read ${value}, expected ${expected}"
+		return 1
+	fi
+	return 0
+}
+
+test_read_write() {
+	local qdir="$1"
+	local cpu="$2"
+	local bad
+
+	expect_attr "${qdir}/1/managed" 1
+
+	echo "${cpu}" > "${qdir}/1/io_cpu"
+	expect_attr "${qdir}/1/io_cpu" "${cpu}"
+	expect_attr "${qdir}/1/managed" 0
+
+	for bad in "$(first_impossible_cpu)" -2 abc 0x1; do
+		if { echo "${bad}" > "${qdir}/1/io_cpu"; } 2>/dev/null; then
+			echo "io_cpu accepted ${bad}"
+		fi
+	done
+	expect_attr "${qdir}/1/io_cpu" "${cpu}"
+
+	if { echo 1 > "${qdir}/1/managed"; } 2>/dev/null; then
+		echo "managed is writable"
+	fi
+
+	echo unbound > "${qdir}/2/io_cpu"
+	expect_attr "${qdir}/2/io_cpu" -1
+	echo -1 > "${qdir}/2/io_cpu"
+	expect_attr "${qdir}/2/io_cpu" -1
+	expect_attr "${qdir}/2/managed" 0
+}
+
+test_reset() {
+	local nvmedev="$1"
+	local qdir="$2"
+	local cpu="$3"
+
+	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
+	_nvmf_wait_for_state "${def_subsysnqn}" "live" || return 1
+
+	expect_attr "${qdir}/1/io_cpu" "${cpu}"
+	expect_attr "${qdir}/1/managed" 0
+	expect_attr "${qdir}/2/io_cpu" -1
+	expect_attr "${qdir}/2/managed" 0
+}
+
+set_qid_max() {
+	local nvmedev="$1"
+	local qid_max="$2"
+	local queue_count_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/queue_count"
+	local retries=10
+
+	echo "${qid_max}" > \
+		"${NVMET_CFS}/subsystems/${def_subsysnqn}/attr_qid_max"
+	while [[ "$(cat "${queue_count_file}")" -ne $((qid_max + 1)) ]]; do
+		if (( retries-- == 0 )); then
+			echo "queue count did not change to $((qid_max + 1))"
+			return 1
+		fi
+		sleep 1
+	done
+	_nvmf_wait_for_state "${def_subsysnqn}" "live" || return 1
+
+	if [[ "$(nr_queue_dirs "${nvmedev}")" -ne "${qid_max}" ]]; then
+		echo "$(nr_queue_dirs "${nvmedev}") queue directories," \
+			"expected ${qid_max}"
+		return 1
+	fi
+	return 0
+}
+
+io_cpu_writer() {
+	local qdir="$1"
+	local cpu="$2"
+	local file
+
+	while true; do
+		for file in "${qdir}"/*/io_cpu; do
+			{ echo "${cpu}" > "${file}"; } 2>/dev/null
+			{ echo unbound > "${file}"; } 2>/dev/null
+		done
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local cfs_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
+	local skipped=false
+	local nvmedev qdir cpu writer
+
+	_nvmet_target_setup --blkdev file
+
+	_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 2
+	_nvmf_wait_for_state "${def_subsysnqn}" "live"
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+	qdir="/sys/class/nvme/${nvmedev}/queues"
+	cpu=$(last_online_cpu)
+
+	if [[ ! -f "${qdir}/1/io_cpu" ]]; then
+		SKIP_REASONS+=("missing per-queue io_cpu attribute")
+		skipped=true
+	elif [[ "$(nr_queue_dirs "${nvmedev}")" -lt 2 ]]; then
+		SKIP_REASONS+=("controller has fewer than 2 I/O queues")
+		skipped=true
+	else
+		test_read_write "${qdir}" "${cpu}"
+		test_reset "${nvmedev}" "${qdir}" "${cpu}"
+
+		if [[ -f "${cfs_path}/attr_qid_max" ]]; then
+			set_qid_max "${nvmedev}" 1
+			expect_attr "${qdir}/1/io_cpu" "${cpu}"
+			set_qid_max "${nvmedev}" 2
+		fi
+
+		# remove the controller while its queue directories are written
+		io_cpu_writer "${qdir}" "${cpu}" &
+		writer=$!
+		sleep 1
+	fi
+
+	_nvme_disconnect_subsys
+
+	if [[ -n "${writer}" ]]; then
+		kill "${writer}"
+		wait "${writer}" 2>/dev/null
+	fi
+
+	_nvmet_target_cleanup
+
+	if [[ "${skipped}" = true ]] ; then
+		return 1
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/077.out b/tests/nvme/077.out
new file mode 100644
index 0000000..c7f6ac3
--- /dev/null
+++ b/tests/nvme/077.out
@@ -0,0 +1,2 @@
+Running nvme/077
+Test complete
-- 
2.56.0

