Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6AA40149B
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896017; cv=none; b=F9QcH9R+sv2lOJgeZQPg2+3qEnLiT5eDu9VHywNa0K7/nTCAY3UB1znSyFxW8mRapj/JXjmX3CbrGEEx9J8gW6REdgBGryQtoLuvZeTFoaoxue1Yslewf75xXvuEEG7+pfdbFcbTlFdmsDBcniiWTIYS2woUbjDz8BrTzlwiMhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896017; c=relaxed/simple;
	bh=OeVHeD3NY9Ivc5lJAGpShZ/dGduawKWe1Tx6Xabt3G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLIrPxcqgzKh6Er/u4paqvx2tSTREu35hqbI0VCGDHLjJre315zma3FVY51b2tIrL/X88uNGkrBRqvozLfkSWrDqolOfhOE/mEcmVRnJE6TZpPUubuAPVkqNIJS3pdCbwfRyd7Gig94alJUxP7OdOQjUogHbjHjjXjlEIZFYo9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rlxkECWc; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rlxkECWc"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gQYYB5Q7tzlgqsP;
	Wed, 27 May 2026 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779895996; x=1782487997; bh=7zs+Rf6tLkWKnXiVrLPyf/Yj
	+TkDzuigYTsemIOUF0g=; b=rlxkECWcS8gYk8ShWSQ/7MbJ8vv75nKfKGbgcAG4
	J9buDUMmKhXked3Qf2iW4JPBd8cGyO+4MZlkERxL5tBU+l61ZUC+GXqDBWDj+uLZ
	cFFgROEadt+iuDLKh2Nb22efxslsFEEaRX5emRehALsrtMlC548u6JduWE5jK50p
	RviN6WquPbkKOyIbwUEGNG9g7KAlUyeIp5TQTVhgKRXp+/B9X2DA6MorTxO9b55Q
	s5gh+XTaAV+XDaoTh8o+TWYbcqlEipDoWjKe6r6hg0rsSSZ+MUU/+ob8Azq+AhIB
	6k1hV+/e5bzoYx4mfJzrFKh56F9xu8UohoSAUwuq8wEDXQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gWTByYDW-wgT; Wed, 27 May 2026 15:33:16 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gQYY74f0Yzlfl8H;
	Wed, 27 May 2026 15:33:15 +0000 (UTC)
Message-ID: <dd49bc0f-c399-4879-afcd-28c817f2f7e7@acm.org>
Date: Wed, 27 May 2026 08:33:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: mark biovec_init_pool static
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20260527150646.2349405-1-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260527150646.2349405-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/26 8:06 AM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/bio.c         | 2 +-
>   include/linux/bio.h | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 2d880d1255fe..e9944dab0132 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1873,7 +1873,7 @@ EXPORT_SYMBOL_GPL(bio_trim);
>    * create memory pools for biovec's in a bio_set.
>    * use the global biovec slabs created for general use.
>    */
> -int biovec_init_pool(mempool_t *pool, int pool_entries)
> +static int biovec_init_pool(mempool_t *pool, int pool_entries)
>   {
>   	struct biovec_slab *bp = bvec_slabs + ARRAY_SIZE(bvec_slabs) - 1;
>   
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 7597ae4dc52b..e60d2f5bd3dc 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -347,7 +347,6 @@ enum {
>   };
>   extern int bioset_init(struct bio_set *, unsigned int, unsigned int, int flags);
>   extern void bioset_exit(struct bio_set *);
> -extern int biovec_init_pool(mempool_t *pool, int pool_entries);
>   
>   struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
>   			     blk_opf_t opf, gfp_t gfp, struct bio_set *bs);

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
