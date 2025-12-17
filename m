Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC06284B2F
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949724; cv=none; b=byLbqg+FBkLT04JNKVVratZABidFVlTYp3zxtP8/VjVplQQuRuLsQBRCUqUP3qDHonbJqqsP7D9NXQMBSL+U2LauxVgWFf2Gyx34285Eg6n9qt2Xt4hHuEMqL3IyMVX0ZYlmjF8SxYPssWkZTeChsJxiZdZOdshBk1mkMYJSN7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949724; c=relaxed/simple;
	bh=/9oWm8ceEqAfsBsRYIxRgDxZg5GCtOB+F+ShDr0LW3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ka4YnXLp8f611WOXgH+cr6phaNFSH562lKUHE0QRjgyGfdOwrFCcLzp8r65JoL0fabtG1Zn8y5c4F24ayPIRjMvv2VlpOmRNfSiT76e88eeGwvCXD1lITRF58stvK00Hu+pAQVTy7l90md0wHazPWwD0DwahlnTBTxoEOUBWSms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VJCQn6ag; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VJCQn6ag"
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7c914482db2so969576a34.3
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949714; x=1766554514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXZxkMGXAND9SSH5kAPkz2RMm8mE6lzClGRP/OAbhxk=;
        b=VJCQn6agCcXKaI+LUIjJ4n+k6Eo0cWNzp/wrQtzqjxyVdSwdzLrDdfZXEIEkM7+ixM
         4nyI7oIDvSh2VmvDvhkhUWst9jnfWW7BLPIa3TPVjiEvabKToGYPJ/e7yfp6e1Fj3gX4
         Idr4t/dQG5pPZ3fKXiKx4c5/cOkQa74OiR5n14ZzUxqITGSnzWr9nC8EwfOcG8ZZ+Z+9
         ot2dFA3eh55snxbbb/6k0hptYjnJy/RBCSZgBC5RzKFVXSsVogh7uJgygccNvlvPxp3/
         D8GmOvbhzRwD/tRYCNMrkA+gxMB9MSh4co8HKsF/sAy14RYzZDvKQK91fALRPAAL6g4s
         wkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949714; x=1766554514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eXZxkMGXAND9SSH5kAPkz2RMm8mE6lzClGRP/OAbhxk=;
        b=R+mtRD1BF9KB707qKTFesr81TkKF+SMnQev4zE2rftiVaTIwk2BxA0RrU1BWBQfc/0
         7UdxLdmLEhM6T4hy3tS3XJyahn7BEftMRZECC50bqmA1u7DTzM3K4ukt/lcrO8Yt6bMX
         41iKkW8cmPydHca+X8tT73k2oSH+c2PettewyxrcQdkELv92/DegdL6uUKHtbDtb7Iu9
         LrtPDZEvd/0OMAM3cGqeaWNsBO0ptvpfBFbreYR1AMPbH4QOzYInuuYnp56ZBZxoizjw
         Kl6B9rmffW6sbrcBpfDdbeudGSX65GhkZ3Howfn1pKd3tvftlDTnHeuB8OqIBg0aLUDO
         loKA==
X-Gm-Message-State: AOJu0YzrHeyeRGlIuZrkAaQHmKR49HRTbCj07wcgiFUk1gvDuhUlVp/K
	FE7SJpMertZw61Ow75OFE16D19jT9XYkTr/WL843j3PtsnNeYQJNceKouneTzphOibOJ8BEfIGw
	XJgw5JEPgzZHj04RoOV8lLfSHBPG4t2QSwmy1
X-Gm-Gg: AY/fxX58n6ZpHAa6uzSy6M8usycXslY707M6YxkkfIZVfKNNWWwruCHMAfJwx5sUwYP
	N/pDOzQwGXOQms16jfPYfvVAMGinqI1I6L9oUW1bExYgj8G3kBTfSxHnrlcJV2pmsKGwy91IT/L
	Xbqf3wJZxmn7fh2MEFfwbM49yDgNZTe9ApKBkVsVW60bQ/VAqC8xNwNgcEvrHUa5BPJQM8681N9
	kxTQusKuJwEa7r5gY5l7CXK/8/NUa9p7iHTa27sZdyvbot0TJf6k7HOgcT/fU/31M3Bel8UTiwS
	F4C2BE9yoElXT5yK1t9OvrJhL/7POzv2GMwoYbcFkraTfcZmPvVZZivk+gdScO28j5itl/Dj/VJ
	DceEQn1lLrkjh+M+C+HmBF5gTx14aixObj667i5K5pw==
X-Google-Smtp-Source: AGHT+IHXjysvU040YFqXFjQ9lictL0w/Wiouu+uAIOKK3LSVq7ies8MkHYN1VQATthOXjraDEMCDPEeJjZXq
X-Received: by 2002:a05:6830:2685:b0:7c9:594f:2d1d with SMTP id 46e09a7af769-7cae8362350mr8864025a34.3.1765949713977;
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7cadb33121dsm2862394a34.8.2025.12.16.21.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 089EA342237;
	Tue, 16 Dec 2025 22:35:13 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 06676E41A08; Tue, 16 Dec 2025 22:35:13 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 14/20] selftests: ublk: add utility to get block device metadata size
Date: Tue, 16 Dec 2025 22:34:48 -0700
Message-ID: <20251217053455.281509-15-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
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
 tools/testing/selftests/ublk/Makefile        |  4 +--
 tools/testing/selftests/ublk/metadata_size.c | 36 ++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/metadata_size.c

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 837977b62417..0f6abb95c87a 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -46,14 +46,14 @@ TEST_PROGS += test_stress_03.sh
 TEST_PROGS += test_stress_04.sh
 TEST_PROGS += test_stress_05.sh
 TEST_PROGS += test_stress_06.sh
 TEST_PROGS += test_stress_07.sh
 
-TEST_GEN_PROGS_EXTENDED = kublk
+TEST_GEN_PROGS_EXTENDED = kublk metadata_size
 
 include ../lib.mk
 
-$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c \
+$(OUTPUT)/kublk: kublk.c null.c file_backed.c common.c stripe.c \
 	fault_inject.c
 
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

