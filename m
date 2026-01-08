Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98AA3EDD69
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864017; cv=none; b=KJaVV2sCP+XoQY2fNkVy/Y3Hq0xwA7X5gXKeHCJbjYfgYQj+dH7phTD6f/dnhtsEnT6STs5GmX64rJ1QesyTt4+Zf37iSx7jKnu8RIbZuDmcG9TLPrAWsorJFZLu5U0Y/ZZvRCZmx2AeNZwwTgy9d2Hqvm7hT23tbOjvKf0sjcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864017; c=relaxed/simple;
	bh=eWMcbdJYhFxvXFqjbBRedUH0jQ5siz6lFXcZN8bMrmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7wPj1hIZUCA8KKhhGiIITjNCxIlhaQI38l8+svHq+oJxuwtZRZUA4vky2gfSSvNzX1Kyjrzcf+MBj3BcPC3pSgUWnFpMYt5ko5A/ApFb3qP47rjHvyP8982EdEe8J8ewxvRv+uX+M0RipGWdjAi2FuPZ2VOlmzpu9mEpTp7Js4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cErvshYF; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cErvshYF"
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7c78003b948so362717a34.1
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 01:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863999; x=1768468799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaU0XpTuR03wE6PGtvQP43RzD+KIxiTF9KOB8gOkl3o=;
        b=cErvshYFo0xrcjBV6YGmWCaja9qhrTTLAEIuF/f0RGtWxmnmG8SsynQ0kDHUqYWhwz
         yM4d/1RhdljDIOCu2y8CjgePkj18kenXtB6qEILqEfU7pYnWCqSTqQGF6+iik3PgPURs
         VUxdos4Zwm6p7M8QXngrrZtrYXdI6rpkf0K2Wr87n7/SjOj40iIR0gm7Vx1uBj8gKk4Z
         +FgUtIcqU2JxRNfwv+DXJJ9JFxk++u7yK/qB9o+DW6K1BFXqUTO0VC1m4pO4fUscfn7r
         lLK6nVzDMLhunQgbW/z2n6S6Nk/a9oLMjaiipMGuikQAaWTDwn1ubQ/FvZLFv151Mr8M
         Hx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863999; x=1768468799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eaU0XpTuR03wE6PGtvQP43RzD+KIxiTF9KOB8gOkl3o=;
        b=ZJP48zMss1XXyPEaJQiZoEE5/RYD1yp+LDlqj6LLWK5Ye3QFoFeH1dDHcLXgLTP/dy
         haReKmBduv+/cNU6/C7jCXrMQRukderOrKmhTnJNgpnCRxSIDeOPOELDvDVwH0K3yFAX
         3jB7fyFiA53KnIxC6r6dvgtUo/No6u9j6uin89vkAWA5GCRb+ZKJFHPS2WjoqYZJ2474
         TIGYQL2Z33zRqABDAlBRfzLBYA2/l/UkNghPjdp2jD3awujvJGFVldwVO57Qx9EUwpil
         2VHvr6rmJigWo3jh9kNLIN78SogebZ5AbcQGPFyp9IDOv8YRquwdDpn1PMGwNDz7QsNK
         W+Sw==
X-Gm-Message-State: AOJu0YwQ/fSg5pKBjHyFAsAsSHW0T0zv03V6c++scizy6TEraYyaohzO
	Fzh7kBy7S0sulJCIwCuEoDYjmDN3jK3GWbqLJFC/ThGOqJJBoEEnhAW7BFbWtEf/sgu9PhhLIzF
	2imK2X2R2vggtRWY08ZQbS5r5eDr3O6rGRXAN
X-Gm-Gg: AY/fxX4avVA9LHvC0joNVuleCLaBPo8aEKUq9f2holVc3vrFG0H+lvhSl9H//SPeIKq
	2newEFAK5/qAUuWJv2pNi2UjXe0fuyJ09O5UkETZ87dzoZqbYpCdbaGmChiDSLkqjMoVCChagx/
	EkE351UIIDNeNbVfsa+ofKx04mKZ1uMy9iNchxM6CQcX3rSrteXOMCAi+o9wH0E/FhIFOpbddQH
	jjMBNUjWqZj8Voh2WHXYZBDlkLSWx8hgYavld/O6xUh8Yybaepz3BeONgKG4v70iO83h1vIyiDH
	h9cRO6lqDWj4TIXOkbHcAn8k+8SGlrwyxk9J+IuMOR6ihUyPlNC+RmPt1O5OIHUgw98Ujjzi38+
	qTQjNWqkMqF66vsj5l467usQKSTQnfK198K/Q3jyhWg==
X-Google-Smtp-Source: AGHT+IFYvl6fYndMLF80xvEQYCcAZV09cJSN26yC4MLZIkfZxRKtsAzFauxuHLBWb6KYs55Z1KkAiyisPKVS
X-Received: by 2002:a05:6871:a003:b0:3d3:2fa6:e16e with SMTP id 586e51a60fabf-3ffc0c4ee00mr2082048fac.9.1767863998824;
        Thu, 08 Jan 2026 01:19:58 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ffa4e3e739sm837434fac.7.2026.01.08.01.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:58 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C4CC4341DAF;
	Thu,  8 Jan 2026 02:19:57 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BC4DFE42F2C; Thu,  8 Jan 2026 02:19:57 -0700 (MST)
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
Subject: [PATCH v4 19/19] selftests: ublk: add end-to-end integrity test
Date: Thu,  8 Jan 2026 02:19:47 -0700
Message-ID: <20260108091948.1099139-20-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
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
index 239ad1c741ef..036a9f01b464 100644
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

