Received: from mail-oi2-f41.google.com (mail-oi2-f41.google.com [74.125.231.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB291448E0
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610954; cv=none; b=jW6gxPzm2+ARn+KMeP69SxVlb1x3OEcZ/l2/HlaRNFalzFATcv8eM631FheOebM0skGV7QCRqR/LaffmnYZeMlWI9noIs6Ag0IEPq1ZR/EUC0ze08Xqvda9ocQgEK9tUOYFlhhJ/WNek52VLWovehP7YHvbWORdXqggcVpEb9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610954; c=relaxed/simple;
	bh=ChhbQmfcR4p8J3/gFvJzvhucipNfIhOl3pNXWmuGJus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdVVIE+WVDsAfj7hB7jWQ0EmVe770vt4ej5pOzUBpNHQfdH5S2PiuOqbi0EqElugbFMaBIONsskgKo5Dev1s2WwQcu/8II0N1/aHiDVyyQahsHxUZF28rJVvbsyI8eBradIKmEyA7h3xFikK3lF6PmWafbkjHfvCmEQJZK5WYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RV6tp/23; arc=none smtp.client-ip=74.125.231.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RV6tp/23"
Received: by mail-oi2-f41.google.com with SMTP id 46e09a7af769-805cc8b4231so213524a34.2
        for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 19:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789610952; x=1790215752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0T1IvfBw3ebyjaZWVZBcsx1XWMSh/Mzfc7wKk0DGKM=;
        b=RV6tp/23c68W1aY+/xF8tDc9i2mbpfVqHXSkvDrKakus5fUSKSMUgXCHKMvu03C830
         KwBKGQtQF4nuvv3oIwcMoxagZYHAgLCw/D4oQYyJbiYSyeLKFTO7aum7o2rPr2i9x9+S
         jh/OTyA90ZMeQuB4u+dBjJvEFSOkd6ZXiZHrIlZe2XWn1i3rK2PmAgXguzxebjBzqHib
         thgDYYC+8zEIPZgxjzYAIls3bCsL2P9YpiGNDFBCO5335YCr8VGB2voSPV+YgQOzu25v
         0CnzmEGH9wSRyTbUdL5tbTfNIKrYAalWszk4kz0W3d2pGBJcrqv9e7Vl5PiaJ7tvZ+ff
         20tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789610952; x=1790215752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f0T1IvfBw3ebyjaZWVZBcsx1XWMSh/Mzfc7wKk0DGKM=;
        b=iGAUdGW681u0p6rQIayoL+BHQs9iBAFvZvBcVdyGVNYUOAEXdkkhDTPlNLOMdIx94e
         j0WYNSlERFZRrvBQ7zW91Wcgf7f9626i3VyeULcmWZvyKzieM2bekSDs+7gcRqnnCC7G
         K97oSBcC1Uxm8B7SJ/zqgROEtSsjM5evpZv91lkpIvKTPP8MnbrML592s3dK/y2SU/A3
         229GDuu8y8sOZkGuR+6dU95TfO0ETjRW5N7NSPXRy1SIQj28hM2CfTudrVlY8TtYFZX/
         MSy+wceeaJZqNclDOheiI+62J9wyLDK7sVcfqgT3xGl/voz4VxlGM24o6pU7pbTH4ffX
         7Ziw==
X-Gm-Message-State: AFuF++kM/QVWdQ2qQx/4yhIKz3545c/2OVNZm8AjB0X93NmOfb8HJRKp
	Mic/zANnVcnd03rGwLDhiPoYW3uACkW4n3T3uK3rkuws0xmOXd7dap1hNqu3Prs3Wp1+u4Vr00P
	YPBmhfY5gA3So/2OBsDac7n7s2vTEONSjNmDDyHu1P6qtRdwWmT6AhO0jzkWKIxzShK+64oRCzJ
	tnj+C4EWPcpU9I26IxK2i0bKekL7WT1pDMSAAmb9mcfePEmcyuorOW2ucNXw==
X-Gm-Gg: AYBFou0iaZfsJ+wCV2xwuNGfLBRxY0YgCIkeIP02wNQ8Q39wFjZx0mOr2DsLnSSEt3c
	fs3HF3DU535FdZl6fVfYVwOcnU/wX6R8Hxj0J0sKik37YOF5qdjgY1GB00Bo1lqFAqr98qQjiNb
	KABe5HByY/8ZaZ8aQNVLPPUiKtVUT7Js+61nsfrRhNA9/TtSlZWZi5ynUIy/k00CmyK+JcNZ91c
	3MFby59gGoM3FZ+NF0CxjskpmxJK9gtq5CgMgj8M+QnCwr//yYBqDLqygL9WLvungXJBejzd9vg
	xG5uiUWvs3sAdI5TIVFPVj4PAkcwx8Li7jNnywY5e8r6pDAi9fIFBWkhcx+cf9jE02/gnscAmHG
	NrdDJ3T/zCyf16PjmVIi/Ou9nCX9ZtyMilt+W20nvVdMaPPzTSXDkBCrRLKpvIqBB68SoEKACLH
	q2bhYwd/aihMywkbJVycxTjZzLd0Mrma76QWL1ma8bkFJ5CoUx0lRn2b2XO1Tt6ghQepfeMDRaF
	THak5GiDts8WLvfxGaFlTLDiRrdaXytLDKk7CM=
X-Received: by 2002:a05:6808:1912:b0:4b9:e5fa:8905 with SMTP id 5614622812f47-4ca4b73867bmr5112939b6e.24.1789610951636;
        Wed, 16 Sep 2026 19:09:11 -0700 (PDT)
Received: from dev-mkhalfella.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-80c46cb6675sm1862569a34.16.2026.09.16.19.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 19:09:11 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Jesse Taube <jtaubepe@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH blktests 4/5] src/nvme-ghost-write-detector: add an ABA ghost write detector
Date: Wed, 16 Sep 2026 20:06:24 -0600
Message-ID: <20260917020752.1672578-5-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917020752.1672578-1-mkhalfella@purestorage.com>
References: <20260917020752.1672578-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consider a write X that is issued to an LBA and times out without ever
being acknowledged. The initiator retries it on another path, where it
lands. A write Y to the same LBA follows and lands as well. The original
X is still in flight somewhere in the fabric, and when it finally
reaches the device it overwrites Y. A read now returns X, a write the
initiator gave up on long ago.

Add a program to catch this. It opens the device O_DIRECT and, on each
iteration, issues a series of writes of distinct byte patterns to the
same LBA, the 4k block at offset 0, waits, then reads that block back
and checks every byte holds the pattern written last. Because the
patterns differ, the value that comes back identifies which write
reappeared.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 src/.gitignore                  |  1 +
 src/Makefile                    |  1 +
 src/nvme-ghost-write-detector.c | 86 +++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 src/nvme-ghost-write-detector.c

diff --git a/src/.gitignore b/src/.gitignore
index e9869e1..9673be8 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -15,6 +15,7 @@
 /zbdioctl
 /miniublk
 /nvme-passthrough-meta
+/nvme-ghost-write-detector
 /ioctl-lbmd-query
 /nvme-passthru-admin-uring
 /nvme-delay-ioctl
diff --git a/src/Makefile b/src/Makefile
index dd64694..92b4d0c 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -24,6 +24,7 @@ C_TARGETS := \
 	mount_clear_sock \
 	nvme-delay-ioctl \
 	nvme-passthrough-meta \
+	nvme-ghost-write-detector \
 	ioctl-lbmd-query \
 	nbdsetsize \
 	openclose \
diff --git a/src/nvme-ghost-write-detector.c b/src/nvme-ghost-write-detector.c
new file mode 100644
index 0000000..bd42dde
--- /dev/null
+++ b/src/nvme-ghost-write-detector.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2026 Mohamed Khalfella
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <malloc.h>
+#include <errno.h>
+#include <libgen.h>
+
+#define BUF_SIZE	4096
+#define ITERATIONS	10
+#define DELAY		3		/* seconds delay between iterations */
+#define WRITE_COUNT	10
+
+#define WRITE_OFFSET	0
+#define READ_OFFSET	WRITE_OFFSET
+
+int main(int argc, char **argv)
+{
+	int fd, i, w, off, ret;
+	char *buff;
+
+	fprintf(stdout, "starting %s test program\n", basename(argv[0]));
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s /dev/nvmeXnY", argv[0]);
+		return 1;
+	}
+
+	fd = open(argv[1], O_RDWR | O_DIRECT);
+	if (fd < 0) {
+		fprintf(stderr, "failed to open device, errno = %d\n", errno);
+		return 1;
+	}
+
+	ret = posix_memalign((void **)&buff, BUF_SIZE, BUF_SIZE);
+	if (ret) {
+		fprintf(stderr, "failed to allocate buffer, ret = %d\n", ret);
+		goto out;
+	}
+
+	for (i = 0; i < ITERATIONS; i++) {
+		fprintf(stdout, "iteration number %d, writing data\n", i);
+
+		for (w = 0; w < WRITE_COUNT; w++) {
+			memset(buff, w, BUF_SIZE);
+			ret = pwrite(fd, buff, BUF_SIZE, WRITE_OFFSET);
+			if (ret != BUF_SIZE) {
+				fprintf(stderr, "failed to write buff, "
+						"ret = %d, errno = %d\n",
+						ret, errno);
+				goto out;
+			}
+		}
+
+		sleep(5);
+		fprintf(stdout, "validating written data\n");
+
+		ret = pread(fd, buff, BUF_SIZE, READ_OFFSET);
+		if (ret != BUF_SIZE) {
+			fprintf(stderr, "failed to read buff, "
+					"ret = %d, errno = %d\n",
+					ret, errno);
+			goto out;
+		}
+
+		for (off = 0; off < BUF_SIZE; off++) {
+			if (buff[off] != WRITE_COUNT - 1) {
+				fprintf(stdout, "validation failed\n");
+				goto out;
+			}
+		}
+
+		fprintf(stdout, "successfully validated\n");
+		sleep(DELAY);
+	}
+
+out:
+	fprintf(stdout, "finished %s test program\n", basename(argv[0]));
+	close(fd);
+	return ret;
+}
-- 
2.55.0

