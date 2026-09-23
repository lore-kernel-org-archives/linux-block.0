Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466D041F35A
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207825; cv=none; b=GEwsapgctci8svB+EN7Zymn1q4GcfBHzJLwTDASkeIN6wQDGBt38qKeVRc1ER5fXSU5quW/Ed2BKCs6mUuRCK6+2aQms3njL/MKurRPd36UwIQcHE168zxHfqXQXbL3mK76HWmQ1XNAxHxv1uT+HIgrcNlMewKpa4UJexEUIEH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207825; c=relaxed/simple;
	bh=yXeThnqDkkqQfZuxk0/UWy3aO+ZnELynhrbLzksgHI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SPABh378CHBCOLCma9AUjyypLxCp1r9TEV/YTuF0MwGJ7qWAcSNAUJZTJpaV5IDoUEOUkPKRzDeoOqYx9sCnVF5E38Ftsl7tDU/aHK4dnTfadn4CGIRmxKmY7U3OjeEvsyY+xccJ857Gq1bIejFYlFD1kGNvGb55j14n4t3rjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=sj5b9uc4; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=yrwTXPMc; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="sj5b9uc4";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="yrwTXPMc"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NNCPDd2037822
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=tePV
	uFSvZh3YZ0vx9H5UbQsBPQSfTF32xq8p5PG2Idg=; b=sj5b9uc4LsyptVKr+OoE
	eTMaUxHRYpb0oukkyF9M/sqlvTEOh384V1RPIGb0H5/FOmaet2XLIrc41yPXv2He
	5xvT4roMGFGCne6FCJbUVnbuC3jjxf0MUi9N6xftBPxSoh4Q9Mq2IMEkS1NBavIC
	0xfX39reA6e3SCDTn64JhDwVB/Jx7SaEY/Y53RxEloAMuf+DHyy9QP0335/gjXjJ
	lMT1QPKwXyWbKt4it30YDciqfjjzF/mjEEYDvbazsLjWRAqlID1SgoPHe1wMJTKl
	dXgcBH0+SK2UrTX7hW46hENyx8jdx1jBYhZ33z+T0/gS4377Lc9EqSGL3aa7UFKW
	ZA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gvh5wcrvu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:56:59 -0400 (EDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so2743648a91.1
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790207818; x=1790812618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tePVuFSvZh3YZ0vx9H5UbQsBPQSfTF32xq8p5PG2Idg=;
        b=yrwTXPMcEJinzT4ktvTbKKrgLFxQ56hHVJ86zqbTwJyyA96yhmNTV1a3mqiyFqL0al
         nDZQyFK56u3mZpR09kakpJnLpQS4CbWuUeJNuJtGz250l1xXTkAp/1rssRDiW67vuZqF
         3LwtG/YrNHT0PTPErTI3GGt8Z3wD7BsmvvFS1bI5UWFWhp6qrnnJp/irfzIjThBphy7C
         vBruNu9BzXH433BW1GE0Qi/y8D3EgYqUP7JH0oIPUqFZeSRi6PKGbTAxNQ2xCypOdXeD
         durIt2Kl3L+R1ntqStICQdVWeM91ACG6qDwfCoroMHPfiSKZf1LcWGiOJE1P4/tt+PqB
         ZYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790207818; x=1790812618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tePVuFSvZh3YZ0vx9H5UbQsBPQSfTF32xq8p5PG2Idg=;
        b=xrO3ofNLzHN4PzSHMJkojNh/NuE4ji/puhiifS1EE2JmK3QSfNJDGkpANoibKjFR3/
         DTmqdo4eA+3UCWbNKS9GS0WvEUq4MApZhEY5OMErT3iKXUc+KeVZNj9ENJGqgEz2Mqm0
         XO28neeg69pLyOusXl3n+acCPppK5b3axZGzhm8prNb/U00Gbxy6BULgBucrdNZ05IHK
         raxs44tlP4NK8tazfpcEZoqzLcrw/NgmSH1C9cv3Y/Fs1kHN2Y4s1FNlyCC7KQZHcF/y
         4tAjzi+S8YfPG1+AHjDCksfn6HOpgtund83t8Gk1Dvexx1S1otr1bVy2Y7pkLMIvH87z
         9JVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzx7GkFsvONDOIKfi/UoL7M/sM3PJR7xJNsGCYbqtbzwnRaFyDwcIsukuXjFjmrclCCqC0Sxkf5lXmcIw==@vger.kernel.org
X-Gm-Message-State: AFuF++nWhyNa04Cv7suCMyeD9pSa0nwUULklUfTujXM9v5c+oef3iSWM
	HZDtknBox+GIh+4irM8/lZZwTFfiLk25zxkKY0NfcTgV8hGoFjXR2ldONsjJVlLZXaD5FPuWRz/
	DmpdWcnkVwFpx11YnmjKA5fA6TrKqiAfA9HB0W2/ASynp+u8MifMAx+6AqeXX
X-Gm-Gg: AYBFou3Owlnx+20QwG4wmW+KORGb24/TT0OOwUl+tYPFD1frS1uaU4qsPJVZb3kN5q9
	q2z/61SIamp5k2daAjfk4PaDB7hEhVE4dGb3sBy729OR4pD5JSowgm8Jrylm5EQVyZL+bE3SXl2
	G1g1mDAE4hFvPA1EVe70eH3o9Kisi0TL4kcbaQPNcyc9kvG6X/R3TSRp4rK0yzuzEjt3AiwwD60
	eO+NI6l4UgIGSBKshpS8MAwlG/tCodyosaKBomXfPlgu89opbsO5jivWtqXCw/dCNtQVu6B/yJ2
	ZZ74pp1sS08Ya8Gq5cC9yxA7jhFZWKUdHVJmFTyqo/BKfgW7BTQdtuuMINsWhjWSTq0qaWO4WXA
	H54fLdC49kryurRepHtiORtaLKMbx077Yf1WuZv8Jlh5b7g==
X-Received: by 2002:a17:90a:d603:b0:39e:4d1e:d47c with SMTP id 98e67ed59e1d1-3a098606bdamr610945a91.25.1790207818505;
        Wed, 23 Sep 2026 16:56:58 -0700 (PDT)
X-Received: by 2002:a17:90a:d603:b0:39e:4d1e:d47c with SMTP id 98e67ed59e1d1-3a098606bdamr610921a91.25.1790207817951;
        Wed, 23 Sep 2026 16:56:57 -0700 (PDT)
Received: from [127.0.1.1] (RED-LION-HO.car2.Seattle1.Level3.net. [4.53.155.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm1331613a91.14.2026.09.23.16.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:56:57 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 23 Sep 2026 19:56:35 -0400
Subject: [PATCH v5 2/9] block: take i_rwsem for the direct I/O write
 fallback
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-blkdev-fixes-v5-2-89e60d66eb38@columbia.edu>
References: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
In-Reply-To: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
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
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790207813; l=4766;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=yXeThnqDkkqQfZuxk0/UWy3aO+ZnELynhrbLzksgHI4=;
 b=QkG2d8Jbv7plkdNQIPKBKPZEtuwiBr0JNrWEczqcHSyaxtBfP4cb6kna3/skQP8mwhum01j+g
 xPTvsnpqIsgAJj1MhM7jYr4Q0lcCwmgWXpAHraJW1U79pTS3KeTw8CI
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: faKlmRNkWhihPFqiTHFJGq78ERB0i4Eh
X-Authority-Analysis: v=2.4 cv=DIEacCNb c=1 sm=1 tr=0 ts=6ab4674b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6aZ3Ysb2zzbY2sELL/OBJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=NEAV23lmAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8
 a=HaKTZzbUtGO3MgJEFeMA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfXxw4GTR5SbBvj
 TP+CJ1SZlMkII2ZR4IMeGIRzUDnHkTU6fpxpNQZV56ug3YxAvimbb3gOXymInUkPRoB0gEe7FId
 JnONhc5S07rQZqs6a/r+FhB1IJKbEiadExl5PAGvJHYpLCxvqf3F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX0Q7XCKp+D0vs
 miofGrZ/8apHLZ52kHgYFOFczs37RGQb8V8228ZQbJNXybT+Mjbxl53jpg5fKl/0yo26JQdac7B
 OBVySn1r9M/TLM3dX4DaGmUjq4rjoqXFx+tEFBX0WfTUFNuE5XI5KDfCsGmGHcF72lIiJVw9Tgx
 hS6FukFdyZTh7LMF5J3GHZn8+EPQ67JflDoss9BpIRqMxqTF9p8aYYEFPW6UpjLhotKj+G7m/E2
 TJvJbvfU3s7S2Z0m5dKLV9qgaLdB+Y1sZONZOIenetS6ayGAudgs78xENqr7F1mXEWhqXJvduGz
 /u/cUCjRGW8ht/zY8B8TDBPqblUPcu3nUvQyjgIMnOj8gM9PHOcTruIt09vrnWPXxXV7U6URsRH
 VhIfar8XE9dJmKyldk6x103UlJ280lQdT/DYYqe039urno57G3K4O7fJaX1IhJXeStuFuQ+kYUB
 tyAPaBUqjIFQg89Y2Zg==
X-Proofpoint-ORIG-GUID: faKlmRNkWhihPFqiTHFJGq78ERB0i4Eh
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=10 impostorscore=10 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230100

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
index 8d74d0e57f43..7ff78b448659 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -770,9 +770,26 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
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

