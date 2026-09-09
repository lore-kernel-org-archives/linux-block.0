Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636F04AB1DA
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991523; cv=none; b=Kp7hEqzcA1h/sIdaQbBtySTTscYKmWvJjPyi+3PNYT1LdzeKCAbUTF+xz2ACd1lWqqAiNKdPxtDsnx+mqpp3wHweNY2SctDw0LduJW+qUyVzMj0klnzMAYQOS0I/4IpigiCoGXJGOIZon7eJ9GTs7FK6ImlyGAL4YwbP2PB3sI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991523; c=relaxed/simple;
	bh=Szkl0zQw5FKjt3p7vuSF/DGwtXkOrx336KERuXYlUgU=;
	h=Message-ID:In-Reply-To:References:From:Subject:To:Cc:Date:
	 MIME-Version:Content-Type; b=APZNMfmtdEMC0Q5Xu1dKjQWxkjVqUYz3ubcZSbUZVBuNaJqZEaAFlv/AfDhUiIIqzcmmmGY9OxZIf3JklUdEJo0RWsNIOtkkd+KwXZri+LRs1Pv099Z1lHB90ua+TQ2p/qw43dr0lH0+pgWhSFsBtmB15jbx96vpjjyzOVmVjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=nYFKGuQJ; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=x+s48mdw; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="nYFKGuQJ";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="x+s48mdw"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689KYusQ1656289
	for <linux-block@vger.kernel.org>; Wed, 9 Sep 2026 18:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=TThN
	0a5nP0zzwXQLrTldgh7wXE1up6HbOywS+CznoLM=; b=nYFKGuQJ9zkkW/LzkJK/
	0NDdRd5p2XnarQ8GF3bDAUQFqhJjYt4oxBiwYfHuoSi+JmDgR+b1C3quOIP1eGdy
	0tnqoC04YxoM5lgxxkD7lRgSc9LJ+nTuHd+c1L7kNGF+R5UZiQNKtLJpPowXZQql
	qs8BlEFaXAW53llBZ4DNt0Zd9JE/GouJCfOSYvfohHiQUJzyG2M4qV7XPmQnzvrf
	GCcL50p+iHN0Cf+XEdNpHpoKrSv/iXbeuTTLbHMKDZY3Qiz4ID0IOcO5Ew4Nmn66
	9/3xkpiee0ABogYx1K0p9zM7iF57moAL3lmgYojEugU705T8jlj7wwSZdIe1e5+E
	pQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gkcxxsym9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 18:05:19 -0400 (EDT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66988049306so8536188d50.1
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788991519; x=1789596319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:cc:to
         :subject:from:references:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TThN0a5nP0zzwXQLrTldgh7wXE1up6HbOywS+CznoLM=;
        b=x+s48mdw0Zxl3sbQR5jnLM4wYcr60n75oNLjKCMZEqpsKsh45FAA1pnbsw6rzi3O21
         r/A8f0e1RQW8gyh2MME7VGudkq1wWYsY7J4QYcjX2uWNWjXW/GUiX1116uGDCV9UJXC6
         Af9RKjH/msvqwkxyg/J0toxu6QPaTSRWb/qNuJ13uC1Poz4+ltWKK825SiPswnxmNGT1
         wE0wNoItwukedDrN7HyPe61E+F6yQBcda9L5dFuD30iF4E80xcbT9iUQKS4OD9QeWtxR
         D6Ojg+/3wWhOhnK+2CTwcQ7ZCoZym/qHaKOYKDDCy4/VBpwST++av+rpKiG1mSuoEFJo
         ihNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788991519; x=1789596319;
        h=content-transfer-encoding:content-type:mime-version:date:cc:to
         :subject:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TThN0a5nP0zzwXQLrTldgh7wXE1up6HbOywS+CznoLM=;
        b=EyQXqnqho8MNrSDHnJ2jLlxokgYLoPWk5IbpplpiLeFMT1m3SgFVhcoahCGuQMtzEV
         CiLje1CdJmcyc79A/q2QZzooq9qdwepO1JWSvlN/nnXTzDEZn0etgTJ91IDfMR2SHIEA
         RV2mFweZxYEFjMzzC6y46E+tb5cQyNXszpMEQkOPf0EaJGKUB4Hz/8g5kl9CIdAmtwPq
         6iFIM3o6DafrG5qhfwxYsOAMPgP+Ga+Im9mNn4jAqLOpqtuqSvOGIMVhe3kiIr0d3jf2
         DHmGxE0hmo2o5GQGq7i0mmeO+dLmov5w62YJBx+p/GZYbNS2ZocJbT4swIB8dQhxnX2m
         MztQ==
X-Gm-Message-State: AFuF++ni9QtLAYXRf757V2itCVEgy5Tr2ci9NCNXwi3JsYbSfS6B8hjd
	crRicZFiei2IiYRzuydw347iZi6yvG/GDDzaPan0h0RYstoY+TOkJeMKIpvNrPIDXCW6iU1vGFs
	mlTBKJ9zLNoDGLpQj/OmOsjOtpu12fScwwNWPJt9Bp8XbKS7pcEO8F59/1s4H
X-Gm-Gg: AYBFou0H5fMCMR1J2l1QNxRmibb3JRXeOmAl6mh1jkJoCGflgsFV9AF9+5i+RXgu8sX
	rw03evQRY1hHzxJjkW+Oia/Mk8qmOwmmQlxm39oS2GzMguZ0kAQfiJfcXe8GySoM26HdhKlY7CO
	uta7KGBjUEO0gNWkSeU94VPUcAHMZh3/pkNRA2iGL9iZpGkKMcoj2YPmg/peAxNj5g37ELKYoW+
	Uv4x7bSoxFtFbfWChJ+nF7t5Uc9S0hFOlUyarjwJna0n5g90RvUn/4KfZTNZOgOOYy/CGgBIT2K
	lfa1fFXh5yWmYHITgT1xrpQG+SB6KNeBmVDVtrpUu6z1slJnk8PithW/tN70LSIj/EXfNs7kRSD
	AD2ZeOCTZTyFeVY4WW4wtc+mh9esF0AyGr8wDQl8Ttild20yT
X-Received: by 2002:a05:690e:1382:b0:667:e855:ecdb with SMTP id 956f58d0204a3-66fb58f806amr13201046d50.3.1788991519493;
        Wed, 09 Sep 2026 15:05:19 -0700 (PDT)
X-Received: by 2002:a05:690e:1382:b0:667:e855:ecdb with SMTP id 956f58d0204a3-66fb58f806amr13200980d50.3.1788991518642;
        Wed, 09 Sep 2026 15:05:18 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-193.net.columbia.edu. [128.59.176.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040693f75sm154018806d6.35.2026.09.09.15.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:05:17 -0700 (PDT)
Message-ID: <20260909-blkdev-fixes-v3-5-1a5222c6e8ad@columbia.edu>
In-Reply-To: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
References: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v3 5/7] block: fail atomic writes instead of falling back to
 buffered I/O
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
Date: Wed, 09 Sep 2026 18:05:14 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=b6EncdGx c=1 sm=1 tr=0 ts=6aa1d820 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=fJxgZNdXt3opHMdyAp+FXA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=yiLHSb9EnpU49bWIXwUA:9 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDI0OCBTYWx0ZWRfXwhAil7SBvaKB
 ey8ymaNzzJUeoiRwToF5m4+z4n/Q7ujExvD+LHegSifEnycDGtmGrcOFdRnMtvEhNCdcsVCCUTL
 BX8S1aalYZNlqKdtw7IAwwemtMCdk97TChsSczlAeJDWxwEIM3K4
X-Proofpoint-GUID: vXInjhBWhQzBxF6EH23NVGXlOpeBQvi1
X-Proofpoint-ORIG-GUID: vXInjhBWhQzBxF6EH23NVGXlOpeBQvi1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDI0OCBTYWx0ZWRfXySA//2WiWkIF
 UqddHBMwxJ8whppobmIFlnjZCElu5BsltUGbhvQB4mHzQC4x78e0So4t5JcBMpuuTctqTN2s29N
 v9VU+tSEUupJ3odx5z8D3c8s/orhHxJGDs9ORKO5gy8kG+NHYm1PoHxoQ9yjyCSp/6t/6ZnqmSY
 h3t0+hSK6kWanqN6gnRVHo4abjvTCM9RK5GwHL4PtxQAXZQHHJ64dE2fctxCinB3kBe4ael17gX
 na8F7pn+zRTTX9VijwyWx9EbplQeDOEP+bXkIQdvslOC0gtwQdAHPZyzL84J4K8PbhUERAZCjJ/
 XZOpx4qDuoHpPcBaNxm4IDsbDe8johFwdBpd40uhd/Bf5ctT8BtPC9kZ0xzGCehE5IOT0ypAqpC
 1Zl/k7zZaB/E2TB9wCVlRzfo4oX5z1J5rSvpZtZ0ybXLmeanefdjVGZvOJr4UdbpxTNpLNWABTE
 pMi3DOrAJVlsB3tCyEQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11900
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 bulkscore=10 adultscore=0 suspectscore=0 lowpriorityscore=10
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090248

An IOCB_ATOMIC direct write to a block device can silently lose its
torn-write guarantee in two ways:

  1. blkdev_direct_write() turns an -EBUSY from page cache invalidation
     into a 0 return, so the whole write is retried through
     blkdev_buffered_write(), with no atomicity guarantee.

  2. On a partial page pin, __blkdev_direct_IO_simple() and
     __blkdev_direct_IO_async() submit what was pinned with REQ_ATOMIC
     set and leave the rest to the buffered fallback.

The second case can be triggered deterministically. A 16K
pwritev2(RWF_ATOMIC) whose last page is PROT_NONE, on a scsi_debug
device with atomic_wr=1, completes short with only three of the four
pages written, violating RWF_ATOMIC semantics.

Fail the I/O instead. Make bio_iov_iter_get_pages() release the pins
and return -EINVAL when a REQ_ATOMIC bio doesn't cover the whole
iterator, since an atomic write is submitted as a single bio and a
short one would be torn. That covers iomap as well, where a partially
unmapped buffer could trip the WARN_ON_ONCE() in
iomap_dio_bio_iter_one(). The async block device path currently sets
REQ_ATOMIC after pinning, so set it before.

Skip the buffered fallback in blkdev_write_iter() for IOCB_ATOMIC, as
it already does for IOCB_NOWAIT, so the -EBUSY case returns -EAGAIN and
the caller retries, matching __iomap_dio_rw().

ext4 has the same fallback and only warns in it. For block devices both
ways in can be detected before any I/O is submitted, so fail early instead.

Fixes: caf336f81b3a ("block: Add fops atomic write support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260802-blkdev-fixes-v1-0-a82fc549fd74%40columbia.edu?part=2
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/bio.c  | 29 ++++++++++++++++++++++-------
 block/fops.c | 10 +++++-----
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 898b2f5ef8c8..63e266d861f1 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1284,6 +1284,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 			   unsigned mem_align_mask, unsigned len_align_mask)
 {
 	iov_iter_extraction_t flags = 0;
+	int ret;
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return -EIO;
@@ -1303,34 +1304,48 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 		flags |= ITER_ALLOW_P2PDMA;
 
 	do {
-		ssize_t ret;
+		ssize_t len;
 
-		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
+		len = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
 				BIO_MAX_SIZE - bio->bi_iter.bi_size,
 				&bio->bi_vcnt, bio->bi_max_vecs,
 				mem_align_mask, flags);
-		if (ret <= 0) {
+		if (len <= 0) {
 			/*
 			 * A misaligned vector fails the whole I/O.  Release any
 			 * pages pinned by earlier iterations before returning
 			 * since this bio won't be submitted to release them.
 			 */
-			if (ret == -EINVAL) {
+			if (len == -EINVAL) {
 				bio_release_pages(bio, false);
 				bio_clear_flag(bio, BIO_PAGE_PINNED);
 				bio->bi_vcnt = 0;
 			}
 			if (!bio->bi_vcnt)
-				return ret;
+				return len;
 			break;
 		}
-		bio->bi_iter.bi_size += ret;
+		bio->bi_iter.bi_size += len;
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
index a3a709697b40..0b614d76d128 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -341,6 +341,8 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	bio->bi_write_stream = iocb->ki_write_stream;
 	bio->bi_end_io = blkdev_bio_end_io_async;
 	bio->bi_ioprio = iocb->ki_ioprio;
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		bio->bi_opf |= REQ_ATOMIC;
 
 	/*
 	 * Users don't rely on the iterator being in any particular
@@ -371,9 +373,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 			goto out_bio_put;
 	}
 
-	if (iocb->ki_flags & IOCB_ATOMIC)
-		bio->bi_opf |= REQ_ATOMIC;
-
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		bio->bi_opf |= REQ_NOWAIT;
 
@@ -766,10 +765,11 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
 		if (ret >= 0 && iov_iter_count(from)) {
-			if (iocb->ki_flags & IOCB_NOWAIT) {
+			if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_ATOMIC)) {
 				/*
 				 * The buffered fallback blocks on i_rwsem and
-				 * on writeback of the data it copied: return
+				 * on writeback of the data it copied, and
+				 * can't provide torn-write protection: return
 				 * the short direct write instead and let the
 				 * caller retry.
 				 */
-- 
2.39.5


