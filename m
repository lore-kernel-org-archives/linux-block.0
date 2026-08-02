Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19C43ACA6C
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785669308; cv=none; b=Bmt+tj2J7yNWjpsaOLRFXcUxUYSThvyg/5vBvAtPL9e/ZeFZlaVOEx7ARSJwLDi0NzDhjF+hG0phsBWt8bUIB8QtPrETb2WoL7nkn/+3WiU7AJqgxAEP70TVCs7ik1Y9W025eKeHJZx18QYkmefM2mwuBh9TQRQfOOqTWPoZZts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785669308; c=relaxed/simple;
	bh=aRrsnrjm+hC0SgmEP6qa3dYjKwh7UQ07bM+pDIpctlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=STu/NKzCiCCqhdwytHJav0slenIk+zEPbuSWitaZnfjni8NgOt5aCxZ/9FSSVvUHpPtcTPBaut3Je140uj4JcG2B/W5EdQkxJg1oikACy0U9MozfTIOfK/GqBDfQ8gkrpnCl0fjBmVMgE9fU4RyFUPtiJGsZ4t1sqY50ksUpvQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=uqLvx8wv; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="uqLvx8wv"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Atu643302847
	for <linux-block@vger.kernel.org>; Sun, 2 Aug 2026 07:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=EgCY
	mPFKitFCAwzyFlrh2gfdR3r1L0t69TYDuLzPI+k=; b=uqLvx8wvUYDJCYeimuWB
	KEij1I7VE6VulAzOcKRHTf2haT0rnqJ1ZKhXPpd1yLQvIOBRO/brmC2fMOUwVbFq
	FTkwQpd45QEAYUmgqDn5O4ytfJNqDjUvA2xw54WstcOJVpV9V4yoIXes5xgmifne
	fAwh4D7gPl3+7Mw63qvrVrA565jqEJcqRjcoGWTMXrDW+DT5x/1iHVJdt0kAZ9WP
	PeBFzKp0cRI+/HXqOS/p1v8dyxS/NxL2GHPKm2bvy0mBywcZuTPiZbm8/xFqYIEo
	pxlzSBQpXrRhCxng2L4YFfbw/kD5cELi3FyrJEnQjpe5S0yqiB3ujBnf2+pWaXgO
	VA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fsy7s0mua-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sun, 02 Aug 2026 07:14:59 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ef18406878so23891786d6.2
        for <linux-block@vger.kernel.org>; Sun, 02 Aug 2026 04:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785669298; x=1786274098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EgCYmPFKitFCAwzyFlrh2gfdR3r1L0t69TYDuLzPI+k=;
        b=QsXDsCXa0FRWNOLFxQfgduwuBe8J1RkEJuA0TmPcfx1L7DGHDcOFIpVDcwSWZrj/65
         ceky47QnJ9WKSzuxrtIBCePxZlqs0/G/lVjjaut1n2feL5xkfh9cMdD1mFEZIJ7HHYlr
         +VFZGD7nE03PYMDOpC/O30YoWz+m7k9CtdmupWvFPxLIhNQZR6RKQLMLaQSTeX4Kq8al
         Nwvxl/8Qcm3k1wCObNPac38Cfu/14JNUTWBcu6vFJ4Hb6O0hUlxktmsFvYKHQUUJY+nR
         DrzzJg8AKg+lk6Ump8kL8JyiDZh/mdszN6Etk+4IeK98+ndeIIx9w0ZPh1b/HnD1vInd
         2PLg==
X-Gm-Message-State: AOJu0YyqijVS55Ka+Nzqp+7aeWde6AmR80KS2GspgTADG5M3+1K13oLp
	1opkQzmUXTAd9gRReEm7Yo3fMhpRFUsm622TcXBvqEssYRtdP3iqpVCNV/puB2htt0VmLmzWULp
	duEEnAWAzraFbZwzY2URNnOPy/zQxDufcVdU24Lwxge3IkPzojAzy4kFB/JRH
X-Gm-Gg: AR+sD10ikApCiwzqeAXxFVYNiCdppy6cwWMATvDhRQ6I4DqI8wd66R5V7f5xMy5S8kq
	JbhhdbmE5A/IGMjSOpZP70KtYdW5TWfu8ApZZHVk3qRpd0lFUbkfGuM0hg6gV8hSxxu7azsurAj
	8HN27a7VcJiwt4IBs6L7kH0jrS9iDy80z+TLVoEW8v5BiRdHf0hXf32G/m1NHSjNOgY7nmRg5XB
	yTjGhpvbm4crefZoYwqX/5ckJS2vcT4g9JPh0VfpMDrBm1cezJGxtob691h3o9ukwbSTaCiq2y+
	H2bBa/wv9ThRs90XsxK4gQv/WstYofCM52pofD12OwjqFNRlLiDPuCfV/+GqpUoCB3hOpeS89Ar
	cfNgoGW+1iT/uY2wuCr6nwxYkEol3VBRxa2fnG0eUBcN1ij+d6tc=
