Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBCB349AE6
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210493; cv=none; b=ZdRwbSGfO3NhTJ4WyBC68wyGFrgdykwDTupA7At3RKby4wCROknVBprcICmNhF/fzmd4mWN2VW0vbAu0uKxFttP0RaG8NNwguta0pTEE0v4mWkCv2B9fg2KrSfCWi1xegxtG2OZIK4C/GrIyC0T8MYXQ6ZbJ9YalSSdt24LgY+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210493; c=relaxed/simple;
	bh=8jgmldQQbiZzzlvIZlNR4V+9tVlk4w4gZb+9NNCt4y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=efdodg1o6VbDDCLW8/XMPu59YKVp/48p8l1c2VjGQWKjCsIe6j1X0FAfMi4ObSvyiCMuXEEaQwr1tgKURdZAwM7RAjQ/ei6HLxa52remYAXl/D9bxei15uROUFTruMQEQe0pgl2K9hrCeNz7H/X2gcQNC3QXvwuCAYagTfne5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=FM/S0CDV; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="FM/S0CDV"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RGNiIA370506
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 11:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=jlmO
	HeLoSvLjpCm3jD8iWkNqxE6EJRsgaFZ0qUuQgW8=; b=FM/S0CDVVFMCT2m5AUDa
	OOFumevWors0oqq7hz6NDLRqsjZtbb+w5BQ34v8yQEwnu2n3lFDEfSqldvNdyEVy
	0ssJO1dDpY8qCk/RgAEmRv9cXwhX56TmsPpwK4nbJYDN4nSff3IfDhbhsLYAclna
	Wa9ga6InnhSRmJ6NqTfz3rMX4dn8n10S/ZiNAU2oPM03q6z+vwwi3+12ndvaO2UI
	lNMKkL7HOaAdQ4Dy6/B9jZlMgvijA8cLlRF0LBz7KRFliypGcf/fvzkS4yCu58IS
	MFNX6vcHiPcShCQ1tg+ZVgP13MMzx1HoK5G9VTgkW41t9/55kWsNz8lehhk04iJY
	BA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4cjrj28ph2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 11:41:29 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c70ab7f67fso2527127385a.3
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 08:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772210489; x=1772815289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jlmOHeLoSvLjpCm3jD8iWkNqxE6EJRsgaFZ0qUuQgW8=;
        b=e+SEyx40E6OvEq1RJsIHxhsNOmnNL/zLabR49PUa9VWdGcYPcDaF6vYUB7lIatXomj
         P35SJE0vfwxh4kbvJYSEUWOF5i1Iee3XQyInpYKQihlxAYKX52uG8IglOvwyMN3ys6fc
         4RnO6es4ShQVFeKOUq4vDzxRMO2J+9UNyMjLmtmU8C4TIkbI35ZmVYyPhW1qyOssDuau
         /ZmmMsh8nHKsUFQTdmwKEN/VT1FBRsZ9e+QkPz9xr+Eduq3VXuA3jve0C2kAiRB7UQbq
         MiFIcFR0qSH0qe7of359imMqVLGYW4iEEAk82a6JT6xIQhpZnjZWhjdLonya5m4Un7Kn
         sLbg==
X-Forwarded-Encrypted: i=1; AJvYcCVwJ3WV6cDwpLiBWY+zZ81vXiIDmvue12zrR0bi0E5KOKwVZ3HyvuuFdp8wqZ2dmbViNmNi8W6vzcUEIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkmLYau0pkyiAksEYXP1PQop8NVhKMHQHr3FGVeVzMHlkBQk4l
	982btwmy25j2OgqAhf6KjMSkX24VeEx2QIDXDvA0Z6gdUV14kGlBknjgoJksUBeaFJ99dKZE3gg
	8OI2IQAQHJZpBqWAlL0G9SrXLWcUIEpAYGAe4tFShDcVod8Mv8IeBQJyEGa81
X-Gm-Gg: ATEYQzy7xAeuzKIPC/5Gu3t6eT6b3joidRk0Su4ozkETEuCa/AILnsL+69pGN+9WyUB
	8SIEFTwmACa/SxRIPaXGwWcvFzl01UkU+L3kpHy+zYGbw0NTjyscL2fZrUNcDNZThsORyOyRDm1
	V6tnp1TCBYSRgNuMo1nH/6qbtEruJm076N6t1XJ4O8j6RBfdDt6TK6glIWvyjcaTe+ISUSdoSIk
	0o3aeZiCoka0CcGX3K5azwOyKvsYqo3uUrx/hLCntqCl/JB6GALsGym3pguXEMN4Ce6VA+ibMTz
	1gsKwIUMFYFwjh4j10Znev/gVn9Ov+lQLhU8JODuEK8GeV+tZq37X1ZVdiRSkqD3NwT0qlTYQOA
	XqAznVSBibFrnHwyz2g36boeqIpyPKWTcw2kK1xHPnQ5uEGNNrcC3HvbC8eeXAq8AodU=
X-Received: by 2002:a05:620a:454e:b0:8c6:e11c:5ec4 with SMTP id af79cd13be357-8cbc8df8884mr430465185a.35.1772210488685;
        Fri, 27 Feb 2026 08:41:28 -0800 (PST)
X-Received: by 2002:a05:620a:454e:b0:8c6:e11c:5ec4 with SMTP id af79cd13be357-8cbc8df8884mr430460585a.35.1772210488048;
        Fri, 27 Feb 2026 08:41:28 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716caebsm46535886d6.15.2026.02.27.08.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:41:27 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 27 Feb 2026 11:41:08 -0500
