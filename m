Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB00D33CEA7
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679457; cv=none; b=MsZ3U1jQ7/AFbocOJM4If67V98b7KUY4vK2E7gL4/jNfEoX453VA2Uecj8rulShr0rLj8yhppRumyWdMSe2WV8qORviWc9FOKH1rMb1OH/Dd7p5PPCU0bp6NdOfjcd4RDFgYXGw0Zv14XeLYlARGE0B+usDm0xsm7fTL1ByOOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679457; c=relaxed/simple;
	bh=ZJPWYFIgWr/fyuaN2xn9XcDL+G5i6WTk1gIkovuWKVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L3xKSInvei7vRX1tEmyO4jHW+23k/n5A9vr1R5zb3DkPbgCwcpiE9K8P5WV23fidzA/lzKXFMrk+YlY0iZ8FhL9p2vIOSRYkkg3R4DkIIJWgPpBSYxVdWHbM+3ex2DZLvx7SLkRcHFiNnLyYCHd+yjXGZRLaVt8T+DuVHHfd+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki3USmfY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki3USmfY"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290a3a4c7ecso73065045ad.0
        for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761679455; x=1762284255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZUNqxnm0eoGyVL12t/bcEaXAjA9vRK9Z+0QxIk2Yok=;
        b=ki3USmfYIMKIRdaQrsRdXGtt2NnpWeg2H1sMNUvM9v3KZLq+f2oYdxwnXZ5myKNWIt
         D7NYt57KPO+Jpk9N6f9HYT6nyCe3QJMDDoIkMDvaEC7j9W5OUXETK3x6T/31o75gEBIM
         FNCUVeKmPsbqhn3g/yV6AR52RjsrP518RhBJHD00Oxj5/pTITFGeOKQ+LQUUK420AJNU
         tw7VoXe2wHs7ksuNax6l4wziquXRPNmkcJpKuSxjaUfEiya+w1oboX+P+1DFAV8Vpz0O
         CLqHbf26Z9d/GqfdLUMRsxKlCO+Ivud6gHyAORYKHExsOeVVIFEz7hhF/e8SgJ6H3YuZ
         6EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679455; x=1762284255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZUNqxnm0eoGyVL12t/bcEaXAjA9vRK9Z+0QxIk2Yok=;
        b=KlyFj+r6u9JcCnP+dB5wx4wXY+Ld/lqX5/TJ6pbSeb24MirtVAlUL0AyGMJG13jUEV
         mvhj/iB8FMd45Zh7CE1EDas8lm+cHfXMclEedr+MdMtqq+lj/tTCZImpPs0FDi/rsb5U
         kCPis8m8Y4ev17GCF3cYKNebfAfFcE4XSUYq6SWiAbiaBdxpP7b5Hv7LsxgnOxgvFx00
         U55dI5g2HV11Y8+utLG3nD3lmB9vaRrR2mn1WOPfIhVeaN9ckTYBVfVSldstdwqeXF0U
         MhIDInjwaS4YSGLd2zAcO8hi5shmnsFmgD5Uhs9nUbc60c7cSc/cdESZB3PY1qUSPGWM
         2O6g==
X-Gm-Message-State: AOJu0YzmNUnRTnMWjB3Q5VZBszLNBopIzU1xm+rUE1lI2Eo2Vg9zQhAO
	2IS2bb/PKuwXan1MiIjDT6YqlWBsfV3lFcz0yyAUxuyh1F97rEcH7Kuzkz//uQ==
X-Gm-Gg: ASbGncsVZpvJQaIA4NXuiTHmknBJWpEGlm58SHCf/V7Tr/9nmF1CynjtZ7qarRR/jNX
	arGU85L6p2s3hzRm27a76Ph1ILDPL/aQDdLqw2TS804W3LjpYxJwNw0HcN/wbWtTu7Kj3nXsPk6
	RiHlAFnu1S4z3DNBA/Pm2Olx1UhIS7jqrWYX3basUs5cUFwhKDh/fS/7dc2+z+hWUsAWJFIkKq4
	2gbwUc4HR3XEGMWp3up/C+i2lzLmtPdFwtgs1xOLE3knr8URHbw7+gi4JWGjEtyv/Mm/lUIpkwD
	8QKr9vTWRt9xKAKWIlct/DT9wxIz1KFsowsefls9wiR/CEJTL2qotaMXxwUC9ni22LdVsqikQjH
	+2icsVOeguc3fYTa3H/yOTti2ZBcdVUetNEQr4o/vdrMlqPU3ePDCsZz8wKHSHWe4
