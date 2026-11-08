Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794157588;
	b=TBEAjDn5WXcGW9+fmkIXjGzqORxIK5G9nOXKHkPw4DBmzAa6Y5moq9cwh3UJgk8lK7s1
	 BAk9KWmXpta5ezJ+rBZ3jWPZ8WqpAbqII2zh1Ygi9RZYXLsAjX4uFHs4+xiaO90Ud6IRX
	 sQ1w/Pn4J7m/GkefF4uGtS+6jPNGS1pIZ2+cBdiMxgxXDCYNnv2VrVaZs6vz7XtcWgQA6
	 OPJCnQElt2We94shDN0DoLJnY4GY3Dprnt+jXOj2wO1mbTjizI0TZKtH5bl81fyrNgYw2
	 yItzBxLEDMTrzMt0T5GlO4TK2rLzGRHskOv+Pa3WSDNDWV4221NhFgrN75mLnZJJL9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794157588;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=IEd3jpYcDB0NK70MyV6liue2t6+43KsA976DKWNPe50=;
	b=e8GQxysJhNRXAzZSjo3WLTq/SXRrhmVPH2vmSHpT1FOr0/kp5eJmRu2pSaqswuMtIw1x
	 3l4z0DgMsFpKb0zNz/UYDavAOflGDyd3lrOk8KRdCWzlK+zbQBsOddy9OUX+9wZFg2Fl2
	 isk71cbcIDP1KxLlKns5qc7PeLoDupLn+AFkYXhXXZ5xQwK3uUehkWiL9TRK8uyrm2suz
	 bUwwLGxKoDhifNVnr/j58AxvrE/GPtZ6cpkt7pLXh6swcxGFbHryCQtnaE36P0hwQ6DQD
	 kkuHvXQABUC+IBrBCIenb0kX63K+YWg/HwnwyTiK4g0DFWAUsh6MzpKIYTnllAT6QhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=V9MbJkdE;
	arc=none smtp.remote-ip=91.218.175.2
Received: from mta0.migadu.com (out-2.mta0.migadu.com [91.218.175.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD20606A320
	for <linux-block@vger.kernel.org>; Sun,  8 Nov 2026 17:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FD20606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=V9MbJkdE
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JkojSWXaqiTE4m7MsVL3k+FVelopN8MwdLMIVVaO17Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794157584; v=1; x=1794762384;
 b=V9MbJkdENmHNBeEfotWF+AMWMIuReMh3cMogaPPYpCteLNr+wC4V4KGEcKLFKMuaUjS7dHr/
 K3ddnXkXT3nWGA9mOrrn7vgz69jBW10m45EYdgFgK++emJu4r7GNjQhBNSwqNOvXs2uzQk34NmS
 fcetf0UxKuqHf3DfXX0TdLSY=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 89021f10fe198751;
	Sun, 08 Nov 2026 17:06:24 +0000
X-Mizu-Trace-ID: 89021f10fe198751
X-Migadu-Flow: FLOW_OUT
Message-ID: <3fc46788-d86d-44c5-8606-385d96fede4d@linux.dev>
Date: Sun, 8 Nov 2026 17:06:21 +0000
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
Subject: Re: [PATCH 2/2] iomap: remove the atomic write length check in
 iomap_dio_bio_iter_one()
To: Tal Zussman <tz2294@columbia.edu>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20261107-blkdev-atomic-bounce-v1-0-f66344262096@columbia.edu>
 <20261107-blkdev-atomic-bounce-v1-2-f66344262096@columbia.edu>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20261107-blkdev-atomic-bounce-v1-2-f66344262096@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/26 04:24, Tal Zussman wrote:
> bio_iov_iter_get_pages() and bio_iov_iter_bounce_write() now fail a
> REQ_ATOMIC bio that doesn't cover the whole iterator, so the bio here
> always covers iomap_length() and the check can't trigger. Remove the
> check.
> 
> Suggested-by: John Garry <john.garry@linux.dev>
> Link: https://lore.kernel.org/all/82978d5c-3e08-48e9-bf0a-7913e1cd0507@linux.dev/
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Reviewed-by: John Garry <john.garry@linux.dev>

This looks ok. But I am just thinking that a CoW-based atomic write does 
not have the single bio restriction, so we don't need to fail the atomic 
in this case. However, we should have consistent rules for iovec's 
whether it's a block device or regular file for ext4 or xfs, so this 
makes sense.

thanks

BTW, you could be a real hero and add an xfstests case for this also.

> ---
>   fs/iomap/direct-io.c | 14 --------------
>   1 file changed, 14 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index ad041ac3252a..aca7cbaea4af 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -370,15 +370,6 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
>   		goto out_put_bio;
>   	ret = bio->bi_iter.bi_size;
>   
> -	/*
> -	 * An atomic write bio must cover the complete length.  If it doesn't,
> -	 * error out.
> -	 */
> -	if ((op & REQ_ATOMIC) && WARN_ON_ONCE(ret != iomap_length(iter))) {
> -		ret = -EINVAL;
> -		goto out_bio_release_pages;
> -	}
> -
>   	if (dio->flags & IOMAP_DIO_WRITE)
>   		task_io_account_write(ret);
>   	else if ((dio->flags & IOMAP_DIO_USER_BACKED) &&
> @@ -393,11 +384,6 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
>   	iomap_dio_submit_bio(iter, dio, bio, pos);
>   	return ret;
>   
> -out_bio_release_pages:
> -	if (dio->flags & IOMAP_DIO_BOUNCE)
> -		bio_free_folios(bio);
> -	else
> -		bio_release_pages(bio, false);
>   out_put_bio:
>   	bio_put(bio);
>   	return ret;
> 

