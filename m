Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D1425897
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791692; cv=none; b=BdOKdfpBVUJ/nPBnLQlp6PTKrS7TuOMP+RPQdszxYTudJG5Gr6rh9vw0lk+T2dUxvGGWAZSS4gFJECXEl+0H6/ybABCVonRGXqZRXLxClT15VvGyBfQ02Vv/17dMT/erkxbzhHPMqTMyFHb3wx+KgLYs1n6HhRVsgPD4dCkK2J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791692; c=relaxed/simple;
	bh=8qxekDeSK5x+ec3E67tUMH2DiSjF/BHmj5eXMGM1EUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjyTPRQxdFiMyVaW7YoSiUUdnI7DZ3yIv5kSuV2pgSIAwkMDAxg8F+9ZO6GUt/I+XwL72FHJpEoqFraFrMECI/uxBgb9M8QWJQLcxsGjtUlChXhJsb1a6kWat+ptpNrm5OJrail5WrOWjRvO2VyECSraaly2QK38dGd46D9dbTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DDzxn+MX; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DDzxn+MX"
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-907ae87ebfcso3562556d6.0
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 14:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785791686; x=1786396486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/ysi0c3v/nSs3PcCunYETC+T3p7rfWS9Ra9/ntvyBI=;
        b=DDzxn+MX2lgwWRBkZu6OQhokrvUo1q+qdVG3p2rhBfx8VhGU6gwhBUlqTeQBCoB30B
         L/tEaknzZ5BQcejafpvsfq1939ABqYP7vtmBBbcuohJfC2b4+rh9IWURJkOJ6UWYnRLw
         DJxvZxEV55gJTW2/bQ1bvnoOq8yGFpuKfVT7UviH6LcyeZ8kn+Vc4/avg+eU6nvQ5Yyf
         Ih1Quw9TDgsdQjVEjjcpJNsec0WVBRtdZQVDs4GEQLYqeOxzSK43QDpFaLxwQwCRaNLy
         pd+aAkvEotoEqbiyJ7caWLZZqm5pQ5+r/6HFpP7/zd913dFy49Sz6wD1sYm5XqmdFoh9
         4m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785791686; x=1786396486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/ysi0c3v/nSs3PcCunYETC+T3p7rfWS9Ra9/ntvyBI=;
        b=KVAkyOhZ3eaP7cMiMZzawS8L38Fj3NfhByB2WA4OUQxgbtJYKl5Usqx+pZKfrzkyWH
         SA5LywimrWN9nWd9apctaAJiYGGJRYHbTJr0rECBCDaNk/YXfPk6Rrg6OyjTbT5I6chu
         Gv4vtjtynBR3QXENSj5W3YCXNAI9jBnOPvMeAk9VRTfyUYM3z1k9h0foMna3wQnMMZws
         mCRQHyGsvjO78lfh+CI1gIu9P2rUfoJjmlpt33hzllKyHszIa8UUaq2AfPxziPCP8+gJ
         98hbZZyc9j0N6yzmwQRswNT2spLS4Ie7lP9rFIKladWzJgeJyitjsSQVUvYpXzxTjr/f
         HaKw==
X-Gm-Message-State: AOJu0YxPm3Lgz1LfT7AfP+I2qExajSSILrXB2AdYQQsuZoJIp+2IN0+p
	LkC2cOwkLpIWFkl+JxequdAjHj2sFBXVrS9KHxutB05EqroaAsdDTCpLCm728dBFkaeBE6+N/3I
	R3+uEy1IWJB4f4nL4m9nqQdhUSpoChX0Ujf3j
X-Gm-Gg: AR+sD12bzqhY7u6xZFbe4e5nAWs0AIJd2SjYvI8Q8sQuDQ/S/DuzbyxMQI5A1B0MbYP
	fUWy9VvSIpwwNXND7XTrc9uYtC/Am8vTqGcjUF+cp9MvYmRXEFLVR80qUBGTiBlIgvJHu5/ZNlf
	qismqPi2RIp5R7m00aU6mZU1cWVZyg78/GEDbSRVYt1/JUBxnkQ9XSR8UafNvsw37SU3lPnwDbA
	ntrY+Yj1a+B6RTNXM/8JedMgYzn0hR05tJSNo2YcGjbxzFDtOERK0kEoCBqaImjn19H1x5xqjDI
	C8nsZoOL4YukKRQ9DyviEx4mEsH8HzzYsUz2RSzyBUSl47nb+8OdO8mZ9uDoWJx6q9QWAgaNvPO
	k889xaBVGc4nfwSNt6d/Imd/5I+4Lt3E2
X-Received: by 2002:ac8:7f55:0:b0:517:6162:daf5 with SMTP id d75a77b69052e-52b5681199dmr174778891cf.3.1785791686336;
        Mon, 03 Aug 2026 14:14:46 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-52b4eb94561sm4853741cf.22.2026.08.03.14.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:14:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id AD42143524;
	Mon,  3 Aug 2026 15:14:45 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id AB005E4041D; Mon,  3 Aug 2026 15:14:45 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 7/8] selftests: ublk: add UBLK_F_IO_DESC_SIZE test
Date: Mon,  3 Aug 2026 15:14:39 -0600
Message-ID: <20260803211441.2538144-8-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803211441.2538144-1-csander@purestorage.com>
References: <20260803211441.2538144-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test loop_08, which creates a ublk device with UBLK_F_IO_DESC_SIZE
enabled and io_desc_size set to 64. The test issues verified I/O to the
device using fio.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile        |  1 +
 tools/testing/selftests/ublk/test_loop_08.sh | 25 ++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 6e4fe8d1fed1..b00ef238a038 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -32,10 +32,11 @@ TEST_PROGS += test_loop_02.sh
 TEST_PROGS += test_loop_03.sh
 TEST_PROGS += test_loop_04.sh
 TEST_PROGS += test_loop_05.sh
 TEST_PROGS += test_loop_06.sh
 TEST_PROGS += test_loop_07.sh
+TEST_PROGS += test_loop_08.sh
 
 TEST_PROGS += test_integrity_01.sh
 TEST_PROGS += test_integrity_02.sh
 TEST_PROGS += test_integrity_03.sh
 
diff --git a/tools/testing/selftests/ublk/test_loop_08.sh b/tools/testing/selftests/ublk/test_loop_08.sh
new file mode 100755
index 000000000000..f7af2587482d
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_loop_08.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+ERR_CODE=0
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "loop" "write and verify with io_desc_size"
+
+_create_backfile 0 256M
+
+dev_id=$(_add_ublk_dev -t loop --io_desc_size 64 "${UBLK_BACKFILES[0]}")
+_check_add_dev $TID $?
+
+# run fio over the ublk disk
+_run_fio_verify_io --filename=/dev/ublkb"${dev_id}" --size=256M
+ERR_CODE=$?
+
+_cleanup_test
+
+_show_result $TID $ERR_CODE
-- 
2.54.0

