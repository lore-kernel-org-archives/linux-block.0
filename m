Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DFB2236FD
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661100; cv=none; b=U9dGgJ1PzTfi+xrATqi4ES4r7f2+B7GKd/PRuy9OeHC5++PGl8Dwt9PS+xtQrGKvZhy+mK4o8Er6Xbc4UwVuudbQHynTH0zWDI75Uji4E55TxQFV5Oe7NB/qStH3IYhe6NRZbHQO9UWqfv7gumWwjT0AyuELVkXdoONcf1GpP1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661100; c=relaxed/simple;
	bh=Z1UdenNqomW1Gdmx86hqjdPqAqBfGOKQ/CBxjOYJH6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoU+BaLSEYRv2ocavvy3sjJnL3UlRhu3GkRWV5MpZ5EkCJIUT7iJZGEiNtj3+Ehm4Zs3yriS7GZOTi5N426rSpWXNjBNLDHKlurDSxzsjTSpO6RMt9q3rF2VgLoCe94BNR66nFK699RHBu+XtQNwo/9bEj543lrSD/RO9uOrq6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Nvu4zP1A; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Nvu4zP1A"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a08cb5e30eso1067955ad.1
        for <linux-block@vger.kernel.org>; Mon, 05 Jan 2026 16:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661092; x=1768265892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWgbGYobkvaFSQnhmymI3uWpc8/0KXyANTacEmbRQf4=;
        b=Nvu4zP1AUR1u2OTOlSMg1Gt/rqgn6E7TwHYkzScRZgn95dYdn5uIBZiZJYMROpju/0
         sHiWsiLHEE21xxGhXelaOufc79a1wWGWL/E/P4kl6sF/2zdQtRlwMQADZbcSsaxTBCiw
         5K4NvPnajm7HIcoSDGrHqR81S3F5LixvAFPa2xWAxIE61Khvw05UIHQp5sT3ohv97AB1
         qyefiE4TTxxsd4PMiZP4QOPUvfbMY+i556dIrsY9VvX45oETOWYjDYOu/JMlxCoezKbB
         DS8ZfqdYHZ0CpcUP3U4ACIDgKT/2DRMMooQqibn2xzDyxMBnyqYPn56JSv0b33vDz4Cv
         RBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661092; x=1768265892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iWgbGYobkvaFSQnhmymI3uWpc8/0KXyANTacEmbRQf4=;
        b=CmLXnBiUA9Q17NU0DbDz1ps7xvf98ULpwZUwikvwr9rzWbwSi1jxw+bpOaNSLcqdLZ
         YVDTeGnUvVn67m5MqupHO0hK3vwMJRvuw7jJFEZlircQo/MjMC7UFQLvVExAdHnjrUIy
         r+2qzg7EhEgsBlHJODCFKH4VWxpopuZXyYUftMMDqSttn22iTf7BjOd37QYA5fS2LaJu
         E2AcBNVUWTZP3lSeAKAfhIzvWzbO4rvIBQzRPLTD7FqSOPtcIm3k1MgIA5MYJYqbCvbo
         y8JmzihgHBZmlFf3A4nmy3bwSu8RiIrLJRUsP2G2YREDxh98Oh1zQt4rCMU4mQ1gjyhf
         QgKA==
X-Gm-Message-State: AOJu0YwyIW7dTrHWGyrYScU3kCdOSyx/ehMMpLoofqVaQTuLAKhvDyRG
	VtpdpujRH/k8SamzbXFP5rceKMvkrQfGL+ZpAdPXxThS34QOWYKoyf7lpCRYNYWf0IcEAkngWmQ
	OczFVNoH523pjiwh+7pajLNqjBH8mDXBvXuoz
X-Gm-Gg: AY/fxX7S2uHWRllMR97QzJOk7td9TEbNmZpuIr+j8d6jXcjFhlUhxAkzTA/+ZeRcGAp
	n13gUYsHo0iRGCrNUCga9gRscCE5HRNAVTn4ofeRzL1xI8sDNazxwyPWWR+0IABPpcjbtdWJ76s
	23BXowXDFWnctM13D7tH++NZn4WINNBkAmw2h5RUBJte5hcdAHxPi48YYrGpLNQSazmRN9IiZde
	wLhZupybmDDm/4WCgtxSIE8heV9KUHEb+AGi+0x5z/rnkAN9KXddGKCVWbuAHSyOPk//byyYZ71
	qDKGefJs9FLW1O1afp0SUAoHptLeY2jcdaRlsXhnoftirRVAO7sUQRn87l4WrR41xyM147D9hPf
	DQ24G/k5vXdUjWb8izfsnNy1pJFDY1E2fDbqC0eHx0w==
X-Google-Smtp-Source: AGHT+IGOfp+6bH84vad2EBQ2+Dwb3Z0fUV6/3dMYfGye5S2Vf4an6Zy5q/XCGn88/corDJ9YMoIic3ed4Enw
X-Received: by 2002:a17:90b:2884:b0:340:be2e:9884 with SMTP id 98e67ed59e1d1-34f5f284472mr709682a91.1.1767661092230;
        Mon, 05 Jan 2026 16:58:12 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34f5faf11e2sm107244a91.4.2026.01.05.16.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:12 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id AB19434173B;
	Mon,  5 Jan 2026 17:58:11 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9D880E44554; Mon,  5 Jan 2026 17:58:11 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 19/19] selftests: ublk: add end-to-end integrity test
