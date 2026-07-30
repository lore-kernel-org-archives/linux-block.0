Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B473BB9EB
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394756; cv=none; b=ZbgV2R9RDFryuoIh1vA/Z0E+/Fmvi7NnSQAFRB6mEqJ8zSA2Y2MWTtLeC0Yg+q+GIzBha4JEkuWhVSE96fAmSbd4b8aovZTxBFm21DJhvECZ+iGdDFqxQ3DJ8SJmUKlmXpOsygqtZC2pE7PH+DiWbUnxbZWHhG6eiXqzqr0yFQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394756; c=relaxed/simple;
	bh=VqAWR9drHd5aaagFAxsb9cXKpB8GAafaVAD01CXD178=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJiX+MFPgPhwBm0zyxNeRiFVgKXBed6zKM0ZLv5vBEMb4ppBd4qa+ZwpZYNHk6D9klHRqS2YiZFAbbhbcOemVA2Qr74PKDpWDXutniBGEXsQZ7xYqVOFYugNJefr34V9UV8LNVUz+cXyRPOgiGTXReB/+bfaJYw8NLOPKxJgKqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=MpKYlVJw; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="MpKYlVJw"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6astl2228356
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=VlLo
	mZ2ihL9HFxlrx7gRVvKB0MpDdFuMFLp7qf/zQYY=; b=MpKYlVJwcHKHdws+WTax
	xNY1KC8xJ5UwioqCDfrXm10hsZ38GifYdzzDgdp5k3EXoevWleyY1dFEYtamvhpJ
	nWsGgJa6p/YoSuJF4WIywki9iMXIn1c5Wn4DkpQGgbayfJ6qYYenwE7IR3x6i5za
	dwukXaXhPCmDnx00K9b63BM+126tHcyEXiVmjVGTroLxLwgeaoTkFFz5LrgjZQxx
	gCxc77WryoG5AoO8xqG+CIpVGqcvPcJy1Hre/qmfzNh4Lg+NyHId2TO5o74a17H5
	PMqGOiw2sWKl/vs2sNdLr6yI8HY3DLjU7PD9m6sqBVNHZv4IJI6fROiKcTd5+32Y
	+Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fqrjq25cb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:59:06 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e66f9e2baso209336885a.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 23:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394742; x=1785999542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VlLomZ2ihL9HFxlrx7gRVvKB0MpDdFuMFLp7qf/zQYY=;
        b=MvpNj5Y99dP00bFDjBgCmlEK7odofUjf934zAT3ckjKxul/9OuC9lBG3BHvjqevbqf
         KMxiIdNz1x5t7/81mJx1AEXKcr9sYayPYwGVHscvXo+iCR5samBUtFreUeGAvurZntCa
         CK4SJBT7ESwAy+Khvy0bu9VldYj4QpMGEhIwkkXxT/bAFVJ1/Hp1v2gQxKVOr8mtIpxq
         yT4fV2T2rfbLwJAUXuSNvG/zaWerO0GJvmjrHuylP61TJZHP7MdehHLMcgqMCP8ZOJ/l
         Vh5EhBytirelEJB44NDy4Zyfz5jRXPKM+LGUnDNGTIgINfxgv/NImd848lG2JD+LWn0F
         yXYg==
X-Forwarded-Encrypted: i=1; AHgh+RrhLrAEvcMyZs5OmY+JsQdh05iYcY4U6FO4IQ0GX0jxRdTTyTb/qAjeyOp69EjgUJWcV2SjOWk0ruWUOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvdQX10RX08OHxhc+FB6RrOCBmmIgrv/2+FlcH4lide4j2y8Aw
	zjSiKRFt2jQEK9TpTjepjIsJ/PsaSzluCXViMYg+9WM7jWGBATlkXFxK6BZDaPOGg15kyXiIqS3
	RJx0YzjC6bd25RiBVsWWOHu0MXxY1zxVpR+j9EKfbmLdZuwEqbuSULAX1w4kT
X-Gm-Gg: AR+sD10cKfMpzR+enCyVo+/LWft8QaRtjRHG8c5gwAYaiJZhSLGxWW8Rj53uiHwaCYH
	WRCy88FEWl/SDikCIXzrDp5krJXMUqom4tQMfH0ExsuroA4O45cHksAj4mMfqIiYAC38QtWaLqC
	vtEbBuO4UOfSnz0p3bGy6Jtva5YfqINrGli2T9shCtvEuYo3RMDb9siYL4HcUJ+QDZxMep3fzq/
	eO+ZawvMNKEq7z9+TwDOu2Bu1sb7ICtApNiBRuWpkRF4cFr7H2HUqrmm9AirbZhzR2GzId9gmo1
	U9VX5wo+tjQLGVdwRwEpA7HkcklvnIE1J9+cySctbTcZXSgQblIKvFr+wkZsLzh/FuS1PploOnH
	bs/p42Q5P7pVPk3Ebm6te5V0Y4E9ETRPJEn1bqWnOgaoqtw==
X-Received: by 2002:a05:620a:4728:b0:92e:94a7:16e8 with SMTP id af79cd13be357-93485f9eb93mr142633285a.15.1785394742159;
        Wed, 29 Jul 2026 23:59:02 -0700 (PDT)
X-Received: by 2002:a05:620a:4728:b0:92e:94a7:16e8 with SMTP id af79cd13be357-93485f9eb93mr142629985a.15.1785394741655;
        Wed, 29 Jul 2026 23:59:01 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3221bc7sm349752485a.7.2026.07.29.23.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:59:00 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 30 Jul 2026 02:57:53 -0400
