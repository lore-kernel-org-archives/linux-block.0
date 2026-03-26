Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5B41C312
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546618; cv=none; b=TWOEIeSAeJ4OFAA9bxo3ox8hGwgGUHEL0ETboEuE0Eq9UttHykWWllCrbCFHwx9HXfIU6Eenhn6jNA2oTtztsXkdbFtOpGSJ4D/kt6Tu4zxtrfJKUzESo02siGmgDJiWK+5HWEDKrxQR7cCHIKIJ2nCRJute1O1SKPsC5VJDztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546618; c=relaxed/simple;
	bh=2QPS7ytt0Poxd7DJjflqezHOUkio892XLMjmgL0zeB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LH5aQdGCmwuE+7tsE8hRhh636ICukZd9qocOujXx/MVX8KGitQsUZNcZ7ENWhzEXtsbynVzGSjefrnDHVoAFh6HOHuMWj8jkl4ZbjMDkot0IW52MCaQLLv/jZvNTkc2r9KnZEMOepnMZwDyGCV6X4dvVGgtAbKybzqFqWx0hNrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SXuOZBvZ; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SXuOZBvZ"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fhWDN4d8gz1XMFjb;
	Thu, 26 Mar 2026 17:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1774546603; x=1777138604; bh=ktIR/4jbcQBOz9DGyDEUUh41eCwEM/8obr3
	Fmwul3P0=; b=SXuOZBvZLliCJLYhrTlphsGazfATKNoPflk7fA4e4pBNK40uaOM
	q6PCDZIWExlSwiCXWs6u9mq6KfOL9K55+IZuvjlzfyYD+v5ZKzWfWY/7erzujaPz
	iZi5eAUEtE/2487T8m+TOR2MHqhQWUZ6b5EcptuuwjXg7VN3xK2KvPRfEATOkGzM
	WVwffEi9WGp332mbU66EcGYFKqXBRmNUJdxXiz8O2FB70q8vdOBKJPR8MsWX1F+x
	mfZHM3DGtW8xNAEYXP5rFnLzh2KYdLrZDiOGV5J1a7onjewYX4KuBTvTGbTAlpzA
	cuObUiDFVOAEcybJf5GkeQTUsbF3VpzDpLA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id A3oZ-4qO-S18; Thu, 26 Mar 2026 17:36:43 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fhWDB5Jk9z1XM0nj;
	Thu, 26 Mar 2026 17:36:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH blktests] src/dio-offsets.c: Fix err() usage
Date: Thu, 26 Mar 2026 10:36:32 -0700
Message-ID: <20260326173632.3259254-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the dio-offsets program detects data corruption, it reports the
following message:

dio-offsets: test_unaligned_vectors: data corruption: Success

The "Success" part in this message is confusing and is reported because
the err() macro is used incorrectly. errno must be set before err() is
used instead of passing an error number as first argument. Fix usage of
the err() macro as follows:
- Change the first argument into EXIT_FAILURE (1). According to POSIX,
  exit codes 1 - 125 mean failure and > 128 means that a program was
  terminated by a signal. Hence, exit with code 1 instead of -1 if
  ioctl() fails.
- Use the err_errno() macro to set the error code instead of passing an
  error code as first argument to err().

Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 src/dio-offsets.c | 99 +++++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 43 deletions(-)

diff --git a/src/dio-offsets.c b/src/dio-offsets.c
index 4d9c71c83798..9fc7b9247b99 100644
--- a/src/dio-offsets.c
+++ b/src/dio-offsets.c
@@ -26,6 +26,11 @@
 #include <sys/mount.h>
=20
 #define power_of_2(x) ((x) && !((x) & ((x) - 1)))
+#define err_errno(exit_code, ...)		\
+	do {					\
+		errno =3D (exit_code);		\
+		err(EXIT_FAILURE, __VA_ARGS__); \
+	} while (0)
=20
 static unsigned long logical_block_size;
 static unsigned long dma_alignment;
