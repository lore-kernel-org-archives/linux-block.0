Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB33DD534
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802154; cv=none; b=Ueh5DcOya8SR1SragjRnpNNbgXL5R6bjxRAojvvMPycu0t/Cps1rIXeIQof43dlvZbyCNTDP7xiBhpVe4kfnLalm7z7Ux5szbSOPW9XUkpnYlYjElXjC2MVe0ELQLGtuxE3G+T49gpVBfZrfjf5YH353VC0syjUN5zDlvwYsLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802154; c=relaxed/simple;
	bh=lwAa3zZY4dUx5e7J56G35xKAUJYH+Ib6EeZjW3NXaCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riGJUEbMN5Sk4kjKd14UhZ5OjofnMwXFA+RKCB8JNwLvXhtehlilbxzRI+1xsq4PcOFj1ngtrsFuHRXISdCbqSGS5RxbxuTnScyXQhXY12NVriE1Rl8+RC6RkjpfQhldQKJDme1diOxxOkGdKDs4mmW9DxYKAKMpRTC8tM37BAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fDVuRrh7; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fDVuRrh7"
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8d6654f06caso82300785a.1
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776802146; x=1777406946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAZHQPO98mzj8j7p5PPgcZ6Q+1cUZmFim3S2B/NBScE=;
        b=fDVuRrh7vEW/l9fQocW4FHVypEZGVgI4FiTpGyY+cqZVRX9fNPcfXvpzpnGqoTQtQz
         BZgQhsotZW5EBxLWs0psFttANvEh0FFgydxgLMAfQzRKZZpSuH5owTMSTtLUsd+1H2Fm
         rVXe8+h4Xe2biJ131NW5ARocVo7XqcBsTjA3K3mDSkywQnn2tIJE2aDeB/1HbFkDYgfp
         tzMa+5cqXGGBjvE1qNKwip4RW0NclSMeWi2uB2lI4SgqUEvQlhpNPDox09/sprDa0Hma
         LVSJ7gXu44umBAWQQVAs7N8spKPGbSOgcBOQ+9Tdfg6JH2RaCjGj8AOQ4zm8wjP1Mh1P
         HnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776802146; x=1777406946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jAZHQPO98mzj8j7p5PPgcZ6Q+1cUZmFim3S2B/NBScE=;
        b=OfZfUEwM9rwbKQv7yZKurk0ZkvPpfqRwZPC1DVHM6AWeTPAdtThTw2pBioZaA6803U
         f+Houav1q8L6Ieh9bqfYgmTirt2Tyb12Is5Uk9PD0oyy67w4JaYJZnRd07GTTNnOkIUs
         pvV+UaImTvJlsFuLxiZbIJ13uRQWgKDCmF6vsbkooJ6aix0obTEe0ggvdFPDHcr1HlC/
         KOB8gZkVT1NV7IexFXY0Cnf54Kx9lq7KFZ7cyZ/zHlzzi7r75Tq+TK/ht+8nmYB7twgR
         wQc8uye2pxvx/KkIeb3h9jKpwcDRqcc0Lr3LTSGoH5Wu70GQ40ZMdKOrzA9X7TYZYUfb
         vFdg==
X-Forwarded-Encrypted: i=1; AFNElJ+KVHltss68CFssC8rQ2WRNtvyR82nopOBoBy51zq3F216htpO18bhNptNZ/I+CnoluIcgJ8i7UjDj7xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfP7AzatDoOIUodigjKpQMq1QwOItI/sAMOH1XXmDla0+m02Pl
	IrmMMIR6alI3ZxhlfCnHQNW6KwlgBPCw+lPcZhQPROD52P7Jqg5B5Gs+OdWoiN5PtTtdJ3Kz4nf
	3k8mc70Ftxoe+9iX2UUpsZkzM6K/zkusKZoWd
X-Gm-Gg: AeBDietxkIu7N1OOVTAqGUJDx7iQ9zj/aUTOFyVD8iyh9lFpbR+4U1FLICPT9hJ5Jyx
	rOBm1kdj6nisCYMF0/iZJ5gyK+rs+MAq3e8sKRasJv15WVoJFsO3W212Yw5/WnpUynRg0/1btVe
	pbDYypB9R50jr3op2TnDFWG2Ktoz0gbtY93jAvudUhFIfGOc5bh2nmhIuG3ZUs5fT3ziQWOTKnf
	NmCiprbbxlA+8cAr/ya0XQYtXWcFHrGu49qjVmk4LW1I8Ti68+pdIzxXk25yzhSzMBpUMCrTLUz
	T0UoP4XJwYhCH3PaH5+xUZShk3vMM75vhyvwnjawlgSGQZw/Q1kKoT0p0daDFHQN7whmn1K8OXd
	4hSYnixQRBF/TZfEPhDjJ17id/xj64e4ZPj4TqvaS8zhJd+0VaakOkk8Mq5+tyJZ5
X-Received: by 2002:a05:6214:518c:b0:8ac:b300:c558 with SMTP id 6a1803df08f44-8b028023a33mr204724176d6.2.1776802146333;
        Tue, 21 Apr 2026 13:09:06 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b02ac7bba3sm10611586d6.11.2026.04.21.13.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:09:06 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id BEAA0340576;
	Tue, 21 Apr 2026 14:09:05 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B9EDDE41A9F; Tue, 21 Apr 2026 14:09:05 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/3] selftests: ublk: add ublk auto integrity test
