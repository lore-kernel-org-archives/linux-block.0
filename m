Received: from mail-wr1-f99.google.com (mail-wr1-f99.google.com [209.85.221.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344DC231A23
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516628; cv=none; b=p5id3VoUX1Y+Dd/1L7PNeND/Y0yA9tfjyVDch3SFFQY4kT5rWZ9hUpcKvC1lUFxV07MuAef2ZpAoB/cy+bbq92culbwdOa+xE+IanJ4YoYjxsh7ffKs2VbASigYNnckX+AdOz7zqWbjab95wUgiDG5VonSPwUfireoD2n7lYkWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516628; c=relaxed/simple;
	bh=+cVia0YqFLhrPDWq9CwKaca7IitMDAWFURSGq1uOQdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1s88OsGoOZ5v0++rkpPtbFuaoP2rKyy14LCk9xS1VZnkKsYpx8Wqx48PbSysOZbyHJHy2trGDzV5N3cL+yYXQXVPmusnsfEX2QeAKNTUIlAJLlV0NyYRWpUFBkxcV8ACLREDpDNGiQqeS26zuqQISKjJf3iJySYI2P3FYM7WE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CwSu8H6W; arc=none smtp.client-ip=209.85.221.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CwSu8H6W"
Received: by mail-wr1-f99.google.com with SMTP id ffacd0b85a97d-42fb71a7b99so8113f8f.0
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 21:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516624; x=1766121424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NOEIyKTQ4B6JXoSeSWaOQfr++6G02m3bohInlhRqug=;
        b=CwSu8H6WECXlxH/eipz4CicJylAmlR6N5ErJ8XPGJeVaVm0YqUWl7zLjsoyvys5fL1
         YVJ/E4Acdjgs3cnwQ0/A+2BejXN+btpaxuDUqAhkeHAjtQe8QVKcCL9zynEodguRP8Do
         6QEftACVLQXTNtYP/yrcugIGAfluUCLyM02wJztnTyN99BuZCktCc/Grx1aSX6YjLfol
         d/cmYuq1el+WVa5Vmf/Ccd+O84NykXQX76vQff2M613HR1ER7P/Zz/w/uP1SEl8J8LsZ
         9mmrb5Fx7oFCHwY8cin+iVMioZpzDJxXsAzzeEyQqVtNRJqs3+VTGVhNGE9tC4xrd2WJ
         7uCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516624; x=1766121424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NOEIyKTQ4B6JXoSeSWaOQfr++6G02m3bohInlhRqug=;
        b=fTNICS4kPbRfb2jY5Q75YHGd7XMOnRSXcRs1zoPbT0KbqFQccYghElsaTsbaAH3SK/
         OuPtucgYxYLyuw6FHODIVTJAAM0c2sB3Nk15krM9fQYMk8q1fAlJt5JrIime75K3/KYF
         yJRuQi+1q3ZDA/sPNBcAfm/W+e+MYkNWBICSfMWTnroPdr02/YPhgMAw4kAEefFpRXtR
         FbHFq57gSs2IpNqocxRg/AyHQGs6tY/eiMdvZFM2qCLn5/fAehKkoFyhjhUIrWgxi+Ex
         WO3u9DIEy3gOaqZs8y/LGNNjmvnLaqCOazCQ85TEOObxBMMIEsHzeUgypMvcoSlRDeEk
         ajrQ==
X-Gm-Message-State: AOJu0YwSpOc7xoo37D0A6UpUjoW2t35nYULGDNqmw3tELcLetHnkJ/V2
	v6Q2Sv01CzsrZyOruiglP5drit0MeKBZwekTiF4I2nESZ+sDXqMMO2u9U4Sv7mv0KbU/Vhf+lxc
	MM26WTdDvayKC7XVw+5gOGasCroLBl9QzAGahmcjjHR6ub4anZ6gW
X-Gm-Gg: AY/fxX6U55SFJZmq62VbPQML/CxpCc5QRmRKcu6fbJPg+SQqNh6R022BHFujPLjGpbX
	fTS+Ule2I9+hjOvdYMZ64SgchcACsgo7ufu3P9aRXMw2oF0cz1CnxpRtjDfDQXhyqXwc322WUaw
	IODhrLtnE10F1EgHcVmJLBbEDFTRIWfZymjixMMU+bIOBV3aTDIA9GS5UfEQrzKOjoWk4+1qpn/
	UKb/bVVPGYB2UIOV6bOgzcBT+6jywlYDrHdROf77fnZ9kFg4V0BF5flPmSNeYjIPkdqWIcmeXwL
	2XDaWCaJT7cygXP/mTvBpt/SqosEyZK5rjG7pZfRszAAwqX25u98/38NRtoheUBA7F9swdF/QzF
	P7hj/0/V0OYNAZVAzr7w1ORDv8qs=
X-Google-Smtp-Source: AGHT+IG6s15ui2sqTjw1W3bSmPEo9ziYpeqrPKSLos4YiY34MH8bAphIvC8pdlnNW0DmClOs2FdPwqh6bDJq
X-Received: by 2002:a05:6000:2909:b0:42b:3e20:f1b1 with SMTP id ffacd0b85a97d-42fb44b3c72mr468875f8f.2.1765516624422;
        Thu, 11 Dec 2025 21:17:04 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-42fa8b88b18sm631354f8f.22.2025.12.11.21.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:17:04 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 120D2342042;
	Thu, 11 Dec 2025 22:17:03 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 0E7BEE41A2E; Thu, 11 Dec 2025 22:17:03 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 3/8] selftests: ublk: fix fio arguments in run_io_and_recover()
Date: Thu, 11 Dec 2025 22:16:53 -0700
Message-ID: <20251212051658.1618543-4-csander@purestorage.com>
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

