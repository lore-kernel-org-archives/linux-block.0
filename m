Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FCB2FF672
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009435; cv=none; b=E8ZaWvl0OFj5QH/W9aJ50iH00tL2l+pZvvmQb1s+D76kRETesi6PlV14MYWEnGy97sHb4BxgJM41ObTjAnK2Xk4Vjleit4pweUHK0e+OWYgLxbt7MgkyNOvy/7mLqAI7Dxf6B0OsFUChgXA7GX5r5HON8VWrrsMeJydvOwle0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009435; c=relaxed/simple;
	bh=aaLnTxu0+z8HNRtZyPcYH9O0R1Nu/2dAETf6TdPfxhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZG4yiVtI1PFf/pW+q8FmPEluqCI+e1NWEhzWXxVv2D3kLQF51mnumJLroL3nebnQIv6eckK5BfPIud8deOd8ZyrvicQQSWoxuIG5KrxVCyMvp7UuLN4xZYCyvT9ubj/gqc9/qcGQdkrk+Nh5W8V51qFx+OQJelH1zp3ZHJUj8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jGZaR2XI; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jGZaR2XI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786009433; x=1817545433;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aaLnTxu0+z8HNRtZyPcYH9O0R1Nu/2dAETf6TdPfxhI=;
  b=jGZaR2XItl9w0FErdj+3W+laFDEn1CnCSEAuYBJ6rnfp16MV3TUsI7YA
   zSQ0ZohoLMxLadxgHfZ4qMSJIJuaxIpNXKZZ8dN75rkz5ugaNW9RdLW+A
   AGb+HcJ8fGYm8XlQz7h5j9OWd3yRuifWeZk2NXBIzzCI3uBl1/Hnb8WnP
   zJdJnRADRg/LwotC3wI7j1FuTNDv9RyRSM5p0OsXVQuwSsGu3AcJFX/tr
   qJXRWuzXIG+SE45DWTQHouLSBgl2AE5yoVruOOh3l3FMsGGiTL4lKlqDd
   Nyi26en1whCxlzznKbTGJ0NNdTMbJ8ib8d0sO/g9/BmVr38wdb4O+dRci
   Q==;
X-CSE-ConnectionGUID: cBlVltvTQ8GefLlLSkjndQ==
X-CSE-MsgGUID: PUZrk7JVRK+wSimmWqiGmw==
X-IronPort-AV: E=Sophos;i="6.25,208,1779120000"; 
   d="scan'208";a="151632683"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2026 17:42:44 +0800
X-CSE-ConnectionGUID: ltaUo+34Sz6voeSA3saKhg==
X-CSE-MsgGUID: 7M6GD+RFSu6exDs/Q3k+GA==
IronPort-SDR: 6a7456fc_GepbR8/a5sXUTC5DVKjVCLAwaLMNfo/LFxphSTGs1v6cM8s
 acEbg1whmLsMBWyboEdrLaHNtwA8RFMcCDO0v2g==
