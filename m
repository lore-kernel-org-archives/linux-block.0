Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CC1188713
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 00:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069777; cv=none; b=Me5r3WnQTS6Aur/nLqypYO50DTXlWmfO1XSXet1G0jCkb2QHfaeq9bDkKJHwgB4s/4h4K+S4ZYVZhzPm67/GEEhlVsFah4/yO/E+XfJRPlIwZ+FZDArjHpDMz/D3ZYn6F5NFRTmrxdMc7rksgzAsbW6oO8RlYa3+bP39gWdMcdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069777; c=relaxed/simple;
	bh=IoCZ6ZPxfmj61WyHvtWW0iu+5wmp6Y5xJVRbIn3IzA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U41K3nq7UWuoyCL5jy9sQlJfvP33TwEthjuhqS8EdZ8hfOR+5d04R+rZt1oNgx7fHhXIPfT3PnmAlNp+8fYSFHkhgmwnJ7eHJQmhEbiY3QyJYSd0rBmJnj1kuguzwDMb6bbB/Le9Xy1pe/XhqugbioAFNq66lSVU8WTPXU8tbxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=P889/CWc; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="P889/CWc"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-251fc032d1fso68516915ad.3
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 17:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758069775; x=1758674575; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ATmFGymkybyKAm0NHpJujWlpTamfL92YEA1XMkuNKxM=;
        b=P889/CWcl31iCJ/5pcXBnFqq/b5z3SyNtnBDXY40wTLHcduH7ze3ouyLoqADDVWHmB
         PsfoBXBVdNHRxIiQgRrEQ/e8hhaMnLYq7nXEU6/vKT9se3nSRnxCrDSI9njk04dDlc+B
         jvwqr04b0veFRA0DZGJ42F4SQ8B4+JAuMw62dQkpwVT1M/bVLd03AUgohQqZduTN1gb5
         JBwyobdKUUCAEcWm588ycAzCLMsUscLPLfr8NG+OWqunw3YvlKK54JuLMF2LZICa4MPT
         55WAF8mqXvY2T179rl/c7/QgTb/MUCgj+9XxDeCIEdL+y8MIDYiTQefKn32IM/cIsIT7
         ANFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758069775; x=1758674575;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATmFGymkybyKAm0NHpJujWlpTamfL92YEA1XMkuNKxM=;
        b=KqOmJ5nWw/hOGUB4YO0yQ7b3Woffu7nGnXHCQ1BrxpV0xPuQPoUE7OBUG8jvZl0o8o
         cIivuVyr/9DoQuIvIawKLVhRx7zZw7Nu9aTI7jivEili9rogkVQQjfWyYo2QN8BxM6jl
         A8+M5XBmYKg57uNpvPOghIE09kls9TUlSIYHWkWlRv8yFs5Aab9NLaHBGOnhQkNTaXF9
         EKa1IraBsEjx5Xqxvx75gy/n5ado3lX7XDxf/TbOlL6Jl2EwnW6kfWUaIzFzMWUrxru+
         ZTgEMSWEDz/RbxCK2/ykbV0OLvDlDQgq+f229g0SHQHejyob2q2FxSpnR8HUKXK6qRas
         rVYA==
X-Gm-Message-State: AOJu0Yz2B6RZqR3KIQAKo/JBej9EQVuu8uQcyP88yHGB3VOC3tkDKbuP
	WpNqA3DhgbYfUqin/xsQGQZqL0hwM86BQNX9LSpyM6C8UC1DOibXzNwSn1IH/6T5+dAf8iOjYyX
	S1mssQQiUvXDLx+5v7lpknetiJDI5bbHWuZmIubxPOkfo/Hq0N0OX
X-Gm-Gg: ASbGncuCR1nZ9yd3CsoqLvnXq2c0bxWWX9CZ6A+AgpozkjL93SsB2ChoN+O0+NdSbHY
	HIESoOnOp7S4g8EmHPgUhmwu8J90+Pi8UnyZNielSa2dZGoWLzDifD3M7EvzHlQNqyjuM+lOK/2
	bujGjX8XqIaV9YX4+YkJqGhVnze1adArxt11mhD2At6nEs2ginfO913OmqLAs84SRnsQ6wH1xlf
	RRGd6ufCdnSm87AeJR6buBjj2IebdfI9ZiQRp7ObynOHg4RCoin2rd5pZzlkYKwp0fSCEChA8+/
	7e/1Xx0xAdzQUb2f5WzCVe8soJH378n4gVyceMFHtPQAyrGR9BmDEFtZrXY=
X-Google-Smtp-Source: AGHT+IGa74cu98ZPyPu6W012ECueI7Hm4NVYYwlDa0a5J3DAoHe3e4Ppjs5ycH+FwgrMvaLiDgzM7paLxaEo
X-Received: by 2002:a17:903:19d0:b0:25c:25f1:542d with SMTP id d9443c01a7336-268137f2336mr2357405ad.36.1758069774981;
        Tue, 16 Sep 2025 17:42:54 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-265c4769cccsm8241155ad.41.2025.09.16.17.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:42:54 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 49A0334028F;
	Tue, 16 Sep 2025 18:42:54 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 2DCDBE41646; Tue, 16 Sep 2025 18:42:54 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 16 Sep 2025 18:42:52 -0600
Subject: [PATCH v2] selftests: ublk: fix behavior when fio is not installed
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-ublk_fio-v2-1-04852e6bf42a@purestorage.com>
X-B4-Tracking: v=1; b=H4sIAAsEymgC/22MQQ6CMBBFr0JmbU2npEpdeQ9DDIUBJiolrTQa0
 rtbWLt8P/+9FQJ5pgCXYgVPkQO7KYM6FNCOzTSQ4C4zKKm0NHgSi30+7j07gQalMZWV0paQ77O
 nnj976lZnHjm8nf/u5Yjb+icSUaCoOq2ULg1Rd77Oi6dNbAY6tu4FdUrpB7jjgMKmAAAA
