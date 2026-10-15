Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4CE5304BB
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792081780; cv=none; b=Hy8SlQWa3z0+I3wE9G8UGJ11cnfQuyzYGNrJughnE0nH1viNBH4dGFuIJzi7XdR6Lp82sOiJct96SouY32r98fO83A10CuZS4WXyJGQKMexeM517wQNFuCPzwZrbV3Tb+2QJuunKH6fyqoP00rG+bsq+2resRkkhRuKy+e87DUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792081780; c=relaxed/simple;
	bh=9k9lf5LCMYIoXK5wcKHHKux3LLOpg6UuG3j3ILWcRRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZFi9wJ5IdVhpEpBlWEeNDEoJ2OgGb8EoJIWGAKXvpc1Dvb94NckLKSRNf65B5YT/7CZECB929EGwbBbC3kSx8rXnxYrkrjdkyhrxZrO8f0DjGlrzDwZvyiI4CHPjxmUlS9/9fBxZ3iU0M8Ff8oIB4E/IGbEYJimkwSPao8SSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=f+Fk82JC; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=kq2aFHN5; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="f+Fk82JC";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="kq2aFHN5"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FG09v61619994
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 12:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Lucx
	v+Qg2qa8pED7S5TpX5inDSSDrF/pL2gspVkeSH0=; b=f+Fk82JCLsIYeoJvPUPK
	r4rLoNLu1+58+G4wD2uI6WNOcrEb98D4HGGkw3XuiuE1HHdhBrRpdo/1tR5TV7VI
	OWVHoKYvwX032WT9fi9X50UDKwaIGiwgk7fB3oW+wNIbTEQeeo4zqbZlxnqCfIIN
	a7S4AzasqLOYSBY2CSXb432q6FzfCWnAw9mA4Na3iQK3/s2cJVUluHQ26FOCcqvf
	G8UhlgdzWjyfG7/Y4fHFN13268P4VMZGBSVmIhRNUZ+Q/xx1aPa4u/7W/0CNGwcq
	3mkf+AHnHxZPq4XBwI8f/OFcEBGLksDkuv7IbPS3J6+1/M17ShNDXKVcZ1KaZ2hW
	ng==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hb1yh89n3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 12:29:24 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc40759b2so1168505585a.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 09:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1792081764; x=1792686564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lucxv+Qg2qa8pED7S5TpX5inDSSDrF/pL2gspVkeSH0=;
        b=kq2aFHN5lIutkfFXp2cU8Ac6Nua/8CuS7lOIbKxcives17tcFjY0goS+kZeHS2Qat3
         aMQFGK/zhUif+luMyxSSpk/vHdYf4vYnrHMeVYE7A78ToM9SGwV795Kxk72DZiyFsiDO
         VP7Zhw+vuLhu3dfoKce1wj98B77aFFKgDAMzKfGAjoZZMo2+MbM5kfW05rsYzVIZOvT3
         2nDnUrGWCQryjHQLuS96iwmhCL/kL7Z9eMy0B/S7elgfENBQHlAxIIVJCOtxUNG34rLd
         6T/h6WeYPlvZDwMYnv27DHrfE/SN94/Ec+lZ0lfV0HFIdIYYUU6akxvpe1SzByh8Ev8d
         LqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792081764; x=1792686564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lucxv+Qg2qa8pED7S5TpX5inDSSDrF/pL2gspVkeSH0=;
        b=MlV8A7cfGOvnrJtiRvuRqgZPcZbLy/+WLFVQOnJendIh/jrcOezv3DCGU4kNAkpj3W
         rUcX5L/PPMxE3AcfqD0b4NeoWR+1VfWTGvG3OYlCh7FOf/yrlw1NBz7FU+cunS8bRafL
         mV2rStari+oYlw6XhUkFmKPYT4hheNGODK9+qWYI5aOMXdPf6wNKK+cWL+PE8laEWxZJ
         DlCWt9K+/YXATedv7caYNHzLX30Wc6vVg/0gl5Rpei/vUR9qxNKMouhU6/y66T5puE+K
         BseSD0vDuLn2+hZ3hTeH+sbYW9kAlBCb8THC9hHrAU1mx5PEMkFb4MQ8zI3kgLmdYy2l
         sWnA==
