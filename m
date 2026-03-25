Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D927EFEE
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467046; cv=none; b=imtHqLfz7cBWT5DXSFX4535PxgcpoceWlcIOcA0aGqawn17qqCdJRaFBDaK+ZqCf4oizzGuWFqy3KYQu3b1KZiAsJGFqBidkj4D0mZqRkFj3g+ExCuLmiLYvBEaxb49V/WZsJ/dd5Mh07jzteXKJc+BD2MzjgqvNkp97v8vRSaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467046; c=relaxed/simple;
	bh=vqYjVe4t0i/AiFArpSZ9mEXLlU4rnE2ZRBBMSnozEZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=taZ8pWcWpdwc3JAnbLAkuDlsr2vziWFu+xsRLoQNEEpVtrDB2QKM+FN/nZ1aSTk2KG7PVQa9BeUirc/5Vy1pGoUfq5VzS5VWygtivXcAf7UepkNsCTY4KqiS4O6m6/dE1h2lIwM8FktCYxpbZXWPTzIXwGruF4emlrH1MqhklQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ea/7FaAK; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ea/7FaAK"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PJSXrf853718
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 15:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=S7NO
	oLpQC1gt8jjGEOFARMhStqFULmtQPTxyzd8Tw9E=; b=ea/7FaAK8Ey0iHDLieZh
	JaXjXfGGE2bKSByCc9yYFObbNVPoP9alZW0vtMBixLqg5f32Dju0WDS6uTXT3eXy
	qvYw4/FrDejFY13IpjVYI3moVgbwSjYbbxC5UOLGkUlH2FoRntN4o/kTvxSGxFp9
	DE9S+soik1w0p5Wq4ot6+xmq0LkOsfACEmrT6/HIlrPe9nRH+wPx8PC53LpHHlDV
	vvUbRI3Z6LpVVzSc5+/kTomyKfTNMxPZnUoywlz8boe8S/yS7/b1g/+omNpa2ILc
	4BOgd3nQElfvurH4Eh1YjcEnvJl8NRR6ahsvFYdr3OJY6rSSBvWWoPSRyUx9wQhl
	Iw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4d4cqjmucv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 15:30:44 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5091782ab06so12829871cf.0
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 12:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774467043; x=1775071843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S7NOoLpQC1gt8jjGEOFARMhStqFULmtQPTxyzd8Tw9E=;
        b=f5djVFG2IgDPp6IJNjgfnfZNC/8MJbzDYVoQPgwDx+M33Q1WMFb1ncg3HVWecKapWM
         i6gyTPQjg4VSiPKMvJYciXSXaJEDaqP7g116aWvz+cG9nKqii+OPo6R/upSCpowbvpLC
         ffs4F+fhkYkcRGgOygAh9+EGrwsFpY7sidmCsD7X41HSM41cs2imScqwDLGIh8x2C5W1
         lz/liI75VpOgohi2gGdvHE9S5jCdALBRUwrSEgVnlqrC2wHUC4R/QyvGt0NxJmBlx/eG
         KTPYC81USoRyJe7O9U1xMdLIH5/wU9R4fzMGPwv27bWxrJ7wLeFwi6WsTzFYVNj4eNCu
         qALA==
X-Forwarded-Encrypted: i=1; AJvYcCUGQitQ7A2W28bedD4b4yu8iRreU4QvYu4yoVpkYcbBKy3cbBozF12b2mC92HWokQJ7zF1VtbYftEYnLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwowRsxDB3jcEiegaHoSbZMp6yVagummpl0Hs7qNeFxyISjhRDp
	796J8h0V3CZFcbsztjgzu/xwB/1Iv/v5j/C93gS6eIFeF/ZcjGhOdkaDgvKC3cKdxVmGXvReRac
	PmywpJ5ViqX4tTx9st48owEbxa+kgnIoy3PFAYvfAAz17po4XPOitBgJ7KcV4
X-Gm-Gg: ATEYQzx1tG9FyOCUUUWi0//8sICBrfsEiiKc7d9g7BrVhrM0ppRy7+Zm8sRreAgVUBi
	17IJxnt1Y+rcERNqApJ42Ks5oCcxehzlfosHdH+DqIfXZckd2ieOGe0qKzvcSWakkeWtr59Fxul
	ueeOMexV0erKxEkeewiB6xnxgkMoLLGmFS/SUZYftiZ7futRr5LIRlBIQE6CIOIY5TAxkN0ifCU
	M0ROYdSuAcCnEMckFb5u6MaoHK2qC11iGTbtDiDENIlR4o8xKC+lVUDtAMb8dOqq/GjO4JsF5IW
	OyTNf8EY699BdOkA92bTsk0F60ti2thj9xjReGTtrX6RWlyPTxF9v74WiiDl9cI1xYs3W0yFA+0
	j2nTblcoMOefnG4mMhh9vZl/Tv1lGhIG3wZ/xNw==
