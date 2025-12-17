Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DD1296BD6
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949722; cv=none; b=QniPaTb1GBYydrue1wVVbzdGoRnnU3ADtMXUG07ULZHcfgsosMLNvtOcicFQuUzFhpT1af27tcl17pSFXqvlveNRM5y/0P51WygL83ZUE5FuN8gbV4UAYLXzNwXmJV52Q3XDyuTIM7lrDplvV31IkVKZcu6CG9WEghdJV3Qvr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949722; c=relaxed/simple;
	bh=t9cYHGY+lbIuHzE8g0pXWWnK6GJfVuAiJzVnLuKG2yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwZ8ZVSW+nySiOIpZ5BgkJhD77QgweKOLeIx3RYr2xRgjhMxfSpXNxoaucwtMb+wCipVHTCau+puMlautuu3cTnm5CLrHbc1hYGlUJOeQGCrOpgFLgnPCXELSkzyoA1R8eqcXhQK/XvoZeLXYbOgP8DRXz2GTDm28h3nfGAk+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LX1e/g3f; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LX1e/g3f"
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7c6cc5e5f42so826620a34.2
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949715; x=1766554515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjfInq/j6ZbezL3hpJSlIUNNH1Zh7wSL0H2qNcnLw04=;
        b=LX1e/g3fDzzEFaG3LUsSGMfYcs7aBOROErCshxIvPEH2jMPXjljTA2N70/QKzpZ9DF
         8/KvUK4ni7/sLX2YwF33J4CnIrs647YVqduOU8uvSqIYVINwWUD/Vg6zzuMrZMsWMJBO
         amrFGpiRSsuuktf8Zm50epMAZ6XEHljvreQSmpVoqRmXjc1s6wGykxlhiMpRC1OQbw7O
         NYhCqepEvDfkYqZJEJWJ9onkC0tDAtKdaRAHELOGbUSIx922a67ccPbKffVQkxyN33mD
         G7dpZmqW+sV4jFgV15Kq9sDksSqpSfEna11zfJXqJHvoAYxTaBp/qgvojUGdSSthjUzT
         d+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949715; x=1766554515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bjfInq/j6ZbezL3hpJSlIUNNH1Zh7wSL0H2qNcnLw04=;
        b=Isy0CDt+x3x24Ai7mZMlZJBPgz4A5xP/PR3JkMAmNMDay8AiANWLGWDRHwcGOVQSBS
         ktC10TwWxbUJtmROmN7AbgzZqpRCHaXCBnQ5gfB0wCcHDccUZK9U85gTSN2QG+i6GznQ
         GpiZ5cedUFDJyWFWiCuxtgXRuprKC6fFXMWLkDAjYdBoZkovsKQ2l365SfWOcAnhP2yt
         CXeTb6yCOBfeVfhzttAZu0VcF6Lwhq/qc++V9nf0aAxfDW40cFOiRPgLj2WjsfZDng8/
         /maANdLDhHpOh2+JZyKgXY2W9uBlaNpLJYv3Ir1Q2n7JDR+9tFq7ueBHSIwsi7SevXP9
         FRWQ==
X-Gm-Message-State: AOJu0YzvCAZFTgEn5FF1EduuohkDQVm/h9RI0N8oXXRpg6Ae3DzYw3fx
	4WibQQkPrpYFwFMgkRD84DRQsohlHHA7TVKg/ZAIErsOStGlY1ukrMX6EL6eGDyoFUndf5nrvew
	zpHIhzIQAB0xdahanE0BPbHwFUy23AVHdfT5s+UHvWO17w2e88ib2
X-Gm-Gg: AY/fxX5BkobcMnmS3sZ4R92uFVjcdzN3PprUTcW2lG8T8Qw6tadScvs/uUMuDNe1X96
	Md2msW0BtPwS14CQq+r+j5ZsV3r357NPnvXl1HKfwDf+DIcubUaGrdJYEpk56K61LeOROJRGpbi
	EkGRIA+YGRlSwn8grgcuK/HepIpD8KRh3bEsR9fluYpLSjgr/VxBTGZHOZnOUXv9EIrPoFaG9Ui
	vlHdr62kazk1zUULLotf5Fqm/G/Jx97NYoYWcUyFFuMb+Pl3YUj+ujD1s8SKDYqzGcrbUpM4R7m
	JHoVy6LwVQt7F2f9MgYwvcZ7nfXAOPKTqxXhZ1lKdzk5RyyejYBbC5LfkkEPVM9sQHlGGd7fUgl
	l2uWhJKCPzTNy1Y9NU255FYA/v/8=
