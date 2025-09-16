Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17629A31D
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 22:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060721; cv=none; b=TJweLiyoLOtNfDn4yc82231ORclLvRwjl7Oub6YgqDxO7n9iDlDIt2ejYY8HDIaRSG4wFB2oXMC+NyLrqdpQYfxy/kvVDruWzevrqdDdWxRnrfe/Vs653q7QecytVGP9PSNqwKM9Wfe6+ky1Mi2T2RryYcSmVpXOYsDc2kr3zAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060721; c=relaxed/simple;
	bh=XttLlsk7gRYOJmZapB4xIOHiWQITKrOKA4AQTvB7Qng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BxHzT2+4Cf/P/XBjSsCFBPcQWuY5xV4TlpRfeLl2jnpBAcw9I2vKJFPjRh4kVLX+J2tEn+FqHNH+jfpzvFGLicBViWmQazCGt/20YFecvRwqpwq9FW3ZRjn9ChYvlZggLPByPeYBq9QQBXp6sflWKRgjUCmpWzMO2wziXjpJBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TwrvrGg+; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TwrvrGg+"
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-829243c1164so300343685a.1
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758060718; x=1758665518; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gw4DZLmwyg50YkiGh4/gwXF8OX17xCIpJi1m3KAs3MQ=;
        b=TwrvrGg+Yx150JEEa3EX4I/vZ02aC41DFgU8tA0gB5Ay7UTnBt9EKU0RCU6j13B4xS
         rmJUOs04pwcQQMHnm/s2FWrFXudPIQCx8ZeMEBHBTJBLRcz+9YqvOfmnHtOc3aBImwgg
         D53jo5JW/FfbwwUlkT7kQZfDIe///6OrqlCaIpQnERQtTKqKbdv4cODSHMiYvPiTX6Va
         P1yA9oqL/SokPHBM+k4uKNcykspdLVgp8FrJN9TJUa5EG/jeKoasib9iSLhlPhyDf2r4
         Y+rtWOtiHv1DlqZ9M6q7D3syzKfvlRm2cE9haL+kosRHlMfhspNXzAUEAai661E9/oGz
         vfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060718; x=1758665518;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gw4DZLmwyg50YkiGh4/gwXF8OX17xCIpJi1m3KAs3MQ=;
        b=PARBRPHspYTHfwxHvfVEogZ6pWxYv1FX/Psneq0Cc88f2ZE6u/4xGfQD6sY39/NMeL
         z1g0gARYJPJ1ucqF++VFS9FuDGaKZzZobHxbBUjX9l3gW6RyWA16P+IzGp/Jwona6Xxh
         ej8ekSeZs/W+9Uzl3ghwzSPLmQUL/VQrJlhOi3NsCT6CPpK3QTSlcS1i4QvmULLOR+MK
         TqD0n+TBj6HhsIhIPaYwyqXe30A+z7gA9iWIlPBcKgWfc9LECYZdV3XNxJqbXFouClmf
         TELA3yFl6wHDJaE8ixBFRBiEjtyV3Ad3lnOo2y/qF86qAXkcmbWLc/bQ0Vria+Z1ioJM
         nwoQ==
X-Gm-Message-State: AOJu0YyKVKjysGfL4UO0rGfg/PkFMYn0A8pl9RIISvNjFARdkeSYo8ES
	Y4RqlbXaNcQ7gRsq8zxoDeWzMd8WrcAZai0BFd5hjGajduij6uYYeieCyMa248EDQqu88DE7jy5
	42a5e2BgpyTvvjB7uXQ1WNZePeB1eI8qHXgTu
X-Gm-Gg: ASbGncsklKBlszNwzLGeQ+y3/KaWIKnbbnt23phPliNUlir96dOr3+KStlglLjqhqHD
	6ivBdAw8WVsyrwVKP1QFkZ6BLjVVJBrkgC5CWtxAMfdEC/UG3JUKv4h4hjQf72XKsK+uYMTAn+S
	zQ2mpLk69kkAoNNH+j/fVHZ4JHo1+G1Vp+yuEDDlxgIPx87FF8ALctLxNXSbMl4tJmW9vFrVFSp
	U+nboemxNqHgJCZRvBv+SPodsgDaTZxvSWSIswlceGSD7GldjZBvJKT+zc/94+RkM9wgw/EnRBB
	bn4X+d7lFtsZvSfvR4nE1Z6EilC54o7nPTtPgKmM4OhG98cYkJWS9y55AZWdl1bPWDQ3WpWpeQ=
	=
X-Google-Smtp-Source: AGHT+IEnOu89ChzU0BaakveFO/z5V8vksE/0QseUXToeKSzd42RhZeVmBkDqeZoXQOUm1RYcOOqyWsIgjzJ5
X-Received: by 2002:a05:620a:44d6:b0:807:198c:8880 with SMTP id af79cd13be357-823fc1c9312mr1910814185a.18.1758060717588;
        Tue, 16 Sep 2025 15:11:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-820cd700f5asm91037785a.7.2025.09.16.15.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:11:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id BA82334023F;
	Tue, 16 Sep 2025 16:11:56 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id C8796E41646; Tue, 16 Sep 2025 16:11:56 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 16 Sep 2025 16:11:53 -0600
Subject: [PATCH] selftests: ublk: fix behavior when fio is not installed
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-ublk_fio-v1-1-8d522539eed7@purestorage.com>
X-B4-Tracking: v=1; b=H4sIAKjgyWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0Mz3dKknOz4tMx8XUNLQwNLS4skA4MkYyWg8oKi1LTMCrBR0bG1tQA
 tsZGgWgAAAA==
X-Change-ID: 20250916-ublk_fio-1910998b00b3
To: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Some ublk selftests have strange behavior when fio is not installed.
While most tests behave correctly (run if they don't need fio, or skip
if they need fio), the following tests have different behavior:

- test_null_01 and test_null_02 try to run fio without checking if it
  exists first, and fail on any failure of the fio command (including
  "fio command not found"). So these tests fail when they should skip.
- test_stress_05 runs fio without checking if it exists first, but
  doesn't fail on fio command failure. This test passes, but that pass
  is misleading as the test doesn't do anything useful without fio
  installed. So this test passes when it should skip.

Fix these issues by adding _have_program fio checks to the top of all
three of these tests.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/test_null_01.sh   | 4 ++++
 tools/testing/selftests/ublk/test_null_02.sh   | 4 ++++
 tools/testing/selftests/ublk/test_stress_05.sh | 4 ++++
 3 files changed, 12 insertions(+)

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

