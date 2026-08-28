Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A136446E010
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925034; cv=none; b=txk8/QeHom7sRP7lBVGJXmBeVoQ2RE8CGGFD8CtE2ATL8v4V53ECykZrIRvpzrz82SxPMdolLlcRitBBY/fsGatNKLT7+wrl45WSh95ptYiRa8VX+gYogTyELmEOHbnsqxz52AuEFnmDSEkx3wyTmbggVVgeosA3FYB0I9CuN4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925034; c=relaxed/simple;
	bh=572OiES/CjhuxPL8vR1LJOvecWmry6un5glgns5urC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ha8gJ7z9+82CB2VH6F0460EW85JdMqHNha/7Ne6sJE0EQZchyCM/2NNuI0tX5pwvOr6GIFEhs0oSTR/h7QxNVbd/NIpC6NYaRxixQP3MNbXuJfFrUDUeZKaVTC+qrCEBTSEeJWGwSS9fBSfH93rR/XfhlSQ2wn5H0+Udv0aHnYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=LxA6bp3H; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=x0QUTq7l; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="LxA6bp3H";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="x0QUTq7l"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SCYBe02008228
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 09:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=pOJo
	XJGTDCmNM/Ad6tqs2TZFZdczxvGzOD6wQaDYgcs=; b=LxA6bp3HGYx/oXH+P0It
	5FDs1OO/GU5787H/eqhKdbiXeOobZAF2gnQaMXXA2/pEN0oFpyOkAUMpPexDv7hf
	dVSY8lb/PFYYlxd/4CD5zjZnZZEpn/S07kBC3f8Czwy2stgreHuWldRgjY+5GzZ9
	ozGACjQS97GlYjlT9eN1N1Tf2HXhqprQbgLcPGDrRc3FzUmcePiZE1RtlndtIimH
	qUcvDNzqOZOJ7j0waoFU86zAhm0smvcwWyj02s+Fmd0tJVoc0nynvuMr6EYWXTee
	ZGOZqu3RbObv+EDSbUlfiWfIR9W5UPEDcHSIWJYv/3R1lOjVm+gx1Xd+IcJgPSmG
	LA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gb9sjrs9b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 09:50:31 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90cd2cadc62so11759596d6.2
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787925031; x=1788529831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pOJoXJGTDCmNM/Ad6tqs2TZFZdczxvGzOD6wQaDYgcs=;
        b=x0QUTq7lrL6IxKOlgC9uzjG3xREt+ylTfePpUdyZzFh88H5cEk4JSG0C6O+g5G+LHS
         /S+Ibuu183aQ91icdDPmL46Cfu291VeI30n+EH2DNW3GFYCTfKz8y3zy0vE16p4wsplS
         LyCRBSgo9e34YTTkshIInlQl5rQXJn8WxZx9tmBoMjkekJ9X5R61BmtgHnUo+c6K/Kf1
         IT+Bd8SLZZaB5CuJNgLsRQg3ZFkcncZwjLyvCfst2IuXKloXdEllHDyGxXfu29Cg6ot6
         z8g5bXxVgm9B6TVKPSRByyfI/iSAphLUCoEfdWXhh/Aq1yqmkSIw0vbtLskorY7moQbm
         K6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787925031; x=1788529831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pOJoXJGTDCmNM/Ad6tqs2TZFZdczxvGzOD6wQaDYgcs=;
        b=mDJrmJWMbG5PEjWe9EijoH+WPL/ZvFt75ujXBQlvL8LE9FC0oxRYl9YD106gwCSn+Q
         9O7ZLjhUqbVu05CQfj9soHjGSAZjNIJ5celLhDnlOf3yXen+dXyRat6aQyqAgEvU6+ZO
         IHWKhN3JZEnXT1CvZ9rNVBqfp1U0JrEyGbBSnsZqcY3kHjJlJkIgnjxAekGHPM3JGSjI
         1u6TzBnZtkjTRkbSVL35iU440txUsE6vMEeg6/pfDIQ1ufzNqaFvKGWyzjgCWGYPq7vO
         PMn2/aUzkftohkxhI0f+Ro+v/8rkhiXKOA94iqUCCJ+3KCftwpezhbTj3nPSp9Yb93aV
         KLnA==
X-Gm-Message-State: AFuF++lA/M5CvzuH2mZqmeiXEuBMpaRqXemSJ+ExvlzmRKgBUZk1+ENG
	CTXduZlk9+jQ1v9Bck7fX2cIQsPnOfNQiEzXTh+ujypa17gtoQntpF99F0eRQ52kzTOsWrLrXcN
	ZCFx1ECOlYXxkw+wkDj0Iu6F/J1q6jPoCDKdUxPxiEJz1o4fLdJx5RdPnYfjn
X-Gm-Gg: AR+sD10LEw4MZWoE2+fBlNaaAMSCcQyffNkn4WC5ClC/VIcRJq71C4U04oWrdjJFwVd
	u5lQHKpoW6uqu+qBt3be8jEcDxqU/oAp4K8frzzro0smQdlW9+PzrUIqbNM0kNzZHJlRE2UmRn+
	LS+4zZqlykkGCu80/gYlj+iG/iXousfG4s7U2JGzezmKPIjrWAnfvqE5F6N85GrWrjnTv6HDvnw
	eK4o9SFukkNiDYyLGf4udiGAeRS58eUcMTfUD7NW8K1QXVivej/2J4Tv4RkTuTwPAIwCz/dnIeZ
	6BdtZtdgWVt1/YXzc+ERVHvWOG+Ov8r+JlIKNCcA65rBdDcXBWd4Gg6DCqMzjpRAkSC10eEyhHm
	mjcN67AEX