@@ -42,7 +47,7 @@ static void init_args(char **argv)
 {
 	test_fd =3D open(argv[1], O_RDWR | O_TRUNC | O_DIRECT);
 	if (test_fd < 0)
-		err(errno, "%s: failed to open %s", __func__, argv[1]);
+		err(EXIT_FAILURE, "%s: failed to open %s", __func__, argv[1]);
=20
 	max_segments =3D strtoul(argv[2], NULL, 0);
 	max_bytes =3D strtoul(argv[3], NULL, 0) * 1024;
@@ -54,18 +59,18 @@ static void init_args(char **argv)
 	    !power_of_2(dma_alignment) ||
 	    !power_of_2(logical_block_size)) {
 		errno =3D EINVAL;
-		err(1, "%s: bad parameters", __func__);
+		err(EXIT_FAILURE, "%s: bad parameters", __func__);
 	}
=20
 	if (virt_boundary > 1 && virt_boundary < logical_block_size) {
 		errno =3D EINVAL;
-		err(1, "%s: virt_boundary:%lu logical_block_size:%lu", __func__,
+		err(EXIT_FAILURE, "%s: virt_boundary:%lu logical_block_size:%lu", __fu=
nc__,
 			virt_boundary, logical_block_size);
 	}
=20
 	if (dma_alignment > logical_block_size) {
 		errno =3D EINVAL;
-		err(1, "%s: dma_alignment:%lu logical_block_size:%lu", __func__,
+		err(EXIT_FAILURE, "%s: dma_alignment:%lu logical_block_size:%lu", __fu=
nc__,
 			dma_alignment, logical_block_size);
 	}
=20
@@ -87,7 +92,7 @@ static void init_buffers()
=20
 	buf_size =3D max_bytes * max_segments / 2;
 	if (buf_size < logical_block_size * max_segments)
-		err(EINVAL, "%s: logical block size is too big", __func__);
+		err_errno(EINVAL, "%s: logical block size is too big", __func__);
=20
 	if (buf_size < logical_block_size * 1024 * 4)
 		buf_size =3D logical_block_size * 1024 * 4;
@@ -97,26 +102,27 @@ static void init_buffers()
=20
 	ret =3D ioctl(test_fd, BLKGETSIZE64, &dev_bytes);
 	if (ret < 0)
-		err(ret, "%s: ioctl BLKGETSIZE64 failed", __func__);
+		err(EXIT_FAILURE, "%s: ioctl BLKGETSIZE64 failed", __func__);
=20
 	if (dev_bytes < buf_size)
 		buf_size =3D dev_bytes;
=20
 	ret =3D posix_memalign((void **)&in_buf, pagesize, buf_size);
 	if (ret)
-		err(EINVAL, "%s: failed to allocate in-buf", __func__);
+		err_errno(EINVAL, "%s: failed to allocate in-buf", __func__);
=20
 	ret =3D posix_memalign((void **)&out_buf, pagesize, buf_size);
 	if (ret)
-		err(EINVAL, "%s: failed to allocate out-buf", __func__);
+		err_errno(EINVAL, "%s: failed to allocate out-buf", __func__);
=20
 	fd =3D open("/dev/urandom", O_RDONLY);
 	if (fd < 0)
-		err(EINVAL, "%s: failed to open urandom", __func__);
+		err_errno(EINVAL, "%s: failed to open urandom", __func__);
=20
 	ret =3D read(fd, out_buf, buf_size);
 	if (ret < 0)
-		err(EINVAL, "%s: failed to randomize output buffer", __func__);
+		err_errno(EINVAL, "%s: failed to randomize output buffer",
+			  __func__);
=20
 	close(fd);
 }
@@ -143,11 +149,11 @@ static void test_full_size_aligned()
 	memset(in_buf, 0, buf_size);
 	ret =3D pwrite(test_fd, out_buf, buf_size, 0);
 	if (ret < 0)
-		err(errno, "%s: failed to write buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to write buf", __func__);
=20
 	ret =3D pread(test_fd, in_buf, buf_size, 0);
 	if (ret < 0)
-		err(errno, "%s: failed to read buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to read buf", __func__);
=20
 	compare(out_buf, in_buf, buf_size);
 }
@@ -164,11 +170,11 @@ static void test_dma_aligned()
 	memset(in_buf, 0, buf_size);
 	ret =3D pwrite(test_fd, out_buf + dma_alignment, max_bytes, 0);
 	if (ret < 0)
