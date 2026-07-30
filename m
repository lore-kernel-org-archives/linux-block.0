Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4CB3AEF44
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395588; cv=none; b=TqFkqjVxTAc8rD1OBxxV9j3jC2yrkU4Y/7lVK/BQVaD42m7kYWtdSLKTpZR4COgcpxuEUyBvKEdkiXXRBAKYyzMTv+J0OFwmPWUhzCKnqErJ2xqtHeH7d7dz2/npDY8qM9NcRaNo5U4n9mAibXIunWfKVtY1Q5KGxUNo/DnaFaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395588; c=relaxed/simple;
	bh=hHCEZENfCfsEpOmC0wBfWJMFm3C20nG7DjOTxirSTUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rPmSyUgxo46NmFzq7M61GNCWImYVBFkXL2a2kY4ZN3VxmntuPFiASS53HjqFHVHmijPkG1DtJEGGeYJt1Tzc6pe3kxUT67IK5sdXAxkF1ezSEh55b0En83DsYOII29SkUFtnt94NwTG4yiLGekl1ox9+82YV5xx884YMG+oJakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=hv0PcEo8; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="hv0PcEo8"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6l16s2248582
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Aj3+
	ozneKRFxvyRKEW1x+foEkavllzfM2NqbtLKj8IA=; b=hv0PcEo8AAPDJ3qmRsyH
	3+KWRKhUuio5bu6v7AnsbOIMwgD7rZbWuZCbxPJ8NOtDT/6jnTzUMipJ0mF7QfZu
	3vHsZW0WXTeqgG2leuJy+YHuFK/7Aze+PS0kNPRJ77w6BASuAor/BNbvhZ+06gWE
	lwCff028FYqKbvLsbLBzqyFKUem7txf57ogPxPRAOr5qdW2T8loIUHnw0K1cQz09
	7P9wendgVQQF2uUVmf24BxrK1lwd44WBWwC/SjBvLCM7Ae8WAwMxAh2mgghG2Jea
	q0yZqxPC9eTBItVbYtNcMTqXiTV+yoGFDSs/zzZjapWZTUnHFT7gf1vSP1LKyFZq
	dA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fqrjq25by-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:59:01 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e55721a8cso206353685a.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 23:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394739; x=1785999539;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aj3+ozneKRFxvyRKEW1x+foEkavllzfM2NqbtLKj8IA=;
        b=ioSXG0Qtt99vKpOF1RyLMupvf7FEIDAv1EZrayfeGPXNdDwt7+URlXELwpjI6rRADx
         icOiMJfhdQJoixvy89PvfsYvrD+aL1mKdYw281NBEa8A4LqVN/5qMjifWLi45pRSTqja
         zUbKFzBafloH0PbsBkKfNIpkY+j6xHTKaMAHez5ED4FaUcrYJgUT5pofoUP3im1Vags+
         V1hExY6/TYxa0WZCR72745uqUVpoeFSFmHVTO5Xxn4mM9WhoRhSluH/d6SPOBy9UzIEM
         diYoacKKE9pgeaxfNTPAFYRmKs3uErltnbcbcA3JhDi6AFelrHY7EMB4ZogLwJLWOoZf
         TBmg==
X-Forwarded-Encrypted: i=1; AHgh+RoSquEqMqujzwEQZn5Dj/aKCXkj7DE+iipctLvuQ/tRGsS8d3g/CWC4px5lC/wEgr34pKhVRffoRDDePw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5tsiSlPRL8UmY6CMkdK36BttgUT0oxDMsOEOQ/wqcbwy80NOz
	0bWotBV7B6QqTOADMM266F4tjEjYO/YzIjG4CDTRRInpzqKNBW9l09eZfw6jUyi3vtT7mbtjk4B
	CNyvDD2+j/S2J9BD4dqnfZFHyf2b4/1ekv/xr4p+D8uwRnGTnci/Bf1P7Y+3U
X-Gm-Gg: AR+sD11L78v66v8hkIc15S/bqoFyzZlAqW/MVKSu0kaydurjJnodLv4gBJP9YvSRcLM
	PJbvtXazqdsvAKlm7IluKMk5UGhT5XvHu4ZViB5E++hDWz1DWmMBzdkrOADvKvyhbgqOzf9KcUp
	XPJW7WyviRR0wOejUN8Y1D7b7K83rqPhmCT+xLGGoCwDskjBiJZeBrOQAw0L89RpS/e9lgFBs3R
	VxoI+3T8YPhp8LqJkLS4JVmRC8FV82UvvBC0jakGuX87siQ213L0Insha3PSv7Tw8qQtUJirXjg
	OtQdOSYs/c1mgEphIkZTI0/sApyLCJC6kmCYZBlXMVOT+9HSi68IvOAcEbcWu9PjO1sQd3Er0XY
	Iex5QHR23Ro8Zz8s/bIII83rO5m5hsB5ZvIwAqImCEzlDgw==
