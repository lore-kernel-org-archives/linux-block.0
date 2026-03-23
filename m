Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44B3DE446
	for <linux-block@vger.kernel.org>; Mon, 23 Mar 2026 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774296491; cv=none; b=KF7ywtTRXHj2jdNqzUuANQ0kmOwyzTGBOb/T1wQMezSvn8PKK9QE2pxXgJ42nBI5i1eHK0E7OMNxywvAQ89Cmt/BPp4Yt+Hv7CrqFdg+H9b/3pEmq4JBCzINal5ziVen+9pWdBT1/LDkmHVLnVCmweBwyVjsYYLzvcaScegk5Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774296491; c=relaxed/simple;
	bh=LerUvkn1t8jg1vHc3k77iR5CoPxGPYC2au3gC7FpUT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJQuAluVFUqc8GY6ePm0KrJEyQHTouXM8/gmDZDi3Cbv5jW0dsWqFgveenrV67mGW5skpF8TR4aouKft9R1bQSjXVzKXax1G5wQcqkR3jX4Hn63Ll95+ECKilZEz280bUjdhu72g+d1FDDeOUME0YQDjZBZN9S501XGsehSrqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=IVGnsiDA; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="IVGnsiDA"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4ffkkH2tPYz1XM6JH;
	Mon, 23 Mar 2026 20:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1774296482; x=1776888483; bh=3mlM4E5yM7ifKtI4AG74kctKozOx42m5wJ+
	uLI2l/eI=; b=IVGnsiDAIm8FSUHURGwpgwtsiDMWch2ywM7E6tOdlzr7jpy2snR
	CFucQjHO1P/VafnJcRtZDMmGYGNCqctL7PbP1unQoG507wXnbL3KRNj2lOgRxSS9
	YMD7kb5vHtUtQbS7k/HIo830XH70+F0K9pXea1rj/UJxhTitKTtVsjxrBMLTwE1O
	ThmLXZnmCjV0iQQcfyvlGzEhdcYBNfc1+BrprDQpL550br9NKBSx2fOwa7qTM/+V
	WDOd1wV0ONYtDliOjNoU/PV4LzyvVrVKjnLVt+LGUkfNkQKqHfsB2qXFbC5tTBw4
	+8CxM2ruTAaYMW2JaiDN+Bmu6pwAdsHRJeA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cECRN8Jgz950; Mon, 23 Mar 2026 20:08:02 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4ffkk90rhsz1XM6J6;
	Mon, 23 Mar 2026 20:08:00 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block/044, scsi/012: Add tests for support for segments smaller than the page size
