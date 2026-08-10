Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E7364953
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786378225; cv=none; b=jIgZTnXzffO/oJwuzD98glepoD52Op+pxMYtpdPxZcoASGBhQI56waIP9vvTa6A4JZYCp0Ee6C/Cx+ogWQyI+FOkQsgmW5oT1laG2uGKP2ldIYP2/ZYwEVEAPdg9tyGoNS3vUGKDm1FiJMXvDQQGnFJFADIbkjj+7tgIR5zDo4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786378225; c=relaxed/simple;
	bh=/AF03rHuJDyQBfFPu4ugDlBCG/z+8RMKjZwI9veqS/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABlBlDXsSdSaVIe8W95jOjsJv3uuG1nCHkyUDAjzufuc5TLmY7RCFBqP7eHttj+BDXvRAIYCY6gkETOdN1SeEC6rkK5/QJJfTgXZjclh/U52P5BBkHuDmxH7YaFcCudxBU8jn7w26k9rNn3nPeS321FA/WAgclDUNJm8upsblow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=CyN46gAF; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="CyN46gAF"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFd26n3733827
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 12:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=f0bZ
	ditIahGukFZnD48c1dgtAdNiTQKz0eXUlzu/oaY=; b=CyN46gAFzGTv5sCQAiJ+
	xhJD7DYCrTeiGETf4yox+1+3CDtlrqNvkTFW4J4vobHmLbXUHDE3doFn2xz6glN6
	k3BaKUBMntJiRVVcyGVM+aPSYqFm+iaf0XYNNoNBeRDmY9JppLG3h/hrnHSqxXvv
	vjK8KVgvBMjsQt6iPYPncBt/4wLvSNnFasjiicrFClgJgyo8becIWZAI0ulxYnrR
	6gWJbEIwkZVX0gc0uqUhLZ6UiI8xM4a2dmU0T4jB029Z7GGdBlXVd/OkAW3bqRIn
	Cc8m/OyKwiMnlPkQ7RPRQxLQ1PMxJu4vRWd97Of20SU/QcoKr4fq6yE9zIqHq0a3
	1Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fygb6gw4x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 12:10:22 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c07f25de2so16120591cf.3
        for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 09:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786378221; x=1786983021;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0bZditIahGukFZnD48c1dgtAdNiTQKz0eXUlzu/oaY=;
        b=QDemAuPTbjfaPpxsfr9Bcfl/a9m1XY5INNo/FAPwtTXyX5KffzjnOldOByRIsU+vVJ
         CbhherR1HHaHNp/j32tU0SnCm/IZcOTvHCsiOMS7j9Nt+xaNpWwlXaGelOKnsanxweyw
         zeufWkRU0N2Z3Xu+Fr2u8bsksERjzfXZx/KcjlB8B+LKXRHPk2OnCRIbkorneYXAchO7
         hxAyc1+tIivvWQxVs3y+Mlns47ST2kiVQZF9ze7YOKQKlHor2OJXAhKTsRmBDmbRghNE
         +qPzT6XFxT9tR3UyZQVxMFBAohjaeYhGWwcM7YAAx4yd12HSpmQEv5OdJC4yKvMTiw3E
         r+qg==
X-Forwarded-Encrypted: i=1; AHgh+Rp40MORP336fNUISEnE2cPmGCjlMD+6JWqkkceq4XZCyjZsr3es0BegVDivAMfNbiLn19EQW7mL+I7K2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDmo/0i4UkhnA0xpSEG4ZkA/87Ah6Ka9SGA0yPHoUKlUGWPQV8
	dIpwNEK005ftoQPtXgotiCE9T1F8iudefpq2E1/WmkakACxhAb4kc9T7ClN0S84vgqkeN9WKWRs
	iShwX1biGCAOTIcVaiw5d1wvYiQYfdG8NzJf6xhG5qN+UWvd7JFcK9P8wqWgK
X-Gm-Gg: AR+sD11KijIqlQvfQTDrdn3EoEd65NYHlbDjhxDmNugL1h8AP4qiaTR+pO4BRtY4PQw
	0/P540aSBZaxltOaxHE2PAZFjQFZl3xziVjN+QyMa4KQhUK0oEl1gIF4ipNcDK6HsfUfi4EnH2y
	zpeyclu7SvdukjuxBttx94URjfkSLVViPnr+nIzqqR8LwWxww1Yilzp8z33+1pUWiF/caGWRfKN
	wmX1oZGeh0HleU4BzVbLViY/l1s34sAriGaFjt1/97tiBv3iWrnr+mfbJjnOL+9C3CqPcEZ2QbJ
	RiY1G1LoOOijtF2tQam/SspZMG4v0Ywm0cXQ6WVpYpTb+yhQiPIgJGWGR8GV4q+oGdUkYjewL2m
	b2WCb4RJJxItHmWbb0Y7KhiVCX7WhcD8Pt7MS7RYV//jB/raPpDgW/w==
X-Received: by 2002:ac8:7fc7:0:b0:519:89b6:78b4 with SMTP id d75a77b69052e-52d20a819bamr234404751cf.40.1786378221629;
        Mon, 10 Aug 2026 09:10:21 -0700 (PDT)