Subject: [PATCH v7 3/5] iomap: use BIO_COMPLETE_IN_TASK for dropbehind
 writeback
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-blk-dontcache-v7-3-3e8e6850068d@columbia.edu>
References: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
In-Reply-To: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Hillf Danton <hdanton@sina.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
        Christoph Hellwig <hch@lst.de>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785394735; l=3060;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=VqAWR9drHd5aaagFAxsb9cXKpB8GAafaVAD01CXD178=;
 b=vBSV9PuGaob7EwfUbiGv6fypiN4LKkZCFKVdXD+PIQv8LCcBMfs8U5vzkhknkhDiwC6C0Zrx+
 5R4OEUS3RiTCHa0v/202zDRtO2dKByH8pttxUhsn6U5qKVyhcv1ODCk
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: R2A9irvyO8_k3mWuzUl4K6eIkMUXhqOa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfXyJvi9GKFtpb1
 k0ZF0WARkjO0yUUz73zbMlvcZ4xOdkxVkqN9PitiK6WUxQaPT7AjbEmVaCeu0BcKQcxbivjH+45
 66E0ZOgJ5TKZXXBscDLE6Te4e28fmcLPwIfQWDfrwJrOKHs6UCHf
X-Authority-Analysis: v=2.4 cv=S4PpBosP c=1 sm=1 tr=0 ts=6a6af63a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=aYi4XJYX91a15INjywwA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: R2A9irvyO8_k3mWuzUl4K6eIkMUXhqOa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfXyw66NWaBVhVA
 3jxSBwWFWd3LrieKeGHCr+SvkHbuqsTSLxWsTKX64jp8DLAZLjZvYcL8af8Krq7TaQ6ALByKlig
 5l3mwTKistlYECsdOZj99VdLGaPa7r5MHKlT4yHhySz+BDfvsLwFYdNJ4IQAfh+vliQKMBRUo2B
 d4R7Dpbdw6psn3DvBeV9uFFZZOrRDLIQIrJjIQlCTOKvD+O3FFHtQkWvqxUbm0xJVnuDzQyB1wT
 ToBKa99IE4c7U565Hb7y4hZK0c0RIKqG8mhPoCW0cR/YoAjwMJIelWKg5gcbY0uLlzMEvvZB9xq
 QzlaqzWJpbVbCqoCyRZR2fx66x99LgpkhMB8zLMRM9Gza2ZMWRoRgodU1R85Qf4yUSXuBnLoNYE
 5ubREAmfkjHSfIr45nGo1vHSS/6MBdpuSE0oi1g7avHvtbE2wHkkMPFoIrK1B88R00X7AB9bHIf
 jsiAXvdr9ZX5KsI3mVw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=10 impostorscore=10
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300048

Set BIO_COMPLETE_IN_TASK on iomap writeback bios when a dropbehind folio
is added. This ensures that bi_end_io runs in task context, where
folio_end_dropbehind() can safely invalidate folios.

With the bio layer now handling task-context deferral generically,
IOMAP_IOEND_DONTCACHE is no longer needed, as XFS no longer needs to
route DONTCACHE ioends through its completion workqueue. Remove the flag
and its NOMERGE entry.

Without the NOMERGE, regular I/Os that get merged with a dropbehind
folio will also have their completion deferred to task context.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/iomap/ioend.c      | 5 +++--
 fs/xfs/xfs_aops.c     | 4 ----
 include/linux/iomap.h | 5 +----
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 30468d51b5ad..1ae8a8fb8503 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -238,8 +238,6 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 
 	if (wpc->iomap.flags & IOMAP_F_SHARED)
 		ioend_flags |= IOMAP_IOEND_SHARED;
-	if (folio_test_dropbehind(folio))
-		ioend_flags |= IOMAP_IOEND_DONTCACHE;
 	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
 		ioend_flags |= IOMAP_IOEND_BOUNDARY;
 
@@ -256,6 +254,9 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
 		goto new_ioend;
 
+	if (folio_test_dropbehind(folio))
+		bio_set_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
+
 	/*
 	 * Clamp io_offset and io_size to the incore EOF so that ondisk
 	 * file size updates in the ioend completion are byte-accurate.
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 51293b6f331f..cd8de8c82d78 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -522,10 +522,6 @@ xfs_ioend_needs_wq_completion(
 	if (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED))
 		return true;
 
-	/* Page cache invalidation cannot be done in irq context. */
-	if (ioend->io_flags & IOMAP_IOEND_DONTCACHE)
-		return true;
-
 	return false;
 }
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 56b43d594e6e..68af4935a107 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -404,16 +404,13 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 #define IOMAP_IOEND_BOUNDARY		(1U << 2)
 /* is direct I/O */
 #define IOMAP_IOEND_DIRECT		(1U << 3)
-/* is DONTCACHE I/O */
-#define IOMAP_IOEND_DONTCACHE		(1U << 4)
 
 /*
  * Flags that if set on either ioend prevent the merge of two ioends.
  * (IOMAP_IOEND_BOUNDARY also prevents merges, but only one-way)
  */
 #define IOMAP_IOEND_NOMERGE_FLAGS \
-	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_DIRECT | \
-	 IOMAP_IOEND_DONTCACHE)
+	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_DIRECT)
 
 /*
  * Structure for writeback I/O completions.

-- 
2.39.5

