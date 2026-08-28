Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77B46C835
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925022; cv=none; b=TjEXNk3FBz94QQuZoV/oVeKCfK45xxvp5HNYlN78PyQsU3MJcfE97isPACA35RSVGL4XcvFG/Cdg733ZM9mhvAAJqBJukkphUAOd87k6C3EbS+eIqNRTe3gdrqcVTpxHUVYdHWvdD4v7rxKmsPAPUNsQDuBZyaTiHzITq4KDEkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925022; c=relaxed/simple;
	bh=lztChwPH+1ASZjAYgppa5ZtHfkdeAZyT/dwRUUUH+CA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDapLY2a6qmaTcov98Ks2EGC2K54T+KAZJ1iszDhqSoztojzn8Gw5rrzc63ZDNUdVKEd3Pb27cji0iWiukqTdYUFb1alQLSOG55AsDPyQUVdPwBIIbuRG2NWLunXNPCYoIQvQFblHkZiJo86xYfWzjGUwe9X1khOL0TP8ID1HdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=CxbpKt0C; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=J1P6XMDP; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="CxbpKt0C";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="J1P6XMDP"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SCYCFc3231992
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 09:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=mWgk
	pzSag0jbNM57A5E7I+GWepk+yurbjd4WqPTkFrg=; b=CxbpKt0CBGPLv8Qhth8c
	Tp39sID6F2XgwhRPuoazV3jrI6lBtv8rMRWrGxDDpJCT6+MRGKiwYafKDuvvHVXi
	PBD2DifF5bd2xrlrIDH63AiS/Vci450USPcXOsEmUqic8bPUrCOJ3frx7OVlTtG5
	kV0UZ4WiYfkfRYPFKVCFII50NCm1SIGJRMenHOcajX/ki28qcR1xuaZ95x6Ndf8u
	uVa+p4lqS2V2s+aZbtnQiW/HovhdsJfJ8CP7idUXZA6Od9zw3TgzrqPqax7/HdML
	Tf7ibN/YnvGdX0deFtAYnRB0Jq9vLRgvMpa8kCdDx//wSz1yLMdF0iUW0LaJarVU
	0A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gaufkvgcb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 09:50:20 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8eeba1d9e47so4891416d6.2
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 06:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787925019; x=1788529819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mWgkpzSag0jbNM57A5E7I+GWepk+yurbjd4WqPTkFrg=;
        b=J1P6XMDP6Fw5jTlMA2d5Xf6Xj4nop7nQVMl8lGFFzhWvODAzw3CYG+WJfdvuAIdNGZ
         eAQsea9/XO/A+sv6AIVYZnKscQMr8ped0NITyhV6ZiLlIeHVL4l7RvTnSqnVm+qZTJNy
         Yp+l2MwBvjlggMP1wzrINVXJEBdAdFzOoSf37I+swgh4EZv6GGM7Fs4Uhegqi8FhiB3M
         Sm3Xpnlo28zZ1OlsL4s76/JFYZUSQ654HcFC/dmSoNFPoIi0eZSxjSSbe80xc3l8Ifaj
         nw9rVm4VrvPJZXybTR4nEmc8bha666emgsv6dkhsk4yiPej4egF/P9NZAX+7p5opl/FD
         2Nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787925019; x=1788529819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mWgkpzSag0jbNM57A5E7I+GWepk+yurbjd4WqPTkFrg=;
        b=XfVw8tHzhDDyNd1yRNqQl0Rmhytn4kMa7Pcj/+WYZhtHgYmYw66bjj+uad7LPeLfHi
         cEHunvXovvHYEICgt3sXmeNZ6Z37PAyoKpJ1iGmP2rz0YwwA05JKGjd0QQlbsNWQk25f
         paUY2oiEUqzkgPyt5wGob6hQ+u7RjXOsfv+9UrppkRtUhaqCtRJYnGNc+3qTnKm++HRm
         E2bh/hX8bSqMHP2Cznb98iQu6UdJtW1vbDXLYYoS9Jb+2gn4wgZxOFRcMvDckMwr5tGV
         oDHY250v5xWo3m3qdQTNhxA69pkYyCfKTT79nnd77MjBlQiz9pw4YYyPtRnRALKQcpCZ
         UElg==
X-Gm-Message-State: AFuF++l0ilhegP/F0I9D8dYKPxdK1JK4sxwj2TQTCMnVXCKsSjTHmQUI
	keD2Og1Ypxx/NAyPxBiNOaauGRXa9zCWJAgjJ76TGt09dxIVnyB2uhejzBvDGtbAl1FnW19ci1f
	LGtERe6yzSsJT82IPfFrBHeXke07dGZ4Rqcv2paEVp3IwyuAcQSTPxJFmZB+U0789R3Fsj0jQYQ
	==
