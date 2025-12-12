Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28F02D739A
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559832; cv=none; b=BfkoTcbnde9x2CeXzm5m7pGkejg3ywlGWJxI+LNeJ0UUppdH+IfSqOAF5B1S/fl8xsrpqqvn6KIZsr18amODKTAvnWZRxNkgGmOrcyyNlJU6Fy3/75/b1JRXiZf6g8K/iIq1zOMxJV+cl35GgRlkCEclEu7HBaNJYx6L3lShm94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559832; c=relaxed/simple;
	bh=+cVia0YqFLhrPDWq9CwKaca7IitMDAWFURSGq1uOQdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGSlEzeVZ0T3muhizrqHdSUoBcnJ5f183d9FFyyFjLuG+r74ITPl6TZFHJ3jw/7zGW8duhhxomWmv5TtVGY+E9HYJ+f38Kz3WxFYzi4uPmOCVdiSTmAoKX19R8wlodWghl8UqpupIN9pwst5U/r64UdwNr/iLpeaqQ+l8G9ZETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=B3bH8foP; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="B3bH8foP"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-7d481452588so98942b3a.3
        for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765559830; x=1766164630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NOEIyKTQ4B6JXoSeSWaOQfr++6G02m3bohInlhRqug=;
        b=B3bH8foPO+ABH5T9yflbvxpzwPNzv9sx0BXlHcMGxjexlzLql/byvG6zMYrwbVo40E
         bP/g5xEF3EhHeeR6jdU9FLxzmIs0ZjJuUoemdKiE8qaU1+IssDeDY3fNHCp5I4vhabgs
         6UCVOC6/Mila12ivRHLmev+9CvDoRFHnImQz7nmpcyWoK6MTyXjhfBi+jNesHcGlP/3W
         HKjkzQMmFA5/BGjnJ3oU19qbuL+DEOY9EqgO6UFMyDFZi6MfG3fmQ/1Iet2N03AXYZCF
         XWkB/7596UJYyhZwuCTqTRVu1J9h5kx1G4+S3wVVGglXUkjzUD10NF46+uTfD1sqmp0o
         o31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559830; x=1766164630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NOEIyKTQ4B6JXoSeSWaOQfr++6G02m3bohInlhRqug=;
        b=GMqGbFt/42/Hl9EBDqgahP63bq0dNOKN/tvjRzQzuAyyTZ58w/4Rf/FsFEbuE8CceE
         mWhpMH1CYZrZXHyAzs5kNCJwMVX0NvavwErBqMPu5sdO15KpvFklCC4mepCYrE9AFyMz
         uIdBnh+/1kSBn5vI51lzP3AaUoM6ER07gkz7FjTVZ1O7jiM5xVmgQDZ5+71nRrXaRhSB
         nPhXsPyGy1v7juRjh3VPCJO4yKBnLwgttJq1viWaCzlSVan0Qw6L9invhH4O2tg9ORzv
         N7W8tI8N2RKQ+ayUyrw2z8WtepuqIKSy9RVNYIyFZ0iBvLtjvQIP24uBdJTCP/QR5TtH
         oQow==
X-Gm-Message-State: AOJu0YzveAg3A/YjRe48sxTsavBJQWUayNAfSJdC2Fi/7BoXrLn3hShG
	IYukpiP7I3VOvdi058KwSg+eMJUwGhwkTQeCIOhb59eqsH2AkILm1FK6BMTDt5UjL8+UX2rWBCK
	f3bQOM6EKjZMqNHSUzGNjcaZFHgGvP7E0ZOda
X-Gm-Gg: AY/fxX6k42xz30I/MEW/s2+HU1ErQDEYiFNmpg9FOJXwZvWnsEIOHL7tHZmG4e0OY3D
	EfbsAtyjETfLYeWgvrl29RFOay8HCHhqrgI23sXWBikasyHGt6zWWLzwjHvjf4AoM0vadxIQAH/
	H1+FvGdogE1X0F4Zosy7MgklglK/acosoGQTKkEfIQj1+L405AaNmaKaAx8U7EudeLLLjKN/odv
	cs09vMHFM7inidYsKb82PXTKJkGHwAw16tC/SgivdGlKuJb1Cj2sZhGXOfkhTealWhtRAh6B6Mi
	lFBUXhLDnE+XUVe581HiOZDAWUezSMRt/Q4LAEaAzT2O/d5ycqhU47DQJ59AKbKXpqyucchPVQS
	/LWw1g/sV0EBKungX4Rqz6FnmgvYJbZqzC/QnwDvftQ==