X-Received: by 2002:a05:622a:4d4d:b0:509:23c5:328f with SMTP id d75a77b69052e-50b80e66e14mr71159931cf.54.1774467042898;
        Wed, 25 Mar 2026 12:30:42 -0700 (PDT)
X-Received: by 2002:a05:622a:4d4d:b0:509:23c5:328f with SMTP id d75a77b69052e-50b80e66e14mr71159101cf.54.1774467042206;
        Wed, 25 Mar 2026 12:30:42 -0700 (PDT)
Received: from [127.0.1.1] ([129.236.226.199])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b9234e3a3sm5534221cf.19.2026.03.25.12.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:30:41 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 25 Mar 2026 14:43:02 -0400
Subject: [PATCH RFC v4 3/3] block: enable RWF_DONTCACHE for block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-blk-dontcache-v4-3-c4b56db43f64@columbia.edu>
References: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
In-Reply-To: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774464193; l=4833;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=vqYjVe4t0i/AiFArpSZ9mEXLlU4rnE2ZRBBMSnozEZ0=;
 b=gpmN0bZuDH/LOZGTVX2LWTAbwaNFAVtx+0hCaa/06cmF7hrJjYYHDM3SkZtVNTBPzJKHCu1Ro
 uxYVg0q9qKMB8UfKgMIhJOiUIQQkEPxysztQm+QmC6XaBib3Uj2eKTq
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0MiBTYWx0ZWRfX6Ul1IIGj0RXt
 ++oRbwyvQX1Gur6LNQiH4wRS0b7ZOTtpLuWWWzceAiKXoj2oJ7jNCMjDZ5Ij5vCkmXTcJ1wlvEs
 p3JvcNB3POiukJLb30yTOYGAMf4/83bdfcQkgSjHPgALtOqE1AqvNOMnnxzvaiOB/KH2BuFF659
 sxy6P+zKqS+tl4MaQm9g/Y7wdPXaPS2CplMirRPy8BS2rzigflBgtl1bIqfIqTJ0gCnu1omn+R4
 WrBJZxJOns+4ABp6CjLGhg6RF+f0aU7Jwh7bcVlziQ0GzusUufzski8SWpXzEVRkOW3TwZrBjIz
 ubDD75d48lYKjTV+pMp60p9lZ3I8SVWMaoqaw0LqvKz0j4uC7a8Tkpx5R7xDeAzFSkznLdnNt52
 lTocV7KxjLXvZzqAu9b4y2sL3GMUsN/T/516XuQBqYKcwCHknCq+uZWVYk6tfFqH9ENtGAk6ACJ
 O+Q3T9ZkIl2bNp++hLw==
X-Proofpoint-ORIG-GUID: xAgHvK6HUtTkyw3j-qL4EaySOH1Uoeim
X-Authority-Analysis: v=2.4 cv=E57AZKdl c=1 sm=1 tr=0 ts=69c437e4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=QOUmeeuX5y9IvSxXHa6D2A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=KmSSIXLuV57r0wwE8Y4A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: xAgHvK6HUtTkyw3j-qL4EaySOH1Uoeim
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11740
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=10 spamscore=0 lowpriorityscore=10
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250142

Block device buffered reads and writes already pass through
filemap_read() and iomap_file_buffered_write() respectively, both of
which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
by setting FOP_DONTCACHE in def_blk_fops.

For CONFIG_BUFFER_HEAD=y paths, add block_write_begin_iocb() which
threads the kiocb through so that buffer_head-based I/O can use
DONTCACHE behavior. The existing block_write_begin() is preserved as a
wrapper that passes a NULL iocb. Set BIO_COMPLETE_IN_TASK in
submit_bh_wbc() when the folio has dropbehind so that buffer_head
writeback completions get deferred to task context.

CONFIG_BUFFER_HEAD=n paths are handled by the previously added iomap
BIO_COMPLETE_IN_TASK support.

This support is useful for databases that operate on raw block devices,
among other userspace applications.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c                |  5 +++--
 fs/buffer.c                 | 22 +++++++++++++++++++---
 include/linux/buffer_head.h |  3 +++
 3 files changed, 25 insertions(+), 5 deletions(-)

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
index ed724a902657..c60c0ad6cc35 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2239,14 +2239,19 @@ EXPORT_SYMBOL(block_commit_write);
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
@@ -2261,6 +2266,13 @@ int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
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
@@ -2589,7 +2601,8 @@ int cont_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 		(*bytes)++;
 	}
 
-	return block_write_begin(mapping, pos, len, foliop, get_block);
+	return block_write_begin_iocb(iocb, mapping, pos, len, foliop,
+				     get_block);
 }
 EXPORT_SYMBOL(cont_write_begin);
 
@@ -2801,6 +2814,9 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
 
+	if (folio_test_dropbehind(bh->b_folio))
+		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
+
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
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

