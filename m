Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06EE286897
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430200; cv=none; b=bY30XhzqPY1SEN6OqflSlvtY+Hrv94VAu5e2AfkT2Jg0NMidh/DZCBPXUhOwhiF4qMZcK30e6P0cxDamw3xIQUohpcqPeayHqaXvzC1xDKdKy6y93LZVoe7dHn0jZyItrcNVM1uNRSMQ36qSbHxj3DNx+hz1rmZA40C80u3mfzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430200; c=relaxed/simple;
	bh=FKbZngLfGMe4F0ejdKJ0fZ6ILmuYiVZnIW21hOqoFMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntJyPz/fUihgJyES5bJJ61YOVixQMXalnkMfpPiv2kENLj+5EyTvwYV664yZLmmrDak5jDn4F3aAWP97PgtI2IqBArGmNvczkMat/V33/ttH+tB1SpWsYTsZ3WqV/vhG1bnZtfaV0vucnHaU5vD+yNVyMsNg6QjDzvLodMlIyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PyfksFWC; arc=none smtp.client-ip=209.85.217.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PyfksFWC"
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-5dbd4f2c3a3so27666137.1
        for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 21:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765430194; x=1766034994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYMmhxte6MTatk0mD4pdp1WR7i9P7+V+tQDFdQu1wO4=;
        b=PyfksFWCqbwVw34UP8Pi5hz2STwDa9VrLb75AWeKbRJ5NeoB4ZyZrX/pe0dqDpILOC
         4BKAhD6Rln8ruAy8MhYXg4DyF/EFwjYkUJcO8QQjoJGHFu9YMHpbPBgCVsFY1ioHWidw
         ChKxdT5SL8eickZjAVEzcAVQ6HVJGMEYhIADESbCRNe+aw3yfILlevnP2k0b8QhTIxiw
         KkgAD0409hZ/gg/06wHLGJVAJNWF73I3XHleaGsi5RsMOyXlc3ZDov1bh8hM2l/IoiEc
         daxgkbWG8Mv59ons6/xS9gYLcL6W67CjmFOXrKY+iOcmdUzQ9GymQE8G3DvD5AlpTPMp
         kqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765430194; x=1766034994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYMmhxte6MTatk0mD4pdp1WR7i9P7+V+tQDFdQu1wO4=;
        b=A4Uo5k712mSVw3+hrRqP+k1t8Z/XtaEwxUIBGqJkzLlDBCyvfWBhzs8hzQdj+lD2jT
         BR9C+dss1PQGiLwCnJUQVVkHOjrE9T0aKuPoqm8pfKFcYYXWyQbbwKVIuLfo2bVRm9zD
         u58WRgO6TJwIc0vVSq1IrAGe/4DVUnmj5arg4creoz+h5N8Goa1p2przEpVGkm3CDXNe
         ExkglCgxF2qER+y/Mj5gTiBkneIlk3/RgrKKFNgVVGJxFjfxCaunTS5aNpyPjjOgULIV
         53jybomFcbsd6MwT0Q3HiVQVFNAFmRlkKy4bTouUes1765zqqotOCbpSoc0AbPesERLE
         cTbg==
X-Gm-Message-State: AOJu0YyttCaPK6etXCoES5UPwsS/c2vcFw2IOShGZ9i22MbDxH2WFYbC
	ZL7Ol3AouonJ9LFAtrg0zR96+2V7LFN0ZqQM/EOnTMT/pGusDRZblGEW+AV3hO11qoH7rz4eliI
	KN8ZyyCqHtNx7kRHLsoTIUJdG9lfTPb6haL+q
X-Gm-Gg: AY/fxX7ULiXbBaBwwc8bHJd6PxH623iUcKTZZMFNbySPSbSQ76iuU3uhOYoXROItkpt
	5nJ1DWCFbpTM6ymM/bSU9HxR0QzS5sPndgVQjrgd/M9OHHB2+yZDBC5ltElIje40EEi4K6b12D/
	JQ9bjxffoJpnnKo+FsUvF9wUXKOTKMYOk9rjb8p+RWzlhshNCog9KlttV3q1AsUWIHR9joR/Bn+
	//yT14Zvpgqa5G/JXodVe1SJQTNAf502Os5c/FDtbG86mLQE16+J1wr6jeKvMIlP7gBdd2oJ5rU
	ExXF/IJrRDn0nEDI4O7ma1SdDHhxvGabyiNUCz1YBpymlYH9BghhBTBifkGoa1uqMlC1/dPMPYR
	gwM+ciXqAB0LnxFOxKk7YXbZWETb0TK86jc0HIQRBZQ==
X-Google-Smtp-Source: AGHT+IH8wHkl6849aTSVx4QBElkuCxFtShXY/UySGgPZAopPw0H4GLbBbyJqdZsPQRlK5nTLNG77Q2JCbfO0
X-Received: by 2002:a05:6102:644a:b0:5db:25d3:28b4 with SMTP id ada2fe7eead31-5e7d0e28186mr197796137.5.1765430193704;
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5e7db2613afsm151339137.4.2025.12.10.21.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 21:16:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 42E6F341DDC;
	Wed, 10 Dec 2025 22:16:32 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3E0A7E41888; Wed, 10 Dec 2025 22:16:32 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 4/8] selftests: ublk: use auto_zc for PER_IO_DAEMON tests in stress_04
Date: Wed, 10 Dec 2025 22:15:59 -0700
Message-ID: <20251211051603.1154841-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251211051603.1154841-1-csander@purestorage.com>
References: <20251211051603.1154841-1-csander@purestorage.com>
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

