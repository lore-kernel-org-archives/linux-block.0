Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29B24611E1
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142563; cv=none; b=iZ6V8bPB6BLGTCcpAm0hj8mXwrRPifU0I/FyZOfYDvc1Z2wOCJwg9dRdobd4cR6MPYkum6lO/H+MOMsLXKSG/HcQpnJsj/eHTQlsqaeSna4v+MTCmRfUjZ+BVBqcHGz4RMRPFh+l6yPbYES5pdhkelBlaknZ+sBO461RLRellfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142563; c=relaxed/simple;
	bh=d+e6TUVdQg81gqZTNATl7FmVG9hllqTqWRa0eEaNMFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbB3PfC/m0fnLyxkVN/GnWO6LXxkSAUQ/nuTERR5G2cotjrjuSue/19zLrnwG2zGtYoEKB1Av2NDOGB/xPNek31cCqGVGUqo/IowGKUthV0lsnH2ISmghddOp2Fkf3MXCcw5g6FmHfnHui9VkafNqJ5pwkNXHZdTLjWDdhLYmuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5AQXmNm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5AQXmNm"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so49002315e9.0
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 02:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792142560; x=1792747360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5WdYVBznDcS74hZppO2I4uFcTaGORYJKgYLdvIcwqig=;
        b=j5AQXmNmRcERv2x0CfU95ICqly+8K0o76DtHH6l0dyqaowhdi4KCrjEfoeZj6r6DIv
         or0a07vPXDSPhTH64An55yaRY3nMPsauF5iFXIOEFAEuJHkGCVsV5OVHnvRPreOv6dhq
         lrt5GvvklsDDuKFIZtiKYsuZE0X6/tDHA4Z3IdNztbOgb3RPG4S2XJBKjHQ3zJ6bP8HM
         biDhT1kSlwQ4Df/h4y2Lj1sXESQz/WSIYXEpBfUWvDFxTQKkzn0S+YJfc8Wpn1qcz0zd
         SlXwzqE1Yr0pXinPhh1IJC3rRjPq1tBrTE+c+zk74j8ROevv6VI/whDpnFb3enwNGyyK
         nbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142560; x=1792747360;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5WdYVBznDcS74hZppO2I4uFcTaGORYJKgYLdvIcwqig=;
        b=0aro0Yosd96jJcowKt0kXPZe7PGZM8IyfaobxKshsnxa2UZHfrkc824HONrB6lUG02
         HxnJorKlqzghyo84Z9GkCyY5SkivmpB2Uwjf+LibRVpWEgRJ31WVWrAGDJgOB666s8Hl
         2eKP0ryf7QGAyNbMFjAKXPOlDX4qGAsBQkSdM/Z+kX5pRJ3FkFiOB84gUccL5pdios8N
         yYxe56kyz0UTrWO1O8gQsFgfABcoGtuhk9NHVMq5SuI7ixBdWB4oR8wfFsQQunyrALgr
         gCjQW0ymqaGbsQBhBKpFguNtIy9mknHXgeFZWI1RU73NKLS9KEiKZzUgj0BCHcsxHDD+
         bK8Q==
X-Gm-Message-State: AFq9FYIpq0Uih5S8zuESUC7XFWMcZoAmPyqi0b0AeL2o4TqIvLU0+Yxq
	wuf4494asTh3KhPqfe+YyVQm28Ew2x7XA97SN/fYmVgiP0UYiXRuaTEsHQntZA==
X-Gm-Gg: AYBFou3f2LsYQbtTCF89OxviW6MjsmZ5K0O9rZg5WnB72cwSoq7Un+2Y6O+dUNYhtDY
	FlPxNE+NhBnk1msjUpHi6iOXiMdT2KqlOFDsAhE8adFtWa+7YWTiMDX3QjTR1BYMj3Lh2OMTRWX
	btO20Sx4rx4PJ9f4UmQfugZVun5GpKXUw+JzoUHmlPI4r+xdrPhzTsPUS3iUlrWqIRdHEtI+gwD
	H5mZBzJarjvi5iLRfBz1HFH5ngagVbM0UnMvHJDy2H1qMHdmb8qcc9mlJDTTlkWLb1d2nm8tr2j
	nJRryeYLQHDKrhwdiBC/phI/m+9CSUrWhNDgBWCvRaSkfL+TtlOOPtFe6yCVsuJErLHEg7PYw/l
	jFmLFdOR7hnQJ+h/GdD5vLGCI5ry2vtDojveUQvT9vQQtJbjjqLzn1t32GSxFAKfxPI3owrj/UW
	MqOUL2GhQHo3M0y/oSVGwcOQslfh6c0ko8qiaJPO7WmLemhDAEYr7+btFH9ta9LPE66crl9rU3J
	3WPd0psL7LOu3Vt69pRSkYCNvJNpxZTx5kabbmy0CZDwwM6Isj8WZabeI+Hycfb+u4gMwxklWgT
	0NurgC5Qzqib/BSkoP1DhzmYSq67TrtZySsDRev3T7nkfrgf
X-Received: by 2002:a05:600d:1b:b0:4a1:9661:14b7 with SMTP id 5b1f17b1804b1-4a196611b9amr320901815e9.32.1792142559985;
        Fri, 16 Oct 2026 02:22:39 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bdc036a4sm160111735e9.11.2026.10.16.02.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 02:22:39 -0700 (PDT)
Message-ID: <be2b6881-75bd-4113-bfcf-c3ac9ed2b80c@gmail.com>
Date: Fri, 16 Oct 2026 10:22:37 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix indention for dma-buf checks
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
References: <de91f480f8507d44ddf99c193ef63dec0f02c749.1792142187.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <de91f480f8507d44ddf99c193ef63dec0f02c749.1792142187.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/26 10:20, Pavel Begunkov wrote:
> There is a weird indention I botched while rebasing, fix it.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Can be squashed into the following commit, if that's preferred.

commit d88e44f43e939e6ac0ca8302c6f3c957b33aa5fe
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Wed Oct 14 12:02:02 2026 +0100

     block: introduce dma map backed bio type


> ---
>   block/blk-mq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1b7f8cbbda8b..726de869a86f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3151,7 +3151,7 @@ void blk_mq_submit_bio(struct bio *bio)
>   	}
>   
>   	if (unlikely(op_is_dmabuf(bio->bi_opf) &&
> -		bdev_has_integrity_csum(bio->bi_bdev))) {
> +		     bdev_has_integrity_csum(bio->bi_bdev))) {
>   		bio_endio_status(bio, BLK_STS_NOTSUPP);
>   		goto queue_exit;
>   	}

-- 
Pavel Begunkov

