Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E96342A132
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864011; cv=none; b=kX32ggex7KJanNw1iKIIU9rTQ49Lgu5cPxZhr7Mr1FMC7d2ktzvB6mKzQV8TpLI+5kdW4wlfAP6dfk6RKYPHdamebydkHDyYfMYxSznU1V1DfY0ecov8JHek5mzItlIdygSWsqG+Tqa0g637OJyqCFj716fTuJvQDHiyMt4OC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864011; c=relaxed/simple;
	bh=9OzlcL0OMkkabAm5Bt97yjXJPRZ7G2AIrVYrMNNwlrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Blz3mzKrplYNC8xD3zMto1YCwKCxpQYkUTvmCWBFctnkDrLeYDcSI9PpyQkYaOhDCnTOykq1xm9nNhwasL6WDe4wqxsCLdrDpvbp0j7RvPzadhenRAhCE30/urJQ+QI6mfQdZTii/xrPbg4RnpQhnFraKvASRR4i0UAS6knLohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SrZ1Hv1q; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SrZ1Hv1q"
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7c7589281e9so552396a34.1
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863998; x=1768468798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUiKvIP8HCqd3i2lEOpd43ZYOvZAdiFALGFMxkbZ3Lg=;
        b=SrZ1Hv1qHYthTgwMEqzYS4jICA7jn9BHX9xFIFQ8APtlvxobZbpvzDkdlhH6K8548A
         A90m+jwNC1vuqW8z/e0yxJhrmkfifeHZzcHKTxIOKBJeAQ2FtZepRJELUl5Q1G7kh3Rd
         eRePO0cb/zgNRQH4l06WiJ4nt9Vtsv84YfAGZPRcaFt7N+D+y/GOtphLCXsZWUwCra24
         B1sxlysGhVNeP81LlDxLH6Idt7hyIOLghscpCuuHakiap9gkED5ayQibw0eppeEX8sOI
         m0BrqV4uhbRpgXhVVFM4cqs16OQU55mDWuk8UI8bc1U84bZAU5UGdcPujf3lK3MsmHf7
         Ts6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863998; x=1768468798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VUiKvIP8HCqd3i2lEOpd43ZYOvZAdiFALGFMxkbZ3Lg=;
        b=Ssg2t512lsxPwPqgxuxDnRWtjSlupmFl8mU0nbtX+eSVBzDMEiaOzESQE38wgqhiX3
         th2SmCHD7SHMaPBRQumsxzUunc5jmspk8iab0pZ76hHZIea58mYV5xSSiwF95TXpGBbD
         AuujT5J6iVNf9/OFYNQkJ4eMWRbd/YThWKK1mkwyT/T/8vdYHEWrBE0UGVGS6JX7qEeN
         IK9ftbbkrU9IODTAAZRmgUgwrx3DD7wc6tOhHp/swmDE01GGchaohecpk7MokTlId/Hl
         0UQbO0Yb+hZX3hoAu87g4uyZOlqpE+qGkDSk8rU62t/kJ4o+N3oBqH+EfOS6KlkYCFgm
         q6xw==
X-Gm-Message-State: AOJu0YzK5eP3r5askXt/012/Y+s/S5a1wSv/UR/YXn4agbp5bgCI811O
	r7VS2pUj2sz8/PbLTmVOq1N/jEfhTcJXzlzCZ07XirtHaDpoqD3FmXObFPMRWVRhinPqVI+fUFl
	qXiIOIkKt2V72mfeTK8+d0GZZfEfai94sFqlm8Unc43/4xdukdg64
