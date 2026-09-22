Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40CB3AEF45
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045675; cv=none; b=Hn6m2MOaswAISeRSRRG0danbuMa3Z0u0+2XZNW9cIZkKhLdQeNcykckq3tCaoLQaN6CDK9Z3QKesjIkbJniVIRBWoE6ca3L7q9uIyIBXxSexRTHCNsoThJJbTYV7DQnNkESCdU1iH7GfUr+w97EVwDd/2aAXYu44MKd3NPyOjk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045675; c=relaxed/simple;
	bh=hK0Uz7nHtHESSVhEzTWW91QCtYxv5e3ePGfGSFiFjUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnFwMv/drBYDQtEQ1GfCGj7lL+xFekl5n6kmPh6BqpxYW/Ty4KTeF0rTCXF4puLQ9n+KfiOYQa/h6p7P+JhxXjdNQP8+JNpdFiMWUqJZ3t6ow3LhH7MlCawmqmZS9s1US2GLsvSbMXfQnpKiXiLXicrSzVaivYRM+TTIfpJjqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=XR+cRPvr; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=q5p6L6TB; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="XR+cRPvr";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="q5p6L6TB"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M2X2Dh1013809
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 22:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=f1I8
	+ew540ISvrOYz3s2O7GFW/de6MBJ+lvSs1/O5tU=; b=XR+cRPvrRFnsNbojp3cv
	kQsoAc+1lxFomCgj2n5cMTA51etl+LING0y6gD6v9iSRQlSk6gMN90rdHAyE7tlk
	+2zvO2ZGauGLe0bYpfN7GqfgBCNTWzcu81rh4oWT3f+IKIkTa3bs5JXUVCbBRBy5
	OTqP3Xil+bswL7UDkdkIUBNWp5o1PDIO3LKGP4CYUl0FO4K1iGj8xrFTKswjdoti
	zkXDxTDonQGdMW2C7F9bUatSgarAB6/+y+pXiBHIAfWUXQ68TX5VBo589Yzl0W6O
	Iowu0DReBQmxuYE+Rh2elbpQGV9nsfJ2WH9LQlFjLM6nJH/hsa2AuAsAhzLIb/2A
	dQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gu6vqctqm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 22:54:17 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52fb8f67601so43239371cf.3
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 19:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790045657; x=1790650457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f1I8+ew540ISvrOYz3s2O7GFW/de6MBJ+lvSs1/O5tU=;
        b=q5p6L6TBrwSGlA6BqVnk7A3/i4eqFGAFBXeCGjDD42ImI62EtXuJbFwFlSEpMvjK+A
         DNTphy+jeDyd9I8OX70Uaq+G6n0AatrbewogPwDYehdTYl4AzKBwNw9BsIGoH39D0SZG
         58aA9JmPJgdkAGFi7zodMrJc1orp6lMxF5kFlOZLHke/x/cygE7RSia10yaS40gBrLNo
         YtFCaNmSZ+soiu2ykgB2gBzx/9xSFek4TqQ9Csh6bIK0QipEz75NWNE0jedMccdIDRju
         L/OJyqYqzyrFvbA7J6/w5gPFo9KNjQeK6doPqGvSDh8y1SnctOaxP1hEpbJFXlZXxc7R
         HrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045657; x=1790650457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f1I8+ew540ISvrOYz3s2O7GFW/de6MBJ+lvSs1/O5tU=;
        b=BrMDMKbx2kgo60Khk0ATQep9jyrgPCKscrhK6zDE657H3ir+UjnoipLX+KQ7I46s8Q
         NizPF9DbBzGWWG/PPoYQx2ZzqBnzFhv8vCEqydUGzCvVy+5y7yBjCWYQ/ToIkOE4hTmm
         FK+f6+DceLS3Z4L7aRUDACUVCwLA5Q7SU2U/9nr4+vreEia6UJzJ+oO3bzOMXtMupLqP
         5U4UVF+nIxRP4RVvNPkkbCsH4uYsiNdFWB7fCgSKHG2tESjICtjSMe3YbQNbQsz65JO2
         I8zYPcPcI1JV/q9QXdz5WjIT0r5x66BW4vrZtz7ZC2JJ6M8WzU3xwVcjlq7tsq+iakU6
         /URg==
X-Forwarded-Encrypted: i=1; AKwUvByg1BZW9xdHZwvAABfxuzzL/Tg+2G/pijdFsZadXZHWZlrT/aQC8oWta1xmdeYg6DcrqDz/OlR8Qd57pA==@vger.kernel.org
X-Gm-Message-State: AFuF++kGWuKDbT6hl5yJr+Dde0t9u0T63PHhZPVIVB88VHXSFWkETB+S
	j4OFMGGT6Al4PCIMKmyJg5mr18I7uM5TXMO7Ske/v/PUvMUvCU6WvZ0zrktr23KIskRo5i/60/t
	C7UynMcM2/vN7hNEpmlAW3J6nrHilJS65O7VJVmTBF2WnZhqI8AiuB4pwKEzY
