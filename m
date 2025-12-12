Received: from mail-lf1-f97.google.com (mail-lf1-f97.google.com [209.85.167.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1202777F9
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516630; cv=none; b=JDL393CyPcWkhHnSrVQy3l0QnQWzCReWU4I7ek26j8+n1uCKaGAwUwNAnh55KgWxJr7UQO7c9YrpQQJKy/XDa4krH+6aLsB19xAZRjxDfETAnEaY5wm9c07U9RRF7QyyJmMnCG196TDgO93Npfrjkc7u83w7/tU3sSmTSHFE6eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516630; c=relaxed/simple;
	bh=FKbZngLfGMe4F0ejdKJ0fZ6ILmuYiVZnIW21hOqoFMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdV5QSIVNEu8yIamNeWDetWaaU4+z33HW+pydpEQQr8as9/JoOexapH0lUV8xPqJ/6UFVsNf1ZMjE94Z8BMd12ewME+9kNR/ezIAvL/wtlknnFUr297rooD8xrrnEtdPvN0/CTWX1MX8PZtcqKSrYf/nrFUDTMwPMA1lSjDIHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Jk4PtFN3; arc=none smtp.client-ip=209.85.167.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Jk4PtFN3"
Received: by mail-lf1-f97.google.com with SMTP id 2adb3069b0e04-596a55d3c0cso49426e87.2
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 21:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516625; x=1766121425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYMmhxte6MTatk0mD4pdp1WR7i9P7+V+tQDFdQu1wO4=;
        b=Jk4PtFN3GvnPuzWi8qP9AoU2rQyqhyOyf906j1oe4pSifzdFm76c7ffZXWw3W+uaQM
         O4QzqFJNuh1177inOF9opDLSkNQ1xkDzeizPRuC2fZ4R52CnDADOR4XKIJmIMzE39v18
         hLLtCa56f1uqGUL77SAxYl64Wo8yCgzmONh5mLZNMI5Zelqc+Oo7rPmDIt+KD9hm0LZb
         PuZkjzUp7sA/PKaLKDyGARS1g3xkdKPqmalVf+8DCkEDj1H+/dEq6l1NVmOhKwFgmvkC
         1LBzxdSPnCmWFmEO9QjxCTwihchuZ8u8pQCKY1AGNFXlLpRwFLO3ekGioKr16hPyXx7r
         EXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516625; x=1766121425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYMmhxte6MTatk0mD4pdp1WR7i9P7+V+tQDFdQu1wO4=;
        b=oBvI1VzkqTKNnm7ESngIrLraLvY9wHBYSUwtGCKGDdW4XIqztpZwrl+Eq05cXv7iua
         w0bvq82ctsUkX2dknWfHlrCeuonBhXb8/s6PF3ZN4XZsWC9A+Gyl5FEvQBlHDtVO10U8
         eH5pycSwsbMhL1Zvrs7ix1BHGzgjoQ2z6cX6/hPiBUKS7CufcuGrB+TDUscXC1gMrTuN
         5Qe4IOfZeOyzXiHmSGfMleblbvuB3tVG0J7uea0mDGupwiXfeRuxz+F4Dik0rc3GffIj
         ikK0edLJ+nQFLymqfqTsb6DaQiMjXZONqszeuHFNMH7MACH+P1877/x1WcXHs/dCskfL
         Ib/Q==
X-Gm-Message-State: AOJu0YzvaaOaXMzgM609/VUDasvBY8g985vjJvAQNs3kSK3EhyONdzif
	v1yQSufVxxHVMcuRDGzHifgk+Afjr93vMpQhPEC8ADNWwmfEnX1t86uJ7Hkqn9I6gX14LW+JjRb
	rbag3gwhIkA5ZU5/xJgC0ay8OzI5wuFe+UpYkYKpehDzw1pqQk+x+
X-Gm-Gg: AY/fxX5S5pOVBNjP/ZGGD7HVh4YaD8hL7euqfwva8UmlZtvyfay1WFnZ/CRUam2hsOn
	AHUZYWWU4QtVNtEATZRAP02e7nCx1NtFICL2X6HTOywUF6Jpqhx6dsaN5qF5MnVfrUeII2/oBHz
	/OXRDv/QtzwIH38vgAjR5f9sLlTeuuUnlSlZ76T7R1ECvFJoWV7cPMJcgkk5ah/UgBuTeNdc9YH
	9jidcBVZydB05uF95LE2hcEdXmQguvlvMgqKSSN2VckcqIZABatBn+Uj6G+tiIolJ5PMb38croq
	mNjKnACVoSy7X+pMTnINlHPRTHmT5iS32JjcwQ5Q2aX5NkxwHcGg31+XB8dSZgK6exxXKQRR0CR
	3rJPIAYLvV1FdvQN6v4ZZR/Rsbu8=
X-Google-Smtp-Source: AGHT+IHED7+rpkRtlBxZO9p+36KWOh4E+ddumxvqZJI9AqcJZ3H9gbQi4l8+a8BmFg25VzAg2XnOgm+Pi/q+
X-Received: by 2002:ac2:4c49:0:b0:594:3a08:162f with SMTP id 2adb3069b0e04-598faa018e2mr135201e87.1.1765516624931;
        Thu, 11 Dec 2025 21:17:04 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-598f81d098asm529311e87.24.2025.12.11.21.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:17:04 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 445CC3420A1;
	Thu, 11 Dec 2025 22:17:03 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 41BE3E41A2E; Thu, 11 Dec 2025 22:17:03 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 4/8] selftests: ublk: use auto_zc for PER_IO_DAEMON tests in stress_04
Date: Thu, 11 Dec 2025 22:16:54 -0700
Message-ID: <20251212051658.1618543-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212051658.1618543-1-csander@purestorage.com>
References: <20251212051658.1618543-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stress_04 is described as "run IO and kill ublk server(zero copy)" but
the --per_io_tasks tests cases don't use zero copy. Plus, one of the
test cases is duplicated. Add --auto_zc to these test cases and
--auto_zc_fallback to one of the duplicated ones. This matches the test
cases in stress_03.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/test_stress_04.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index 3f901db4d09d..965befcee830 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -38,14 +38,14 @@ if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
 fi
 
 if _have_feature "PER_IO_DAEMON"; then
-	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
-	ublk_io_and_kill_daemon 256M -t loop -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
-	ublk_io_and_kill_daemon 256M -t stripe -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
+	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
+	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
+	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
 fi
 wait
 
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
-- 
2.45.2