X-Gm-Gg: AY/fxX6c3tiONllAoO4fAPSzi7n28cAM94UO7bRFEjM2pGhzeWbsG2qCNyGOp1q7k06
	sEklwJdiAaVgfnUd8IBxs98V4SO6wV9eWS33yECGFkoMA8XWWUhyZriFc7ezChW76k+5w17rSDv
	W3yn2OukM28dxKqGr+/5QsbXksqG4sqxGznmyQyIU+jXWwZFqrrB5HP5MmbWiFnyt4ILZLs9jSK
	PS5IzzXHpzsFMF+krj3JcoElGPb7E1zEVXfQIAY5IZqrZuCenLyK+ngk62uGlAYQl+LFmVBVHlG
	OYDv2G4dDL1icBRe1iNgd/ep14R0y6Du4kBOahn9CUXKVp2IdZJk7Y3kVx+61sck72wWDe8rUOF
	J+4IX1tTT6anRSvQX1E04yWusR8M=
X-Google-Smtp-Source: AGHT+IEMYn8qGLSHkK75uAAuzyF1tc5/kRXEa/H/RxheREPQOHr9VMCDWdd15D1Qh/+p630u8i3hRg7auOGU
X-Received: by 2002:a05:6870:b3d6:b0:3e8:2323:867f with SMTP id 586e51a60fabf-3ffc094ee9emr1931424fac.2.1767863997870;
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ffa4e3e739sm837429fac.7.2026.01.08.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E12183421AE;
	Thu,  8 Jan 2026 02:19:56 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DC198E42F2C; Thu,  8 Jan 2026 02:19:56 -0700 (MST)
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
Subject: [PATCH v4 13/19] selftests: ublk: add utility to get block device metadata size
Date: Thu,  8 Jan 2026 02:19:41 -0700
Message-ID: <20260108091948.1099139-14-csander@purestorage.com>
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

Some block device integrity parameters are available in sysfs, but
others are only accessible using the FS_IOC_GETLBMD_CAP ioctl. Add a
metadata_size utility program to print out the logical block metadata
size, PI offset, and PI size within the metadata. Example output:
$ metadata_size /dev/ublkb0
metadata_size: 64
pi_offset: 56
pi_tuple_size: 8

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile        |  5 +--
 tools/testing/selftests/ublk/metadata_size.c | 36 ++++++++++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/metadata_size.c

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 06ba6fde098d..351ac6438561 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -47,14 +47,15 @@ TEST_PROGS += test_stress_03.sh
 TEST_PROGS += test_stress_04.sh
 TEST_PROGS += test_stress_05.sh
 TEST_PROGS += test_stress_06.sh
 TEST_PROGS += test_stress_07.sh
 
-TEST_GEN_PROGS_EXTENDED = kublk
+TEST_GEN_PROGS_EXTENDED = kublk metadata_size
+STANDALONE_UTILS := metadata_size.c
 
 LOCAL_HDRS += $(wildcard *.h)
 include ../lib.mk
 
-$(TEST_GEN_PROGS_EXTENDED): $(wildcard *.c)
+$(OUTPUT)/kublk: $(filter-out $(STANDALONE_UTILS),$(wildcard *.c))
 
 check:
 	shellcheck -x -f gcc *.sh
diff --git a/tools/testing/selftests/ublk/metadata_size.c b/tools/testing/selftests/ublk/metadata_size.c
new file mode 100644
index 000000000000..76ecddf04d25
--- /dev/null
+++ b/tools/testing/selftests/ublk/metadata_size.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <fcntl.h>
+#include <linux/fs.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+
+int main(int argc, char **argv)
+{
+	struct logical_block_metadata_cap cap = {};
+	const char *filename;
+	int fd;
+	int result;
+
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s BLOCK_DEVICE\n", argv[0]);
+		return 1;
+	}
+
+	filename = argv[1];
+	fd = open(filename, O_RDONLY);
+	if (fd < 0) {
+		perror(filename);
+		return 1;
+	}
+
+	result = ioctl(fd, FS_IOC_GETLBMD_CAP, &cap);
+	if (result < 0) {
+		perror("ioctl");
+		return 1;
+	}
+
+	printf("metadata_size: %u\n", cap.lbmd_size);
+	printf("pi_offset: %u\n", cap.lbmd_pi_offset);
+	printf("pi_tuple_size: %u\n", cap.lbmd_pi_size);
+	return 0;
+}
-- 
2.45.2

