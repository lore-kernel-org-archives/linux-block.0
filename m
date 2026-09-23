Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CAC3F86F2
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207824; cv=none; b=ZNOg3Lz720TnatgynzHSHqpougGn63B4skOOD6C+LGS8eiQZv5IrCMHwTdBoeYo6bYgOEISLczqj+5YC1rfk5Mlvv5YZJdgvrG0lghMAt16M3AV1fzHsMPHBhBoPqeO+5CmnD/Pucoebj/8dhd0lap7JzeRoLcKf3RU8fSHKSzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207824; c=relaxed/simple;
	bh=+6JrzqfYyBrGC9pfDqzdgv7ta7N3grQNKoC2mDums3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bOSN3CvMnvIif3/lEWX4wXgFfg+DAFZP7juDAgZfGL+/EoQl9O73u8huk6Bo6oimVFlJHqqtR1nVngHRCcJySAOaM83IDs1UYH4/N/HYTz6W7YcDFARLjXcA/hvaX6xaystUec3ESzAjT2oEyA0DCNmEKD+Xu3ICUVlrwQuVQMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ZIF+oELv; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Xfp1wmY/; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ZIF+oELv";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Xfp1wmY/"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NNEMOo047246
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=HttR
	teK87V8g79twx1jaSTPrE7lew+ZNw8C68XNjrsg=; b=ZIF+oELvaW4TWpkgzVo9
	+v/WeH+if8/IRVrLAJKDNHdQTl2ZHsH+jRqHFkmNgR/Fgjg4w+FdDo0kknGaGSW0
	ihnWu9Wi2+2yayUmldfplrbrtVnR/uKIAU+3ACBCq8cVU+tVFYRdSBZScK3bTjK1
	+L3/saRYZiEIgkFDT7lWt3bZ6b7T1DndNE7JMRJtn0gXtdM57d0B1aIci3jlbtGg
	npWUP5yBf6uctWaYskHQM82oJZcAVRRU9WkI41Pa/ywhRbnXw753KtAoq05umEyi
	75akWk2w9/mrZtn0apY5rHKVZy9R6FHkuGMBuEkqN7jhMuM7zBm9Fq1kr4lJBNyB
	SA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gvhrem5kh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:57:00 -0400 (EDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-381250979d5so1265560a91.0
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790207819; x=1790812619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HttRteK87V8g79twx1jaSTPrE7lew+ZNw8C68XNjrsg=;
        b=Xfp1wmY/GwU5bYrn38l3lBntinZsSggL7IG92n/d1k/STAi24AolVLTeqyThD72ruW
         IaU0ofx5V/R+dXCf5eKbziaaOvT77Rjwy1+El58SMy5qrXzjZPNQWyRzgvYDDfGc1jAX
         aMtx/FMxtQ622eWM3bX2R1efLNrKHSmCY7pyK7D8dRwLMvnN0IDGbJJTKTWrEfmYtkVX
         NRDsonus8B4nz/RzTqh+52p00/bJKUsxbQ56b8WX2gBmsx/YcfkvHOX10aUdKB/XP/iw
         2sue/GWOgcyHufjpLOr7BRL6puGBacl+vsUkDMCAIrTiHV7l9Sz7x44bCa29hd4Oi2hR
         wn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790207819; x=1790812619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HttRteK87V8g79twx1jaSTPrE7lew+ZNw8C68XNjrsg=;
        b=ws9syytrWxKZQzSWW+VynDH7QpxauqomrzoKNMULnzuozkMIshyoAp39rk3Em6si6v
         VPtDmKpy9zeZxKLHhcvptSTe52mpehITrw1X1QeA3SDZEm9rVFXCTrlcRJNKzwIDuZSY
         7fxXvfoWsTEmh37c3e17VPWywuVMth5w05REv83hEnHAOTaNYkd/UHX6mdr5d1ucAGmj
         yxIxdpFD9BTP9U5DXOEc3yukYrgtrlSUq4eyo1WFd+YF2FeS6RkZPmLyBnfbMntzhQzo
         HLqaqM0mBo+nTJAo0NhpbFGOSWneV4RegYpwA7wafQ00Jwv+M6RFSHUW4D8+BoBZoWZy
         FCQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcncYueSuYgNgJBQ6iHgPK6W0fN4UT4BIxRB47QIYD71pwAHVZzKl6fvuLccu85urqi0MJpTjFI4Cu6w==@vger.kernel.org
X-Gm-Message-State: AFuF++niuPRdN0CH2CbnwwBwe3nI7rmhWiAeCESSSCr3AHyrSmPXwfIO
	5u9vIgSYmX7D/2KoChYQEVs0UIVshHcM4yExpSCJp5x57iBnBM4MkKxFbgInv66mPwKKGpWLEiF
	byX8eYgXHDcZuWhZvHv7+K/q+WjLCAXr6bSCizrUYWquLv7QfWJ0fwL2Lqtlh
X-Gm-Gg: AYBFou3ZnlZxC+Rh7SVBWxgwjIqoPlHFePNHNupnbvMjsoXnOotSrhkeK8vTPz8+TJY
	LFo7ZMMK5HqrVWCCpoWAlWPUouV3tJb8j853vIq6xRcX+MmZsyBlaldrcxgEH3YEHiv2/OSq5OH
	AtFVuHKDLG88xK39nqgifw434BYkLzq99uNFMmcxap8UD+zNGSwlDIqSBRmMYTqKmxZT4T2gq9x
	DxsVg2N6aYRoY4wtPvGFoqdq5W9LyInuaXHQItO3zXsbvdb2/CoR4fVOkTg9tCshi+cdKd6JmrB
	IYoX7oKNbOzAYSZOUFFeLVqWcR6Zn6YMmoWT8WHM8mV4bDXoqZF8bTbDOy9SNrF458rhrYDPi+6
	sPpwGyjfcTx0HqdePVasvQMlN3Gm7nk2IEpoRANymFbYL5g==
X-Received: by 2002:a17:90b:3985:b0:39e:6c69:f482 with SMTP id 98e67ed59e1d1-3a098d5e61fmr587377a91.65.1790207819421;
        Wed, 23 Sep 2026 16:56:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3985:b0:39e:6c69:f482 with SMTP id 98e67ed59e1d1-3a098d5e61fmr587362a91.65.1790207818962;
        Wed, 23 Sep 2026 16:56:58 -0700 (PDT)
Received: from [127.0.1.1] (RED-LION-HO.car2.Seattle1.Level3.net. [4.53.155.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm1331613a91.14.2026.09.23.16.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:56:58 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 23 Sep 2026 19:56:36 -0400
Subject: [PATCH v5 3/9] block: take i_rwsem for the splice read path
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-blkdev-fixes-v5-3-89e60d66eb38@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790207813; l=2886;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=+6JrzqfYyBrGC9pfDqzdgv7ta7N3grQNKoC2mDums3M=;
 b=dD7Cr3HZsDdAA+/bC11LwMS3llQ1d3sCSR6/9uZY0+P+73KAknov8g3Rkg8eZm4OsVsAKz51H
 U7kxqmE9IGaDj0C3yx5QoD1f+Q+Ez0zWFF4MgOVTY5TZY87E0SpFnvK
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: Mosst9J71r9ukY-0jkBxn_WdYuZBrLP9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfXzVniRmuJrQ04
 g2rb4bwfEWzSaPEp/sfUacvINeCy7CLECFdujjriyBPiy2F3qi5kEQnGqWxOsOM9jQhKNNfmrbX
 QrwmiAnnwtG3DLr9vALYVgjbFHkM/USheQB9Ru7eUVrxyGeFeR2IAsjxT5WIM1hyJhTEkWoqi4b
 06g7MnfMJx082fHH3psKDD0l13tZ6v9dJFjzE58NwSv5jYTQuxq9R2fyBy6ipXL7gKbDOr4IAcT
 ORrgsVoZoq2XXBWaU3xaI7oLEgU/WKI98Hu1AyqVbx6fOa4+pPvqkS0g39Q68Z3yIaC39iS50Ob
 /B7PuGqo3edv/eq6od0dUzPvz2DwQRRrTKB63Ac62QpusFU0J8lhmiaXMEHtdVOIH6tWQA28cfa
 p+tedkvA7+5CSc8K2Z7l2OdO6YEmMwOPDi9J7/Wl3ZH2y0lCX11IhY95tIs+mrkT0cMpq7RHjUd
 5N+BziwUNKYRyKpDpVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX4hwSDmhHzqPQ
 scXRlhJBAfO4dHBQ4X3286pvTd1uYa+Q1PMEh6rg8Mt5a0zQTyApofdJlUeT+O0UX2/KmWNmv3E
 6gLBHaKXIZZjH6jaBHddezx9ZEqEMr6r43tQsRhsIsCMo+EV1OWf
X-Authority-Analysis: v=2.4 cv=J/A/fwnS c=1 sm=1 tr=0 ts=6ab4674c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6aZ3Ysb2zzbY2sELL/OBJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8 a=kXXCQoMOyz17bj_MZH4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: Mosst9J71r9ukY-0jkBxn_WdYuZBrLP9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=10 malwarescore=0 phishscore=0
 suspectscore=0 lowpriorityscore=10 bulkscore=10 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230100

def_blk_fops wires ->splice_read directly to filemap_splice_read(),
which allocates folios based on mapping_min_folio_order() without any
lock against set_blocksize(). A splice from a block device can race
set_blocksize() raising the minimum folio order and insert a folio that
is too small for the mapping. blkdev_read_iter() wraps filemap_read()
in inode_lock_shared() for this reason, but the splice path was missed.

Splicing from a block device while toggling the block size between 512
bytes and 64K with BLKBSZSET hits this within seconds on a
CONFIG_DEBUG_VM kernel:

  page dumped because: VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping))
  kernel BUG at mm/filemap.c:858!
  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  RIP: 0010:__filemap_add_folio+0x51c/0x570
  Call Trace:
   filemap_add_folio+0x64/0x140
   page_cache_ra_order+0x1dd/0x3d0
   filemap_get_pages+0x153/0x760
   filemap_splice_read+0x13f/0x300
   splice_file_to_pipe+0xc0/0xd0
   do_splice+0x6a8/0x890
   __do_splice+0xb0/0x210
   __x64_sys_splice+0x80/0x100
   do_syscall_64+0x10e/0x520
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Take inode_lock_shared() around filemap_splice_read(), like the read
path does.

Fixes: 3c20917120ce ("block/bdev: enable large folio support for large logical block sizes")
Assisted-by: Claude:claude-fable-5
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 7ff78b448659..652297cd90b4 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -860,6 +860,22 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+/*
+ * Take i_rwsem to avoid racing with set_blocksize changing i_blkbits/folio
+ * order and punching out the pagecache.
+ */
+static ssize_t blkdev_splice_read(struct file *in, loff_t *ppos,
+		struct pipe_inode_info *pipe, size_t len, unsigned int flags)
+{
+	struct inode *bd_inode = bdev_file_inode(in);
+	ssize_t ret;
+
+	inode_lock_shared(bd_inode);
+	ret = filemap_splice_read(in, ppos, pipe, len, flags);
+	inode_unlock_shared(bd_inode);
+	return ret;
+}
+
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
 		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_WRITE_ZEROES)
@@ -961,7 +977,7 @@ const struct file_operations def_blk_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= compat_blkdev_ioctl,
 #endif
-	.splice_read	= filemap_splice_read,
+	.splice_read	= blkdev_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,

-- 
2.39.5

