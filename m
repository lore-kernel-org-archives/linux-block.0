Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355971;
	b=P47kslxgnphrNhs6cRjEhsToIQedLGsjx2hLsSDqQ6E7DX20zgMvx9paO7JEdN4GaxUP
	 Xg0hsSq6PhxD1mhg8sgyxFEARnwBfmSLYhSFpwfxsVDyKeRT48GVsrAaonx53eT0Lr5zT
	 QIQGP4B5Cu1SsqUoSDNC9m0kJFrUaHhidaHl47da7EvTkpdyFnBExF35tHlxzv2oa3fg9
	 I+Svfx1l1C19C18oyvrulEFHQQD6fV6CTcsb7vjtJYl1aWTyfNUVXBFz1Jlc6RaW5wcr9
	 GHqn0CB4qSCPAKLYxllWJtUqoyv/p0cR238eNQySePTQgImuGXw0pSTtIj2qNFFzWYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qUelzvzI0I1/N8qXjV1BcthIIh2qTCSRp7SQgDbPekE=;
	b=Toc5Ix70jXEzkeyUpEuiAMW+OYxsslAaSCZxFPeuXfu9u0DqvCXOWTUB8TeGv7Dy2oYM
	 qtlMyZjGNfq5NveHPiWi6tEEFh/hbW8btgZVAYC9KEbCfIHIFR642PY+Tiruz8XCtbK6t
	 jzch4dGihnWMwJD0x43nD+WaB+wLp8WJRHCnLEo9OKT62WAP24+Am9vtoz4XRy6IyxM/i
	 6/5X/g5/HJAfpe3f4FoNPHGqGDxLiWsNx1rTdFgEjV5NhKyHPlBKi2a6N2B8nPMJcEhlJ
	 J/69bvgebhHbQtx+9HdUTrmc2eDabmreDSs3e9NBuA5gehjca2GpOhodm13YGMjSWUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhLMcOaL;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D513606A31A
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 10:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D513606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhLMcOaL
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e0d1da913so398178f8f.1
        for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 03:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793355970; x=1793960770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qUelzvzI0I1/N8qXjV1BcthIIh2qTCSRp7SQgDbPekE=;
        b=PhLMcOaL7tR16t9O6qwnKaq504i2yptLi47qNgV2oTRgaJFinkcAjXKqL5IyImiZtT
         SP97MVdHIjdTbyfAFuD7U2d6bVxWfhydX0ZOhHdPc0l5OeQ+E9c+PSj6Rf4MLvAV9dRa
         cLD8CqB18+b5RCnqDP/SbF9KotPj17RkpymGVZef9iNn8w/r+UfrIuj6Nep9ElZ28bjf
         qKWVOaDHUGTmSZuLNgsKzw0EgGZFipgVCdG0lzH8bCGTiciYoyATJl9h748ncbkk0418
         WE/xegpkV4LyN4mWZ3GeIFEnBBrL9gjhvziGkyy0ia56EMIZDyW6cn4RHfAnJFwhE41Z
         cFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355970; x=1793960770;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qUelzvzI0I1/N8qXjV1BcthIIh2qTCSRp7SQgDbPekE=;
        b=U1yi7t3h2Poqkvm7tAlddVYg89mF3HnBRj5JXFee1mg15defbJbov7a81gHXYYKUTV
         ix2MOT10HFlmaZOhfVLsrZN5FZgLKxsq4A2NL+2pbO0mn9ti9MU5uwpnu0FiLQPjlFz0
         zf5Jtd7WVq+7MKTADxH+s50z9mmNU2JgHpsPJ9Ux6IUwg3C655DUPNer+gXEvRUqpd95
         pNmOKBq1B26AHnPfWhPanGcmfnkrnG146rPjzMpOd0hKO82Ty7ovva8D2G9CJlTxdI1Q
         fT1FpPgH4IwPlZZ4VjGgNG3QuqB+GbO4JDliDiQa7aUFBYpoXueMC13z9z5N0711zype
         N0kQ==
X-Forwarded-Encrypted: i=1; AKwUvBydrT5icB5s3srqbedlr/9wPhs2smF/HlJjOGZgrJszWVFhfw6aU0cCNtkcQ1n3e53SKBnC/ufwkVILKA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKdRATLEPvrAoW4k+KDfzM7/uXkZrQbVn7brbPDV3I+r0BMWoR1
	GVNYj7Kwo+zsOOeKh04OvqmZhFLbL5YsqWOafr2WWLAyPHiyHQiCCt+4