X-Gm-Gg: AYBFou36aSZRHd5T+UPbIqGjlmGWK2ZvgSuf2K06WPJPK8OJ0babotZKxzAJE017dsj
	JSacmrEvFtvAsPu48MW8Ezwywq+7dK2vEJoEPF6uhc1XA/wz8mlNrTJQpsFjvF+/0N2EouqEXH6
	C8dxOsLleMmxjeTFcbE7EZlHxKFpTOTV4Cl7QDsDzOMpJcSmVFWuRKAgPK4ZmNjkQtrBidX4ATv
	Nq4pjfwu0M6tW+FqQlvTjHdXjCjA9dz/7iOXJ81mfNxKE/UK/GR3q9LHnMOnmk4/ZytQw6fjn1u
	FpTJs51uQ/jjuINxPpyxt+VUZBlIMlAbd4bcnI5hV5L6Ir6ykhyDgZlR2m4odZGI7XPlC7iJ2na
	StTCxh65i85BFT5NPf0gSytlDZQTwMVt6jGa+sS56PsvJ
X-Received: by 2002:a05:622a:550c:b0:530:6f9f:d4b9 with SMTP id d75a77b69052e-532d8d37e9bmr34420531cf.20.1790045656733;
        Mon, 21 Sep 2026 19:54:16 -0700 (PDT)
X-Received: by 2002:a05:622a:550c:b0:530:6f9f:d4b9 with SMTP id d75a77b69052e-532d8d37e9bmr34420261cf.20.1790045656256;
        Mon, 21 Sep 2026 19:54:16 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e18fce9fsm2048421cf.15.2026.09.21.19.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:54:15 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 21 Sep 2026 22:54:02 -0400
Subject: [PATCH v4 5/8] block: fail a short atomic pin in
 bio_iov_iter_get_pages()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-blkdev-fixes-v4-5-e2801f71ede9@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790045650; l=4319;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=hK0Uz7nHtHESSVhEzTWW91QCtYxv5e3ePGfGSFiFjUI=;
 b=eXzHltWGxrOFw9o7LuFKPUEV9XvGOIQ8fGSN+MJP9ksj06z1WPRWWl06UJNojPd1s5rdfiEyU
 Hr3YcNOp6VvBbpFT43I0dkUmiqOs4Q9OQSJ7LbLb1r1SiiRAWfDWf2y
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: t777r-yy0AuWT7g7998bAZr4HmAPlDXk
X-Authority-Analysis: v=2.4 cv=BsoIUoX5 c=1 sm=1 tr=0 ts=6ab1edd9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=DOn4q0-T8uZzdi3JsfgA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDAzNyBTYWx0ZWRfX71YN7uXiP2xu
 kv56X9/6f1TYxvGkkdxBd227E1MlT3P79x1ytEedOi9jY4jPe22MlLXv1N8NWCYP4+poNOkhZZg
 kXdmtYrySVFmuGuTeicJ0Ja7v8P25mkPva99kCcvjLizJ5wnHdNxVJFzJIexkeqa4HK270uQ9Kb
 dRbnlVu06I7+2/CkLBFf5oMgR2UemwYiZYQuNwflXEtk8ygu+I2ou4XA/W9V/Qi7WDgLjKcGtM+
 QepZfmg1i6sWcSfZLMh11p64M5UUtIcarmV/3wNIMP2w9EbBJDExYyBaz7OTRn5tuy7t+H5OJj2
 O6buEp8AxE8geSOQQua0B/qEChsu/CpJNYr2VQw2KRt1fYHYXKQC1T8nfasnIX2BNDpkB2Xtefe
 Z5X/wHl+xozVcfwV3K0WRUD8/hFWkdtW306PXqpn+d3p3u2dO29jDLHN4N0UM+zbedBGaXhLaiB
 +saFes4/dXDDnC+jzHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDAzNyBTYWx0ZWRfXwZxFDkqqKjo/
 gtEwwdN1aaxDaa6MAuGaHUcfSiUT0IrO9DnBuXWT+PjIUV/Cu6poXQl0csQ0vgJaJTdPS9d7KEB
 KtBFQcw/05Te8RcLE8KSi0XtMiv+WV3qyZ2wTuA55q6sBBfkQG9G