X-Received: by 2002:a05:622a:1b24:b0:51c:f3:34e3 with SMTP id d75a77b69052e-52b567dfbf3mr133725691cf.28.1785669298383;
        Sun, 02 Aug 2026 04:14:58 -0700 (PDT)
X-Received: by 2002:a05:622a:1b24:b0:51c:f3:34e3 with SMTP id d75a77b69052e-52b567dfbf3mr133725281cf.28.1785669297834;
        Sun, 02 Aug 2026 04:14:57 -0700 (PDT)
Received: from [127.0.1.1] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b917efsm208062155e9.11.2026.08.02.04.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 04:14:56 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 02 Aug 2026 07:14:27 -0400
Subject: [PATCH 2/2] block: take i_rwsem for the direct I/O write fallback
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-blkdev-fixes-v1-2-a82fc549fd74@columbia.edu>
References: <20260802-blkdev-fixes-v1-0-a82fc549fd74@columbia.edu>
In-Reply-To: <20260802-blkdev-fixes-v1-0-a82fc549fd74@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785669291; l=3804;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=aRrsnrjm+hC0SgmEP6qa3dYjKwh7UQ07bM+pDIpctlY=;
 b=nw9LoR6QS/MxYtYUmsn5Od8WhIBL1DAmUSX/EA2KourvpeoRHbb9l3elEqY7wh9s6I63YEeUF
 AoKoxT70uWNB/qwT1yh9ibpnd1S0NXyyl3TLLwMzMRqW06IgNEUnLKw
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA5NSBTYWx0ZWRfX27LETMgmssTQ
 HBvkZYNtvatTuxK88yLPmpEkikFQhNQJOrRlbryPVqRnqWkBtfS72nfM1wflyX0iNcHjmBUyCao
 I6nkaQHvkknB/ayafl/4qYAeMHaPKxaPkLqbskYKP1JzwL0cgr9fGV6pd07IcvS52uVS8Qc2EsH
 qSWN3VaNlpUg0mqx3WoteFceCnAe7FmOi+FLF/gzcqf4I7GZZ+6fpf3Y65pqvtWfsqyBSWgCVrG
 0yM33l41Nsz8TAzcovdIMJ2ViqW9LvshFmKj3cNn7o6nO+nOho/xmNNPpHkIx+OgeMQtA42Ccmr
 SjhoBuaB2UpOAqCUFnG+UbQmxp7TdD30b1xhnJ+Ea7yP8Hx2RyGmpyO/oC6VS/nyh3Gus7MaKtU
 E5qIJ6CRnL7m64XdlJOxUwRreCqREgsKjxNRUR28g3eykQKhPsCaZTFprEodvo1UNVnxl8qXH7F
 6V0AhdDIqOSaRy5b8dw==
X-Authority-Analysis: v=2.4 cv=ILYyzAvG c=1 sm=1 tr=0 ts=6a6f26b3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=NEAV23lmAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=sbZGx9YuH3hznvUd2dEA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA5NSBTYWx0ZWRfX+t+wMeTCI4Gy
 jgr9CmxcYppFtpbmpkLIBkYyyjDyQAoIz2d9RFJ+MQ0GMP4GQFbnRYlxz9D9ZBq1eYKp4SfQYhT
 Ruq1e66UhrybdE5/YVkBuYz1wnKWf5hdk3ItcxnYr//vlKeaE+ls
X-Proofpoint-ORIG-GUID: Z773S4td1x1CWmJmOx8VAyQ9tT8cTlgt
X-Proofpoint-GUID: Z773S4td1x1CWmJmOx8VAyQ9tT8cTlgt
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11862
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 adultscore=0 phishscore=0 lowpriorityscore=10 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=10 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020095

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

The reproducer used was written by an LLM, and is available at [1].

[1] https://gist.github.com/tzussman/69d06bc57d42a42989eb038b1b5aeb74

Fixes: c0e473a0d226 ("block: fix race between set_blocksize and read paths")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260730-blk-dontcache-v7-0-3e8e6850068d%40columbia.edu?part=5
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 5b938f673d4f..26711cc239d5 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -763,9 +763,14 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
-		if (ret >= 0 && iov_iter_count(from))
-			ret = direct_write_fallback(iocb, from, ret,
-					blkdev_buffered_write(iocb, from));
+		if (ret >= 0 && iov_iter_count(from)) {
+			ssize_t ret2;
+
+			inode_lock_shared(bd_inode);
+			ret2 = blkdev_buffered_write(iocb, from);
+			inode_unlock_shared(bd_inode);
+			ret = direct_write_fallback(iocb, from, ret, ret2);
+		}
 	} else {
 		/*
 		 * Take i_rwsem and invalidate_lock to avoid racing with

-- 
2.39.5

