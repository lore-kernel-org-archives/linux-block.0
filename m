Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14053B7B83
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991232; cv=none; b=pGzypH5YVM5jvpIay3cdUjIgxP31KbUlDm4YIaUeIuloDSWnACHiez8NJaxRx980hwx6m0Uviscyo+cS0bq4fXQvBbOLZ3OhG/HERfUMXOKFvBNO7VRsxXfkYyHsn5YF31HARixWsTU70vebqrrnhq1UyYwPJAf512WaImOeG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991232; c=relaxed/simple;
	bh=O4XevJ8HWjAvUQlUza+/KsywVjvdxM8otqyAjEW2gkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C202dGneUo1URfOeleHhMiXuBW5K9ZdoEGxgTHLVjCfgB4PoxMbi5ZBWo+sSNyUzIrbryszqFKVHOsgiBBEvIgL/puTqBgA1AbDUtGgsA/TjKd/uie6EX+LHpzC6GQOGqWRvzE8fTYRofGPgLxZJEummNSg1EEMWWkScNQGD5lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=GEV4F/Rx; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=x6ZXkQGF; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="GEV4F/Rx";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="x6ZXkQGF"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689KYY8w1438122
	for <linux-block@vger.kernel.org>; Wed, 9 Sep 2026 18:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=OHeu
	hw4L3n9jZDkIAzrhQrQraRuBwX+0vErB9kq+zus=; b=GEV4F/RxCUljoIaRfCF3
	Xo6pHQvbs3ZQKHsDfnOqqwJlEPu6s6eQD115+hIZGlijejz6oIK7d43dqw3Rol40
	hzrfCq27HTFri+iZleBpcR6f5R9kngYPzYI90z9WtJkmZBJDxi+K/Oo1BZGON0nf
	JMyrmw7gaMTC7QI7v0O3HnDGJOYmzoGxct+fMsCJd1oimc5Xv0WVQKmnB2s3sKVj
	Qd9KlAXBzj4f/GKimXRRw7kviRq/3DWKK/PiXK6Ze+ZiGjWpF7QrSADE9M7y/Bzn
	2MK8+EA449zVwGZl0rgCvU3pkw4/J0XEXJzjHmZ4DkCkCWQkIO5FDGRXBtm+EoNQ
	dQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gkcxwsrgq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 18:00:24 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939665a1ae6so840471785a.0
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788991224; x=1789596024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OHeuhw4L3n9jZDkIAzrhQrQraRuBwX+0vErB9kq+zus=;
        b=x6ZXkQGF0+HvhbtGsnIM0yF8R3487jKyXQJeca/XXsoCZkbehCCAO3DEfVpuObbxgI
         /ktlreN0r3gLHJwIoywFoUaOs8/F2ej1DAyNJrBtIXu9k8jbyACrs7yUO0nvPbRBdLTO
         Cipnesx1/EpvkUGCVnmNV9M2QWTlpxSPU1M6nfYAYVq0EOoEjCEl/zYE6mmweQS5z2Uj
         hQv91YqA6jYSHqzFipGPc3YzkqOie3L90ZH7THYAxGOrXTRJAQUMR4esid5PCXW69aG9
         6EoAX2snNLCkF6wz97uCpzT/56wWZIxclKnJjY5FDy61lzHgftoBNytrAppKYcJTG9ho
         zEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788991224; x=1789596024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OHeuhw4L3n9jZDkIAzrhQrQraRuBwX+0vErB9kq+zus=;
        b=oqoKIkVTfGgykfEYIdcVFSG83LFM/M/IoxDf8dhLbGCiZoKApQbxD96UTAJCg/SaY8
         HJNJfKNJGFlyJFHXcNagFUbYUWDqEjDqv/oAslDxgAcsu5b6lvw6tpjAKNSFv4R9Erv+
         xgund/vrwFAQvC8ZA7zA4l2Ppzg7wD9BkS7zkRaxj6MIt3cnBYnmXXQ+hWwCzUDJ5CJe
         +BKGW6UqtZfwQGPfUyA+wDDpHy9GEvGrdSqBpZjO+hkUvZH6YZn0QGZnpBaynIphjzKy
         AaEKoCxfSWUdG8tngHmHwcKqiVlWO2XVPDKIZzFKlY+DMBhwIl+TRfLKSrm9qdg+VA5P
         mOyQ==
