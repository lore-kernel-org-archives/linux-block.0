Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091517464;
	Fri,  8 Nov 2024 05:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731044731; cv=none; b=dMzPp+3pQbUNR8lrwInNbcT8NR9L51wdFUBdKPccnHUBSrriztLA2aDFx+zJmD1okdKH3gYwfoUxpzTZlrgYweX3Szzpu15nEEqwP8z6NicddXvmQ4h0rQvAlhaSvfKKmf5LSBMR9zqzWuMpmuj88osKTCeMBhWAKTCMxS04b9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731044731; c=relaxed/simple;
	bh=VLlq4g5rm4UHn+2jdmGwFnyCo7uIRE8W8YkYXJ4bG74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L3ucB4pbEPtFH7xjsnIM0zYGGCFtP3V22HOKjm1TZZODmET1lowZxZ1/ZPpVOsYIlqUU2BlaVyYvsCHiHaeKDre8q5QnMUpv7e/VWcU1qbCxsEe2Jf8QfLC5mFtFIfru2GrxZa0GFeclYspe0NCh0/13x12KA2fa2G62hjLWfng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S18GCDHG; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S18GCDHG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Bt+Jk
	l72MFjik7CIlL5r5sM/qwYsSKvqIcgcbWbeB50=; b=S18GCDHG8TZi8o/FltuTG
	aVb7XA51TD5ixr+NDjRsNqbOG6fZv54o37HtxdG5h004MNOzvCJmOUilNJ+M0n9a
	8eIOr3wJlPBfevpARDNbKpKQcNmzOIKychR2up0JtAAWuzM7PoVl1P0W+KQxt4mO
	HIqmBDZ9r/ZkU5kgHKkRKs=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCHoyxdpS1nIJ8PCw--.6298S4;
	Fri, 08 Nov 2024 13:45:16 +0800 (CST)
From: David Wang <00107082@163.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] block:genhd:/proc/diskstats: use seq_put_decimal_ull for decimal values
Date: Fri,  8 Nov 2024 13:45:00 +0800
Message-Id: <20241108054500.4251-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCHoyxdpS1nIJ8PCw--.6298S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr1rKr4fJw1fXFyrKF1Dtrb_yoWrWF1Up3
	ZIk3Z5X3yfJas0gF15Aws2gFWUJFyUZFyqvwsIyrWxW3Z0vw17Xr4fArZ7ta4UW39Fka1U
	Zr17Wa47KF4rXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRn2-nUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqRSRqmctoVRm6wAAs0

seq_printf is costy, for each block device, 19 decimal values are
yielded in /proc/diskstats via seq_printf; On a system with 16
logical block devices, profiling for open/read/close sequences
shows seq_printf took ~75% samples of diskstats_show:

	diskstats_show(92.626% 2269372/2450040)
	    seq_printf(76.026% 1725313/2269372)
		vsnprintf(99.163% 1710866/1725313)
		    format_decode(26.597% 455040/1710866)
		    number(19.554% 334542/1710866)
		    memcpy_orig(4.183% 71570/1710866)
			...
		srso_return_thunk(0.009% 148/1725313)
	    part_stat_read_all(8.030% 182236/2269372)

One million rounds of open/read/close /proc/diskstats takes:

	real	0m37.687s
	user	0m0.264s
	sys	0m32.911s
On average, each sequence tooks ~0.032ms

With this patch, most decimal values are yield via seq_put_decimal_ull,
performance is significantly improved:

	real	0m20.792s
	user	0m0.316s
	sys	0m20.463s
On average, each sequence tooks ~0.020ms, a ~37.5% improvement.

Signed-off-by: David Wang <00107082@163.com>
---
 block/genhd.c | 63 ++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 34 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 1c05dd4c6980..72f481a82fa4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1264,40 +1264,35 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 			part_stat_unlock();
 		}
 		part_stat_read_all(hd, &stat);
