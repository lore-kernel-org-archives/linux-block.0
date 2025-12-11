Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF51DF27F
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430195; cv=none; b=gY/wVxRXR3OwcKu38fSs4M1BR4FZ7r0Kta78G4h5YWsROoeWOEyxjtWNOPbh/P+cvG4FX6PAirlMu4GtgY3XcYg8uY1BnWgNEqH59mbIsdOiIEFRB2MtAzdtwSsEsLjTwRc+gaAT/Wc0F5TFPC9FtiJN5xY2XM/ScXmvG4Q7TEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430195; c=relaxed/simple;
	bh=xXu+tf+waXGAT/KO+5HTnzcECs/GS8n6wDa3C/1zl2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxIPIfdLE1OWIGLV2QVUPCaPDd4MPzV0hCbLF2bXbTEOjmj3lB9oD8Qn1jMUG5h39uIftApGkSj3xjDFWUqal9Kml23a8udcOHEpX3uVQP7zfZ9uWECWLR1x6ZMlYCFwg0jJlkyoM34Po8sExtHr8MbS8Juj/Hxibxf20qWn0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Lz3qJqo2; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Lz3qJqo2"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-34a764f7646so86223a91.3
        for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 21:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765430193; x=1766034993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIW7E3VVU8tn1DtuqotssIV4P+soF2bl+d1MuLtFvGM=;
        b=Lz3qJqo2fLwHLy8ipMHT00KPmmBf9rpGf7x0zw1Z14hZpahMGqMg/Pnb9MkNFxc8Kc
         gt7Dcym6WBAXErx8qBelVUWg0hhrYME30uhDyJUKHEAMflX/HvtTIZgWSsdpge6rApEr
         gC1r4nLNANu9R9KXY2SRz+W7anh1V1vLfdXpGURAdJXfp2kJPrlJWdegaea0njHotfaz
         XjEpK//8gGCf/9RqwVgbzsgrYyDTlXfj52+434D7cx1MQZYQs6MFvsIzpVWdkKM26nM3
         acCD97gZe3QEW5YQLdOuz7dy0NGbBR3ltbD961+2pxArTgvcV6LgGFwaljdGHhVWpSY5
         XDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765430193; x=1766034993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hIW7E3VVU8tn1DtuqotssIV4P+soF2bl+d1MuLtFvGM=;
        b=xGqFAftTVkREd/YMh+ke6AMTx+hx63mcm/RZh5ubBP8MT6JEU2y+BDOL+W6zVsdn71
         nDisRImTuZCTyZrw/Qyh+t/n8bT6QlPmhSXsy9ZvjZMBOJrk4cXp3F+oXg8C6bvvoEUE
         ahDBuufVaj1eNSpgTFvI2aUhgXoJhl1BEK6SbIWztGcpRho14Abe7fsLCBs2yp8FhJ8W
         FYfvbWBOyrKOwUXLPdmHJzkghLc3V2n0DSvcIZB6d+KQxxy1r9hj+KVxhiAGjDeQav6f
         5XDxD4xJkS3hQPTKupxhXXPZ6qozw7iJBU6Fd9e5uqROBvVvaefp06ktaIL2vsz598HM
         F6EQ==
X-Gm-Message-State: AOJu0Yx0VdkanQRBV0r3ZmnP+bvcC/Imz/u+zxHyvrF9e8bEtC/Q5J0B
	ZO6AzhYp9D57ZHIUR6eVH5/SgJ8G0Yvmlfkt/kGfNcwL/qdVN1VmLtQUNw638Zl04TA9ghEUrxx
	iQo99meSzAtpzDlENumlpcIItUsNCJR5kncZL
X-Gm-Gg: AY/fxX60F4DCJvsq5XVU3pCE3grqdiWcx3riNdgyZcTUgkFs+z8p5+ShbaxIQw+t8D4
	IpLAbLlT7zozbkj9ku8GTvWSv1BxYgWuZv+ii8MV0I5Knq4dERB7e8qYQfZXtZwax6xks1srpWw
	EP1d3mz6zXzeJE5Dv77o5SduqVqOXS3Fc0chUnIDEv2fSYQp89eyLWxl9xfHIOU7gBISCq03HU/
	rxvHWWK8trwjUWoown16YNoO2ACPd7Kk1hx0BnaoCEi5i3OCVSxkbXGA6PADfYVIICyK61j/x+o
	p5PcejqH0CA8thbQ7uz19ACQ5lYiJx5IPCzS1ITXeXuTASxgHiNK8Rng/igPQdJ6Rcl9vGH+l7l
	eu9I7RmLFmWOghDTLtTfs6oYcN7dCwVhiu44qC5bpYQ==
X-Google-Smtp-Source: AGHT+IG7vmAzN/4l/NU8zDsbC/0SMS8MR6+u+mFFoheI/aKNzzXKO2NBd1YC20FVT8PGNC8K5ew7ysZpXoYQ
X-Received: by 2002:a05:6a00:12d4:b0:7aa:6dd9:807 with SMTP id d2e1a72fcca58-7f4f9d2dc21mr908468b3a.6.1765430192602;
        Wed, 10 Dec 2025 21:16:32 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7f4c44ce5e1sm228638b3a.8.2025.12.10.21.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 21:16:32 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0D1FD341D2E;
	Wed, 10 Dec 2025 22:16:32 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 0A359E414B9; Wed, 10 Dec 2025 22:16:32 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/8] selftests: ublk: fix fio arguments in run_io_and_recover()
Date: Wed, 10 Dec 2025 22:15:58 -0700
Message-ID: <20251211051603.1154841-4-csander@purestorage.com>
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

run_io_and_recover() invokes fio with --size="${size}", but the variable
size doesn't exist. Thus, the argument expands to --size=, which causes
fio to exit immediately with an error without issuing any I/O. Pass the
value for size as the first argument to the function.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
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