X-Forwarded-Encrypted: i=1; AKwUvBwAq2Wv211Y+2STcJPkhur48NMY93jBw3ntaAzvwuFO1Q3r6vdJgowpU1oODXU6LsSc9eQJSk471kNgRw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKuIlCGL0bxkLPkepNvB95QgX47J9gO08DYJplRNV3+l40J4iud
	wUzAq2pUG/SKm3xUbqAcyX7Nhc5h6Vs/ziZRBMPdd6MRHLEnQJFFHaLqznFr8C/rACdIzny169d
	ZyRc0WMCsnEbXBcGu5nep5J7D57ZDZaZoold9taIk2D65/vTWV+QocpF8B9k1YiXskp73
X-Gm-Gg: AYBFou2tiIFRK+5QV4pqJWi8iXp0LtTWc1xnjL/Mx+rimoK0FVlJdfJVOtHGiL5fcNw
	i/Z4//78eklxa1ExmNFTONC4B8qMPr4gNdQDRGon81TVdX5eHbCYX0dmtLh7fv6I4vghF0/rjGg
	rhERYRnC2U9ZflOjUY9SWQK6Vowz5ug+wa/Uq/90MXItHf4cluzqsiG+eopVq58RYTyNG1TGu/N
	gLc8gcQmkbhpacQxEWXSyQgP50QemBSj8uyoLqE3tXfZZX8EVYh+GKqBgK6r5MHgF+zIYBymS8+
	Ra/P58o/sKlN6+Zd6QFu1ml+QkvDv0mA8+URadmvekZt8FNJOqzHNTBkBgvoUA7poujxeAbGdJI
	L/U/h93uGzTMa8NxmZYNME/DGBtyCmTDLsbppEgNXW7sr
X-Received: by 2002:a05:620a:448f:b0:939:b94c:3e85 with SMTP id af79cd13be357-93ebd1bb1c2mr3089083285a.24.1792081763470;
        Thu, 15 Oct 2026 09:29:23 -0700 (PDT)