Date: Mon, 23 Mar 2026 13:07:51 -0700
Message-ID: <20260323200751.1238583-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Linux kernel commit 889c57066cee ("block: make segment size limit workabl=
e
for > 4K PAGE_SIZE") was merged about one year ago and adds support for
DMA segments that are smaller than the virtual memory page size. This is
important for devices that do not support DMA segments larger. This patch
tests the code paths added by that Linux kernel commit.

Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Please note that this patch depends on two block layer and one SCSI
patches that have not yet been merged.

 tests/block/044     | 58 +++++++++++++++++++++++++++++++++++++++++++++
 tests/block/044.out |  2 ++
 tests/scsi/012      | 56 +++++++++++++++++++++++++++++++++++++++++++
 tests/scsi/012.out  |  4 ++++
 4 files changed, 120 insertions(+)
 create mode 100755 tests/block/044
 create mode 100644 tests/block/044.out
 create mode 100755 tests/scsi/012
 create mode 100644 tests/scsi/012.out

diff --git a/tests/block/044 b/tests/block/044
new file mode 100755
index 000000000000..e2ca2d9aea3a
--- /dev/null
+++ b/tests/block/044
@@ -0,0 +1,58 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2026 Google LLC
+#
+# Test support for DMA segment sizes less than 4096 bytes. See also comm=
it
+# 889c57066cee ("block: make segment size limit workable for > 4K PAGE_S=
IZE").
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION=3D"do IO on null-blk with 512 byte segments"
+TIMED=3D1
+
+requires() {
+	_have_fio
+	_have_kver 6 14
+	_have_null_blk
+}
+
+test() {
+	local bs=3D4096
+
+	echo "Running ${TEST_NAME}"
+
+	if ! _init_null_blk nr_devices=3D0; then
+		echo "Loading null_blk failed"
+		return 1
+	fi
+	if ! grep -qw max_segment_size /sys/kernel/config/nullb/features; then
+		SKIP_REASONS+=3D("max_segment_size parameter is not supported")
+		return 1
+	fi
+	local nullb_params=3D(
+		blocksize=3D"$bs"      # bytes
+		completion_nsec=3D0
+		max_segment_size=3D512 # bytes
+		memory_backed=3D1
+		size=3D1               # MiB
+		submit_queues=3D1
+		power=3D1
+	)
+	if ! _configure_null_blk nullb0 "${nullb_params[@]}"; then
+		echo "Configuring null_blk failed"
+		return 1
+	fi
+	fio --verify=3Dmd5 --rw=3Drandwrite --bs=3D$bs --ioengine=3Dpsync --thr=
ead \
+		--group_reporting --sync=3D1 --direct=3D1 \
+		--name=3Dblock-044 --filename=3D/dev/nullb0 \
+		--output=3D"${RESULTS_DIR}/block/fio-output-block-044.txt" \
+		>>"$FULL"
+	local fio_status=3D$?
+	rmdir /sys/kernel/config/nullb/nullb0
+	_exit_null_blk
+	case $fio_status in
+		0) echo "Passed";;
+		*) echo "Failed (fio status =3D $fio_status)";;
+	esac
+}
diff --git a/tests/block/044.out b/tests/block/044.out
new file mode 100644
index 000000000000..4718ff7bd595
--- /dev/null
+++ b/tests/block/044.out
@@ -0,0 +1,2 @@
+Running block/044
+Passed
diff --git a/tests/scsi/012 b/tests/scsi/012
new file mode 100755
index 000000000000..a2043f95deaa
--- /dev/null
+++ b/tests/scsi/012
@@ -0,0 +1,56 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2026 Google LLC
+#
+# Test support for DMA segment sizes less than 4096 bytes. See also comm=
it
+# 889c57066cee ("block: make segment size limit workable for > 4K PAGE_S=
IZE").
+
+. tests/block/rc
+. common/scsi_debug
+
+DESCRIPTION=3D"do IO on scsi_debug with 512 byte segments"
+TIMED=3D1
+
+requires() {
+	_have_fio
+	_have_kver 6 14
+	_have_scsi_debug
+}
+
+test() {
+	local bs=3D4096
+
+	echo "Running ${TEST_NAME}"
+	local scsi_debug_params=3D(
+		add_host=3D1
+		clustering=3D1
+		delay=3D0
+		sector_size=3D"$bs"      # bytes
+	)
+	if _have_module_param scsi_debug max_segment_size; then
+		scsi_debug_params+=3D(max_segment_size=3D512) # bytes
+		echo "Segment size =3D 512" >>"$FULL"
+	fi
+	if ! _init_scsi_debug "${scsi_debug_params[@]}"; then
+		echo "Initializing scsi_debug failed"
+		return 1
+	fi
+	local blkdev=3D/dev/${SCSI_DEBUG_DEVICES[0]}
+	[ -b "$blkdev" ] || return 1
+	local ioengine
+	for ioengine in psync sg; do
+		echo "$ioengine"
+		fio --verify=3Dmd5 --rw=3Drandwrite --bs=3D$bs --ioengine=3D$ioengine =
\
+		    --thread --group_reporting --sync=3D1 --direct=3D1 \
+		    --name=3Dscsi-012 --filename=3D"$blkdev" \
+		    --output=3D"${RESULTS_DIR}/block/fio-output-scsi-012-$ioengine.txt=
" \
+		    >>"$FULL"
+		local fio_status=3D$?
+		[ $fio_status =3D 0 ] || break
+	done
+	_exit_scsi_debug
+	case $fio_status in
+		0) echo "Passed";;
+		*) echo "Failed (fio status =3D $fio_status)";;
+	esac
+}
diff --git a/tests/scsi/012.out b/tests/scsi/012.out
new file mode 100644
index 000000000000..9c85da01e04e
--- /dev/null
+++ b/tests/scsi/012.out
@@ -0,0 +1,4 @@
+Running scsi/012
+psync
+sg
+Passed