X-Gm-Gg: AR+sD12yLccGa9DhgZpEXUYYz1W/Vfl0ilp3dhd56UXzhBDBh7T5Ls/Is9tkFqRrLZi
	9Pi1LiZnstCBUdV2fJLcCpUrX6Yf2JPNYvrVvFan4jEFVCJwiwTlhlr4n48ko3L3TznpNRQGnjC
	JYvDoTgDLN/vAJbEYNYVM/PpyDleRHmdtGSAl/OD+C2oMxAmZwteFIBItOVxNXUVOYJL4AX9YCx
	QcLZFCixaTFGJzUUgfa/qN+WkYWtb6zoCzzHez41MjH+TjdBFhJSk9yAZIWTtFp8GQE9ZV8uOCQ
	o7UWViTb4U65qSqRjITih/XFlOoMiAWRGDQgnb9nldJlxNqGLIuUARw02gs21cmUtG4lj8HE5yf
	AlsLWkpZ8
X-Received: by 2002:a05:6214:5a06:b0:90c:5947:7e64 with SMTP id 6a1803df08f44-90ce0bf74f1mr109799886d6.3.1787925018861;
        Fri, 28 Aug 2026 06:50:18 -0700 (PDT)
X-Received: by 2002:a05:6214:5a06:b0:90c:5947:7e64 with SMTP id 6a1803df08f44-90ce0bf74f1mr109798766d6.3.1787925018305;
        Fri, 28 Aug 2026 06:50:18 -0700 (PDT)
Received: from [127.0.1.1] ([45.130.83.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce4534ebesm15645116d6.48.2026.08.28.06.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 06:50:17 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 28 Aug 2026 09:49:51 -0400
Subject: [PATCH v2 2/7] block: take i_rwsem for the direct I/O write
 fallback
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-blkdev-fixes-v2-2-32f3f40cebed@columbia.edu>
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
In-Reply-To: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787925005; l=4610;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=lztChwPH+1ASZjAYgppa5ZtHfkdeAZyT/dwRUUUH+CA=;
 b=L1XVFubg3p6Sql6VAoc7sXpVFgPRPKovliasY3MQR+iWjp8SbRO697dnbZTB5gvYrUzhCuJ/Z
 6qBsLZCcKZDCZpMRpq2kKzRICvyP03CM/5ml/onLLIaR1THBPoW6YVW
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=daOwG3Xe c=1 sm=1 tr=0 ts=6a91921c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xDWFIMX55ayQNp92vt0S/Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=NEAV23lmAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=HaKTZzbUtGO3MgJEFeMA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExOSBTYWx0ZWRfX2Q/scSOCpL+B
 GoqNy8fNHxm+VpSPBfLizFTBSwyh0Q+79oqvLJHlde8q45ekxc+2/Kni4BNHpAVHsAWTkBtb+/h
 Rhw9NO8wMMkDLdHdAmS20FK6ExHQXJJbffH/1jJPM6OitMmtV2HXw9VYw46qRGwvGeJmM1jia5N
 QxQanfroOBON+fQcWIy15IsY7lCTRZ8blLz+IMAiocbqqKqzzIqMdPYy7Tr3QevI+0z7jqB66wR
 5m+sxe9NaxWwtAMoL4IX83pSM6MWE5UWMzHG81Lx6ZLQ1yO0ASiUar19SC3A34y9UdmEZEKoHOK
 80Rxa9xAOuPlEKmbOeiThjAPbHSoAMkostD75DUtntOS/rBdW36CvD1np9jsdzx4pywilA9UzDY
 wRbPKosvZFMvxiv8Fgo0vDupMwuMS1cZtcocEMSS5UK5rgCIMEBsXUwHAoZJBCc07yxDwrspiEm
 M5muz1nxf/EY8zOijBw==
X-Proofpoint-ORIG-GUID: 5qusjcxCHy3ExKEk6Sl0QNzErlB4dlC9
X-Proofpoint-GUID: 5qusjcxCHy3ExKEk6Sl0QNzErlB4dlC9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExOSBTYWx0ZWRfX2TT7Ww5N2kRB
 BrR+RIwDdwZv5JFpsrh5fXFjZNrBlCZeKaJifATW4rlSiAqIKop/880T4Mt8g4nVAt97fsQsLZZ
 8yEZrszjOf+IGnTd8vBxq77pTJ0HZ1SgpBoZjXA9UzLK4tpo3agv
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11888
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=10 lowpriorityscore=10 impostorscore=10 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280119

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