X-Received: by 2002:a05:620a:448f:b0:939:b94c:3e85 with SMTP id af79cd13be357-93ebd1bb1c2mr3089077885a.24.1792081762752;
        Thu, 15 Oct 2026 09:29:22 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-51.net.columbia.edu. [128.59.176.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5086fe3sm803716285a.37.2026.10.15.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:29:22 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 15 Oct 2026 12:29:13 -0400
Subject: [PATCH blktests v3 3/4] block/052: add a pinned page leak test for
 trimmed direct writes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-blkdev-fixes-tests-v3-3-b6ffa6410514@columbia.edu>
References: <20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu>
In-Reply-To: <20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@linux.dev>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792081758; l=9942;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=9k9lf5LCMYIoXK5wcKHHKux3LLOpg6UuG3j3ILWcRRw=;
 b=D6tAX3MYyDGCvqY7mLb9i1eTxGhUjCpCiKUH4Gs76auosBnfrjLloRt1//OF2RnKJNkfKj4YP
 kOUBmCPcSixBLTrOlTJgGfe7bzvzjaFY8MvNTphui1hW09298/N3vMY
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: _4yk1hEB5LDwLA3nBTvt33Q_7tdT5ZiH
X-Proofpoint-GUID: _4yk1hEB5LDwLA3nBTvt33Q_7tdT5ZiH
X-Authority-Analysis: v=2.4 cv=TMnQ2Fla c=1 sm=1 tr=0 ts=6ad0ff64 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=NKoNGjn6KhAaSQkl0TXC/A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=VwQbUJbxAAAA:8 a=BPaW7FqENuk_g8a1aMAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2NSBTYWx0ZWRfX0hS4c+rxzYee
 Ps++k7/cjH8OnDL8M7jd5eiuYkQgLp8JB4HNBNS87SGxGeB4sBkrZQLHEGyU7RYIaTVYsugsrcJ
 M1ndYs7X/VHnO5FJycPjH2U8B/MED3EbjLbUc88xZhSmqTEUuVMB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2NSBTYWx0ZWRfX65Lazew2C321
 MMc4OgGcFTwFSLdSxYmn61ZBBJqsdl2rtkvBSS4pqHIqXFKVazw3Xby3P2NR3hvlGEh7cSdI7z/
 md2vk8aqkgNbebHkclWSsOUpakj3LGIp2X9bS+5cOOvfQMIChj6mmmLlPlEqsKpOtJtikjt9Ljf
 uEBD6o9RRc+TeZsVZUh2pNeCopILZWhXKxv68oFDoZEFFrf0DUgKYEisyXskyxTnbl5tr2Sj3ck
 1tjtqInhWJ9oCo99EwpIAef2AKpTM1sV7vPxEYDQrE/z1K4Q3rtFq+ZvbBKiR6QM9tKM4+gaeek
 3yO/EDxXHcdfSk4G6UF5aCocUG/AXjRUl26E7MBIXzh92rcswoij5UkWEkm/ib/xO+qO1Ctntav
 2pPsp5MocjFGJjw0AKGtWcz4ONhJZRghADb5pNAIf24JnP6TxNacgp+mcDEeagOIUZxhK2glm6H
 wBmt1wx++mgA1fq80eQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11936
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=10 bulkscore=10
 impostorscore=10 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150065

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
 src/bio-trim-pin-leak.c | 200 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/block/052         |  64 ++++++++++++++++
 tests/block/052.out     |   2 +
 5 files changed, 268 insertions(+)

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
index 4d56623..f3f338b 100644
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
index 0000000..b3a51a1
--- /dev/null
+++ b/src/bio-trim-pin-leak.c
@@ -0,0 +1,200 @@
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
+	int status = EXIT_FAILURE;
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
+		goto out_close;
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
+		goto out_close;
+	}
+	if (hpsz < 2 * lbs) {
+		fprintf(stderr, "huge page size %ld is below two blocks\n", hpsz);
+		goto out_close;
+	}
+
+	badseg = mmap(NULL, lbs, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (badseg == MAP_FAILED) {
+		perror("mmap");
+		goto out_close;
+	}
+
+	before = meminfo("HugePages_Free:");
+	if (before < 2 * iters + 2) {
+		fprintf(stderr, "HugePages_Free is %ld, need at least %d\n",
+			before, 2 * iters + 2);
+		goto out_unmap;
+	}
+
+	for (i = 0; i < iters; i++) {
+		map = mmap(NULL, 2 * hpsz, PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+		if (map == MAP_FAILED) {
+			perror("mmap");
+			goto out_unmap;
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
+			munmap(map, 2 * hpsz);
+			goto out_unmap;
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
+			munmap(map, 2 * hpsz);
+			goto out_unmap;
+		}
+
+		if (munmap(map, 2 * hpsz)) {
+			perror("munmap");
+			goto out_unmap;
+		}
+	}
+
+	after = meminfo("HugePages_Free:");
+	printf("HugePages_Free: %ld -> %ld over %d iterations\n",
+	       before, after, iters);
+
+	if (after < before) {
+		printf("%ld huge pages leaked\n", before - after);
+		status = EXIT_LEAKED;
+	} else {
+		printf("no huge pages leaked\n");
+		status = EXIT_SUCCESS;
+	}
+
+out_unmap:
+	munmap(badseg, lbs);
+out_close:
+	close(fd);
+	return status;
+}
diff --git a/tests/block/052 b/tests/block/052
new file mode 100755
index 0000000..a4edec2
--- /dev/null
+++ b/tests/block/052
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
diff --git a/tests/block/052.out b/tests/block/052.out
new file mode 100644
index 0000000..71c1f0a
--- /dev/null
+++ b/tests/block/052.out
@@ -0,0 +1,2 @@
+Running block/052
+Test complete

-- 
2.39.5