-		seq_printf(seqf, "%4d %7d %pg "
-			   "%lu %lu %lu %u "
-			   "%lu %lu %lu %u "
-			   "%u %u %u "
-			   "%lu %lu %lu %u "
-			   "%lu %u"
-			   "\n",
-			   MAJOR(hd->bd_dev), MINOR(hd->bd_dev), hd,
-			   stat.ios[STAT_READ],
-			   stat.merges[STAT_READ],
-			   stat.sectors[STAT_READ],
-			   (unsigned int)div_u64(stat.nsecs[STAT_READ],
-							NSEC_PER_MSEC),
-			   stat.ios[STAT_WRITE],
-			   stat.merges[STAT_WRITE],
-			   stat.sectors[STAT_WRITE],
-			   (unsigned int)div_u64(stat.nsecs[STAT_WRITE],
-							NSEC_PER_MSEC),
-			   inflight,
-			   jiffies_to_msecs(stat.io_ticks),
-			   (unsigned int)div_u64(stat.nsecs[STAT_READ] +
-						 stat.nsecs[STAT_WRITE] +
-						 stat.nsecs[STAT_DISCARD] +
-						 stat.nsecs[STAT_FLUSH],
-							NSEC_PER_MSEC),
-			   stat.ios[STAT_DISCARD],
-			   stat.merges[STAT_DISCARD],
-			   stat.sectors[STAT_DISCARD],
-			   (unsigned int)div_u64(stat.nsecs[STAT_DISCARD],
-						 NSEC_PER_MSEC),
-			   stat.ios[STAT_FLUSH],
-			   (unsigned int)div_u64(stat.nsecs[STAT_FLUSH],
-						 NSEC_PER_MSEC)
-			);
+		seq_put_decimal_ull_width(seqf, "",  MAJOR(hd->bd_dev), 4);
+		seq_put_decimal_ull_width(seqf, " ", MINOR(hd->bd_dev), 7);
+		seq_printf(seqf, " %pg", hd);
+		seq_put_decimal_ull(seqf, " ", stat.ios[STAT_READ]);
+		seq_put_decimal_ull(seqf, " ", stat.merges[STAT_READ]);
+		seq_put_decimal_ull(seqf, " ", stat.sectors[STAT_READ]);
+		seq_put_decimal_ull(seqf, " ", (unsigned int)div_u64(stat.nsecs[STAT_READ],
+								     NSEC_PER_MSEC));
+		seq_put_decimal_ull(seqf, " ", stat.ios[STAT_WRITE]);
+		seq_put_decimal_ull(seqf, " ", stat.merges[STAT_WRITE]);
+		seq_put_decimal_ull(seqf, " ", stat.sectors[STAT_WRITE]);
+		seq_put_decimal_ull(seqf, " ", (unsigned int)div_u64(stat.nsecs[STAT_WRITE],
+								     NSEC_PER_MSEC));
+		seq_put_decimal_ull(seqf, " ", inflight);
+		seq_put_decimal_ull(seqf, " ", jiffies_to_msecs(stat.io_ticks));
+		seq_put_decimal_ull(seqf, " ", (unsigned int)div_u64(stat.nsecs[STAT_READ] +
+								     stat.nsecs[STAT_WRITE] +
+								     stat.nsecs[STAT_DISCARD] +
+								     stat.nsecs[STAT_FLUSH],
+								     NSEC_PER_MSEC));
+		seq_put_decimal_ull(seqf, " ", stat.ios[STAT_DISCARD]);
+		seq_put_decimal_ull(seqf, " ", stat.merges[STAT_DISCARD]);
+		seq_put_decimal_ull(seqf, " ", stat.sectors[STAT_DISCARD]);
+		seq_put_decimal_ull(seqf, " ", (unsigned int)div_u64(stat.nsecs[STAT_DISCARD],
+								     NSEC_PER_MSEC));
+		seq_put_decimal_ull(seqf, " ", stat.ios[STAT_FLUSH]);
+		seq_put_decimal_ull(seqf, " ", (unsigned int)div_u64(stat.nsecs[STAT_FLUSH],
+								     NSEC_PER_MSEC));
+		seq_putc(seqf, '\n');
 	}
 	rcu_read_unlock();
 
-- 
2.39.2