X-Gm-Message-State: AFuF++nHgBzhIU1phO9Sw59eqATJeLO7zrsfRXf5H0Uuop43oKFwX4Ef
	JHuDrTowo6Ve4tvY2in5vMD6F7vHmkXd1vVuysuyxgb03LVwFc9tUn2/Ntu9nkjayWwTVjgHYkn
	CLh76RDUQoPsJ4qC6zbY58E+Gv5SzOSPBQ3BMaoLLYNHRPFIkEQO3n+AkWUTz
X-Gm-Gg: AYBFou27n+zMMfGQa1lHfYQuNi0Mxdc2UOkzls0Rjb9d3gDZsm294pVIwowff9WyZU8
	1lUx4DRVM+1RRDWCBGjtaphsaww3mCr45UEm3lHZOrlq4QG8JSgMm16cKtrRzkVesGLZO/LzJmi
	otf2qWizbwvtNZPiwwXVJAuloGXmNQLmLEwdubJySu5+2qSkMOrK0viAs5Gl3jDvVSlb0iSiciD
	OMhvzMIVAsLH1zSzerX7gO4S8GnQUX/ys7wUhtCpL9FYh0IbwHJWcEGpDZ1CVwRmVo6RAQfNirO
	zPoxl55YRevS8Qsdp9FbZF5eXKT6dLw7YhEhjcZ+378QlATCfhY9VwmOViP2NzAh/2KqQofHgeW
	/v6AerVH5tXekONN8deHMyKX+d7i21iQG6HDOJ6AtcNUmV5bG
X-Received: by 2002:a05:620a:4151:b0:932:ddff:1241 with SMTP id af79cd13be357-93980425ab9mr4372453685a.26.1788991219695;
        Wed, 09 Sep 2026 15:00:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4151:b0:932:ddff:1241 with SMTP id af79cd13be357-93980425ab9mr4372408385a.26.1788991217103;
        Wed, 09 Sep 2026 15:00:17 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-193.net.columbia.edu. [128.59.176.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbe31c6sm1535326985a.46.2026.09.09.15.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:00:01 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 09 Sep 2026 17:59:40 -0400
Subject: [PATCH v3 2/7] block: take i_rwsem for the direct I/O write
 fallback
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-blkdev-fixes-v3-2-1a5222c6e8ad@columbia.edu>
References: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
In-Reply-To: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788991197; l=4703;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=O4XevJ8HWjAvUQlUza+/KsywVjvdxM8otqyAjEW2gkk=;
 b=L6fykDJbi56xVjU4w3porinRK7hzSl8V57Ps0HUow4zw7jLIDcMxCHMwGd4yyLJn9x7oyz/uo
 Tx5+x0k6mJtBVJYp+Y3rj9GOqhBK8a9MleNHC3owCSKlSVxLb+yR/Hz
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: dvcuq0oQqLUKgbBX-jodygeXDQKE24em
X-Authority-Analysis: v=2.4 cv=ZPRCCn7b c=1 sm=1 tr=0 ts=6aa1d6f8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=fJxgZNdXt3opHMdyAp+FXA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=NEAV23lmAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=HaKTZzbUtGO3MgJEFeMA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDI0NyBTYWx0ZWRfX/46aV7o4zTFC
 /FS1hJ/MLSrgchNpgFZeV5dIXT52c+IpwgZWrF4RdWfJ0w/FasC36PeDFQXhulAf1Md8/BkbdnD
 VA+22JkWkGzfGKVYW7M3pPmNXQR2Zw4Sm6pe0ps1cE4rYs/6I5bADmKF+UllQnOC5DqoxJjl1Ex
 vY1E/gw2IUdj5RSeK0DOw6jqHYbgrklejkABfBkvUnWOxRkGGHU2Skde9tzMP5ktWisnElRLwor
 j4+1xZhnIW8sn36PIqAd8oN6zqAyz+Om+57lienm3zh4wh9EqOSMHPEFuY3wpfET0TSHqLmNYiQ
 Ur29D9u54Z3OIImruQwhO0nq00vmfDcs6YzZv3cVBpZRwsyYLuAilegwqfxBOZM1ismmNKNV+Pn
 TPB5qwtgBRbl1ZFJfNjOjUcuwDBUOKpVmZ3y1X4sUAP8d4gYkU2iKgvWp3T5OVAkUFAQjldeFct
 Rfsb+YeNyFqBxBb8/xw==
X-Proofpoint-ORIG-GUID: dvcuq0oQqLUKgbBX-jodygeXDQKE24em
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDI0NyBTYWx0ZWRfX6LWzT7cAv0jK
 OFN/yBEVQBPsPmW8pyfwCgnEegPjlNdPQDEnYAklv7N21xYa9NWvV6kYc4/ByyaUQwbfYwLSBL5
 9VNaK/wTAtSWTIFp2v3jyKIjX+wS/FzRmVVa6MxuuAK+z8zpgA7m
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11900
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0
 suspectscore=0 bulkscore=10 impostorscore=10 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090247

Commit c0e473a0d226 ("block: fix race between set_blocksize and read
paths") closed a race between set_blocksize() and block device I/O: with
large sector size support, set_blocksize() can change i_blkbits and the
mapping's minimum folio order while a concurrent reader still holds a
folio of the old, smaller order, leading to crashes. In particular, it
made blkdev_write_iter() wrap buffered writes in inode_lock_shared().

However, the direct I/O fallback path was missed in that conversion.
blkdev_write_iter() passes blkdev_buffered_write() as an argument to
direct_write_fallback() with no lock held. A direct write that completes
only partially then finishes as a buffered write with no protection.

This can cause a BUG by racing partial direct writes against
ioctl(BLKBSZSET). Writer threads issue O_DIRECT pwritev() with a
two-segment iovec whose second segment is an unreadable PROT_NONE
mapping. The direct path then writes the first segment, fails to pin the
second, and returns short, entering the fallback. A second thread keeps
toggling the second segment's protection so that some fallbacks get past
fault_in_iov_iter_readable() and reach the page cache, a third thread
populates the page cache with folios of the current block size via
pread() and readahead(), and a fourth thread toggles the block size
between 512 bytes and 64K with BLKBSZSET. The minimum folio order only
moves with block sizes above PAGE_SIZE, i.e. with
CONFIG_TRANSPARENT_HUGEPAGE raising BLK_MAX_BLOCK_SIZE to 64K.

On a CONFIG_DEBUG_VM kernel this yields the following BUG:

  page dumped because: VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping))
  kernel BUG at mm/filemap.c:858!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:__filemap_add_folio+0x860/0x8d0
  Call Trace:
   filemap_add_folio+0xc9/0x1f0
   __filemap_get_folio_mpol+0x240/0x660
   iomap_write_begin+0xa87/0xd70
   iomap_file_buffered_write+0x304/0x6a0
   blkdev_write_iter+0x255/0x510
   do_iter_readv_writev+0x23d/0x3c0
   vfs_writev+0x211/0x7d0
   do_pwritev+0x121/0x190
   do_syscall_64+0x121/0x630
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