Received: from uls-op-esai3-o.wdc.com ([10.248.3.41])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2026 02:42:20 -0700
X-CSE-ConnectionGUID: IAKP7sJ+QP+5BrtWt885WA==
X-CSE-MsgGUID: eIcOpr8NTjyxQ4o21Tpo0Q==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai3-o.wdc.com with ESMTP; 06 Aug 2026 02:42:19 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	0wnerD1ed <l7z@0b1t.tech>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] block/045: respect dma_alignment
Date: Thu,  6 Aug 2026 18:42:18 +0900
Message-ID: <20260806094218.2077413-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the kernel commit 14b007e17881 ("block: validate user space
vectors during extraction"), the test case block/045 fails with the
error message below:

 block/045 (test direct I/O full-trim bvec alignment)         [failed]
     runtime  0.550s  ...  0.630s
     --- tests/block/045.out     2026-08-03 19:26:40.407053612 +0900
     +++ /home/shin/Blktests/blktests/results/nodev/block/045.out.bad    2026-08-05 20:48:33.366932845 +0900
     @@ -1,2 +1,4 @@
      Running block/045
     +bio-full-trim: pread returned -1 (errno 22)
     +bio-full-trim helper failed
      Test complete

The errno 22 means EINVAL. The commit introduced the dma_alignment check
and returns EINVAL when the check is not fulfilled. The test case calls
pread() with one byte offset. This offset is not aligned to the
dma_alignment, then EINVAL is returned.

To avoid the failure, respect the dma_alignment check. Get the
dma_alignment value and pass it to bio-full-trim command. Use the
alignment to decide the offset value.

Link: https://lore.kernel.org/linux-block/anMscoGkR5BYjSGy@shinmob/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
I confirmed that block/045 can detect the KASAN stack-out-of-bounds
that was caused by the v1 kernel patch titled "block: fix aligning of
bounced dio read bios" [*], regardless of whether this blktests patch
is applied or not.

[*] https://lore.kernel.org/linux-block/20260713152912.2333321-1-hch@lst.de/

 src/bio-full-trim.c | 27 +++++++++++++++++++++++++--
 tests/block/045     |  3 ++-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/src/bio-full-trim.c b/src/bio-full-trim.c
index e304b2c..a3dda4c 100644
--- a/src/bio-full-trim.c
+++ b/src/bio-full-trim.c
@@ -12,26 +12,49 @@
 #include <sys/mman.h>
 #include <unistd.h>
 
+static int msb(unsigned int v)
+{
+	unsigned int b = 0;
+
+	while (v >>= 1)
+		b++;
+
+	return b;
+}
+
 int main(int argc, char **argv)
 {
 	unsigned int block_size;
 	unsigned char *p;
 	long page_size;
+	unsigned int dma_alignment;
+	unsigned int dma_aligned_offset;
 	ssize_t ret;
 	int fd;
 
-	if (argc != 2)
+	if (argc != 3)
 		return EXIT_FAILURE;
+
 	page_size = sysconf(_SC_PAGESIZE);
 	if (page_size <= 0)
 		errx(EXIT_FAILURE, "invalid page size");
 
+	dma_alignment = atoi(argv[2]);
+	if (dma_alignment == 0)
+		errx(EXIT_FAILURE, "unexpected dma_alignment");
+
 	fd = open(argv[1], O_RDONLY | O_DIRECT);
 	if (fd < 0)
 		err(EXIT_FAILURE, "open %s", argv[1]);
 	if (ioctl(fd, BLKSSZGET, &block_size))
 		err(EXIT_FAILURE, "BLKSSZGET");
 
+	dma_aligned_offset = 1 << (msb(dma_alignment) + 1);
+	if (dma_aligned_offset >= block_size)
+		errx(EXIT_FAILURE,
+		     "unexpected dma_alignment %u for block size %u",
+		     dma_alignment, block_size);
+
 	p = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
 		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if (p == MAP_FAILED)
@@ -40,7 +63,7 @@ int main(int argc, char **argv)
 		err(EXIT_FAILURE, "mprotect");
 
 	errno = 0;
-	ret = pread(fd, p + page_size - 1, block_size, 0);
+	ret = pread(fd, p + page_size - dma_aligned_offset, block_size, 0);
 	if (ret == -1 && errno == EFAULT)
 		return EXIT_SUCCESS;
 	errx(EXIT_FAILURE, "pread returned %zd (errno %d)", ret, errno);
diff --git a/tests/block/045 b/tests/block/045
index 65bfcb9..6e112b6 100755
--- a/tests/block/045
+++ b/tests/block/045
@@ -25,7 +25,8 @@ test() {
 		return 1
 	fi
 
-	if ! src/bio-full-trim /dev/nullb1; then
+	if ! src/bio-full-trim /dev/nullb1 \
+	     $(< /sys/block/nullb1/queue/dma_alignment); then
 		echo "bio-full-trim helper failed"
 	fi
 
-- 
2.54.0

