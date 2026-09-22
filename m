Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2873B5841
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045665; cv=none; b=IH2j21ZjlpbNcveTtD639dC3JSsxCSFikvm1AWLEx6c+6LPGLz5LBhSrq7X+L8kzHAhkOQANjqZDjnfr13MSIo2O3ebU2em4Zakm1jzWZeD7WPaqQl8CA+XM9tVkvKYE+/xio8kyo/ERaJ6vmmoPe6Smuy4xiz4FN2lOQkjJyWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045665; c=relaxed/simple;
	bh=wygfwy6WLEmcRyxRJTfZrlUVqjeOxy5tXzglSXSaVpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=plmZVN3GsRbJmdSWdHCa+cnJNhOEXO3n9OZiZ8bpXIHttAG9qSp/uXQqBpAa5Sm9K2lbiITlDP0C+SQy/JfHTMMwakzaeq2bDI+Chg2EykuuccD0Kx+xayBWhj3GeMBoICJtrOfLDkgibWZ6EnVts6BK+A9G9BSjZ6B0oe+hyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=O+QRAAop; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=fX21hCT+; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="O+QRAAop";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="fX21hCT+"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M2X24Q1013705
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 22:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=g+ry
	kKqwK3PaWFm95Xep4+ofJmlr+BCp13pqFh0Yazw=; b=O+QRAAopFmkvoxIzZM0P
	WORu32X0XHI5gHmDaQs1ePqKbaMfpAxkVIHGYMzOgcRu9R2R01GNv11yPzCjS3nq
	fAwm8dogovc6oskOvCM9oHQoS99qwTOrHJbe9MDOUpMGfMa1LYDuUps+butZKR2h
	BEaMBbvE96ylt+RvmprW+cyXIb0JhRLRvBZaDOiYQgftqipAdfOHBi7pmxNZghph
	lcPWpDAsc+mhQrkkad6GLAbx3sww4wrFQI13vvEjgtu1H6aPk8MaekCz2bodEgTE
	1Oozk1QC1SPDJjufELeE8CdISQUs6oBMdypJ9LtWrRYZJKvKaAZ9qtZrXPWnnvPm
	wQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gu6vqctq5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 22:54:14 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-530e5b709b1so76552771cf.0
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 19:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790045654; x=1790650454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g+rykKqwK3PaWFm95Xep4+ofJmlr+BCp13pqFh0Yazw=;
        b=fX21hCT+yy1ijAlkKTKIQ11VZ5il8b5e1YTmEpOroLHjF9gasVnZnWTt4ymH0zZZGh
         cBRE1k8sB8Fd5psdyeZXJdaofKf19hRAIFcC16wD8Jk+dW+/s4k8OLMdon5QsbAoG/En
         rUxDVd6P0rkWIWejg23rLlrNGkLRBnJDEwEGabZLqkkKOA/zLO48nzUMwVo0WYWu4Fpp
         0ypLgN+SEuHuirBe0op4VXMITPwosHfFPoQxjy8bDRa04YdMgMt84nzwL1jDDJEGjfev
         Yfx5kp6pKZK0bzLMVk72jAPC96pPrAgZEnCc4yKtNNfLBLJS6S51fi4L3peAMlmweYQL
         /AqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045654; x=1790650454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g+rykKqwK3PaWFm95Xep4+ofJmlr+BCp13pqFh0Yazw=;
        b=jjzq/7FlJ2hDAVx/TqQva7K+irBh28F/49Qog1GC69d0VURy+fnZMGT4f6gMu9EBaB
         mNXXQiEWd9PKqXHOFBnwtqjqvQ052FlHycenBimDB3DRLu/JaUesTOqXxUBzOy8KH2LQ
         7ZICFbzneUQXiGYGyZuMV5SjmUkN35rbzgRomz+v7+3ba5inQjm6sjXBJKKq1ZuXaISu
         DqM0odKv0AtRvY7kw/QfaObVdFM31Xu+Ywr5WZTcrumPvmXkS61m4/79vJ+CYF9sQvOB
         aq0icROLRQT/Vfas9h+o7cFiqS8Z+0Y+sWAhvIZqXFgAHGVe3gg+ocRLGJSdu6TTPpif
         Hmfw==
X-Forwarded-Encrypted: i=1; AKwUvBwoaGbhqiR/BLNwn5Qnce+R675rYNTNnx0hNFCcGMSn7Vrov0M84oD9c2OyXtJr/A2UOcBNv8zJQwtFNw==@vger.kernel.org
X-Gm-Message-State: AFuF++lB0bXyeo/O88/ggR+CrmGz6XsQG6UPOjlstvujabj1Xwakno7+
	lVj8WPw+ACHEp9tIN2IKBGakNdWNH4btr9hIQgxo4OcEvupaIkaxjgzspySvIgEyoiYs+8P3vmF
	LIkzqIapQ2UZhHxnWsiBU139cKdZ850slMGRhDlLiCb+1i+Zylps5EwbSnZl1