-		err(errno, "%s: failed to write buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to write buf", __func__);
=20
 	ret =3D pread(test_fd, in_buf + dma_alignment, max_bytes, 0);
 	if (ret < 0)
-		err(errno, "%s: failed to read buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to read buf", __func__);
=20
 	compare(out_buf + dma_alignment, in_buf + dma_alignment, max_bytes);
 }
@@ -194,7 +200,7 @@ static void test_page_aligned_vectors()
=20
 	ret =3D pwritev(test_fd, iov, vecs, 0);
 	if (ret < 0)
-		err(errno, "%s: failed to write buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to write buf", __func__);
=20
 	for (i =3D 0; i < vecs; i++) {
 		offset =3D logical_block_size * i * 4;
@@ -204,7 +210,7 @@ static void test_page_aligned_vectors()
=20
 	ret =3D preadv(test_fd, iov, vecs, 0);
 	if (ret < 0)
-		err(errno, "%s: failed to read buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to read buf", __func__);
=20
 	for (i =3D 0; i < vecs; i++) {
 		offset =3D logical_block_size * i * 4;
@@ -234,7 +240,7 @@ static void test_dma_aligned_vectors()
=20
 	ret =3D pwritev(test_fd, iov, vecs, 0);
 	if (ret < 0)
-		err(errno, "%s: failed to write buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to write buf", __func__);
=20
 	for (i =3D 0; i < vecs; i++) {
 		offset =3D logical_block_size * i * 8 + dma_alignment * (i + 1);
@@ -244,7 +250,7 @@ static void test_dma_aligned_vectors()
=20
 	ret =3D preadv(test_fd, iov, vecs, 0);
 	if (ret < 0)
-		err(errno, "%s: failed to read buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to read buf", __func__);
=20
 	for (i =3D 0; i < vecs; i++) {
 		offset =3D logical_block_size * i * 8 + dma_alignment * (i + 1);
@@ -295,7 +301,7 @@ static void test_unaligned_page_vectors()
 	if (ret < 0) {
 		if (should_fail)
 			return;
-		err(errno, "%s: failed to write buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to write buf", __func__);
 	}
=20
 	i =3D 0;
@@ -318,7 +324,7 @@ static void test_unaligned_page_vectors()
=20
 	ret =3D preadv(test_fd, iov, vecs, 0);
 	if (ret < 0)
-		err(errno, "%s: failed to read buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to read buf", __func__);
=20
 	i =3D 0;
 	offset =3D pagesize - (logical_block_size / 4);
@@ -367,7 +373,7 @@ static void test_unaligned_vectors()
=20
 	ret =3D preadv(test_fd, iov, vecs, 0);
 	if (ret < 0)
-		err(errno, "%s: failed to read buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to read buf", __func__);
=20
 	for (i =3D 0; i < vecs; i++) {
 		offset =3D logical_block_size * i * 8;
@@ -400,8 +406,9 @@ static void test_invalid_starting_addr()
 	if (ret < 0)
 		return;
=20
-	err(ENOTSUP, "%s: write buf unexpectedly succeeded with NULL address re=
t:%d",
-		__func__, ret);
+	err_errno(ENOTSUP,
+		  "%s: write buf unexpectedly succeeded with NULL address ret:%d",
+		  __func__, ret);
 }
=20
 /*
@@ -436,8 +443,9 @@ static void test_invalid_middle_addr()
 	if (ret < 0)
 		return;
=20
-	err(ENOTSUP, "%s: write buf unexpectedly succeeded with NULL address re=
t:%d",
-		__func__, ret);
+	err_errno(ENOTSUP,
+		  "%s: write buf unexpectedly succeeded with NULL address ret:%d",
+		  __func__, ret);
 }
=20
 /*
@@ -458,16 +466,17 @@ static void test_invalid_dma_alignment()
 	if (ret < 0) {
 		if (should_fail)
 			return;
-		err(errno, "%s: failed to write buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to write buf", __func__);
 	}
=20
 	if (should_fail)
-		err(ENOTSUP, "%s: write buf unexpectedly succeeded with invalid DMA of=
fset address, ret:%d",
-			__func__, ret);
+		err_errno(ENOTSUP,
+			  "%s: write buf unexpectedly succeeded with invalid DMA offset addre=
ss, ret:%d",
+			  __func__, ret);
=20
 	ret =3D pread(test_fd, in_buf + offset, size, 0);
 	if (ret < 0)
-		err(errno, "%s: failed to read buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to read buf", __func__);
=20
 	compare(out_buf + offset, in_buf + offset, size);
 }
@@ -506,11 +515,12 @@ static void test_invalid_dma_vector_alignment()
 	if (ret < 0) {
 		if (should_fail)
 			return;
-		err(errno, "%s: failed to write buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to write buf", __func__);
 	}
 	if (should_fail)
-		err(ENOTSUP, "%s: write buf unexpectedly succeeded with invalid DMA of=
fset address ret:%d",
-			__func__, ret);
+		err_errno(ENOTSUP,
+			  "%s: write buf unexpectedly succeeded with invalid DMA offset addre=
ss ret:%d",
+			  __func__, ret);
=20
 	iov[0].iov_base =3D in_buf;
 	iov[0].iov_len =3D max_bytes;
@@ -529,7 +539,7 @@ static void test_invalid_dma_vector_alignment()
=20
 	ret =3D preadv(test_fd, iov, vecs, 0);
 	if (ret < 0)
-		err(errno, "%s: failed to read buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to read buf", __func__);
=20
 	compare(out_buf, in_buf, max_bytes);
 	compare(out_buf + max_bytes * 2, in_buf + max_bytes * 2, max_bytes);
@@ -568,12 +578,13 @@ static void test_max_vector_limits()
 	if (ret < 0) {
 		if (should_fail)
 			return;
-		err(errno, "%s: failed to write buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to write buf", __func__);
 	}
=20
 	if (should_fail)
-		err(ENOTSUP, "%s: write buf unexpectedly succeeded with excess vectors=
 ret:%d",
-			__func__, ret);
+		err_errno(ENOTSUP,
+			  "%s: write buf unexpectedly succeeded with excess vectors ret:%d",
+			  __func__, ret);
=20
 	for (i =3D 0; i < vecs; i++) {
 		offset =3D i * iov_size * 2;
@@ -583,7 +594,7 @@ static void test_max_vector_limits()
=20
 	ret =3D preadv(test_fd, iov, vecs, 0);
 	if (ret < 0)
-		err(errno, "%s: failed to read buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to read buf", __func__);
=20
 	for (i =3D 0; i < vecs; i++) {
 		offset =3D i * iov_size * 2;
@@ -622,8 +633,9 @@ static void test_invalid_dma_vector_alignment_large()
 	if (ret < 0)
 		return;
=20
-	err(ENOTSUP, "%s: write buf unexpectedly succeeded with NULL address re=
t:%d",
-		__func__, ret);
+	err_errno(ENOTSUP,
+		  "%s: write buf unexpectedly succeeded with NULL address ret:%d",
+		  __func__, ret);
 }
=20
 /*
@@ -656,12 +668,13 @@ static void test_invalid_dma_vector_length()
 	if (ret < 0) {
 		if (should_fail)
 			return;
-		err(errno, "%s: failed to write buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to write buf", __func__);
 	}
=20
 	if (should_fail)
-		err(ENOTSUP, "%s: write buf unexpectedly succeeded with invalid DMA of=
fset address ret:%d",
-			__func__, ret);
+		err_errno(ENOTSUP,
+			  "%s: write buf unexpectedly succeeded with invalid DMA offset addre=
ss ret:%d",
+			  __func__, ret);
=20
 	iov[0].iov_base =3D in_buf;
 	iov[0].iov_len =3D max_bytes * 2 - max_bytes / 2;
@@ -677,7 +690,7 @@ static void test_invalid_dma_vector_length()
=20
 	ret =3D pwritev(test_fd, iov, vecs, 0);
 	if (ret < 0)
-		err(errno, "%s: failed to read buf", __func__);
+		err(EXIT_FAILURE, "%s: failed to read buf", __func__);
=20
 	compare(out_buf, in_buf, iov[0].iov_len);
 	compare(out_buf + max_bytes * 4, in_buf + max_bytes * 4, iov[1].iov_len=
);
