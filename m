Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E09E46D558
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925026; cv=none; b=NnqnWADkaYcmpdWoCeghZgpkZodLDb9Fq6XhRc62X/DmOFMBkNQJbnt770zZ/ECjvF2eSTkVVnTeknSVJiI/7kL+QUdSlh8yDdkuy5rhBgjjj6doRs0hcftv4S5ZscTmQeM0cpeFZ6sBv38bqqwTXreyyrEWGeHlxmlicLoN12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925026; c=relaxed/simple;
	bh=nGU4ZTBzn3aF/jEzn6TEW4RsPtGSLYpYxrHIRAT6WO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YYnhf5i/GI0dfoVd4Psmjrz8MWg24tP8iXdHyimlDtCIWgFbXQmiSaXjGemDLnk9Nvy1zbOTlhM+5mFkNxi9IaqNqn8hIpp+U4OJUNPoOWgBet4MRDpcR6f9OOabJFCp/r0Jf264BtJBGX1G1fpnJiLRbVklMkuH3obDhVNTuOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=TC65GV9a; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=bGY/GjW/; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="TC65GV9a";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="bGY/GjW/"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SCYFI81743342
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 09:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=PmAd
	iHxzSpepwE7sbIhm/WAFwGYto5pQ5mrP6+6odVs=; b=TC65GV9amv0ybweYpxjY
	csgQTIoXkTZnpuqh4eT0cub/2HuHY1pO4Jl+kjN4F3PDrkM+omsW3NGTB1DZWfro
	z4/glTqx8M2mLSQnaMOcRm4uCwn+IARNq9yZRUBfBa3irNoB2XSezklKFGFsItGc
	irOr/IRuamOhpwp1Id1hgwEjVypAPPEvy3UD/2UTdSlhgH6fnLhuX8kw4zHj3DPO
	g/mAqJPnYUVEo7T5UOvls/oZLDFqvitMsZjJrvsO4qHgZwidtsE7GPhy69QuxowW
	PD7x/KkJc0oFzMXMyU2OWKADs1GlK3C3/e+fILkIYgC1+Sv/Cml8m1+hEgDZN7dJ
	zQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gaufacg0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 09:50:24 -0400 (EDT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90cd474a7d0so23849886d6.1
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787925023; x=1788529823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PmAdiHxzSpepwE7sbIhm/WAFwGYto5pQ5mrP6+6odVs=;
        b=bGY/GjW/sM7i42PpEM6mDY0AsVUrm8w1GBzQdOY9CNF7P4nTCL52n0zknMcSp9XJ5s
         Ungt1Kh93I1QnyJoPk7hPoSr9tJxyEIbh2zR8OxkH4N5vFQmyFbeOtQcMhBYebb1Djc4
         V+MP0cRBLKJRCe2xhs1CIe0z7Xa+OJApIRzeo+EXwfm5moezAIBXV7Esn/v96gkZWUPI
         OSz3AlvdlCr1Uibugy/udo2vQn7Jag7wda0AsZX9uCDEVj+SWfOru0yEsXTyeAoVKAvr
         pXUTFAiSxI5B+3wq+l9vCM2sYqeVExurK828KinHDrMjMH99EPbgaKUdWkd23i8Bs3DK
         UpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787925023; x=1788529823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PmAdiHxzSpepwE7sbIhm/WAFwGYto5pQ5mrP6+6odVs=;
        b=e2ozHlT5ZnztOu4qqg5AqKh4DtVyS+PBZSgJrJVYmvyw+qSAW4V8KJwEmDUlWiYVp1
         q7zs6n+QOqKREloUux2JStLUlMPo9hyLK32/SzBjfsKOA/z4/gctGEgjdU5Vz7xoSiK/
         yymg034plLcNgd9v1Y6a9ZaBFj0W0WSlQdMaa2ghmkFpWEz20NlLMYcavQz9IIguIbiW
         at1jVyXC+xKaT8TUV2z17yuW8DsntjrQYy3EmTqLJ2KUMJVYd636DKP/bUegQw1idFp2
         VWxb8YfSddr1YTe/VIadaUZ66xTgQJ7Hklgrhs6+nxHxsXDTj2iRJee1WocHEFePy8/d
         248A==
X-Gm-Message-State: AFuF++nKUz2BwjO/O+xElOiezgHEk7DR3mlEeUJ8Trkn/WhwpU9reD70
	jEN5gKiY32/jYIlX0N46RQsISNo87r6YA2ec6/EdKTnO9HQtLc3Dq0h2yZAaG4VAK7t8GtW3nZ+
	amUkAfjp3SOhblF356YeGNbGIORiMDCD6p6G0aHHH3VgVkB6LXKY0SZ+DvHr/
X-Gm-Gg: AR+sD13rLIP4rTJ9z9kpGr6sZFzaVX9S4X/Pw3EKOKq2Gnh+6dyENxnkDsivi6FlGGn
	2mFgRxyK2CfWjXgX4/12nm9gv8lrzrHU+D44TRI20JPpnU1zEQYPGR2uM9Be/K/i9yg3p2oTiYn
	uCJfLh+HyfhEppkQE4iLTGPKO9fDlvZY+yjYGHCzBDIMjiRln2X9sbUSF5g41OzUizHdhdaFrBR
	6mO61Y3Sk/ZFVyoEgcWEMe5gnDknd4GfHOk4eAIlT7dHMF3Kq/67PoEIl/8lJwHnKX5ttRyxdin
	ZwfwLubWlvdCSu8tIL0VxZOF2eD07Tes4adX2tcomJ+ozKcMqz5pOvrWHsijQNtgnTVsdLfUdLv
	wc8qZdlVf
X-Received: by 2002:a05:6214:ac9:b0:8e0:7d6a:480d with SMTP id 6a1803df08f44-90ce0ef6619mr87721696d6.20.1787925023187;
        Fri, 28 Aug 2026 06:50:23 -0700 (PDT)
X-Received: by 2002:a05:6214:ac9:b0:8e0:7d6a:480d with SMTP id 6a1803df08f44-90ce0ef6619mr87720466d6.20.1787925022388;
        Fri, 28 Aug 2026 06:50:22 -0700 (PDT)
Received: from [127.0.1.1] ([45.130.83.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce4534ebesm15645116d6.48.2026.08.28.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 06:50:21 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 28 Aug 2026 09:49:52 -0400
Subject: [PATCH v2 3/7] block: take i_rwsem for the splice read path
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-blkdev-fixes-v2-3-32f3f40cebed@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787925005; l=2730;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=nGU4ZTBzn3aF/jEzn6TEW4RsPtGSLYpYxrHIRAT6WO4=;
 b=/8snr6j3GY8v39lMzgXuQ/x7S18viJt+QLVqsA+fl4DCUganenyyqqCmmqwEjPNMi2Rk+EqXQ
 ESt8PK45Y6BA2Zv81gfq9v91cHD9J2xm3At2MJuNXIkxnwhdtd/8yAE
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExOSBTYWx0ZWRfXxtJL8D5x9waK
 ZkpF9r9AMIN0CCxPz9SFaqK9Pzfwu+0D+6hkJuw3XhkEdEhg9x5WX5IbBhoNDnz/phX36Xg2Ioi
 Ftwk4MjRUoCJawnShrIiRe1mPI9v6opwWaXTMXW/CyZdN5iOPyMFzsAN4xNogHhJHiYMP75hQPk
 aQIsqB/nwmbTLM77OqJ/QMhaZikHifFrkrQnN/IXVwkf12kl0c9iglRRoVu/4wOjsROszhvRrJ4
 ri1vieJtcYcpmtH7epVia3mqYpCheK0mYcy7teGi0/ZaMUvl4wcJHXSNnJOM79ylpsewLhodQMZ
 iU4AXYOuw+n3qpPJFNoum9o7MA8bKrU0Hu8hKr+tescnZc1DEz6pbQYxRTfwZ85bZsmOSPF/11k
 OupfPjTFhgK/NR1Hksm7DLtDhexjYD6U4/lu6fyH5mDN4J7Tzah3UlealUnnspO+M49OYoLTyjZ
 RljAkjwJmYLTimlSGfQ==
X-Authority-Analysis: v=2.4 cv=PIc/P/qC c=1 sm=1 tr=0 ts=6a919220 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xDWFIMX55ayQNp92vt0S/Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=kXXCQoMOyz17bj_MZH4A:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: nLvhFVz7lUgS5Yk-h-oAqJMcKY4rZ-yt
X-Proofpoint-ORIG-GUID: nLvhFVz7lUgS5Yk-h-oAqJMcKY4rZ-yt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExOSBTYWx0ZWRfX0mHZK25GpAKR
 SBvWQWBJ0P+FZ9KzKP9pigdipL3ikamrzbHWf8qVinHqWdu1eoZAl3Th3ykQMQlvttLuomS2Y8s
 0uZvXZ4WKb3LKySIcY5q5r/lLNrsE7u5TE28LQ5PxVR0/R0M1HC8
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11888
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 impostorscore=10 malwarescore=0 spamscore=0 bulkscore=10
 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280119

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
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index d5f569333f46..a51814821100 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -855,6 +855,22 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -956,7 +972,7 @@ const struct file_operations def_blk_fops = {
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