Date: Tue, 21 Apr 2026 14:09:01 -0600
Message-ID: <20260421200901.1528842-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260421200901.1528842-1-csander@purestorage.com>
References: <20260421200901.1528842-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The end-to-end integrity ublk selftest test_integrity_02 requires a
relatively recent fio version to support I/O with integrity buffers. Add
a version test_integrity_03 that uses the block layer's auto integrity
path instead. The auto integrity code doesn't check the application tag,
and doesn't indicate the bad guard/ref tag (just returns EILSEQ). But
it's a good smoke-test of the ublk integrity code and provides coverage
of the auto integrity path as well.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile         |   1 +
 .../selftests/ublk/test_integrity_03.sh       | 103 ++++++++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_integrity_03.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index ec6a8ce83d38..6e4fe8d1fed1 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -35,10 +35,11 @@ TEST_PROGS += test_loop_05.sh
 TEST_PROGS += test_loop_06.sh
 TEST_PROGS += test_loop_07.sh
 
 TEST_PROGS += test_integrity_01.sh
 TEST_PROGS += test_integrity_02.sh
+TEST_PROGS += test_integrity_03.sh
 
 TEST_PROGS += test_recover_01.sh
 TEST_PROGS += test_recover_02.sh
 TEST_PROGS += test_recover_03.sh
 TEST_PROGS += test_recover_04.sh
diff --git a/tools/testing/selftests/ublk/test_integrity_03.sh b/tools/testing/selftests/ublk/test_integrity_03.sh
new file mode 100755
index 000000000000..10f02339ea2d
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_integrity_03.sh
@@ -0,0 +1,103 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+if ! _have_program fio; then
+	exit $UBLK_SKIP_CODE
+fi
+
+_test_fill_and_verify() {
+	fio --name fill --rw randwrite $fio_args > /dev/null
+	if [ $? != 0 ]; then
+		echo "fio fill failed"
+		ERR_CODE=255
+		return 1
+	fi
+
+	fio --name verify --rw randread $fio_args > /dev/null
+	if [ $? != 0 ]; then
+		echo "fio verify failed"
+		ERR_CODE=255
+		return 1
+	fi
+}
+
+_test_corrupted_reftag() {
+	local dd_reftag_args="bs=1 seek=58 count=6 oflag=dsync conv=notrunc status=none"
+
+	# Overwrite 6-byte reftag at offset 48 + 10 = 58
+	dd if=/dev/urandom "of=${UBLK_BACKFILES[1]}" $dd_reftag_args
+	if [ $? != 0 ]; then
+		echo "dd corrupted_reftag failed"
+		ERR_CODE=255
+		return 1
+	fi
+
+	if fio --name corrupted_reftag --rw randread $fio_args > /dev/null 2> "$fio_err"; then
+		echo "fio corrupted_reftag unexpectedly succeeded"
+		ERR_CODE=255
+		return 1
+	fi
+
+	if ! grep -q "$expected_err" "$fio_err"; then
+		echo "fio corrupted_reftag message not found: $expected_err"
+		ERR_CODE=255
+		return 1
+	fi
+
+	# Reset to 0
+	dd if=/dev/zero "of=${UBLK_BACKFILES[1]}" $dd_reftag_args
+	if [ $? != 0 ]; then
+		echo "dd restore corrupted_reftag failed"
+		ERR_CODE=255
+		return 1
+	fi
+}
+
+_test_corrupted_data() {
+	local dd_data_args="bs=512 count=1 oflag=direct,dsync conv=notrunc status=none"
+
+	dd if=/dev/zero "of=${UBLK_BACKFILES[0]}" $dd_data_args
+	if [ $? != 0 ]; then
+		echo "dd corrupted_data failed"
+		ERR_CODE=255
+		return 1
+	fi
+
+	if fio --name corrupted_data --rw randread $fio_args > /dev/null 2> "$fio_err"; then
+		echo "fio corrupted_data unexpectedly succeeded"
+		ERR_CODE=255
+		return 1
+	fi
+
+	if ! grep -q "$expected_err" "$fio_err"; then
+		echo "fio corrupted_data message not found: $expected_err"
+		ERR_CODE=255
+		return 1
+	fi
+}
+
+_prep_test "loop" "end-to-end auto integrity"
+
+_create_backfile 0 256M
+_create_backfile 1 32M # 256M * (64 integrity bytes / 512 data bytes)
+integrity_params="--integrity_capable --integrity_reftag
+		  --metadata_size 64 --pi_offset 48 --csum_type nvme"
+dev_id=$(_add_ublk_dev -t loop -u $integrity_params "${UBLK_BACKFILES[@]}")
+_check_add_dev "$TID" $?
+
+fio_args="--ioengine libaio --direct 1 --bsrange 512-1M --iodepth 32
+	  --filename /dev/ublkb$dev_id"
+fio_err=$(mktemp "${UBLK_TEST_DIR}"/fio_err_XXXXX)
+ERR_CODE=0
+
+expected_err="Invalid or incomplete multibyte or wide character: read offset=0"
+_test_fill_and_verify && \
+_test_corrupted_reftag && \
+_test_corrupted_data
+
+rm -f "$fio_err"
+
+_cleanup_test
+_show_result "$TID" $ERR_CODE
-- 
2.45.2