X-Google-Smtp-Source: AGHT+IFgnuSnxzxyZhlxXCm06adjAhw+FMslmg7CdLoYqsLNAQ2SWmYevbIro3Br6Bwt3HhLVwp6ug==
X-Received: by 2002:a17:902:f693:b0:24c:7b94:2f87 with SMTP id d9443c01a7336-294dee80f3dmr3866555ad.14.1761679454779;
        Tue, 28 Oct 2025 12:24:14 -0700 (PDT)
Received: from localhost ([2600:8802:b00:9ce0::f9da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d429c6sm128114365ad.85.2025.10.28.12.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 12:24:13 -0700 (PDT)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH blktest] Makefile: add check-parallel target for faster shellcheck
Date: Tue, 28 Oct 2025 12:24:11 -0700
Message-Id: <20251028192411.19144-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new check-parallel target that utilizes all available CPUs to
run shellcheck in parallel on test files, significantly reducing
validation time from ~40s to ~11s on a 48-core system.

The original check target remains unchanged for compatibility.

blktests (master) # vim 0001-Makefile-add-check-parallel-target-for-faster-shellc.patch
blktests (master) # time make check
shellcheck -x -e SC2119 -f gcc check common/* \
    tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
check:634:20: note: Double quote to prevent globbing and word splitting. [SC2086]
check:667:20: note: Double quote to prevent globbing and word splitting. [SC2086]
common/nvme:447:5: note: Double quote to prevent globbing and word splitting. [SC2086]
common/nvme:453:6: note: Double quote to prevent globbing and word splitting. [SC2086]
common/nvme:553:42: note: Double quote to prevent globbing and word splitting. [SC2086]
common/nvme:554:28: note: Double quote to prevent globbing and word splitting. [SC2086]
common/nvme:556:28: note: Double quote to prevent globbing and word splitting. [SC2086]
common/nvme:557:28: note: Double quote to prevent globbing and word splitting. [SC2086]
common/nvme:558:23: note: Double quote to prevent globbing and word splitting. [SC2086]
tests/pr.bk/001:9:3: note: Not following: tests/pr/rc: openBinaryFile: does not exist (No such file or directory) [SC1091]
tests/pr.bk/001:11:1: warning: DESCRIPTION appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/001:12:1: warning: QUICK appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/002:8:3: note: Not following: tests/pr/rc: openBinaryFile: does not exist (No such file or directory) [SC1091]
tests/pr.bk/002:10:1: warning: DESCRIPTION appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/002:11:1: warning: QUICK appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/003:8:3: note: Not following: tests/pr/rc: openBinaryFile: does not exist (No such file or directory) [SC1091]
tests/pr.bk/003:10:1: warning: DESCRIPTION appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/003:11:1: warning: QUICK appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/004:8:3: note: Not following: tests/pr/rc: openBinaryFile: does not exist (No such file or directory) [SC1091]
tests/pr.bk/004:10:1: warning: DESCRIPTION appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/004:11:1: warning: QUICK appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/005:8:3: note: Not following: tests/pr/rc: openBinaryFile: does not exist (No such file or directory) [SC1091]
tests/pr.bk/005:10:1: warning: DESCRIPTION appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/005:11:1: warning: QUICK appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/006:9:3: note: Not following: tests/pr/rc: openBinaryFile: does not exist (No such file or directory) [SC1091]
tests/pr.bk/006:11:1: warning: DESCRIPTION appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/006:12:1: warning: TIMED appears unused. Verify use (or export if used externally). [SC2034]
make: *** [Makefile:22: check] Error 1

real    3m43.712s
user    3m38.640s
sys    0m3.321s
Running shellcheck with 48 parallel jobs...
tests/pr.bk/005:8:3: note: Not following: tests/pr/rc: openBinaryFile: does not exist (No such file or directory) [SC1091]
tests/pr.bk/005:10:1: warning: DESCRIPTION appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/005:11:1: warning: QUICK appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/006:9:3: note: Not following: tests/pr/rc: openBinaryFile: does not exist (No such file or directory) [SC1091]
tests/pr.bk/006:11:1: warning: DESCRIPTION appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/006:12:1: warning: TIMED appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/001:9:3: note: Not following: tests/pr/rc: openBinaryFile: does not exist (No such file or directory) [SC1091]
tests/pr.bk/001:11:1: warning: DESCRIPTION appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/001:12:1: warning: QUICK appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/002:8:3: note: Not following: tests/pr/rc: openBinaryFile: does not exist (No such file or directory) [SC1091]
tests/pr.bk/002:10:1: warning: DESCRIPTION appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/002:11:1: warning: QUICK appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/004:8:3: note: Not following: tests/pr/rc: openBinaryFile: does not exist (No such file or directory) [SC1091]
tests/pr.bk/004:10:1: warning: DESCRIPTION appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/004:11:1: warning: QUICK appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/003:8:3: note: Not following: tests/pr/rc: openBinaryFile: does not exist (No such file or directory) [SC1091]
tests/pr.bk/003:10:1: warning: DESCRIPTION appears unused. Verify use (or export if used externally). [SC2034]
tests/pr.bk/003:11:1: warning: QUICK appears unused. Verify use (or export if used externally). [SC2034]
check:634:20: note: Double quote to prevent globbing and word splitting. [SC2086]
check:667:20: note: Double quote to prevent globbing and word splitting. [SC2086]
common/nvme:447:5: note: Double quote to prevent globbing and word splitting. [SC2086]
common/nvme:453:6: note: Double quote to prevent globbing and word splitting. [SC2086]
common/nvme:553:42: note: Double quote to prevent globbing and word splitting. [SC2086]
common/nvme:554:28: note: Double quote to prevent globbing and word splitting. [SC2086]
common/nvme:556:28: note: Double quote to prevent globbing and word splitting. [SC2086]
common/nvme:557:28: note: Double quote to prevent globbing and word splitting. [SC2086]
common/nvme:558:23: note: Double quote to prevent globbing and word splitting. [SC2086]
make: *** [Makefile:30: check-parallel] Error 1

real    0m22.464s
user    7m24.518s
sys    0m11.703s


10.0x faster than sequential
  Concrete numbers:
  - make check: 223.7s (3m43.7s)
  - make check-parallel: 22.5s

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 Makefile | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 36dbcaf..7825c79 100644
--- a/Makefile
+++ b/Makefile
@@ -16,6 +16,7 @@ install:
 # SC2119: "Use foo "$@" if function's $1 should mean script's $1". False
 # positives on helpers like _init_scsi_debug.
 SHELLCHECK_EXCLUDE := SC2119
+NPROCS := $(shell nproc)
 
 check:
 	shellcheck -x -e $(SHELLCHECK_EXCLUDE) -f gcc check common/* \
@@ -24,4 +25,15 @@ check:
 	! grep TODO tests/*/rc tests/*/[0-9]*[0-9]
 	! find -L -name '*.out' -perm /u=x+g=x+o=x -printf '%p is executable\n' | grep .
 
-.PHONY: all check install
+check-parallel:
+	@echo "Running shellcheck with $(NPROCS) parallel jobs..."
+	@ret=0; \
+	find tests -type f -name '[0-9]*[0-9]' | \
+		xargs -P $(NPROCS) -n 1 shellcheck -x -e $(SHELLCHECK_EXCLUDE) -f gcc || ret=1; \
+	shellcheck -x -e $(SHELLCHECK_EXCLUDE) -f gcc check common/* tests/*/rc src/*.sh || ret=1; \
+	shellcheck --exclude=$(SHELLCHECK_EXCLUDE),SC2154 --format=gcc new || ret=1; \
+	grep TODO tests/*/rc tests/*/[0-9]*[0-9] && ret=1; \
+	find -L -name '*.out' -perm /u=x+g=x+o=x -printf '%p is executable\n' | grep . && ret=1; \
+	exit $$ret
+
+.PHONY: all check check-parallel install
-- 
2.40.0

