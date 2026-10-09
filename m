Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072493EB0F0
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791590037; cv=none; b=Iv7oRZc8ePsDoJ+jnkNjwTdfHsaWNmg+nupaA5sWzqhre4BT9XRSxKatU57TJ+sVjzTqOSw8DCIOv0Lcxx3Y7tceqiwIcK8zS3p4icL8pusQ2MZT0mif+rsfmZxgUFHx1nsZX9StkUqXlG7w1124/q8iIXcKlsEvrlBl+A3AOvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791590037; c=relaxed/simple;
	bh=VyXhtFiMq/Wr2840EFICxA95Eq3mSO7AkJu6UmBlNYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SSuA9p0qemTXgzVabRAyYb7z1CPqhbVkCukvBnqW+HsXbFZalvKxcSjje/V/4eP2j4BBumeI92dm0XfM1dJpk15IX51IKA0IRWfiBbAbSc54pgueFuTJG2zUtrlThqov0xeDPnAa3GYbnczmJXvDuaSnrcIksJBmQpCUA7Nnu6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=jfkjdiLs; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=rHmMC0G1; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="jfkjdiLs";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="rHmMC0G1"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699MZ1Bd2056584
	for <linux-block@vger.kernel.org>; Fri, 9 Oct 2026 19:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=wLpq
	/5lQU7VvbTNVr7RRaDzQbiXzex1T413zsN3LIzQ=; b=jfkjdiLsHF/LnKawxHD3
	FkpYvGnMsTuNkdMv92b+hnrBZG7gEHGvzwNKpYXJ32g/P0LcsWMD+H1bJhdSdfDx
	08/2wbMuyVc4z8XWV4spq9rxxIEpe4oZeAjfNLHWAD5U9cEXAFQfncWhSvosUImz
	eUe97sOUoBz3Qz6O/jhlgMyzbSeeJblJZWi00yiDQsva0p9utpJWhktGfVYZaXy9
	s5DMyM1y+/y3A4i95/0Nbo9D6HB1XPmz7yzixJaimnMr/gbm40XLQxnQlT7QxmsD
	Q76MbhpPdZkbwJlLFNkG/RTuhsqRSclBRXtpxhZvwQsmpRDqtXZmPD2BC5shZY0S
	tQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4h74tcjfk9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 19:53:53 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93e834ff4d0so55455785a.3
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 16:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791590032; x=1792194832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wLpq/5lQU7VvbTNVr7RRaDzQbiXzex1T413zsN3LIzQ=;
        b=rHmMC0G1+uOxspy1KtQPtpR98tZNMUWgEojsVq5ai/27PI+ec4xmNuY/MxRkGnNvCT
         Qei/M4ecIMOYPrLO3uK9UMqg6QJWFUxpPLcz9ArOXDe6W/L6yMwl9+JlExdhoLHHO48B
         qreiO62mBBXJa8L/HifysA8EXofdZY2qyEdn6hNcebD6Qn6O/6GxLKanOiBfBN8zmmdm
         LQvckjJSBtThBQ85iPbVrHk1QaUkyo+kfdwdu4kNeGI3koPrz98RLi8DHhOjv3tuIANv
         SD16uKcmoy5Pxt794PvA+YH9rLiij6D3jjra7lumhWMeEKGee0NASY5Odv2DKzC99+lz
         xk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791590032; x=1792194832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wLpq/5lQU7VvbTNVr7RRaDzQbiXzex1T413zsN3LIzQ=;
        b=Jl0ARiYx8rK0CkgER8uKn0AychhfWLSWjTqxuaWZxtQlJRkz2UAC97tgeH2qJ5jUZL
         lFC6hz4Z+j8gG1VEhdC3mVM32bOSdbn/LJoLw9UtCUQci8sLVvS39s74I/R3m/+0YZYz
         M520k2STGDsZketTMWgd1dG0NQAp8NwJjDTwbOF1f4wEXX3DPm2VjtAt1S6CMBwyrjM+
         goSYitSqx3ggIpWEN+q0O7/f2ldcVuEjvSqEAopX9MlZmckaFV4zT87Pe8EX30aXNRYz
         VQJbs6moGq+oP2W99URcwg7SCgDztqlie5AKvX59wX3XjFH9lk8f/G6DARwyar+YdI64
         a4RQ==
X-Forwarded-Encrypted: i=1; AKwUvBzfS6AOV1ujs5HdOMNiBrgwl7XHe17OS+d5GjpY5/trFYladTBg30UTtq/1PEmE1Q4WN+K8WZUJafWpSg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK6p3RnLlUgCY9auJW3YvgN1Xh/4nZxjv+D8BwQsYC14hwNjbbz
	PHzx8+2pmmYmAYN/HatnsHKbtvDcqdzk85zZTyRPAy3jHWkA4mGB7yDnjpr9cYVc96g8d6As7LO
	xqpq6RsqW5fvB8xt6z5UsLAXoaWfOhbs4N/qvMn45bavTwdHxA7WvF/bl2S8/
