Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDF63B7B7B
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564626; cv=none; b=HVmFtWBlXfh+KXpjOcUgtTgxEsHq6ZS9DBSRxtVm90o+RyttrcpiBc+FoOc94b5OUu7hyygKJ5CgikjYfq6Iki4KGG9RVOpoGlZKl5cGvuPx3YPDFsnnIzCzV80hr8Gr14cfZdbmt+QO1Cglr+CmhmOcAjEH0U9avPPlY3XL0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564626; c=relaxed/simple;
	bh=xdvTrLLNkhh/VNie1HKBr0I6wCWduLL9Lh+uwojAFoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l2YHEUafF1p/lcTS9chl9qL4ZKpv7ySyPHLPMXjTtMaiYOHZzi9DBfPQOAi2vK8GeamTUt5hTl2d9ZQxzlDZFe0L76WnhLMpGMC+GgI72z08mgCjRURRW3V1DhFK5YRZAekZbm9SGj3MMfif9Ot3AHo3OyzzFT6D3IYK3VCKPNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=fxhzHHvR; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ScxV2J5P; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="fxhzHHvR";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ScxV2J5P"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GYI4F3932422
	for <linux-block@vger.kernel.org>; Fri, 9 Oct 2026 12:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=UxC4
	2J9hWjW5KsD4TB2Zh7izZ1X3VipEtKIilECW9Gs=; b=fxhzHHvRJYZRJLkIFrmY
	5T358/S67swKEemAYgjfR6piavFRpBVUxVXJfPLu0deYbmhS/GDsd6nV0qP0aYkj
	QUcveg9BBDg7GZfWd1ExfUBgwRj43iynQb2lsBYCfLylni1voW80duP27imsp8cD
	8ufToG31tUzxeH6A8D7dLS0HPhEKhaDelFFL/raORv8CywaLqtU+SQcgc+lvSFNj
	lTYtxCVEueX5AJ6lJY68rtxR4CliJFvp7WF7Qsxo3j5wWSLNh2vAbkhOwIKNMcA6
	iLcpkZLaw1pvt2YZ7W+yHaY6n/ercF27/Zc4MN4l2oQFt7HYVwj6483UcV/y9ZJy
	cQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4h6vkqbefe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 12:50:23 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5339253dc3fso145679191cf.0
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 09:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791564622; x=1792169422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UxC42J9hWjW5KsD4TB2Zh7izZ1X3VipEtKIilECW9Gs=;
        b=ScxV2J5P0mQFZxK+NQDuuQt06+JnsBS5zzIarsyTz4UPrMIyGZD4+QbJJNsQDV7y+2
         jHuR+SRSR+Eg6SDv9daK58PbkJKSnmew7q3RghpSoudbsRE3K2QZlhKRU1b+y0wwoqxi
         9owITtq0TRSEMHvFK1TlR50v8V28Tt9NCV4pFSuSl0iTbxdpAAL2eC63Zeq2OUtmTwoY
         M55VqsEjhqALMibl9u4dyvYGdWfDoeJ+si0TbYf9LFJCpvPfm1GrC4xypQ5KHkm2FpEe
         ftnq0YzHg4u5E4cYRhkVsTTKJDzrMNu1VMRd2KeBVxDm0jfNVgo7i++EoqnzhkadEePT
         GH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564622; x=1792169422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UxC42J9hWjW5KsD4TB2Zh7izZ1X3VipEtKIilECW9Gs=;
        b=HZpaxcAJZRYfiKydEmS/afMg21qq36OrOujie63rKhg1cYbIUS7+BLLnT6TKf9bz/R
         ZLFrxs4YJ04J8RWnY/4nNxUJFxTa6fab+eR9qjgc5AcBcXjqfcqyYmCni7eX11XduxLg
         Y3lw/fbmNppMT9LdxEKfSRKsB2OuCmP7eoyywlv2MXi5OlfJziIhe7DoSULrmTuE2tuF
         hiTbe3pirAl+1sMexDNo6xHekRyKGejt16A44SoBNxRPOX8qYD+dMU9ohsPG6jXJf2A0
         LXsr2rBXnOoCuLbWliixeAifvr6KEvW0c+vfmMXTV6ju6vZGWtom0hn2JUyReADf6v4r
         RaCA==
X-Forwarded-Encrypted: i=1; AKwUvBwJHsvcl7g/9hn1bpgxAnrZwqEOJadpyq4m/9SHi0cOf4YJ/jzW2EPVAEsbONcHEgrZBH3rajQe4jMoIA==@vger.kernel.org
X-Gm-Message-State: AFuF++nrqp2JkwGi2Ie9dR/xLAPrf46TLRtFDdLM1BZgkFN7cYhVwvHi
	Wdk67lC8OKpLK46YMIsf0J8V8jA/Xa2KKmenWpXo0uVmoQ1NXgaSXN5u4ZbXPAMiM5a1WVK+4et
	DvirKLj2SLmhk9CTxKmLTWwv2jYyS5ZGbYKh01FZeLYQVS10alzzDzljnzUI1