X-Received: by 2002:ac8:7fc7:0:b0:519:89b6:78b4 with SMTP id d75a77b69052e-52d20a819bamr234403791cf.40.1786378221085;
        Mon, 10 Aug 2026 09:10:21 -0700 (PDT)
Received: from [192.168.0.165] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997402a89bsm4159805e9.0.2026.08.10.09.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 09:10:19 -0700 (PDT)
Message-ID: <8eb00a03-d6c6-423e-9768-48fd2566f11d@columbia.edu>
Date: Mon, 10 Aug 2026 19:10:16 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RWF_DONTCACHE regression fix for xfs
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Hillf Danton <hdanton@sina.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
        Christoph Hellwig <hch@lst.de>
References: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
 <annkDbhXBEeMoNVT@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <annkDbhXBEeMoNVT@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzOSBTYWx0ZWRfX2Lq/FeJbENus
 atwGHQsWzRlbI4BEiY1hKiBo2ftsupMeZ/P/sVyz5ej0yYlKYaWQIXAbuubUI3XL8sZ2TEmfYCG
 zUdfolzd+QTJtylQi0qxMuwPk9vuUDzgTCg95QselSeVC0xLiAKW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzOSBTYWx0ZWRfXwsJSAHD1iaLr
 M7NbOPnBhBFC71IXvJCxbVA6heCOVgEue4Ud7flWex2uZ3FibrQpRNRjPX/gL+iJCX8BbJLXmxg
 xnXaCE+IstLyJBgDroTjKSRTKXuOegOn9Xi+j5S4otEVOBMcTDQpmheyEDNr6yY7IJ8RMcZg6AQ
 Pwb2/4dEWIfEEctu3phmmMCd9Ud7wh329B0wPfh/5DGkM2/9Ebji/Yd4vv7oF3KGDEZN3Uqm5Ka
 VJ9i+QEV9AGVp3ofiWZaZcXZV+2/bmF4C0of6sbqkN60bpAkxMIzPKWYqBvFxRF2JWW6tluuiAq
 E8BpdegqvO/aiyf38UjAWVdxk1PT6QM306am5oqAjwPzi0whc8VAiT1qgfyEt9lEYjKeT8AqZLh
 2qD3hR9g8giPcLNdFpPbgnss/98yfUmCLqbJ84O1Nhm181cnhtuKnokOKh0EqtsoTDK83qSFUNG
 dKcJVM5t6Q1P3dqFw5w==
X-Proofpoint-GUID: mSibRuZLx279yj3Nl-kHi0gXlU_NycTW
X-Proofpoint-ORIG-GUID: mSibRuZLx279yj3Nl-kHi0gXlU_NycTW
X-Authority-Analysis: v=2.4 cv=MuZiLWae c=1 sm=1 tr=0 ts=6a79f7ee cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=dys9yn6NND9hJ5TNHOUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11871
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=10 phishscore=0 lowpriorityscore=10 clxscore=1015
 impostorscore=10 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100139

On 8/10/26 10:45 AM, Christoph Hellwig wrote:
> Below is Tal's suggested fixup for xfs with the whitespace damage fixeѕ.
> It should probably be attributed to Tal instead.  Can you handled it
> from here and send it to Jens with your signoff/authorship to avoid
> the performance regression in XFS?
> 

Yes, will do shortly. Thanks Christoph!

> From: Christoph Hellwig <hch@lst.de>
> Subject: xfs: avoid double deferrals for RWF_DONTCACHE writes
> 
> XFS already defers some writes to a workqueue when transactions are
> needed to process the I/O completion.  Disable the block layer bio
> task completion in this case to avoid a major performance drop.
> 
> Fixes: efbde6f9f449 ("iomap: use BIO_COMPLETE_IN_TASK for dropbehind writeback")
> ---
>   fs/xfs/xfs_aops.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index f73e26d9c9f9..059846a8d65c 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -372,10 +372,14 @@ xfs_writeback_submit(
>   	}
>   
>   	/*
> -	 * Send ioends that might require a transaction to the completion wq.
> +	 * Send ioends that might require a transaction to the completion wq,
> +	 * and disable the block layer task completion for them as there is no
> +	 * need to defer twice.
>   	 */
> -	if (xfs_ioend_needs_wq_completion(ioend))
> +	if (xfs_ioend_needs_wq_completion(ioend)) {
>   		ioend->io_bio.bi_end_io = xfs_end_bio;
> +		bio_clear_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
> +	}
>   
>   	return iomap_ioend_writeback_submit(wpc, error);
>   }
> @@ -481,7 +485,14 @@ xfs_zoned_writeback_submit(
>   {
>   	struct iomap_ioend		*ioend = wpc->wb_ctx;
>   
> +	/*
> +	 * Defer all completions to our workqueue as all zoned writes require a
> +	 * transaction to be persisted.  This also means we never need the block
> +	 * layer in-task completion for a task context.
> +	 */
>   	ioend->io_bio.bi_end_io = xfs_end_bio;
> +	bio_clear_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
> +
>   	if (error) {
>   		ioend->io_bio.bi_status = errno_to_blk_status(error);
>   		bio_endio(&ioend->io_bio);
> -- 
> 2.53.0
> 