X-Gm-Gg: AYBFou2Ij3ONTcn2tHtR2E72MGX+D4snwrJNi85ieQZZMiCFz87wxhQFr22nBNCc4dg
	C0dj9xUZK/K7Dvk0MhLr5mB0C3plWB7gE1EwUhW28XggrcbwvYx3QwXxjUCQWihmC76mIBlzPQs
	GiLM4658/FzpzdmTJkTQ8iIzyofldJ/+DP803sfk6UkEoh8Ui1pidPK43Ob/qPOX0Mg7//5khth
	J3IcnOe52eV/X+SBgX3KPdBGfcSddUQ+dL+R2ahBRRxxZNmAYQ5ONGEG+G/KkL9lv3iGfKKHizA
	b2eEFwgB9uDaosOTSrVyIMxEqjW4KIbUaJ8KzTrDgmx6PfbcNv+fP7n781RzYAR13WDTpca/CR5
	2HMbsafgj/CfmRVxB7K04AOwpL+T2P2bdoadJI7wkVshu
X-Received: by 2002:ac8:5883:0:b0:530:fb97:4986 with SMTP id d75a77b69052e-532d8e6e41dmr35889761cf.51.1790045654015;
        Mon, 21 Sep 2026 19:54:14 -0700 (PDT)
X-Received: by 2002:ac8:5883:0:b0:530:fb97:4986 with SMTP id d75a77b69052e-532d8e6e41dmr35889531cf.51.1790045653533;
        Mon, 21 Sep 2026 19:54:13 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e18fce9fsm2048421cf.15.2026.09.21.19.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:54:13 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 21 Sep 2026 22:53:59 -0400
Subject: [PATCH v4 2/8] block: take i_rwsem for the direct I/O write
 fallback
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-blkdev-fixes-v4-2-e2801f71ede9@columbia.edu>
References: <20260921-blkdev-fixes-v4-0-e2801f71ede9@columbia.edu>
In-Reply-To: <20260921-blkdev-fixes-v4-0-e2801f71ede9@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.garry@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790045650; l=4766;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=wygfwy6WLEmcRyxRJTfZrlUVqjeOxy5tXzglSXSaVpM=;
 b=sPYgGOCsYx+rYKOC0hGHBpvNO8eZLUjiJzGZjWcsKv81n8diiIzIxvYlKjsVW3sH+6PLcdUl0
 +x98Eg8Km/BAVLRPp7uJO1KTGQ6lqcwCo9X7hWR4yj2d/ae8lIK9v2l
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: 4USs0ksDUQY-dQFfhJAbbGc5rn0cIU86
X-Authority-Analysis: v=2.4 cv=BsoIUoX5 c=1 sm=1 tr=0 ts=6ab1edd6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=NEAV23lmAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8
 a=HaKTZzbUtGO3MgJEFeMA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDAzNyBTYWx0ZWRfX0I0W4thoMxXY
 CZMgCs9G7xJzi2Lvzqt3l4jxymZXFsASnMGvzv/VtFTjBUpSHrGwMCgZS5PJNIcpghBAtbwAS5m
 lJ1FdguyS/lfOpwK5JjG8DVqn0FgOkfTxN8Q9LnaHMWBu20ugdxCIZczM+A0cmroSZqtVfAscQj
 vFWTIz1h7Mt7kKWkSrSYj2bzSygsD/vbuRowi6H34f85bByQ6BFsG9hbqbU2M6nVH0bOYLxxbPw
 pJz4JN7L7snr3b8sui9HqLUqICZj05EmXkI8gaNIOe+P2bD4GMIXN1UZCOlfDNTZaiCBIniDTHE
 nPeWVJsPLOgIvJhpINIOVe+0YDK5qthNpIwXADZoB/n+4kXyPDD4SJozcs7yE5QfwUUzVNLjLX8
 vqIeI1ywC+dpvXUOcZ3Nc1G8aJjtC4JHlvTlt/dXVIFwzldkAdMC2P+PD71+Px+DO/g4OAHLPgB
 WgQnzB9zYM3BUp7LHBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDAzNyBTYWx0ZWRfXzd3klNcvC9MA
 fspIFEJofdD+o55sD7KRFFpPzAB4KSEbtBsjiTf5sG4qYxTgtliEexc6ZcwIJRlHjjjs5j3e1bb
 NfhtNcsSf1btd5KvdI/aQ9NCh+05aDe7jaEKyGTEEKw5xd/b0r7b
X-Proofpoint-ORIG-GUID: 4USs0ksDUQY-dQFfhJAbbGc5rn0cIU86
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11912
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=10 malwarescore=0 lowpriorityscore=10 suspectscore=0
 priorityscore=1501 impostorscore=10 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220037

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
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
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

