Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08FE34B662
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982794; cv=none; b=V5lHWUS8CIyMlWkgyIskHAW8rIfW33GHkigOcktGU7fgp35FkHuIDcbm7m2MDzfvEeJsN8Kcdk3vIEbhyPm7wv4Nhjt6TGZiSyTwH7VwfxmhPKKL95zrnesDB+0z1xR6X8GpO8mZngu32xLiHETdQeSTNKljoC6DqiSvStWacIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982794; c=relaxed/simple;
	bh=obaIzVk2GLEOOacy7EyU3XEneSjd7PF288qmX6xPgg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n94CQFVvWzGZWy5IYcLtoXETdO2ECTjQlA9Bab42HFD402vGvSLa9Winwfk+zxI/dAhsQaaMCZ3r9/N9dla+kdDbkNZwd2UhDYOkyc8nFdDvmtGd2fsfdXGz2mcxVieoiCh7FmQYseAbuvcxjQTNO3k7E/O95fhM8GYOmw/zNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=V2cGEHqI; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=UB8l0hdu; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="V2cGEHqI";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="UB8l0hdu"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689IfLTm901245
	for <linux-block@vger.kernel.org>; Wed, 9 Sep 2026 15:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=et2P
	GKftYmV6ASGOGFqxXp7WgymzRzFQcOeYvtolW0Y=; b=V2cGEHqIge6Dtp6oFLjI
	y7LkJDemg8jOgrsCEI1Q5h5Qw+Ao88SRleudCqeMP/sjRVPfPULoCNulU2JtVvTL
	PLjUOfPIlIQHUEV+ZaMlQKFlE707H5zsXtUmdRB1/8eQ6UT7VwabAaSzZZAu2Cvp
	F+sn/uDLiBBDjXu+cuaqTKz/36/OZaB/h/MQx9MGTEvrOh0zC2oOWN5ZJ5JA0D8b
	8SjqQgCVFMiTTzqdP+PTc9gcRJ0THN2YwnMhe7g/Q5O7v3OtDNCNP/QsphCv+YdL
	WgX+fAuUw/nXi7C0UTDXevhp/2vSNaTFmgPpQ1PdCN0S3wdOHosjNGZJP0unvMrO
	GQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gkcy08qt6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:39:50 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52fb6c7b680so81470811cf.1
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788982790; x=1789587590; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=et2PGKftYmV6ASGOGFqxXp7WgymzRzFQcOeYvtolW0Y=;
        b=UB8l0hdugJKRqoJuJ5YzmEr2J1LchN8voH8vQYAkN3PTccU514rABYgIoyy+NS5wiT
         gYgbJje42MWy8Qdo5ACnAuEC0RqN8t1c2+LwSfu/48p1qKb/YD6yKOoNuJZ+WOm3ngX6
         ugWbYp3toeBkOcSQtFVeUzz7vaklpU3S11+g7lJRP6S8baGnBWQw3fc/t/IUIdazcEKu
         fUv43ZmURAVgXWOTVCIJMYsLfTIaK+nQEDnAweS7+07vM+Of9JetwLO7ke3vJOLhwfpZ
         GbIb3/8u8iOf2Oa49F0Fm66mRXmvq4/yuLCX+PBv8yxGSsArxaY5tcMz+5BVvQyEL5sF
         VGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982790; x=1789587590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=et2PGKftYmV6ASGOGFqxXp7WgymzRzFQcOeYvtolW0Y=;
        b=nbhJ45ijnA11wNJsqKbFCbaTfIFv7zdyBz1iTa1/u121akkB2ut3ea8oq07uSbt0UX
         yrOlpszr5tpqNeQVdKlN7+yIx6666lrzmm4RgB+pQJ4VXkz0GZyc7QsThhzWTBPl7Z0h
         kCccGfG9AuTyhVD7GztyK++W3IE3XpjY+c4gxcpYQg0fBsmWRChWYCj0W/ToJ13tiAgO
         i3LcnwRnIWAz+3iUSx/byYUEC8KPdCAp3D68FvKDnRfGqPgMcyCHsskG/DiBUWE299BR
         xZBUGsx7Dt8rOXe68l6iZT+g7JWZj8OTr3M90RZtayGl+qFtsGtOUWy0VxqOPgnpQFoJ
         kVyg==