X-Gm-Gg: AYBFou26HrPvBv9rYsj5EYYi+X62sUzu+qWbnUm9mqHxSpyUJSzmPH+Pe7YiILlh+He
	1EHEhubE/vr1lXB8zo7VVpOBTJFuEcbOzSbtqviv5wBr1obQucXBBYAz6vpt/f5lBPxxGmeIFi6
	lUQ+qhen9ZMGGLzMdnlWbvyQ2ntEURim+7htTK4YbqM4Vl5PixhQBpsr6ghuCk6djXTnjAcKvIA
	okR/Qwiy//OFyDg3CDH+J9fS8/qnY6F65wFa7vWK8IiS7oy/TQ6bOUEG6H6pVhyM0fHgLXZLpHO
	YuDsK4Hulumb0q461NZ16GKfbgaLLq/rBrtFjxZEbdkGY/eNBiqkETPTmQ1eYFnM4LDViT3I4L2
	YxwAX+oRz82LvUSMRbQOOGzYtRYSfz/REhih8eD3+2lPCy8m1cYsKDSKh+HO8V4+aPWjPvCJGe0
	/5Rdz5Z/scVuGVGcz3pJs4257fAmqlIkfr36Z++JYs3QkFbZthTF6fumkLsl5AqA1NWQ5c4Lg+K
	2G2V30uz11/AfdcIjIIli+tFHuG0JoQgs1fqLKnbw571dWusf2de8Draq6aA6d0KVVs8yEtXuuI
	FA+oC9lEZqkkfqpT5/iKt5yFyphzdTPdcLPSQmCwk9BtTDZ43B95oCg4r2Aj25Ob5GkhisRU48s
	AaMAdT9qFDg4pBkbtVF5pUNDPDzMBBPqyRwWPG/5efczU1t6vh8ngdZgdZQNbWO1bNxsPTSD3GU
	ZcrA==
X-Received: by 2002:adf:e011:0:10b0:48e:6c3f:f7b2 with SMTP id ffacd0b85a97d-48e6c3ff7d7mr5879996f8f.23.1793355969523;
        Fri, 30 Oct 2026 03:26:09 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80ecbsm2527884f8f.35.2026.10.30.03.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 03:26:08 -0700 (PDT)
Message-ID: <bcafcbcf-9503-4fe5-82e4-ab9f8a3cb687@gmail.com>
Date: Fri, 30 Oct 2026 10:26:09 +0000
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: only fail dma-buf bios that need block layer PI
To: Kyle Bader <kbader@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: Kyle Bader <kbader@ibm.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Tushar Gohad <tushar.gohad@intel.com>, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261029155821.2983229-1-kbader@redhat.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261029155821.2983229-1-kbader@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 15:58, Kyle Bader wrote:
> From: Kyle Bader <kbader@ibm.com>
> 
> All dma-buf (P2P) I/O to a device with integrity data is rejected
> today, at registration and in blk_mq_submit_bio(). Only a bio for which
> the block layer generates or verifies PI needs that. The block layer
> then walks the bio_vecs, and a dma-buf bio has none.
> 
> Reject only those bios, and remove the check at registration. Then a
> submitter that attaches its own PI, for example with
> IORING_RW_ATTR_FLAG_PI, can do dma-buf I/O to such a device.

Looks good,

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

It's also enticing to shove it under the existing
bio_integrity_action() check, but it can be done later.


> Link: https://lore.kernel.org/all/bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com/
> Assisted-by: LLM
> Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kyle Bader <kbader@ibm.com>
> ---
> v2: a shorter commit message (Christoph), and Anuj's Reviewed-by. The
> code is the same as in v1, so the tests of v1 still apply.
> 
> v1: https://lore.kernel.org/all/20261028181412.1919506-1-kbader@redhat.com/
> 
>   block/blk-mq.c | 9 ++++++++-
>   block/fops.c   | 2 --
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7fff1305b..3fc9fdeb3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3138,8 +3138,15 @@ void blk_mq_submit_bio(struct bio *bio)
>   		goto queue_exit;
>   	}
>   
> +	/*
> +	 * The block layer cannot generate or verify PI for a dma-buf bio, as
> +	 * that walks the data pages.  Only fail the bio if it needs that, not
> +	 * if the submitter attached its own integrity payload or if PI
> +	 * generation or verification is turned off for the device.
> +	 */
>   	if (unlikely(op_is_dmabuf(bio->bi_opf) &&
> -		     bdev_has_integrity_csum(bio->bi_bdev))) {
> +		     bdev_has_integrity_csum(bio->bi_bdev) &&
> +		     (bio_integrity_action(bio) & BI_ACT_CHECK))) {
>   		bio_endio_status(bio, BLK_STS_NOTSUPP);
>   		goto queue_exit;
>   	}
> diff --git a/block/fops.c b/block/fops.c
> index 01bc8afe3..5c8024011 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -947,8 +947,6 @@ static int blkdev_init_dma_buf_io_ctx(struct file *file,
>   		return -EINVAL;
>   	if (!disk->fops->init_dma_buf_io_ctx)
>   		return -EOPNOTSUPP;
> -	if (bdev_has_integrity_csum(bdev))
> -		return -EOPNOTSUPP;
>   	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
>   }
>   
> 
> base-commit: 45b716456dd99488a0cef58482120dc0474aa696

-- 
Pavel Begunkov