X-Google-Smtp-Source: AGHT+IHGuUlVvqYdwC5MHO+Zg10nd280P7si1rrad6oOsSGHdNNclHEYNg0v2QaljbxWC85Y2sUJA+x8m7OF
X-Received: by 2002:a05:6830:2708:b0:7c5:4005:ffe0 with SMTP id 46e09a7af769-7cae837c564mr8249162a34.6.1765949715602;
        Tue, 16 Dec 2025 21:35:15 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7cadb2d9814sm2754118a34.3.2025.12.16.21.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:15 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A6A793404B4;
	Tue, 16 Dec 2025 22:35:14 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A1573E41A08; Tue, 16 Dec 2025 22:35:13 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 19/20] selftests: ublk: add integrity params test
Date: Tue, 16 Dec 2025 22:34:53 -0700
Message-ID: <20251217053455.281509-20-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test case null_04 to exercise all the different integrity params. It
creates 4 different ublk devices with different combinations of
integrity arguments and verifies their integrity limits via sysfs and
the metadata_size utility.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile        |   1 +
 tools/testing/selftests/ublk/test_common.sh  |  10 ++
 tools/testing/selftests/ublk/test_null_04.sh | 166 +++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_null_04.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 0f6abb95c87a..d567f90d30b3 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -24,10 +24,11 @@ TEST_PROGS += test_generic_13.sh
 TEST_PROGS += test_generic_14.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
 TEST_PROGS += test_null_03.sh
+TEST_PROGS += test_null_04.sh
 TEST_PROGS += test_loop_01.sh
 TEST_PROGS += test_loop_02.sh
 TEST_PROGS += test_loop_03.sh
 TEST_PROGS += test_loop_04.sh
 TEST_PROGS += test_loop_05.sh
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 6f1c042de40e..9756b0ee876c 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -374,10 +374,20 @@ run_io_and_recover()
 _ublk_test_top_dir()
 {
 	cd "$(dirname "$0")" && pwd
 }
 
+METADATA_SIZE_PROG="$(_ublk_test_top_dir)/metadata_size"
+
+_get_metadata_size()
+{
+	local dev_id=$1
+	local field=$2
+
+	"$METADATA_SIZE_PROG" "/dev/ublkb$dev_id" | grep "$field" | grep -o "[0-9]*"
+}
+
 UBLK_PROG=$(_ublk_test_top_dir)/kublk
 UBLK_TEST_QUIET=1
 UBLK_TEST_SHOW_RESULT=1
 UBLK_BACKFILES=()
 export UBLK_PROG