X-Received: by 2002:a05:620a:3709:b0:930:f852:6daf with SMTP id af79cd13be357-93487207b6emr145582285a.87.1785394739072;
        Wed, 29 Jul 2026 23:58:59 -0700 (PDT)
X-Received: by 2002:a05:620a:3709:b0:930:f852:6daf with SMTP id af79cd13be357-93487207b6emr145579585a.87.1785394738610;
        Wed, 29 Jul 2026 23:58:58 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3221bc7sm349752485a.7.2026.07.29.23.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:58:57 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 30 Jul 2026 02:57:51 -0400
Subject: [PATCH v7 1/5] block: introduce bio_in_atomic()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-blk-dontcache-v7-1-3e8e6850068d@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785394735; l=2716;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=hHCEZENfCfsEpOmC0wBfWJMFm3C20nG7DjOTxirSTUU=;
 b=0SI7Xl8K46e0uZlTQGRMH9PF2VforZ2ADnod5gEhiUnACnwVjnxh4x+kTnl1qD5D6oyl3rPbF
 pLBs0BjnLHtCNXNT9pp0MnVsyv5sMsoS/rOivi/TnyaG9EJUxZTJlIh
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: H1c6S96lHWAr5RYghuXf_MjFGyMhOVMl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfX8HiGy2Uc4rRp
 Vxj2aQd5YtMetWmufLMftSngm6k047XgAklLZEWbjNlVdLzxBbrDgct98czBjjkDppUf6clE57T
 5dQfykn7zVIYF9wO4HdLutVd9tZvC7nGeaIWPBSvkgXa9PtVHRod
X-Authority-Analysis: v=2.4 cv=S4PpBosP c=1 sm=1 tr=0 ts=6a6af635 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=JfrnYn6hAAAA:8 a=i_Ns0s3d_2HFdJHkmwAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: H1c6S96lHWAr5RYghuXf_MjFGyMhOVMl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfXwB6pFPTNwwvV
 gS11TfDlUWQuGWuXrTb2Jk7outf4iLMrTw/VUW+K8yk7FaQoFIwNw3Jyq7nrFc84IcP9i27TWr+
 kKNMYITEEzUr9SOHk4F2v6VfoYYQJfBxZHCCKlrTqiapkr2kT4HN1hUKxhQ5bb2Put45RhbENBS
 ihN1NqK0JeQUhWEo6inDi+O0oCAxcnigdpSpSTeeRnPLrulVk1pzzletPyr1ydgYe8jOa4rUg8E
 BjfmgSu5W0+MzG5NlyUXsRp+nw/A59xLswxD0Ulv5VCJ54B6d8zxDzg7UbFmsGAfNZTKGqQNpFH
 hHtuHYGwUxgh0N8b/BfWq32hD76dFOKqSdYKqpTXJsBjDZA3Of7x12NgUZRWip36tdvt5SiXuYy
 vlVOKZpDVVhCEM4rFd1yItsFmmVUpkq2ioNULs4zq6mp/46AXpfx3CFke1J2FPoIzZdnsWLg5pL
 dpUJF/VJgr59oXJ0cYA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=10 impostorscore=10
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300048

Move the atomic context detection logic from erofs's z_erofs_in_atomic()
into the block layer as bio_in_atomic(). This helper returns true when
the current context is unsafe for sleeping bio completion handlers (e.g.,
hard/soft IRQ, preempt-disabled).

The logic was originally added to erofs in commit c99fab6e80b7 ("erofs:
fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC"). A
subsequent patch will use it in the block layer's bio completion
infrastructure, so move it to include/linux/bio.h where both subsystems
can share it.

Convert erofs to call the new bio_in_atomic() directly.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/erofs/zdata.c    | 11 +----------
 include/linux/bio.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 74520e910259..f796bb3ef53b 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1427,15 +1427,6 @@ static void z_erofs_decompressqueue_kthread_work(struct kthread_work *work)
 }
 #endif
 
-/* Use (kthread_)work in atomic contexts to minimize scheduling overhead */
-static inline bool z_erofs_in_atomic(void)
-{
-	if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
-		return true;
-	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
-		return true;
-	return !preemptible();
-}
 
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       int bios)
@@ -1452,7 +1443,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
-	if (z_erofs_in_atomic()) {
+	if (bio_in_atomic()) {
 		/* See `sync_decompress` in sysfs-fs-erofs for more details */
 		if (sbi->sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
 			sbi->sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 8f33f717b14f..62a983758e09 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -368,6 +368,21 @@ static inline struct bio *bio_alloc(struct block_device *bdev,
 
 void submit_bio(struct bio *bio);
 
+/**
+ * bio_in_atomic - check if the current context is unsafe for bio completion
+ *
+ * Return: %true in atomic contexts (e.g. hard/soft IRQ, preempt-disabled);
+ * %false when a bio can be safely completed in the current context.
+ */
+static inline bool bio_in_atomic(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
+		return true;
+	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
+		return true;
+	return !preemptible();
+}
+
 extern void bio_endio(struct bio *);
 
 /**

-- 
2.39.5

