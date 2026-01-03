Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0A323BCE3
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401139; cv=none; b=GTzzZBqJWMwXSJDuV27pIiBzUd0lAGeDHxweCm4ER7BMKzKBv9I0CdfOTEXCVQRnaw6uJqcwzwgOMgbQ9OUgfo2uLWHwRTfTdqQWB1qNa41U/1FCuoD1l0gQZnutqIPO1mQ1MCpO2SmPKp6pW77bKY/O6uBkF0fjtZ+07gY7EiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401139; c=relaxed/simple;
	bh=W1ZlcN21O1nUErIL2QddLDLpe6HN6kZRnr32eNyAemQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMOme3MbTXCYrFJDwGkjXSlDhpMtR3yEBIyBZpKGA6XVdXlvk0GmI2C3T3VN8bb8YufhuiOMx20dmJahscbnMJ7XMhkHAbUSn1rSUQP8mqvwPFJ4r7EsZeuy2hsOQwJtaazx92ujobFh4SB4opjpChCc/OTozKLvmpMwbAEWLDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cYT1LIRV; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cYT1LIRV"
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a08ced9a36so28581315ad.2
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401135; x=1768005935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jcv9O2RJUqAVhSh3+8hkyCUs42mqp2c/jNxHfDkP5b8=;
        b=cYT1LIRVvZUZNIWxSZOmeVHC3acOrupFekPaCQrvcqdKHNZsDq3XVW0bGgZETBWz1E
         SUWe7JSF0O8xfOGlZ9ixQ8wMvXXpYjPVc3jsp3YqIhVuxQXyxWgub0G6nVmf7hDqo0Io
         /GSCOyT1rzKT60JY6u6wPvmXuqSCYYYft5xbKeowIQqlJVv4HY3dOW3psxBVG6GotGZe
         InGNsDXACSfUwSUN2OB/ynXVmJF3PsoeR5XKgeDeZRTlJz7+900TdtA19Sat+vF54Gw7
         b0r8sLmIHICIG3dtl8liqQzvtzwnFvuQfETT3KOUtfwkt5vdi7zd+F+Md6j8djIIQfVO
         t2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401135; x=1768005935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jcv9O2RJUqAVhSh3+8hkyCUs42mqp2c/jNxHfDkP5b8=;
        b=ehMr4ns1STjNie5hHJkHj5CmXVpzQE9WiNrRLtf295tOJul54utEYwYSOs3MOgRA2K
         BYv+OC0kMO2qmeLBh1j5wMf+0hkZ4+XVvqklLm0nOcuuJ1NGnnd4NK7xBEwbXMFXpsqi
         qmlHM08WSNHnTzZFx70G0NkUIy9Kktzu2UG0UFEap0EkaZWEf61X09RvT6IH9t7J15vw
         l7DhcKHkdklzdx3j1O45+bMH0hT0hG2/d5+6vT4MqmMvSRr1/UqYhjZYMMfxNgseYB4s
         NE4N95T9GB8cE4RBFJaOXzLMAyc2JARWIfYtUOQTi0lUwWv5icYYdkf+bZ+EPPNIMZnz
         SN0Q==
X-Gm-Message-State: AOJu0YzycUUOVnRza69ZiSaqXXRBdeBbC8QNC7uG6MBgPVqv0ISwxH4a
	Ieoqr5TwRAj2tFHCQoRUdroniYrp6xQQmlp5xSQIGYn+EQOtuyWB64Mn1X6eXF0a/oOyfoN+CKM
	DKyvHUeaTgUTDR/zWTy0u/4ZIag7zReIuuKv9d5sbj2WdceBMHI+C
X-Gm-Gg: AY/fxX4UWWwtZI+9EK/VGGZ1DbE6N6B8i7HeiJxV6DU9TqyJA4ebfed+wjcZrNQzbhN
	VGjVxPRFr1C3lZFJd8saffTqdXV6YYJlDsTS39Z1gmgRt3fcWVYX0JXhHTnCziI6XoRDFqqEsq2
	/q100GICJLKt3AcxiR3hMUstHBWfpyRHbaOEyJ8tLNrqEFHrZ3hcGNwuVbzdb/0OCzWd/X1bPal
	nYbKjOdNIsn07w3vHM2WbSWGOpu5L5NHOAgwiy+foFIIkqUnKepFc5WJ1MIFqbTw7i+4oHhazvu
	2KUJOUbFivfjEqA/aVUZY65kB5TlJDiRFCOO6RGneTV4ZzDHtt9O/Yx1RawNVs5VdZs5lNDowFU
	dnqKKOq/mmr/cDhLOUi1v0M4TqYQ=
X-Google-Smtp-Source: AGHT+IFVCSwIg44UNU7r0AMnF+xe20OgYVh3bcBfLnFf339bcxoBxZ5KSQRqFVbWIPZUso95dTnP5yojbSft
X-Received: by 2002:a17:902:e5d2:b0:266:914a:2e7a with SMTP id d9443c01a7336-2a2f29406ecmr330612725ad.6.1767401134795;
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a2f330c704sm46168885ad.0.2026.01.02.16.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 26171341C73;
	Fri,  2 Jan 2026 17:45:34 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 22707E43D1D; Fri,  2 Jan 2026 17:45:34 -0700 (MST)
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
Subject: [PATCH v2 13/19] selftests: ublk: add utility to get block device metadata size
Date: Fri,  2 Jan 2026 17:45:23 -0700
Message-ID: <20260103004529.1582405-14-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
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
index 06ba6fde098d..41f776bb86a6 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -47,14 +47,14 @@ TEST_PROGS += test_stress_03.sh
 TEST_PROGS += test_stress_04.sh
 TEST_PROGS += test_stress_05.sh
 TEST_PROGS += test_stress_06.sh
 TEST_PROGS += test_stress_07.sh
 
-TEST_GEN_PROGS_EXTENDED = kublk
+TEST_GEN_PROGS_EXTENDED = kublk metadata_size
 
 LOCAL_HDRS += $(wildcard *.h)
 include ../lib.mk
 
-$(TEST_GEN_PROGS_EXTENDED): $(wildcard *.c)
+$(OUTPUT)/kublk: common.c fault_inject.c file_backed.c kublk.c null.c stripe.c
 
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