Subject: [PATCH RFC v3 2/2] block: enable RWF_DONTCACHE for block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-blk-dontcache-v3-2-cd309ccd5868@columbia.edu>
References: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
In-Reply-To: <20260227-blk-dontcache-v3-0-cd309ccd5868@columbia.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772210483; l=4224;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=8jgmldQQbiZzzlvIZlNR4V+9tVlk4w4gZb+9NNCt4y8=;
 b=vm0JkGcE+Uz0XFcsWwyvUOREbVMTCc75ksaV58G85KW5Z1ue6w4/8TqYICgOvWLed9AR0ZKdg
 MXRWrkfiaqjDOu1E1bJGDUJ5l8zmf/6G8O+4wBj6LctSBz2MF/pSI8J
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: bklrKalCzO1AfYq20iL0RldChaaDjzSD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE0OCBTYWx0ZWRfX660iiP+zum6n
 a8q+d0IXd/TDrd9t/eIfzm5AAI5P5Z/UgGTojsTEuNf3eRkyACAA2F1FXvjNzLLRKJOpJMvR44F
 KVryBhBqmW0gZJsNV1P67f2ttCwHoKlBvTDTllZRcO1p+IOS9zmYKRngoxlSlAZq8ihlyy2duCM
 pQTCu+EWgNoJwA2+T0ogKpqn/huN/bFBgLq2+G+a+GKPR21glwxg64n6bBv2afvY0q+49gNwJDH
 RF9KFtazn7+6rKic3OA7eqlwBkKBQ7YqjrwrcYK1Ogf6Gqb+9h+H9rp2yxG0w6FhgufpAPjIu7m
 23UA5ixD4QzGyWfuwgeIHYzpSwaYpy95DnEuvhjNTPNN7P6pI8nUACpVKgdFBMeenTQCtDofz7K
 WSn2TOmoenSNil9cj3lIg9WcPEwCXN1x1AanzGjQVzEXFGriVElh36XNxLhMOY6TVx8dP5mBLDW
 DDrmiYlhEQxrV0eAucw==
X-Authority-Analysis: v=2.4 cv=Sbv6t/Ru c=1 sm=1 tr=0 ts=69a1c939 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=Kw1KkKa2aV08GXngiw4A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: bklrKalCzO1AfYq20iL0RldChaaDjzSD
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11714
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=10 lowpriorityscore=10 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=10 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270148

Block device buffered reads and writes already pass through
filemap_read() and iomap_file_buffered_write() respectively, both of
which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
by setting FOP_DONTCACHE in def_blk_fops.

For CONFIG_BUFFER_HEAD paths, add block_write_begin_iocb() which threads
the kiocb through so that buffer_head-based I/O can use DONTCACHE
behavior. The existing block_write_begin() is preserved as a wrapper
that passes a NULL iocb.

This support is useful for databases that operate on raw block devices,
among other userspace applications.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c                |  5 +++--
 fs/buffer.c                 | 19 ++++++++++++++++---
 include/linux/buffer_head.h |  3 +++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 4d32785b31d9..d8165f6ba71c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -505,7 +505,8 @@ static int blkdev_write_begin(const struct kiocb *iocb,
 			      unsigned len, struct folio **foliop,
 			      void **fsdata)
 {
-	return block_write_begin(mapping, pos, len, foliop, blkdev_get_block);
+	return block_write_begin_iocb(iocb, mapping, pos, len, foliop,
+				     blkdev_get_block);
 }
 
 static int blkdev_write_end(const struct kiocb *iocb,
@@ -967,7 +968,7 @@ const struct file_operations def_blk_fops = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 };
 
 static __init int blkdev_init(void)
diff --git a/fs/buffer.c b/fs/buffer.c
index 838c0c571022..18f1d128bb19 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2241,14 +2241,19 @@ EXPORT_SYMBOL(block_commit_write);
  *
  * The filesystem needs to handle block truncation upon failure.
  */
-int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
+int block_write_begin_iocb(const struct kiocb *iocb,
+		struct address_space *mapping, loff_t pos, unsigned len,
 		struct folio **foliop, get_block_t *get_block)
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
+	fgf_t fgp_flags = FGP_WRITEBEGIN;
 	struct folio *folio;
 	int status;
 
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
+		fgp_flags |= FGP_DONTCACHE;
+
+	folio = __filemap_get_folio(mapping, index, fgp_flags,
 			mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
@@ -2263,6 +2268,13 @@ int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 	*foliop = folio;
 	return status;
 }
+
+int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
+		struct folio **foliop, get_block_t *get_block)
+{
+	return block_write_begin_iocb(NULL, mapping, pos, len, foliop,
+				      get_block);
+}
 EXPORT_SYMBOL(block_write_begin);
 
 int block_write_end(loff_t pos, unsigned len, unsigned copied,
@@ -2591,7 +2603,8 @@ int cont_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 		(*bytes)++;
 	}
 
-	return block_write_begin(mapping, pos, len, foliop, get_block);
+	return block_write_begin_iocb(iocb, mapping, pos, len, foliop,
+				     get_block);
 }
 EXPORT_SYMBOL(cont_write_begin);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index b16b88bfbc3e..ddf88ce290f2 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -260,6 +260,9 @@ int block_read_full_folio(struct folio *, get_block_t *);
 bool block_is_partially_uptodate(struct folio *, size_t from, size_t count);
 int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 		struct folio **foliop, get_block_t *get_block);
+int block_write_begin_iocb(const struct kiocb *iocb,
+		struct address_space *mapping, loff_t pos, unsigned len,
+		struct folio **foliop, get_block_t *get_block);
 int __block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 		get_block_t *get_block);
 int block_write_end(loff_t pos, unsigned len, unsigned copied, struct folio *);

-- 
2.39.5