X-Google-Smtp-Source: AGHT+IHpDdHBoJHEFtsw5G8Q+oXhxmWs0OnZKWDZwJIWo8p+KqoHWDCCol6UB04IZ7qsvhQ8mmu9137r4gnv
X-Received: by 2002:a05:6a00:234c:b0:7a2:855f:f88b with SMTP id d2e1a72fcca58-7f668dc54a6mr2346324b3a.3.1765559830118;
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7f4c276f23csm831520b3a.3.2025.12.12.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:17:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8532A3407A6;
	Fri, 12 Dec 2025 10:17:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8337FE4232B; Fri, 12 Dec 2025 10:17:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 4/9] selftests: ublk: fix fio arguments in run_io_and_recover()
Date: Fri, 12 Dec 2025 10:17:02 -0700
Message-ID: <20251212171707.1876250-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212171707.1876250-1-csander@purestorage.com>
References: <20251212171707.1876250-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

run_io_and_recover() invokes fio with --size="${size}", but the variable
size doesn't exist. Thus, the argument expands to --size=, which causes
fio to exit immediately with an error without issuing any I/O. Pass the
value for size as the first argument to the function.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh     | 5 +++--
 tools/testing/selftests/ublk/test_generic_04.sh | 2 +-
 tools/testing/selftests/ublk/test_generic_05.sh | 2 +-
 tools/testing/selftests/ublk/test_generic_11.sh | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 8a4dbd09feb0..6f1c042de40e 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -331,15 +331,16 @@ run_io_and_kill_daemon()
 	fi
 }
 
 run_io_and_recover()
 {
-	local action=$1
+	local size=$1
+	local action=$2
 	local state
 	local dev_id
 
-	shift 1
+	shift 2
 	dev_id=$(_add_ublk_dev "$@")
 	_check_add_dev "$TID" $?
 
 	fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio \
 		--rw=randread --iodepth=256 --size="${size}" --numjobs=4 \
diff --git a/tools/testing/selftests/ublk/test_generic_04.sh b/tools/testing/selftests/ublk/test_generic_04.sh
index 8b533217d4a1..baf5b156193d 100755
--- a/tools/testing/selftests/ublk/test_generic_04.sh
+++ b/tools/testing/selftests/ublk/test_generic_04.sh
@@ -6,11 +6,11 @@
 TID="generic_04"
 ERR_CODE=0
 
 ublk_run_recover_test()
 {
-	run_io_and_recover "kill_daemon" "$@"
+	run_io_and_recover 256M "kill_daemon" "$@"
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
 		_show_result $TID $ERR_CODE
 	fi
diff --git a/tools/testing/selftests/ublk/test_generic_05.sh b/tools/testing/selftests/ublk/test_generic_05.sh
index 398e9e2b58e1..7b5083afc02a 100755
--- a/tools/testing/selftests/ublk/test_generic_05.sh
+++ b/tools/testing/selftests/ublk/test_generic_05.sh
@@ -6,11 +6,11 @@
 TID="generic_05"
 ERR_CODE=0
 
 ublk_run_recover_test()
 {
-	run_io_and_recover "kill_daemon" "$@"
+	run_io_and_recover 256M "kill_daemon" "$@"
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
 		_show_result $TID $ERR_CODE
 	fi
diff --git a/tools/testing/selftests/ublk/test_generic_11.sh b/tools/testing/selftests/ublk/test_generic_11.sh
index a00357a5ec6b..d1f973c8c645 100755
--- a/tools/testing/selftests/ublk/test_generic_11.sh
+++ b/tools/testing/selftests/ublk/test_generic_11.sh
@@ -6,11 +6,11 @@
 TID="generic_11"
 ERR_CODE=0
 
 ublk_run_quiesce_recover()
 {
-	run_io_and_recover "quiesce_dev" "$@"
+	run_io_and_recover 256M "quiesce_dev" "$@"
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
 		_show_result $TID $ERR_CODE
 	fi
-- 
2.45.2