X-Forwarded-Encrypted: i=1; AKwUvByRoEy1ZCR+V9xvXRkLd/rXU1EfemTKU54z2VeXtzIUbWZLf+P4Vax1TndJC6uu3pGhlHTybwKiHIFSCA==@vger.kernel.org
X-Gm-Message-State: AFuF++mMGs8spiMHttKv0EE8/mCH/5eE8jAFwlp8HlKaSXaL/QRiZpJY
	cT3i8LbGiHpoiC1FmDFgR4hx3SPRVAdX4Y3Cedr/Pd5JK/qyeybvg82Hp5BTgAqTCU7GKcnUt7n
	Mz0vukm+GKgAbcS6mCU2x1oNHfzHz0qUxhFgp7qWuzMBDRurAHW5J2iTobloNz1W2Ybnr2KU=
X-Gm-Gg: AYBFou1+6t8XV5opb2UhSr8oAcDG7zGelhErafS+2ezrmH15BDIXyVzK844quwtfuMW
	XcCblrN4hGRNVxJjN/6JZWhgzbEJiLyB9TMbBm0XEJeixSF0xWTkVgAYPo563e/+HfgvB3KzmY9
	1ILuDGLpvJMBSpFG9iqSgKnyAb7ABoTOTR1FeNoLwdmwe557PfZZLlpc6QhCT14ZQWtwZKMkfGF
	57Ac1TKHxBGhF7TXUaawVpQWKI1UD+P82izhsXgH3qzlweBoKrPqxThOK/e7ijH8gcDPK2o4Pkc
	Z+9wayclF4mxaZCffy0C2khYaI2ZTy7wPlY8kIdhlj2ZkZ2QMZ5GdVzrENGvWEAL+iK1IWy3O5I
	lPWzG6dy+C3PR3XlEGpMpqGuCscgOb1YlpcHlV6O1Kz7nhpcG
X-Received: by 2002:ac8:5fc8:0:b0:52f:b58d:7d5b with SMTP id d75a77b69052e-530aeb4047cmr38823751cf.21.1788982789674;
        Wed, 09 Sep 2026 12:39:49 -0700 (PDT)
