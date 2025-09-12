Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E43222582
	for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757646902; cv=none; b=CYXYjlF4hX0QHsZs6VXISKUGH+mKmsX9YoEKMKTwQA37ORAN2Ho3raSaU10lSA1kOOikMFsjQdXcVuRzoXCuSroHeNQPN6pzTeITIRz3auf3K+5iCmLiOlpwEzgRSK4PM+dX3UEwu+q3VwthBtYsPIMAYnZpPh5+Wl4aSg5cfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757646902; c=relaxed/simple;
	bh=A8Zgi4kyYrz+VcezB5BnREYndevofiMV6qNejq8swZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=XlybLlNBv01D8dK8uQD99zuKF5DQJ+RZOiVXTWOBgHnpbkNFFaXqNbBJH1obN9uOrj35R4nztR4oW4DvCFVlIRqs2H15rgtl5vVK6kNWNCzsPofkLZE3+2sf0JpH4SsIBD+VGi9TfxZZ8osn7AXRkKzYAp4eBVtkNF9DXGEQ3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NAZg/u0v; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NAZg/u0v"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250912031457epoutp029b57ea4747e740f1557f87b4d3229965~kaoqGr_CR1190711907epoutp02G
	for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 03:14:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250912031457epoutp029b57ea4747e740f1557f87b4d3229965~kaoqGr_CR1190711907epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757646897;
	bh=3NM0DqzQah0ZzTtHgBZREV5jdbjqfPi7VwM4heyyDus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NAZg/u0vFDHwRQgNRAWV0/0J7dmipScMQXNPiz3tq6Mthxz4xiZqYf97h7wOjekDA
	 SSo3qk8EhLqa7MbTpc1tKGwW0hKybggQKaD/56fj5zBBl9M+4ZeO3UKyt42qpXRQ7u
	 J+BbGzPytEh7XAWTxtSdLchosmXi9y3OpSWFSNPU=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250912031457epcas5p269cebe29bef1c77c2a7588c0d9032554~kaopvGOHy1904519045epcas5p22;
	Fri, 12 Sep 2025 03:14:57 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cNKKr37ymz6B9m5; Fri, 12 Sep
	2025 03:14:56 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250912031032epcas5p3f38da43ad6cf93b849bb44f14e49c8f9~kaky5-geZ0074300743epcas5p3n;
	Fri, 12 Sep 2025 03:10:32 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250912031031epsmtip1f497818f0ca9f7b10491d8a2eff7816c~kakyNZGVV3046230462epsmtip1O;
	Fri, 12 Sep 2025 03:10:31 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: yukuai1@huaweicloud.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, xue01.he@samsung.com, yukuai3@huawei.com
Subject: Re: [PATCH] block: plug attempts to batch allocate tags multiple
 times
Date: Fri, 12 Sep 2025 03:06:01 +0000
Message-Id: <20250912030601.236426-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bfc12406-e608-b3fa-45e7-2105d9cc15bf@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250912031032epcas5p3f38da43ad6cf93b849bb44f14e49c8f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250912031032epcas5p3f38da43ad6cf93b849bb44f14e49c8f9
References: <bfc12406-e608-b3fa-45e7-2105d9cc15bf@huaweicloud.com>
	<CGME20250912031032epcas5p3f38da43ad6cf93b849bb44f14e49c8f9@epcas5p3.samsung.com>

On 2025/09/03 18:35 PM, Yu Kuai wrote:
>On 2025/09/03 16:41 PM, Xue He wrote:
>> On 2025/09/02 08:47 AM, Yu Kuai wrote:
>>> On 2025/09/01 16:22, Xue He wrote:
>> ......
>
>
>Yes, so this function will likely to obtain less tags than nr_tags,the
>mask is always start from first zero bit with nr_tags bit, and
>sbitmap_deferred_clear() is called uncondionally, it's likely there are
>non-zero bits within this range.
>
>Just wonder, do you consider fixing this directly in
>__blk_mq_alloc_requests_batch()?
>
>  - call sbitmap_deferred_clear() and retry on allocation failure, so
>that the whole word can be used even if previous allocated request are
>done, especially for nvme with huge tag depths;
>  - retry blk_mq_get_tags() until data->nr_tags is zero;

Hi, Yu Kuai, I'm not entirely sure if I understand correctly, but during
each tag allocation, sbitmap_deferred_clear() is typically called first, 
as seen in the __sbitmap_queue_get_batch() function.

        for (i = 0; i < sb->map_nr; i++) {
                struct sbitmap_word *map = &sb->map[index];
                unsigned long get_mask;
                unsigned int map_depth = __map_depth(sb, index);
                unsigned long val;

                sbitmap_deferred_clear(map, 0, 0, 0);
------------------------------------------------------------------------
so I try to recall blk_mq_get_tags() until data->nr_tags is zero, like:

-       int i, nr = 0;

-       tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
-       if (unlikely(!tag_mask))
-               return NULL;
-
-       tags = blk_mq_tags_from_data(data);
-       for (i = 0; tag_mask; i++) {
-               if (!(tag_mask & (1UL << i)))
-                       continue;
-               tag = tag_offset + i;
-               prefetch(tags->static_rqs[tag]);
-               tag_mask &= ~(1UL << i);
-               rq = blk_mq_rq_ctx_init(data, tags, tag);
-               rq_list_add_head(data->cached_rqs, rq);
-               nr++;
-       }
-       if (!(data->rq_flags & RQF_SCHED_TAGS))
-               blk_mq_add_active_requests(data->hctx, nr);
-       /* caller already holds a reference, add for remainder */
-       percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
-       data->nr_tags -= nr;
+       do {
+               int i, nr = 0;
+               tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
+               if (unlikely(!tag_mask))
+                       return NULL;
+               tags = blk_mq_tags_from_data(data);
+               for (i = 0; tag_mask; i++) {
+                       if (!(tag_mask & (1UL << i)))
+                               continue;
+                       tag = tag_offset + i;
+                       prefetch(tags->static_rqs[tag]);
+                       tag_mask &= ~(1UL << i);
+                       rq = blk_mq_rq_ctx_init(data, tags, tag);
+                       rq_list_add_head(data->cached_rqs, rq);
+                       nr++;
+               }
+               if (!(data->rq_flags & RQF_SCHED_TAGS))
+                       blk_mq_add_active_requests(data->hctx, nr);
+               /* caller already holds a reference, add for remainder */
+               percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
+               data->nr_tags -= nr;
+       } while (data->nr_tags);

I added a loop structure, it also achieve a good results like before,
but I have a question: although the loop will retry tag allocation
when the required number of tags is not met, there is a risk of an
infinite loop, right? However, I couldn't think of a safer condition
to terminate the loop. Do you have any suggestions?

Thanks,
Xue
