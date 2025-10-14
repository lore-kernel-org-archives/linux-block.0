Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB216313E3F;
	Tue, 14 Oct 2025 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447178; cv=none; b=lrMl/blOUVBlcE8PQKtzLX6Os4talQtEA5nYsVB2een3MJ+R8ldcYNJUQMFhsBFQva1Nb2wbmos0gvtZhm8T+5G1ONM/Ro2KyfK864HNEcr21PfgF82ZSSv8gA9iI1sZ+fxq2w9UTGhJeJA9gKXkEQ+kf7zHvXq9udfLmrNqS4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447178; c=relaxed/simple;
	bh=FMRMKN/65QkSbO6rI6e3u+TLrLLYCKdJGv94LrhicwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OO1xVoxVosQpUmo375rnL31yWFsy632aodWBB5WAop+P/XQGUtEzwrQCbeYwAEsn0FPrv/dfYFLXIx0Zinol/Do+yTA56NDax5Kem8utRY7HkKoz1e96qVFh2TMAljoS9K7SlPspfvWu15jlOPC+fgxVjP9iux4w9b66SmYFj1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=F2boAKcd; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="F2boAKcd"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59E6ZMve2905485;
	Tue, 14 Oct 2025 06:05:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=cX2hAgeSX8sQp3EdzeOZ8RwmbnMTQ6NpxUrU47Ri+L4=; b=F2boAKcdRUHV
	7hPTeY2+8gRBsulA9BHaZ0UfEpLiF4Dxo79DBEn4GBRwgesIq9Eo89rikTuoK9nl
	0DuA/iz2DcnblPtu8Z7FzgMGl5UDuEpUr2XEztBiD91vkn3uvoYP5H8QiyVF1t8r
	m7z57FjH6w4QZCZteMz0Pd55jyC4oEJhnArSRvmD2MCFeyY+omDBTZR45I3SA+um
	SsMy8eBNXCdqHpMC78OSPHI2TK0jf+NDaYb+KrAsuAaxrkjnxb/66A5GMTd6FR2d
	4NA+OEFssyjjrajTlR9v9CAphr/W7MSIVDbNHPnQclhH+eLnsRRVCmVxLnCppIPg
	UnZ55DuogQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49shcr1uw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 14 Oct 2025 06:05:51 -0700 (PDT)
Received: from devbig091.ldc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 14 Oct 2025 13:05:50 +0000
From: Chris Mason <clm@meta.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: Chris Mason <clm@meta.com>, <axboe@kernel.dk>, <nilay@linux.ibm.com>,
        <ming.lei@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <johnny.chenyi@huawei.com>
Subject: Re: [PATCH v2 for-6.18/block 05/10] blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()
Date: Tue, 14 Oct 2025 06:05:01 -0700
Message-ID: <20251014130507.4187235-2-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250910080445.239096-6-yukuai1@huaweicloud.com>
References:
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: oXRUz5I_LbfgTMXS2msoifkYZ9NEjaw6
X-Authority-Analysis: v=2.4 cv=Y7r1cxeN c=1 sm=1 tr=0 ts=68ee4aaf cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8
 a=aQaWdk62591M1yJ-J1UA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: oXRUz5I_LbfgTMXS2msoifkYZ9NEjaw6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEwMCBTYWx0ZWRfX/u6Xghdx8Xa/
 9KLjvFdLx9+x2Kr9FiF1WDuy1/9VEG6qkeBY0OzZszEXY1LdYp2en2BaWykpWCtmEwfovAmcFuP
 CaVHfP2n8gC/9/wQChA0dHw8t2hOzsuro+KRhNZlTsmNH61JrZWKW+e5Zl80h43Y59rxgM/bDgP
 TZ2e52p3prKqcsat4tKCue81RVan057d0tjMEmmYSH/loT6eW9koFGndNtIB3R/E04gMpX/qhPL
 5o3Z811ynZlX3LWrHq7pArGoQK2Db0TeIroXhUhH2SmhVkLXq2CbCkiK/sppDi+ZtAX6CaYRwj1
 mV55XfWWeWOo30Mh/plGXJ1rngOkhJ3RZairsTUEQg7BAwHCCRvuiFKuxFcGoJYPgD5tgdbMmv3
 s/V/0qqozVfuHqCCPnxL000AP/de3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01

Hi everyone,

My review automation flagged this one in linux-next, and it looks like a
valid bug to me:

On Wed, 10 Sep 2025 16:04:40 +0800 Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Yu Kuai <yukuai3@huawei.com>
> 
> For shared tags case, all hctx->sched_tags/tags are the same, it doesn't
> make sense to call into blk_mq_tag_update_depth() multiple times for the
> same tags.
> 

[ ... ]

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9b97f2f3f2c9..80c20700bce8 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4935,34 +4935,35 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>
>  	blk_mq_quiesce_queue(q);
>
> -	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (!hctx->tags)
> -			continue;
> -		/*
> -		 * If we're using an MQ scheduler, just update the scheduler
> -		 * queue depth. This is similar to what the old code would do.
> -		 */
> -		if (hctx->sched_tags) {
> -			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
> -						      nr);
> -		} else {
> -			ret = blk_mq_tag_update_depth(hctx, &hctx->tags, nr);
> -		}
> -		if (ret)
> -			goto out;
> -	}
> -
> -	q->nr_requests = nr;
> -	if (q->elevator && q->elevator->type->ops.depth_updated)
> -		q->elevator->type->ops.depth_updated(q);
> -
>  	if (blk_mq_is_shared_tags(set->flags)) {
>  		if (q->elevator)
>  			blk_mq_tag_update_sched_shared_tags(q);
                        ^^^^

Does blk_mq_tag_update_sched_shared_tags() use the wrong value here?

In the old code, q->nr_requests was updated to nr before calling
blk_mq_tag_update_sched_shared_tags(). But in the new code, this
function is called while q->nr_requests still contains the old value.

Looking at blk_mq_tag_update_sched_shared_tags():

    void blk_mq_tag_update_sched_shared_tags(struct request_queue *q)
    {
        sbitmap_queue_resize(&q->sched_shared_tags->bitmap_tags,
                             q->nr_requests - q->tag_set->reserved_tags);
    }

It reads q->nr_requests to calculate the new sbitmap size. With the
reordering, this will resize the sbitmap to the old depth instead of
the new depth passed in nr.

-chris