X-Received: by 2002:ac8:5fc8:0:b0:52f:b58d:7d5b with SMTP id d75a77b69052e-530aeb4047cmr38823141cf.21.1788982789113;
        Wed, 09 Sep 2026 12:39:49 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-193.net.columbia.edu. [128.59.176.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530868ceb68sm83026191cf.29.2026.09.09.12.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:39:48 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 09 Sep 2026 15:39:30 -0400
Subject: [PATCH blktests 3/3] block/051: add a pinned page leak test for
 trimmed direct writes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-blkdev-fixes-tests-v1-3-1f8af8665d16@columbia.edu>
References: <20260909-blkdev-fixes-tests-v1-0-1f8af8665d16@columbia.edu>
In-Reply-To: <20260909-blkdev-fixes-tests-v1-0-1f8af8665d16@columbia.edu>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788982781; l=9801;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=obaIzVk2GLEOOacy7EyU3XEneSjd7PF288qmX6xPgg4=;
 b=QUuHBIYKvImq5+Ve97OlyejDbi2UAgPCPfZMIAxR68JDmkkoWvqxcgTmIeaOs4M3TV/4e/Bg4
 UxpL6h1kUaKAkrpZY7rncfMzldu8gJ6fO5fTWrk3zy4YJY0TzA+tXYQ
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: UuWHaWWOAN3ff3A-APdXE3PXK3otLf-t
X-Authority-Analysis: v=2.4 cv=NrlE4MdJ c=1 sm=1 tr=0 ts=6aa1b606 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=fJxgZNdXt3opHMdyAp+FXA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=VwQbUJbxAAAA:8 a=ReHvhgLgI_wA6UgXX78A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIxOSBTYWx0ZWRfX+34YK172vy/u
 Hk1/WD8hlWbeUJXVRWsAjhBgLmNxwMQhqcqeGzOM6ZG9QC0a+bnJKyJbHyUybynsCEE3sTEglYt
 RC7XhUYyN2+8Yjzb9W3Gve3XeVCMVCry2ExmxUvlVlod7e5ev4B+
X-Proofpoint-GUID: UuWHaWWOAN3ff3A-APdXE3PXK3otLf-t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIxOSBTYWx0ZWRfX1hnOAFylqXlO
 lYbyR7KEiHFzTPuQm1cj7/o+1+S7wyEdLuspBrTZk8PcSmzu1uowN1QJYQU+/w+Ldf54xt8Iyka
 vBLXe9ufSxiF79RckRpRErjsmqTyrWQHnBLju38+/wUp5ZdFADCEEW1eYAaMZfQOdu2rsDeYxeA
 dzSe+DAG/eJubEEDmyxxH6F8Wlim0ZAYQFKU7hYFkq5dokKNehjXC1gxbOSa+VFVvvrnaTJpvsE
 456cwhPtHAJxnHAymPufdXrqtmjXRl/sF3IhY2kmQnbsiQj2Rg7Y5qM2S3GCpCuXbSPp8spbHD4
 A1LUTf2qWtglbfbDg3Tp29mjaHtNh1mM83y1VqW8A9MuQjgOQoCW8Jq4tS/outJhdOPQHWb44p/
 tH+DovV6qHs8YofFkxdC/4KJShx76gN0zXqOj+BCk0wsx/R+/L6MiZDgBBf/In5KqMWOTyTGUIb
 w3XYAdFTGGLWmRHvC8w==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11900
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=10 impostorscore=10 clxscore=1015 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090219

bio_iov_iter_align_down() trims a direct I/O bio down to the logical
block size and unpins the pages it drops. A bvec can span several pages
of one folio, each with its own pin, and dropping or shrinking such a
bvec has to release all of them. When it does not, the folio is never
freed.

This is a regression test for that issue, fixed in the kernel patch
"block: unpin all pages of a bvec in bio_iov_iter_align_down()" [1].

Issue O_DIRECT pwritev() from a hugetlb mapping to a memory-backed
null_blk device with a 64K logical block size, with a first segment that
ends half a block past a block boundary and an unreadable second
segment, so that the bio is trimmed by several pages of one huge page.
Place the first segment across two huge pages so the tail is its own
bvec and gets dropped, and inside one huge page so the tail is the end
of a larger bvec and gets shrunk, to cover both paths. Compare
HugePages_Free before and after, and fail if huge pages leaked.

The leak needs a logical block size above the page size, i.e.
CONFIG_TRANSPARENT_HUGEPAGE raising BLK_MAX_BLOCK_SIZE to 64K, and a
large folio backing the buffer, which hugetlb provides. Reserve huge
pages for the test and restore the previous count afterwards.

[1]: https://lore.kernel.org/linux-block/20260828-blkdev-fixes-v2-6-32f3f40cebed@columbia.edu/

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 src/.gitignore          |   1 +
 src/Makefile            |   1 +
 src/bio-trim-pin-leak.c | 191 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/051         |  64 ++++++++++++++++
 tests/block/051.out     |   2 +
 5 files changed, 259 insertions(+)

diff --git a/src/.gitignore b/src/.gitignore
index dbebc22..92c08d1 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -1,5 +1,6 @@
 /bio-bounce-read
 /bio-full-trim
+/bio-trim-pin-leak
 /dio-fallback-race
 /dio-offsets
 /discontiguous-io
diff --git a/src/Makefile b/src/Makefile
index 328f2c5..aba50f7 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -15,6 +15,7 @@ HAVE_C_DEF = $(shell if echo -e "$(H)include <$(1)>\n$(H)ifdef $(2)\nHAVE_$(2)\n
 C_TARGETS := \
 	bio-bounce-read \
 	bio-full-trim \
+	bio-trim-pin-leak \
 	dio-offsets \
 	loblksize \
 	loop_change_fd \
diff --git a/src/bio-trim-pin-leak.c b/src/bio-trim-pin-leak.c
new file mode 100644
index 0000000..54af181
--- /dev/null
+++ b/src/bio-trim-pin-leak.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-3.0+
+/*
+ * Copyright (C) 2026 Tal Zussman
+ *
+ * Check that a direct write trimmed to the logical block size unpins all the
+ * pages it drops.
+ *
+ * Issue O_DIRECT pwritev() from a hugetlb mapping with a two-segment iovec
+ * whose first segment ends half a block past a block boundary and whose
+ * second segment is an unreadable PROT_NONE mapping. The direct path pins the
+ * first segment, fails to pin the second and trims the bio down to a block
+ * boundary. The trimmed tail spans several pages of one huge page, each with
+ * its own pin. If the trim releases at most one of them, the huge page
+ * never returns to the pool, which shows up as a drop in HugePages_Free.
+ *
+ * The tail is either its own bvec, when the first segment straddles two huge
+ * pages, or the end of a larger one, when it sits inside a single huge page.
+ * Each iteration issues one write of each kind. The direct I/O fallback
+ * finishes the trimmed half block through the page cache, so each write
+ * returns one and a half blocks.
+ *
+ * The tail only holds several pins when it spans several pages of a large
+ * folio, so the device needs a logical block size of at least four pages and
+ * the buffer comes from a hugetlb mapping.
+ *
+ * usage: bio-trim-pin-leak <blockdev> <iterations>
+ *
+ * exit:  0 = no huge pages leaked
+ *        1 = setup error
+ *        2 = huge pages leaked
+ */
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/uio.h>
+#include <unistd.h>
+
+#include <linux/fs.h>
+
+#define EXIT_LEAKED	2
+
+static long meminfo(const char *key)
+{
+	char line[256];
+	long val = -1;
+	FILE *f;
+
+	f = fopen("/proc/meminfo", "r");
+	if (!f) {
+		perror("fopen");
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), f)) {
+		if (!strncmp(line, key, strlen(key))) {
+			val = strtol(line + strlen(key), NULL, 10);
+			break;
+		}
+	}
+
+	fclose(f);
+	return val;
+}
+
+int main(int argc, char **argv)
+{
+	struct iovec iov[2];
+	long pgsz, hpsz;
+	long before, after;
+	char *badseg;
+	char *map;
+	int lbs, iters;
+	int fd, i;
+
+	if (argc != 3) {
+		fprintf(stderr, "usage: %s <blockdev> <iterations>\n", argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	iters = atoi(argv[2]);
+
+	pgsz = sysconf(_SC_PAGESIZE);
+	if (pgsz < 0) {
+		perror("sysconf");
+		return EXIT_FAILURE;
+	}
+
+	hpsz = meminfo("Hugepagesize:") * 1024;
+	if (hpsz <= 0) {
+		fprintf(stderr, "no hugetlb page size in /proc/meminfo\n");
+		return EXIT_FAILURE;
+	}
+
+	fd = open(argv[1], O_RDWR | O_DIRECT);
+	if (fd < 0) {
+		perror("open");
+		return EXIT_FAILURE;
+	}
+
+	if (ioctl(fd, BLKSSZGET, &lbs)) {
+		perror("BLKSSZGET");
+		return EXIT_FAILURE;
+	}
+	printf("logical block size: %d, page size: %ld, huge page size: %ld\n",
+	       lbs, pgsz, hpsz);
+
+	/*
+	 * The trimmed tail is half a block, and it has to span at least two
+	 * pages for a pin to leak.
+	 */
+	if (lbs < 4 * pgsz) {
+		fprintf(stderr, "logical block size %d is below four pages\n",
+			lbs);
+		return EXIT_FAILURE;
+	}
+	if (hpsz < 2 * lbs) {
+		fprintf(stderr, "huge page size %ld is below two blocks\n", hpsz);
+		return EXIT_FAILURE;
+	}
+
+	badseg = mmap(NULL, lbs, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (badseg == MAP_FAILED) {
+		perror("mmap");
+		return EXIT_FAILURE;
+	}
+
+	before = meminfo("HugePages_Free:");
+	if (before < 2 * iters + 2) {
+		fprintf(stderr, "HugePages_Free is %ld, need at least %d\n",
+			before, 2 * iters + 2);
+		return EXIT_FAILURE;
+	}
+
+	for (i = 0; i < iters; i++) {
+		map = mmap(NULL, 2 * hpsz, PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+		if (map == MAP_FAILED) {
+			perror("mmap");
+			return EXIT_FAILURE;
+		}
+		memset(map, 'A', 2 * hpsz);
+
+		iov[0].iov_len = lbs + lbs / 2;
+		iov[1].iov_base = badseg;
+		iov[1].iov_len = lbs / 2;
+
+		/*
+		 * One block from the end of the first huge page and half a
+		 * block from the start of the second, then an unreadable
+		 * segment: the bio is trimmed by half a block, dropping the
+		 * bvec pinned from the second huge page.
+		 */
+		iov[0].iov_base = map + hpsz - lbs;
+		if (pwritev(fd, iov, 2, 0) != lbs + lbs / 2) {
+			perror("pwritev");
+			return EXIT_FAILURE;
+		}
+
+		/*
+		 * The same write from the start of the first huge page: the
+		 * pinned segment is a single bvec, and the trim shrinks it
+		 * by half a block instead of dropping one.
+		 */
+		iov[0].iov_base = map;
+		if (pwritev(fd, iov, 2, 0) != lbs + lbs / 2) {
+			perror("pwritev");
+			return EXIT_FAILURE;
+		}
+
+		if (munmap(map, 2 * hpsz)) {
+			perror("munmap");
+			return EXIT_FAILURE;
+		}
+	}
+
+	after = meminfo("HugePages_Free:");
+	printf("HugePages_Free: %ld -> %ld over %d iterations\n",
+	       before, after, iters);
+
+	if (after < before) {
+		printf("%ld huge pages leaked\n", before - after);
+		return EXIT_LEAKED;
+	}
+
+	printf("no huge pages leaked\n");
+	return EXIT_SUCCESS;
+}
diff --git a/tests/block/051 b/tests/block/051
new file mode 100755
index 0000000..a4edec2
--- /dev/null
+++ b/tests/block/051
@@ -0,0 +1,64 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Tal Zussman
+#
+# Issue partial O_DIRECT writes from a hugetlb mapping to a block device with
+# a 64K logical block size and check that no huge pages leak. The bio of such
+# a write is trimmed down to a block boundary, and the pages it drops each
+# hold their own pin when a large folio backs the buffer. If the trim
+# releases at most one of them, whether it drops a whole bvec or shrinks one,
+# the huge page never returns to the pool.
+#
+# Regression test for patch "block: unpin all pages of a bvec in
+# bio_iov_iter_align_down()".
+
+. tests/block/rc
+. common/null_blk
+
+DESCRIPTION="check for pinned page leaks from trimmed direct writes"
+QUICK=1
+
+requires() {
+	_have_null_blk
+	_have_kernel_option TRANSPARENT_HUGEPAGE
+	_have_kernel_option HUGETLBFS
+	_have_src_program bio-trim-pin-leak
+	if (( $(_get_page_size) > 16384 )); then
+		SKIP_REASONS+=("a 64K block size is below four pages")
+		return 1
+	fi
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local nr_hugepages ret
+
+	if ! _configure_null_blk nullb1 blocksize=65536 memory_backed=1 \
+	     size=64 power=1; then
+		SKIP_REASONS+=("null_blk does not support a 64K block size")
+		return
+	fi
+
+	nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
+	echo $((nr_hugepages + 40)) > /proc/sys/vm/nr_hugepages
+
+	src/bio-trim-pin-leak /dev/nullb1 16 >>"${FULL}" 2>&1
+	ret=$?
+
+	echo "${nr_hugepages}" > /proc/sys/vm/nr_hugepages
+	_exit_null_blk
+
+	case $ret in
+	0)
+		;;
+	2)
+		echo "huge pages leaked by trimmed direct writes"
+		;;
+	*)
+		echo "bio-trim-pin-leak helper failed"
+		;;
+	esac
+
+	echo "Test complete"
+}
diff --git a/tests/block/051.out b/tests/block/051.out
new file mode 100644
index 0000000..e9a2745
--- /dev/null
+++ b/tests/block/051.out
@@ -0,0 +1,2 @@
+Running block/051
+Test complete

-- 
2.39.5