The same workload also trips WARN_ON_ONCE(pos >= folio_pos(folio) +
fsize) in iomap_trim_folio_range().

Fix this by calling blkdev_buffered_write() in the fallback path under
inode_lock_shared(), matching the plain buffered-write branch. With the
fix the same workload runs clean.

A short IOCB_NOWAIT direct write reaches the same fallback. Taking
i_rwsem there can now block behind set_blocksize(), and the fallback
already blocks on writeback of the data it copied in
direct_write_fallback(). blkdev_write_iter() already rejects a purely
buffered IOCB_NOWAIT write with -EOPNOTSUPP, so do not enter the
fallback for IOCB_NOWAIT at all: return the bytes the direct path
already wrote, or -EAGAIN if none, and let the caller retry.

The reproducer used was written by an LLM, and is available at [1].

[1] https://gist.github.com/tzussman/69d06bc57d42a42989eb038b1b5aeb74

Fixes: 3c20917120ce ("block/bdev: enable large folio support for large logical block sizes")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260730-blk-dontcache-v7-0-3e8e6850068d%40columbia.edu?part=5
Assisted-by: Claude:claude-fable-5
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index c57784773fe1..d5f569333f46 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -765,9 +765,26 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
-		if (ret >= 0 && iov_iter_count(from))
-			ret = direct_write_fallback(iocb, from, ret,
-					blkdev_buffered_write(iocb, from));
+		if (ret >= 0 && iov_iter_count(from)) {
+			if (iocb->ki_flags & IOCB_NOWAIT) {
+				/*
+				 * The buffered fallback blocks on i_rwsem and
+				 * on writeback of the data it copied: return
+				 * the short direct write instead and let the
+				 * caller retry.
+				 */
+				if (!ret)
+					ret = -EAGAIN;
+			} else {
+				ssize_t ret2;
+
+				inode_lock_shared(bd_inode);
+				ret2 = blkdev_buffered_write(iocb, from);
+				inode_unlock_shared(bd_inode);
+				ret = direct_write_fallback(iocb, from, ret,
+							    ret2);
+			}
+		}
 	} else {
 		/*
 		 * Take i_rwsem and invalidate_lock to avoid racing with

-- 
2.39.5

