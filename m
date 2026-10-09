Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00753AEF2E
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564624; cv=none; b=SI0ULuhbSteEvqTwwI7CSpMms1ftvj0G66uaYElQ3i/yQ5XuD44cKxd8DBNs3iouVYcy018I5x2/HKpLrqrZ7OGyxdVbGibExvg1/WmRM3u6xnkZP9s8l8AlTjn/fCPJ5xvJynqzSDlLVzA5WYFUv+HkEKMj8AFKxQ9ReIrgBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564624; c=relaxed/simple;
	bh=dDshcLMc+GbAJE5S53bKt5KKBIFrr+TFSMnkBV9A44Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P8ShK0QWB6pHv5bErTPD5RMitBTIhziT4GEPjIIqKZbLHjgFMdxppisjYNmL+JGilP6sT6XxCttuwQXS1toqhA6Oz9092mLPgJsm8qbtpmLfJfFaa6h5Fs/Z//QFnsWq8LKsUWuf04c1YJ4ZggLqWq0ceUbObCMXLGCXHmvL7B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=N4SPD5JB; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=USuOXGdV; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="N4SPD5JB";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="USuOXGdV"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GYIoF1242735
	for <linux-block@vger.kernel.org>; Fri, 9 Oct 2026 12:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=7+SK
	9Hsocl/1FR69kerT0MC33AS/WWqivFjKplkjQYM=; b=N4SPD5JBASgZ9tnVZZk5
	CLWTKnWhqTMn8911JbdVrEkGhInt2thnlmOSOX5B+5Ib9FgpjM74ujtTY3tMC3f6
	eMpes6Ug9Lga5RuHMvrl0e9RVNOjcw25Qmk+/Mr+U7iqHcvL+MBuK3XvEMwzNAoY
	D8kmHjzaF+7UvIkjOaMg2XFRyWEGHO1UkJmDPa6nPWjqzn2+6SdCKEDNhzfT/wmM
	+MeqMbdep808D0nQvm42ZoqDl9Q9kk3YZULKeet9eo34Fp42OQNxFzsW3WfsuMLK
	fCU3IWSQfnQIqxwvKneTiNN4YF3rakc30QJsJ7XtVROcOs9O8yi8v/JD3EcOA3k7
	+Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4h6we3kd1k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 12:50:21 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53380b67cfdso147336971cf.1
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791564621; x=1792169421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+SK9Hsocl/1FR69kerT0MC33AS/WWqivFjKplkjQYM=;
        b=USuOXGdVac0YuM77kqmFFfXYminOpuSaifqoP2jPm8nMHYsM9STm9SEMt4FDZN0lgA
         qTj3AmJen9pmEqixi8RYf2r/QZXjxwViqjTzy1X6QlTtf2TrQ5MTaWRb3YGGRadVVIGy
         RjIEh+Y7Jk1zzNbOIJd3+XLXH7opt7236NDmZwGKsdlBRYVuew2/7ROVBvSHAuyfEtj+
         RjnPfnP+YoJ6DHBJh1SHLUhRCVBILu00jcEIz+VuzMMdueAW5tKbPjMNhNehhwj+qg7w
         e+ZSx1lEgrdBJ3T6rjCA9LTYIiZuo4h7vf7VN+wAKXe3fx2P6F2vT8LTACkK4kJ9BiVV
         YXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564621; x=1792169421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+SK9Hsocl/1FR69kerT0MC33AS/WWqivFjKplkjQYM=;
        b=jEh0B7TNGZS1397xCarjPqD5w6XLedMJMsopFpeaPsGV1eJjZ30lM7odg8rmm0g0Ul
         xl3t2bU0CF/7dlZTElO1J191vOguoglvoI3mD/UxmyY4mVng/v3a3ktUsTuhFKSC76TF
         WeT4bRuxdJclCP4jKemIPLOpqh0QIxAIJxYzQxEM2zq5fs0W795EvofMvr3RVA+Qe/yj
         3ZECjgQToXcNjc9EOtZp/30BMzBKtXH8uh0gTXIJ6++X9DLVEvsPBLQim6rPlw+nhoIq
         CVjDx3dMo1/oitwgqxJ0O+nN8nbYe/JsYPeMNxFM/vdnoVzL5z9sTqQcCnqk9we2YvAZ
         +u5Q==
X-Forwarded-Encrypted: i=1; AKwUvByGZ9lckdjw65/+6BfF4FFAy5GAOxqLt3sAbmxhN4z0nTKoqxJcrAvYFY9RIJ3oUrCZqAL8MnP0gHtwzA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLodRtTEvMHYfEpeeg5izfXOl3V952Ejrd2zCF+6Tk7TgLlOgD9
	KE/lDY0Y4i3cKvdH08H8v1rb+hjXFnewcRsUJxp2vbIKSA5WeymK2KIV+AtlCOOsVRKkZcC1MZK
	V90aDKe2LUGs7yr0PUvfKNviCGEQHYXCwHAiOwL1LzDQL1FpAQqabXdCDclM6
