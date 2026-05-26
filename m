Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8CE3537FB;
	Tue, 26 May 2026 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824700; cv=none; b=Y+EVTn4NCKQJaZM0Dhup967T9oVFJkvzZQ+tduQRd3eK2UB2p5qf4l3kfCCcFUtkGzFAtr21HS+Pa/YZKhTA5C4SJqeL5UwPpx8Q+S3pH8QvHMmEZ4xMPX+m4vofzydi5OgqgrNSwXjcqDie6z3Y1yO5BPPb74uvOdQBfkQXSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824700; c=relaxed/simple;
	bh=hUX+sMpv1RYjQUE0XAWWbaHl/z6Ty9C+AIXiqaj7F8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJRPSOYXxvnSuYxJ80yh/O0pyzaUa8HFsY4bXh5c2523cfaDZfxEqGxiT1AJJ1PNkE2/WL1EHqVxNyjz1MttWBKfQlMYkEwKvhhywkk7PhXS64323QEGOl7k9+60dUEvYfA3htH/GTQrD95ghx3SmKJPncLLOu4JFtSsXLv8jTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mDtGehD/; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mDtGehD/"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gQ3B23XGvzlh2gK;
	Tue, 26 May 2026 19:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779824695; x=1782416696; bh=BuUW9memthV8KoV9LZ3u++Mt
	3bOI81/TyBV4xxdsvrA=; b=mDtGehD/GKtzVBEby3Muy5Wt3FR76Kvl+98omoO+
	rplekp3o2OvfsyXjvc1g2G2JqgvXxqai6E4wvHMuhNRm45xWaDQhr0UmLrodlSGG
	GWigSUVI20xh/muhyWXDPPDYK8I/YerJxFmy1d9Z2L/4CyWwdDpY+awIQAnCcRDv
	4sJNRd5fc9r+tU16mwzO4fZUVr2fMKsnc8WP5sPAHQbuQmMOwzEdQhRIFzGmwpMa
	zTn4MyujA1XZp3PuzZdYupjtB7ueLTCXhCsR/CdbkxEm32j3XrNhNrcfOpqgDkJT
	rGPrg7Gh8UwYpwgO8CAbWHUssXnySCVI6ibOrNAVbML3vA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NZohV5G2gKOF; Tue, 26 May 2026 19:44:55 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gQ39y50chzlh2fs;
	Tue, 26 May 2026 19:44:54 +0000 (UTC)
Message-ID: <6e22f3b1-2481-4170-b2eb-0e4420a1ac92@acm.org>
Date: Tue, 26 May 2026 12:44:53 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Use struct_size() helper in kmalloc()
To: luoqing <l1138897701@163.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260526085648.1784798-1-l1138897701@163.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260526085648.1784798-1-l1138897701@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/26 1:56 AM, luoqing wrote:
> From: luoqing <luoqing@kylinos.cn>
> 
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Signed-off-by: luoqing <luoqing@kylinos.cn>
> ---
>   block/bio.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index d80d5d26804e..397fc3bc0ede 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -657,8 +657,7 @@ struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask)
>   
>   	if (nr_vecs > BIO_MAX_INLINE_VECS)
>   		return NULL;
> -	return kmalloc(sizeof(*bio) + nr_vecs * sizeof(struct bio_vec),
> -			gfp_mask);
> +	return kmalloc(struct_size(bio, bio_vec, nr_vecs), gfp_mask);
>   }
>   EXPORT_SYMBOL(bio_kmalloc);

Has this patch been tested? If I apply it and try to build the kernel,
the following appears:

block/bio.c:633:34: error: no member named 'bio_vec' in 'struct bio'
   633 |         return kmalloc(struct_size(bio, bio_vec, nr_vecs), 
gfp_mask);

Bart.