X-Gm-Gg: AYBFou2nUqc0EV0GFM/5ecZhLSjkykYwKlBlA4UpgmRFQTRZ6EwxZP5TLIvHkph6Iyh
	n6jGrGTbvMGcLjAKwHDJQYJZ1aZhUB62K8O0LkTB8cTgrmoh+uGfbTG+EzyAXAXf2spO3tFfj8+
	QtKbcYcbLgqEIhyB/XGA0pojgC9iVwdHGYixjDo1qZ1q1ygkF5hIc/w7nR0/vyeA6yk3+EtUkfh
	jd/BEAWNy3fesVsvJtO5EiaaAUBkVUC19Rw3s/iMxJy39QUTBmrQi9BXfbN4ljxgaDeViBAhaVP
	G37eXngDpP/WqvrNxr/UNYJR+ban8pYOCY2TwpHGxjeEWdrWNCDGLc7PMvTmHCJSGyMyDOhDZMP
	PQsFwSwR6+BdV32wmZT5HtwBHNqj0TFRZ7qAX9LGcuxgikco=
X-Received: by 2002:a05:620a:230c:20b0:93e:c12c:fbc6 with SMTP id af79cd13be357-93ec12d10b1mr347853585a.83.1791590032405;
        Fri, 09 Oct 2026 16:53:52 -0700 (PDT)
X-Received: by 2002:a05:620a:230c:20b0:93e:c12c:fbc6 with SMTP id af79cd13be357-93ec12d10b1mr347852185a.83.1791590031874;
        Fri, 09 Oct 2026 16:53:51 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb984889fsm304517485a.13.2026.10.09.16.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 16:53:51 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 09 Oct 2026 19:53:47 -0400
Subject: [PATCH blktests v2 3/4] block/051: add a pinned page leak test for
 trimmed direct writes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-blkdev-fixes-tests-v2-3-fcb3599e47f7@columbia.edu>
References: <20261009-blkdev-fixes-tests-v2-0-fcb3599e47f7@columbia.edu>
In-Reply-To: <20261009-blkdev-fixes-tests-v2-0-fcb3599e47f7@columbia.edu>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@linux.dev>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791590027; l=9801;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=VyXhtFiMq/Wr2840EFICxA95Eq3mSO7AkJu6UmBlNYY=;
 b=VNuPzIa6LfarlBVOsogRBK3rEUoXaVoR/ApkpgYGCgMgXd97kQcym+8iWXan/L1eRWV7D4nSN
 IAwUG+5Q2DaDL3A+UZ1TJnmvP1KQ/48ggc9wRZjpIBSuzM6HUOmAdjA
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5NSBTYWx0ZWRfX2QOWeis27IV+
 DIwmjsNPh3iB4LTvUrCqRHARZu1gGgaetcB9FYKuj0jUW2sWHNHLjmbmFF5fgWD7Erespc3iHHp
 VJGmi2abGHtazjoBlWc8/9ZxaJgB1cdaIA/QhJ/OHJgVy0+zAKD6AG0ax+rscnyCkI1OztIKb57
 k1K3cw7BMK8OrdXlPkSazMFN9tz8WGtID9t6Yb+spLXNtbzi8KyXpMV17EViu8AOmAajjkl+IBw
 0GaNBjF1PzU7GSTeBgR1xQ61DeoT/emXhylMDDoYd3FbIwsX3jbNwERO9re2qarf/oy/Hmq6HQf
 BOVmTo24xYl9tzl4aZi8d0YQSvViMHrlOHVrgtqMptGuplGCvCN0yHZ2I8SNuwQ5jPL5uKYENQ5
 LJm0vTkK1JyNrqP210qTVZAUIJfIcmV4tdl6ThPZ/QERtm3bAMjblCZLOMDprML/CGwMZMWBrxr
 z52i4tDz6eH0S1ynKHg==
X-Authority-Analysis: v=2.4 cv=TKTQ2Fla c=1 sm=1 tr=0 ts=6ac97e91 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=VwQbUJbxAAAA:8 a=BPaW7FqENuk_g8a1aMAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: rRtuhjbkJYPA-5cdMBe6uF0Xj7OIQnXo
X-Proofpoint-GUID: rRtuhjbkJYPA-5cdMBe6uF0Xj7OIQnXo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5NSBTYWx0ZWRfX23rzlvbWCdZ8
 GKobyXAAvkELKMKlNk9rj7ybb6cfk+wJeiX2ulDOGR8Gs+GiPdeYrlE5RWPXQdmSXX8z5TRmRpv
 b3q/EUEgC4FRPM1gi54IOyn1qEwwTIMUXJwBWBjxSkQpcbDp3ueM
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=10 adultscore=0 suspectscore=0 clxscore=1015
 impostorscore=10 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090095

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

[1]: https://lore.kernel.org/linux-block/20261009-blkdev-fixes-v6-8-307939c387df@columbia.edu/

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
index b7e8ca9..0bdfd05 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -16,6 +16,7 @@ HAVE_C_DEF = $(shell if printf '$(H)include <%s>\n$(H)ifdef %s\nHAVE_%s\n$(H)end
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