X-Change-ID: 20250916-ublk_fio-1910998b00b3
To: Mohit Gupta <mgupta@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Some ublk selftests have strange behavior when fio is not installed.
While most tests behave correctly (run if they don't need fio, or skip
if they need fio), the following tests have different behavior:

- test_null_01, test_null_02, test_generic_01, test_generic_02, and
  test_generic_12 try to run fio without checking if it exists first,
  and fail on any failure of the fio command (including "fio command
  not found"). So these tests fail when they should skip.
- test_stress_05 runs fio without checking if it exists first, but
  doesn't fail on fio command failure. This test passes, but that pass
  is misleading as the test doesn't do anything useful without fio
  installed. So this test passes when it should skip.

Fix these issues by adding _have_program fio checks to the top of all of
these tests.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v2:
- Also fix test_generic_01, test_generic_02, test_generic_12, which fail 
  on systems where bpftrace is installed but fio is not (Mohit Gupta)
- Link to v1: https://lore.kernel.org/r/20250916-ublk_fio-v1-1-8d522539eed7@purestorage.com
---
 tools/testing/selftests/ublk/test_generic_01.sh | 4 ++++
 tools/testing/selftests/ublk/test_generic_02.sh | 4 ++++
 tools/testing/selftests/ublk/test_generic_12.sh | 4 ++++
 tools/testing/selftests/ublk/test_null_01.sh    | 4 ++++
 tools/testing/selftests/ublk/test_null_02.sh    | 4 ++++
 tools/testing/selftests/ublk/test_stress_05.sh  | 4 ++++
 6 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/ublk/test_generic_01.sh b/tools/testing/selftests/ublk/test_generic_01.sh
index 9227a208ba53128e4a202298316ff77e05607595..21a31cd5491aa79ffe3ad458a0055e832c619325 100755
--- a/tools/testing/selftests/ublk/test_generic_01.sh
+++ b/tools/testing/selftests/ublk/test_generic_01.sh
@@ -10,6 +10,10 @@ if ! _have_program bpftrace; then
 	exit "$UBLK_SKIP_CODE"
 fi
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 _prep_test "null" "sequential io order"
 
 dev_id=$(_add_ublk_dev -t null)
diff --git a/tools/testing/selftests/ublk/test_generic_02.sh b/tools/testing/selftests/ublk/test_generic_02.sh
index 3e80121e3bf5e191aa9ffe1f85e1693be4fdc2d2..12920768b1a080d37fcdff93de7a0439101de09e 100755
--- a/tools/testing/selftests/ublk/test_generic_02.sh
+++ b/tools/testing/selftests/ublk/test_generic_02.sh
@@ -10,6 +10,10 @@ if ! _have_program bpftrace; then
 	exit "$UBLK_SKIP_CODE"
 fi
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 _prep_test "null" "sequential io order for MQ"
 
 dev_id=$(_add_ublk_dev -t null -q 2)
diff --git a/tools/testing/selftests/ublk/test_generic_12.sh b/tools/testing/selftests/ublk/test_generic_12.sh
index 7abbb00d251df9403857b1c6f53aec8bf8eab176..b4046201b4d99ef5355b845ebea2c9a3924276a5 100755
--- a/tools/testing/selftests/ublk/test_generic_12.sh
+++ b/tools/testing/selftests/ublk/test_generic_12.sh
@@ -10,6 +10,10 @@ if ! _have_program bpftrace; then
 	exit "$UBLK_SKIP_CODE"
 fi
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 _prep_test "null" "do imbalanced load, it should be balanced over I/O threads"
 
 NTHREADS=6
diff --git a/tools/testing/selftests/ublk/test_null_01.sh b/tools/testing/selftests/ublk/test_null_01.sh
index a34203f726685787da80b0e32da95e0fcb90d0b1..c2cb8f7a09fe37a9956d067fd56b28dc7ca6bd68 100755
--- a/tools/testing/selftests/ublk/test_null_01.sh
+++ b/tools/testing/selftests/ublk/test_null_01.sh
@@ -6,6 +6,10 @@
 TID="null_01"
 ERR_CODE=0
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 _prep_test "null" "basic IO test"
 
 dev_id=$(_add_ublk_dev -t null)
diff --git a/tools/testing/selftests/ublk/test_null_02.sh b/tools/testing/selftests/ublk/test_null_02.sh
index 5633ca8766554b22be252c7cb2d13de1bf923b90..8accd35beb55c149f74b23f0fb562e12cbf3e362 100755
--- a/tools/testing/selftests/ublk/test_null_02.sh
+++ b/tools/testing/selftests/ublk/test_null_02.sh
@@ -6,6 +6,10 @@
 TID="null_02"
 ERR_CODE=0
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 _prep_test "null" "basic IO test with zero copy"
 
 dev_id=$(_add_ublk_dev -t null -z)
diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
index 566cfd90d192ce8c1f98ca2539792d54a787b3d1..274295061042e5db3f4f0846ae63ea9b787fb2ee 100755
--- a/tools/testing/selftests/ublk/test_stress_05.sh
+++ b/tools/testing/selftests/ublk/test_stress_05.sh
@@ -5,6 +5,10 @@
 TID="stress_05"
 ERR_CODE=0
 
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
 run_io_and_remove()
 {
 	local size=$1

---
base-commit: da7b97ba0d219a14a83e9cc93f98b53939f12944
change-id: 20250916-ublk_fio-1910998b00b3

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