X-Proofpoint-ORIG-GUID: t777r-yy0AuWT7g7998bAZr4HmAPlDXk
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11912
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=10 malwarescore=0 lowpriorityscore=10 suspectscore=0
 priorityscore=1501 impostorscore=10 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220037

On a partial page pin, __blkdev_direct_IO_simple() and
__blkdev_direct_IO_async() submit what was pinned with REQ_ATOMIC set
and leave the rest to the buffered fallback, tearing an IOCB_ATOMIC
write.

This can be triggered deterministically. A 16K pwritev2(RWF_ATOMIC)
whose last page is PROT_NONE, on a scsi_debug device with atomic_wr=1,
completes short with only three of the four pages written, violating
RWF_ATOMIC semantics.

Make bio_iov_iter_get_pages() release the pins and return -EINVAL when
a REQ_ATOMIC bio doesn't cover the whole iterator, since an atomic
write is submitted as a single bio and a short one would be torn. That
covers iomap as well, where a partially unmapped buffer could trip the
WARN_ON_ONCE() in iomap_dio_bio_iter_one(). The async block device path
currently sets REQ_ATOMIC after pinning, so set it before, and move
REQ_NOWAIT along with it.

Fixes: caf336f81b3a ("block: Add fops atomic write support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260802-blkdev-fixes-v1-0-a82fc549fd74%40columbia.edu?part=2
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/bio.c  | 29 ++++++++++++++++++++++-------
 block/fops.c | 12 ++++++------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f95b63c0604a..14429a5d4e68 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1285,6 +1285,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 			   unsigned mem_align_mask, unsigned len_align_mask)
 {
 	iov_iter_extraction_t flags = 0;
+	int ret;
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return -EIO;
@@ -1304,34 +1305,48 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 		flags |= ITER_ALLOW_P2PDMA;
 
 	do {
-		ssize_t ret;
+		ssize_t size;
 
-		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
+		size = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
 				BIO_MAX_SIZE - bio->bi_iter.bi_size,
 				&bio->bi_vcnt, bio->bi_max_vecs,
 				mem_align_mask, flags);
-		if (ret <= 0) {
+		if (size <= 0) {
 			/*
 			 * A misaligned vector fails the whole I/O.  Release any
 			 * pages pinned by earlier iterations before returning
 			 * since this bio won't be submitted to release them.
 			 */
-			if (ret == -EINVAL) {
+			if (size == -EINVAL) {
 				bio_release_pages(bio, false);
 				bio_clear_flag(bio, BIO_PAGE_PINNED);
 				bio->bi_vcnt = 0;
 			}
 			if (!bio->bi_vcnt)
-				return ret;
+				return size;
 			break;
 		}
-		bio->bi_iter.bi_size += ret;
+		bio->bi_iter.bi_size += size;
 	} while (iov_iter_count(iter) && !bio_full(bio, 0));
 
 	if (is_pci_p2pdma_page(bio->bi_io_vec->bv_page))
 		bio->bi_opf |= REQ_NOMERGE;
-	return bio_iov_iter_align_down(bio, iter,
+	ret = bio_iov_iter_align_down(bio, iter,
 			&bio->bi_io_vec[bio->bi_vcnt - 1], len_align_mask);
+	if (ret)
+		return ret;
+
+	/*
+	 * An atomic write is submitted as a single bio, so it has to cover
+	 * the whole iterator or it would be torn.
+	 */
+	if ((bio->bi_opf & REQ_ATOMIC) && iov_iter_count(iter)) {
+		bio_release_pages(bio, false);
+		bio_clear_flag(bio, BIO_PAGE_PINNED);
+		bio->bi_vcnt = 0;
+		return -EINVAL;
+	}
+	return 0;
 }
 
 static struct folio *folio_alloc_greedy(gfp_t gfp, size_t *size,
diff --git a/block/fops.c b/block/fops.c
index a3a709697b40..90777e8a9a6c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -342,6 +342,12 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	bio->bi_end_io = blkdev_bio_end_io_async;
 	bio->bi_ioprio = iocb->ki_ioprio;
 
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		bio->bi_opf |= REQ_ATOMIC;
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		bio->bi_opf |= REQ_NOWAIT;
+
 	/*
 	 * Users don't rely on the iterator being in any particular
 	 * state for async I/O returning -EIOCBQUEUED, hence we can
@@ -371,12 +377,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 			goto out_bio_put;
 	}
 
-	if (iocb->ki_flags & IOCB_ATOMIC)
-		bio->bi_opf |= REQ_ATOMIC;
-
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		bio->bi_opf |= REQ_NOWAIT;
-
 	if (iocb->ki_flags & IOCB_HIPRI) {
 		bio->bi_opf |= REQ_POLLED;
 		submit_bio(bio);

-- 
2.39.5