X-Received: by 2002:a05:6214:27e1:b0:907:44ac:7d12 with SMTP id 6a1803df08f44-90ce0b467a0mr87795956d6.0.1787925030442;
        Fri, 28 Aug 2026 06:50:30 -0700 (PDT)
X-Received: by 2002:a05:6214:27e1:b0:907:44ac:7d12 with SMTP id 6a1803df08f44-90ce0b467a0mr87795146d6.0.1787925029825;
        Fri, 28 Aug 2026 06:50:29 -0700 (PDT)
Received: from [127.0.1.1] ([45.130.83.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce4534ebesm15645116d6.48.2026.08.28.06.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 06:50:29 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 28 Aug 2026 09:49:54 -0400
Subject: [PATCH v2 5/7] block: fail atomic writes instead of falling back
 to buffered I/O
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-blkdev-fixes-v2-5-32f3f40cebed@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787925005; l=3243;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=572OiES/CjhuxPL8vR1LJOvecWmry6un5glgns5urC0=;
 b=ctdPaig/TPcLwkd135uOHim6leQoiv3dyzVAv5IWWPpvmjaeShsahmLX+O7aFEDrItQ5mSZ+s
 Heg3BLVKSv7DKG2Duzq3/crPLfU9p6h48t4FD+QtOTPKCvHLdVQwKwx
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=abhRWxot c=1 sm=1 tr=0 ts=6a919227 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xDWFIMX55ayQNp92vt0S/Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=bwvcz7OWzcURP5mN1j0A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: X_hzyrPu91JI6ySbo9y-D8W8SebzcxrX
X-Proofpoint-ORIG-GUID: X_hzyrPu91JI6ySbo9y-D8W8SebzcxrX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExOSBTYWx0ZWRfX9LmoLDmrJhZF
 wYzETLI1qMk3Fbqy11s6Kjt7WDfoJrxSWc3G0TCzM0OHxnvNsPbAG9epLWqI/OUh854+0ryxF/L
 aZFkPCkDvNDsihAJyTkJy20pNU4KzNJTc2S6m6gDaIJDaaYIJOSB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExOSBTYWx0ZWRfXzFUJ09UUp397
 W/Sg4ai0Ra18vDNLu2Ft+DjMuPbeXBDaAzYaeD6GeO48q9sNYh71sFLjcUD1be+ugdpwLOOlkgX
 O0cGKaJrcH7wagNKr4FfQHdSEkglgY8DozsTNd/s7jMXKEpVgQR8UgAa8K6h7pf8jc3xkdaH+u4
 NlzPZlxb/Wyl2LUv26XlQFidcOoQxgs6uWR/qdvrcgY6Uv44RNbR+hggBsqDwXn76WKiDcgpqYQ
 Apf/CZMN+y40+zCootYxYYEXFBGg253ubBy9YAYZwezD92BLn8Q0Jqcayn7qRQ+opnwULtFm2ep
 rvo2myslaTQ3voJApRfc0HWZtapdmNLrD08J25Ixro8Ta31Y6lEocoGw1CJjnV8rORPSDbKHNSH
 6ELnZZPKrSfyapsqzBfrsA6ksfEqKmbd8FS/ANXUnaEmo0Okxn9y8a2qH9vyTta2z228YZ9+Cmt
 24aY3Vh6mdEcFwaUu8g==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11888
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=10 clxscore=1015 impostorscore=10 lowpriorityscore=10 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280119

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

Fail the I/O instead. Return -EAGAIN when page cache invalidation fails
for IOCB_ATOMIC rather than retrying through the page cache, matching
__iomap_dio_rw(), which treats the failure as transient and lets the
caller retry. Release a short atomic pin and return -EFAULT before
submission, which is what a direct write already returns when none of
the buffer can be pinned. A sync atomic write can then never return
short with a remainder, so the buffered fallback is never reached.

ext4 has the same fallback and only warns in it. For block devices both
ways in can be detected before any I/O is submitted, so fail early instead.

Fixes: caf336f81b3a ("block: Add fops atomic write support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260802-blkdev-fixes-v1-0-a82fc549fd74%40columbia.edu?part=2
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index a3a709697b40..8769bb13df1c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -87,6 +87,12 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	ret = blkdev_iov_iter_get_pages(&bio, iter, bdev);
 	if (unlikely(ret))
 		goto out;
+	if ((iocb->ki_flags & IOCB_ATOMIC) && iov_iter_count(iter)) {
+		/* a short atomic write would be torn by definition */
+		bio_release_pages(&bio, false);
+		ret = -EFAULT;
+		goto out;
+	}
 	ret = bio.bi_iter.bi_size;
 
 	if (iov_iter_rw(iter) == WRITE)
@@ -352,6 +358,12 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		ret = blkdev_iov_iter_get_pages(bio, iter, bdev);
 		if (unlikely(ret))
 			goto out_bio_put;
+		if ((iocb->ki_flags & IOCB_ATOMIC) && iov_iter_count(iter)) {
+			/* a short atomic write would be torn by definition */
+			bio_release_pages(bio, false);
+			ret = -EFAULT;
+			goto out_bio_put;
+		}
 	}
 	dio->size = bio->bi_iter.bi_size;
 
@@ -691,8 +703,15 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 	written = kiocb_invalidate_pages(iocb, count);
 	if (written) {
-		if (written == -EBUSY)
+		/*
+		 * The buffered write fallback cannot provide torn-write
+		 * protection, so atomic writes must fail instead.
+		 */
+		if (written == -EBUSY) {
+			if (iocb->ki_flags & IOCB_ATOMIC)
+				return -EAGAIN;
 			return 0;
+		}
 		return written;
 	}
 

-- 
2.39.5