Date: Mon,  5 Jan 2026 17:57:51 -0700
Message-ID: <20260106005752.3784925-20-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test case loop_08 to verify the ublk integrity data flow. It uses
the kublk loop target to create a ublk device with integrity on top of
backing data and integrity files. It then writes to the whole device
with fio configured to generate integrity data. Then it reads back the
whole device with fio configured to verify the integrity data.
It also verifies that injected guard, reftag, and apptag corruptions are
correctly detected.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile        |   1 +
 tools/testing/selftests/ublk/test_loop_08.sh | 111 +++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index bfd68ae64142..ab745443fd58 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -33,10 +33,11 @@ TEST_PROGS += test_loop_02.sh
 TEST_PROGS += test_loop_03.sh
 TEST_PROGS += test_loop_04.sh
 TEST_PROGS += test_loop_05.sh
 TEST_PROGS += test_loop_06.sh
 TEST_PROGS += test_loop_07.sh
+TEST_PROGS += test_loop_08.sh
 TEST_PROGS += test_stripe_01.sh
 TEST_PROGS += test_stripe_02.sh
 TEST_PROGS += test_stripe_03.sh
 TEST_PROGS += test_stripe_04.sh
 TEST_PROGS += test_stripe_05.sh
diff --git a/tools/testing/selftests/ublk/test_loop_08.sh b/tools/testing/selftests/ublk/test_loop_08.sh
new file mode 100755
index 000000000000..ca289cfb2ad4
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_loop_08.sh
@@ -0,0 +1,111 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+if ! _have_program fio; then
+	exit $UBLK_SKIP_CODE
+fi
+
+fio_version=$(fio --version)
+if [[ "$fio_version" =~ fio-[0-9]+\.[0-9]+$ ]]; then
+	echo "Requires development fio version with https://github.com/axboe/fio/pull/1992"
+	exit $UBLK_SKIP_CODE
+fi
+
+TID=loop_08
+
+_prep_test "loop" "end-to-end integrity"
+
+_create_backfile 0 256M
+_create_backfile 1 32M # 256M * (64 integrity bytes / 512 data bytes)
+integrity_params="--integrity_capable --integrity_reftag
+                  --metadata_size 64 --pi_offset 56 --csum_type t10dif"
+dev_id=$(_add_ublk_dev -t loop -u $integrity_params "${UBLK_BACKFILES[@]}")
+_check_add_dev $TID $?
+
+# 1M * (64 integrity bytes / 512 data bytes) = 128K
+fio_args="--ioengine io_uring --direct 1 --bsrange 512-1M --iodepth 32
+          --md_per_io_size 128K --pi_act 0 --pi_chk GUARD,REFTAG,APPTAG
+          --filename /dev/ublkb$dev_id"
+fio --name fill --rw randwrite $fio_args > /dev/null
+err=$?
+if [ $err != 0 ]; then
+	echo "fio fill failed"
+	_show_result $TID $err
+fi
+
+fio --name verify --rw randread $fio_args > /dev/null
+err=$?
+if [ $err != 0 ]; then
+	echo "fio verify failed"
+	_show_result $TID $err
+fi
+
+fio_err=$(mktemp fio_err_XXXXX)
+
+# Overwrite 4-byte reftag at offset 56 + 4 = 60
+dd_reftag_args="bs=1 seek=60 count=4 oflag=dsync conv=notrunc status=none"
+dd if=/dev/urandom "of=${UBLK_BACKFILES[1]}" $dd_reftag_args
+err=$?
+if [ $err != 0 ]; then
+	echo "dd corrupted_reftag failed"
+	rm -f "$fio_err"
+	_show_result $TID $err
+fi
+if fio --name corrupted_reftag --rw randread $fio_args > /dev/null 2> "$fio_err"; then
+	echo "fio corrupted_reftag unexpectedly succeeded"
+	rm -f "$fio_err"
+	_show_result $TID 255
+fi
+expected_err="REFTAG compare error: LBA: 0 Expected=0, Actual="
+if ! grep -q "$expected_err" "$fio_err"; then
+	echo "fio corrupted_reftag message not found: $expected_err"
+	rm -f "$fio_err"
+	_show_result $TID 255
+fi
+# Reset to 0
+dd if=/dev/zero "of=${UBLK_BACKFILES[1]}" $dd_reftag_args
+err=$?
+if [ $err != 0 ]; then
+	echo "dd restore corrupted_reftag failed"
+	rm -f "$fio_err"
+	_show_result $TID $err
+fi
+
+dd_data_args="bs=512 count=1 oflag=direct,dsync conv=notrunc status=none"
+dd if=/dev/zero "of=${UBLK_BACKFILES[0]}" $dd_data_args
+err=$?
+if [ $err != 0 ]; then
+	echo "dd corrupted_data failed"
+	rm -f "$fio_err"
+	_show_result $TID $err
+fi
+if fio --name corrupted_data --rw randread $fio_args > /dev/null 2> "$fio_err"; then
+	echo "fio corrupted_data unexpectedly succeeded"
+	rm -f "$fio_err"
+	_show_result $TID 255
+fi
+expected_err="Guard compare error: LBA: 0 Expected=0, Actual="
+if ! grep -q "$expected_err" "$fio_err"; then
+	echo "fio corrupted_data message not found: $expected_err"
+	rm -f "$fio_err"
+	_show_result $TID 255
+fi
+
+if fio --name bad_apptag --rw randread $fio_args --apptag 0x4321 > /dev/null 2> "$fio_err"; then
+	echo "fio bad_apptag unexpectedly succeeded"
+	rm -f "$fio_err"
+	_show_result $TID 255
+fi
+expected_err="APPTAG compare error: LBA: [0-9]* Expected=4321, Actual=1234"
+if ! grep -q "$expected_err" "$fio_err"; then
+	echo "fio bad_apptag message not found: $expected_err"
+	rm -f "$fio_err"
+	_show_result $TID 255
+fi
+
+rm -f "$fio_err"
+
+_cleanup_test
+_show_result $TID 0
-- 
2.45.2

