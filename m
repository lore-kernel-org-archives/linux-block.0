Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7190225A2DD
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401144; cv=none; b=VN4U091axqN883ssQul8/DIlpE4EI1ePDnBzYiBVasxgnMFsrG5S3jlJBbzlxLefFaHkk+BktSZGgUlZs87gVq3Zsy/9N4T4Vv4yT++Ahu8EdRBRQPh9hMZiMwS0CZCYaTNqCahdwI4v/SwpVgHcWFIUs3lxR7YhhKcz8rl2N1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401144; c=relaxed/simple;
	bh=T6I6wJ3K0zbZovsFhPHvXVOw2B2xHcL5y1GMqwzvtJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3z8jioyNrOFMR2LGYxQbI8LV/vWy/R89pXgv+erqRP8M/kajkL9VrL3o6Nc77c9QPr7updKB0zrZv9JrNsEcJ0xkqbmY/NzK5mAlvb0u3d5CzeiKirQ51bRf4yDdYj8U+8xEj4uyX/wNDphWopeDLnVDJZKPHFh56XWUUVwL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ErFNr+tz; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ErFNr+tz"
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-6446c1b327aso1744379d50.3
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401136; x=1768005936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMHoFk6qxgkVzaDa4BWjqhlQdF6TcBBx1Xc90nS+iKc=;
        b=ErFNr+tz3yWB1PdPogqri8YNOEoE37BsA1htINfi32HxtYv1jmy5E46XHWmZLpSIMk
         +WeGKSKWi+3791jTTRf6ekUn6ThwPAS57ZVck8qPoTU4zHO3brrApQmvuNrPj8OXFdEC
         hj1fY9KSUYM3EVV9uZ53XZVcbLi++7JWl6CE5WLJhjy8ka51bxx33lM+e3b+9YXcQvkD
         gZhGXx/LRO2DbmPyQqw0IK1QH0bAz8GADVPp90CLfe1h3Qr6TCeJxTEQZnMIP8puR/bj
         MRukWtuOG8aSdCS3YkwxmbnZAV5+b9gvlqGbmklaGIla6ZpDkCGKaKr+XVV1YNqks2BN
         W7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401136; x=1768005936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iMHoFk6qxgkVzaDa4BWjqhlQdF6TcBBx1Xc90nS+iKc=;
        b=YNHqi6OUVBsLNdfX28PkX0gzj32cEd4Z5lOuhqUjUKJUF1i2nFO1W6SSwBf28Q3c2h
         Gckz7fNvkzN8ksTmOphx2LHGDIilSXuPjFCgWdbCO81HCx3Fl/kc2w6PKrQU2eRQm9hs
         TAT4+hDgcQ1hBVHum5S7VERuzAvWCgMLzUw/NuCFhnBriIaqCib2sa0EJv6zarfIb6qk
         PQYKSJBrdE1WIlJPB3TEzYNVQ3nHTopeneNgxwcRdy6Cbj4ASBCDYw6JC/yn/qVvKMiG
         LIH+q8PN4l4KV5PQKdKYTbSX6pOhvxTn2xNiREuAox2nONEEIWwFxaksZyQF+9VLtyhK
         yBgw==
X-Gm-Message-State: AOJu0Yx+0uCUTmaZMLRTdVpyZWt1hYkme9blXOWsH6u1n9B6GYDWRSTA
	Z1tR/3+FYCKq12mcUmHeNLTNWYP/136vzvCisQxn3QGbmzZZG4lobHBiIa9XroxVCcF7dSQynxR
	0qu/ZLiJt50h+/jGh2Q1BScbNLLPljTNKbjxSgTNmdnP7hhNSCKNt
X-Gm-Gg: AY/fxX7/llcf1uShrDjzA8ZZmKfajTO80utff65xXrk1rLDGhoS2bFx5QNYOU9NjUQy
	26zD0PTFTjUVoqyc9DyE6cfKmCbzplxzZdXvBKxPGX6SIVB9DOmHaZg7tq7I7i/BGWmU9P9RcGy
	3p3DdX82y+leKmHIgJxAHHGiLynYJptqcuXDItACa4ccE2f6Hfb4lppxKgbU2/Wq8V9ABq1B6pY
	gN2sJD0gnH2qza+AtXEncEcAjG5k+vFD44CURJRCwLrqhdVQ22NGStNImGojewFUOj9C2uEgwJF
	McG4L6J9NfrS7tOdtcveNS0Vb9hluzqZ2lXl7O9YqHp9N0x/gos5yvucbCzfaG0sFdDFYwkQshZ
	EQlKEhrHVI/7KXEisQ68KnKfGAic=
X-Google-Smtp-Source: AGHT+IGZCBwrWBAXCJXU3hc6rJVsmVB1yfkFx752MekQsf0o8FuzhVWl6oSZF47VlzZwoNripcFsCHwHInYw
X-Received: by 2002:a53:c043:0:20b0:63f:a103:5d26 with SMTP id 956f58d0204a3-6466a933687mr22504120d50.6.1767401135899;
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78fb4550d72sm20957187b3.32.2026.01.02.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E473B3402DF;
	Fri,  2 Jan 2026 17:45:34 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E24FBE4426F; Fri,  2 Jan 2026 17:45:34 -0700 (MST)
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
Subject: [PATCH v2 18/19] selftests: ublk: add integrity params test
Date: Fri,  2 Jan 2026 17:45:28 -0700
Message-ID: <20260103004529.1582405-19-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
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
index 41f776bb86a6..bfd68ae64142 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -25,10 +25,11 @@ TEST_PROGS += test_generic_14.sh
 TEST_PROGS += test_generic_15.sh
 
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
index ea9a5f3eb70a..7ff6ce79d62c 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -382,10 +382,20 @@ run_io_and_recover()
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