diff --git a/tools/testing/selftests/ublk/test_null_04.sh b/tools/testing/selftests/ublk/test_null_04.sh
new file mode 100755
index 000000000000..0b0719ea33a3
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_null_04.sh
@@ -0,0 +1,166 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID=null_04
+
+_prep_test "null" "integrity params"
+
+dev_id=$(_add_ublk_dev -t null -u --metadata_size 8)
+_check_add_dev $TID $?
+metadata_size=$(_get_metadata_size "$dev_id" metadata_size)
+if [ "$metadata_size" != 8 ]; then
+	echo "metadata_size $metadata_size != 8"
+	_show_result $TID 255
+fi
+pi_offset=$(_get_metadata_size "$dev_id" pi_offset)
+if [ "$pi_offset" != 0 ]; then
+	echo "pi_offset $pi_offset != 0"
+	_show_result $TID 255
+fi
+pi_tuple_size=$(_get_metadata_size "$dev_id" pi_tuple_size)
+if [ "$pi_tuple_size" != 0 ]; then
+	echo "pi_tuple_size $pi_tuple_size != 0"
+	_show_result $TID 255
+fi
+capable=$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")
+if [ "$capable" != 0 ]; then
+	echo "device_is_integrity_capable $capable != 0"
+	_show_result $TID 255
+fi
+format=$(cat "/sys/block/ublkb$dev_id/integrity/format")
+if [ "$format" != nop ]; then
+	echo "format $format != nop"
+	_show_result $TID 255
+fi
+protection_interval_bytes=$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")
+if [ "$protection_interval_bytes" != 512 ]; then
+	echo "protection_interval_bytes $protection_interval_bytes != 512"
+	_show_result $TID 255
+fi
+tag_size=$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")
+if [ "$tag_size" != 0 ]; then
+	echo "tag_size $tag_size != 0"
+	_show_result $TID 255
+fi
+_cleanup_test
+
+dev_id=$(_add_ublk_dev -t null -u --integrity_capable --metadata_size 64 --pi_offset 56 --csum_type ip)
+_check_add_dev $TID $?
+metadata_size=$(_get_metadata_size "$dev_id" metadata_size)
+if [ "$metadata_size" != 64 ]; then
+	echo "metadata_size $metadata_size != 64"
+	_show_result $TID 255
+fi
+pi_offset=$(_get_metadata_size "$dev_id" pi_offset)
+if [ "$pi_offset" != 56 ]; then
+	echo "pi_offset $pi_offset != 56"
+	_show_result $TID 255
+fi
+pi_tuple_size=$(_get_metadata_size "$dev_id" pi_tuple_size)
+if [ "$pi_tuple_size" != 8 ]; then
+	echo "pi_tuple_size $pi_tuple_size != 8"
+	_show_result $TID 255
+fi
+capable=$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")
+if [ "$capable" != 1 ]; then
+	echo "device_is_integrity_capable $capable != 1"
+	_show_result $TID 255
+fi
+format=$(cat "/sys/block/ublkb$dev_id/integrity/format")
+if [ "$format" != T10-DIF-TYPE3-IP ]; then
+	echo "format $format != T10-DIF-TYPE3-IP"
+	_show_result $TID 255
+fi
+protection_interval_bytes=$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")
+if [ "$protection_interval_bytes" != 512 ]; then
+	echo "protection_interval_bytes $protection_interval_bytes != 512"
+	_show_result $TID 255
+fi
+tag_size=$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")
+if [ "$tag_size" != 0 ]; then
+	echo "tag_size $tag_size != 0"
+	_show_result $TID 255
+fi
+_cleanup_test
+
+dev_id=$(_add_ublk_dev -t null -u --integrity_reftag --metadata_size 8 --csum_type t10dif)
+_check_add_dev $TID $?
+metadata_size=$(_get_metadata_size "$dev_id" metadata_size)
+if [ "$metadata_size" != 8 ]; then
+	echo "metadata_size $metadata_size != 8"
+	_show_result $TID 255
+fi
+pi_offset=$(_get_metadata_size "$dev_id" pi_offset)
+if [ "$pi_offset" != 0 ]; then
+	echo "pi_offset $pi_offset != 0"
+	_show_result $TID 255
+fi
+pi_tuple_size=$(_get_metadata_size "$dev_id" pi_tuple_size)
+if [ "$pi_tuple_size" != 8 ]; then
+	echo "pi_tuple_size $pi_tuple_size != 8"
+	_show_result $TID 255
+fi
+capable=$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")
+if [ "$capable" != 0 ]; then
+	echo "device_is_integrity_capable $capable != 0"
+	_show_result $TID 255
+fi
+format=$(cat "/sys/block/ublkb$dev_id/integrity/format")
+if [ "$format" != T10-DIF-TYPE1-CRC ]; then
+	echo "format $format != T10-DIF-TYPE1-CRC"
+	_show_result $TID 255
+fi
+protection_interval_bytes=$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")
+if [ "$protection_interval_bytes" != 512 ]; then
+	echo "protection_interval_bytes $protection_interval_bytes != 512"
+	_show_result $TID 255
+fi
+tag_size=$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")
+if [ "$tag_size" != 0 ]; then
+	echo "tag_size $tag_size != 0"
+	_show_result $TID 255
+fi
+_cleanup_test
+
+dev_id=$(_add_ublk_dev -t null -u --metadata_size 16 --csum_type nvme --tag_size 8)
+_check_add_dev $TID $?
+metadata_size=$(_get_metadata_size "$dev_id" metadata_size)
+if [ "$metadata_size" != 16 ]; then
+	echo "metadata_size $metadata_size != 16"
+	_show_result $TID 255
+fi
+pi_offset=$(_get_metadata_size "$dev_id" pi_offset)
+if [ "$pi_offset" != 0 ]; then
+	echo "pi_offset $pi_offset != 0"
+	_show_result $TID 255
+fi
+pi_tuple_size=$(_get_metadata_size "$dev_id" pi_tuple_size)
+if [ "$pi_tuple_size" != 16 ]; then
+	echo "pi_tuple_size $pi_tuple_size != 16"
+	_show_result $TID 255
+fi
+capable=$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")
+if [ "$capable" != 0 ]; then
+	echo "device_is_integrity_capable $capable != 0"
+	_show_result $TID 255
+fi
+format=$(cat "/sys/block/ublkb$dev_id/integrity/format")
+if [ "$format" != EXT-DIF-TYPE3-CRC64 ]; then
+	echo "format $format != EXT-DIF-TYPE3-CRC64"
+	_show_result $TID 255
+fi
+protection_interval_bytes=$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")
+if [ "$protection_interval_bytes" != 512 ]; then
+	echo "protection_interval_bytes $protection_interval_bytes != 512"
+	_show_result $TID 255
+fi
+tag_size=$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")
+if [ "$tag_size" != 8 ]; then
+	echo "tag_size $tag_size != 8"
+	_show_result $TID 255
+fi
+_cleanup_test
+
+_show_result $TID 0
-- 
2.45.2