X-Gm-Gg: AYBFou0b85Bpc1i9vRiD3t0hgHBQh1U9t+zxNMFo9MUCW0geJnP9x+trrmxFoTNNxym
	nsg75+PyprILo4RuqZqtVFw25vg0AAxovYUuUTmZxBESs2+IQvbAQjEcHcw4Wy/Wn/EyiqnLX+z
	rZxNqhvT/t9BDR0AH2hoUKMdKa5it/hQ/BTDJwgYioznICOtobpfccZ755p1BQiAYZpqgk7POnh
	+zFKfD3oxuX2pJcV/VFuE/xgkJvAtogkI5B+l6NCSSr+F6Dn/okVsbxthygdOgOYhqHLDFsLVmr
	UYLD77/RQpPauD3dqwGMsY5QZq/03FDV84mvTzZY4bcfYIw03D4eNyvO6jVk/q23NRzzhNCJQTK
	KtTnyk3RxlWTKFdqp7BZE2WK2LIUfSIYSwWtQyuA0fPPQvHg=
X-Received: by 2002:a05:622a:2483:b0:534:b7b2:6353 with SMTP id d75a77b69052e-5359fdcab5bmr34976611cf.56.1791564621949;
        Fri, 09 Oct 2026 09:50:21 -0700 (PDT)
X-Received: by 2002:a05:622a:2483:b0:534:b7b2:6353 with SMTP id d75a77b69052e-5359fdcab5bmr34976201cf.56.1791564621494;
        Fri, 09 Oct 2026 09:50:21 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b77d0eesm22234701cf.19.2026.10.09.09.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:50:20 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 09 Oct 2026 12:50:11 -0400
Subject: [PATCH v6 3/9] block: take i_rwsem for the splice read path
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-blkdev-fixes-v6-3-307939c387df@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791564615; l=2887;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=xdvTrLLNkhh/VNie1HKBr0I6wCWduLL9Lh+uwojAFoU=;
 b=0DVWtwMl4wsi7+jJcHHGeA+AlLkkvxb6Jkr/lBvb7bzhr+NsN0nmUXaOJB0k5WE+DI+dh8rxn
 kNvPxKcALCpDFiKIM74BqIosqqq/ghwO5ckLKsjqEODWHtm4w1RaWls
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX3hnaQBLy5HMM
 YOY4bsSD5mwWsTiepEZGBr8Xy7DQoupDZGM+9q5v5yhggzkZyxAXJlV5ry6eCaS5GsuPQN7jM40
 dob8/CFmdFxmq1GmSb1ketHwkuWyyElG4XfaXh7yUt3Ud8aX/Moj
X-Proofpoint-ORIG-GUID: NMOVSgl7GLI-OVNt4hgxOFLwikMSHtUt
X-Proofpoint-GUID: NMOVSgl7GLI-OVNt4hgxOFLwikMSHtUt
X-Authority-Analysis: v=2.4 cv=JaUpPkKV c=1 sm=1 tr=0 ts=6ac91b4f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8 a=kXXCQoMOyz17bj_MZH4A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX6NyNa19qK/lE
 +9OTl/DbLcayfMGJQAN3VJFT+oyPkHH+MZc+qgYHTM7XlqbwjeXFfAOV2ZkqoTLQmtf0ps30BnY
 MvxrBnhPRQzuUG4Shu1G9poi8sTRCI5IS14/EFKixdcgFyYSoy278uoYLbB3oTidV/1E/5Y3nHa
 DPh4UT5Ppjel4JnnHa0mgGuKCxGFk4dCVyf1eHQqkv2MALz1PUT1GTKOS+IX4cdhx4Xh134xWuG
 FGWprdSi0m26+7qb7g2LZVFGAusMvM6D7eUkiBVy+nnoUTeWcJM/IlY2wHsp1LGitOvNPAPtDK1
 xhFDwXaYXFnQOvjYDrdrhm7A5AjJ3zPoEmVOwDbFqTD9QM1SmG552P6MIIystsBVUqdYuuYPrq7
 rUKvki7CSncqgCXrhmf1VkZ97YG0EAoXA/CqBsS4ZWldQwbPKyE19PRoC1GTf/NvdfncielY9Ea
 bPg+9CMkPqNcBIhcRLw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 suspectscore=0 bulkscore=10 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=10 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090067

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
index 52ebf5bd1443..9c556bd08c6b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -883,6 +883,22 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -984,7 +1000,7 @@ const struct file_operations def_blk_fops = {
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