X-Gm-Gg: AYBFou0MjLXXQWgVH2S+b+duFTLAKmL4itw3GxhCg7xpgblD8ZhSKtYKO3VxEibQLab
	FnmDEIK/vfolRa/E7OnCUUYdymoaZi7abEf5xm6unkhUXbaoOapsKXI5qdNFVQKWUpoWj9qfDTB
	7Fx3N33MBZcpSt9HmeyVdOREoacTX54GcryCWeUDoER82y7ODRXZYL6Oiy3wO8QGlVa/pnetVTo
	+uRR+VRmF/+W37T9xXV/pAc8jsU3bsZO0P3VPBGI+FByrh00+Tn7Gg/ZVd60B3Q6yfoWi/dA7Px
	Lvkl8aM5O+UKJvtMG4MuS1buFUseh6fXfHJAroXLEpUZ0qCHcM+fTe/d3P63tgVrNR7jl9Z6h6g
	MTnG7RAMpEujMV6urvT5dn951ATRtANPcAV/YOgSFe3Ms9FQ=
X-Received: by 2002:ac8:5a54:0:b0:530:dc5e:27b3 with SMTP id d75a77b69052e-5359f488e49mr42742981cf.3.1791564620754;
        Fri, 09 Oct 2026 09:50:20 -0700 (PDT)
X-Received: by 2002:ac8:5a54:0:b0:530:dc5e:27b3 with SMTP id d75a77b69052e-5359f488e49mr42742391cf.3.1791564620048;
        Fri, 09 Oct 2026 09:50:20 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b77d0eesm22234701cf.19.2026.10.09.09.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:50:19 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 09 Oct 2026 12:50:10 -0400
Subject: [PATCH v6 2/9] block: take i_rwsem for the direct I/O write
 fallback
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-blkdev-fixes-v6-2-307939c387df@columbia.edu>
References: <20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu>
In-Reply-To: <20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu>
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
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791564615; l=4956;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=dDshcLMc+GbAJE5S53bKt5KKBIFrr+TFSMnkBV9A44Y=;
 b=7iAc8SSFEcROQAmY5eXrAlCLPwKvbAPfKwfIahwUaDAk1njSzpupgTlu/IHHM9pwn2aub7CuC
 ZJMB1CHuFXcCNvsMzOHNMWqYeOxvlit2uqZEyHjSzPx2pzu/55NgWVA
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: USuu4-Ik21UBASCTtXTaO_x5rEHw6yl5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX8+hKUOYSAd2k
 zjOx9uVLqgoaRo9QOIWaCIvUGpmef/O+tSnOqEdDB+WpZqd+rPKdfM6eRICdUhd9DXlBwr6WDXz
 kH7L6QkAPwh6qI3FDjIaGa0+comoZuniMCf2ASpggJAaA5EIhD+m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX2gYRzkKwZ2sJ
 +FpqU+q7YKt7HHDOFxMcQPleriS88CRnK6uT4qpl6eNhVb0e/scW8C9KH1l/89/ubIt/DjI1nAv
 FMSFXF6PIS1BswnzsoMccACdK3AbO7VscfZuUQMuShHNntQunxrnvAGDG50FI3q7yzzeU1Hylpb
 jixvshJVG4nQgQi0Vkql8RL1ydQxzLX/lEgNe3uw8ucO76TZCgvNFStdBvM31bFaV1L/aKHkYhq
 tYLdCxNRKc/ggL645/ljuU4jBbLMlMzE5/AAL+qmkkONTE/UByR50n7/d/7FdORnM2kfQM5WEXF
 rm86b4PEMqsI7klOhS1MLg4X4yjMIL7LTUGbqV6Y15jYO9Iv1Sy7FZcjJI/LKkjhsaeWHosYI+y
 i5I4ObgdAruy22N7BDSBPUAaxIu86vYFsxL/LCcKI+/1bdkh6RKvbZWeY195L5MPCUwYF3FNQyU
 gujMFA8JnwsmpM8ZkvQ==
X-Authority-Analysis: v=2.4 cv=eYio7LEH c=1 sm=1 tr=0 ts=6ac91b4d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=NEAV23lmAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8
 a=hYhY-2XO39JmFoxvHv4A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: USuu4-Ik21UBASCTtXTaO_x5rEHw6yl5
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=10
 clxscore=1015 impostorscore=10 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090067

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
 block/fops.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 5a559fcfadf9..52ebf5bd1443 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -782,9 +782,28 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
 		if (ret >= 0 && iov_iter_count(from)) {
-			ret = direct_write_fallback(iocb, from, ret,
-					blkdev_buffered_write(iocb, from));
-			need_sync = true;
+			if (iocb->ki_flags & IOCB_NOWAIT) {
+				/*
+				 * The buffered fallback blocks on i_rwsem and
+				 * on writeback of the data it copied: return
+				 * the short direct write instead and let the
+				 * caller retry. The bytes already written
+				 * still need a flush if REQ_FUA was not set.
+				 */
+				if (!ret)
+					ret = -EAGAIN;
+				else if (!blkdev_dio_fua(iocb, bdev))
+					need_sync = true;
+			} else {
+				ssize_t ret2;
+
+				inode_lock_shared(bd_inode);
+				ret2 = blkdev_buffered_write(iocb, from);
+				inode_unlock_shared(bd_inode);
+				ret = direct_write_fallback(iocb, from, ret,
+							    ret2);
+				need_sync = true;
+			}
 		} else if (ret > 0 && !blkdev_dio_fua(iocb, bdev)) {
 			/*
 			 * The device does not support FUA, so REQ_FUA was not

-- 
2.39.5

