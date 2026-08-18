Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA573B101C
	for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065750; cv=none; b=BJvT6Di6hNltARPMFUueDuydBcRSSChC03ZNNXY1isHExmOi+bTqlV/VzLZAXegZ/lK5Md8lA08UniLVu4VgENZ5fuC/tLX9IlI6n+WemCfsjTNypszmWlYOpUcyNzqN4jMeqSdc60tBky/XS9HBZxquEzGb/LGLxVC6QLv7/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065750; c=relaxed/simple;
	bh=vjFoh0HcmhBVPT5/d1SyMXHta8/RgJh136Og8Vd2Qek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7QgVBwv+NfzlIcx9xWmAnP9zGtWCyQP7zGtA4RGxQ2bVYsQVmigX4NqRbCgH58cQykk1Vo1TylVsKAFt9EXi6yjX10zl+P7MeAXS2s9T87aWIeFWUof9sAW2xoXDgExftczSIdjQc8zRpEctjdWv60yGiZCzRzgLLKO9c7BDXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6QgFocM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRpcXuj+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6QgFocM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRpcXuj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787065747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlX+X1VWu30n4FQxr2jVaIi0+ztBEd4ppgKRk/Z28YY=;
	b=O6QgFocMGdG9ZTci3966K+tpaLb3Hcio36kzJCKCHjwQVvW1gN9A8nbujycLf0Krh5FU3+
	AhYgDRVz0nR1FNUYmasDOrh1iX9MiSQg0qygSrFiGBpStclOVRUJf/1iZ1K5/ZG1shPuJr
	J5q5W2Jeyz0dcy5KjQd1eLgl+doOEP0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-TRJIvbw2NAG4s-mL3iF7_w-1; Tue, 18 Aug 2026 11:09:06 -0400
X-MC-Unique: TRJIvbw2NAG4s-mL3iF7_w-1
X-Mimecast-MFC-AGG-ID: TRJIvbw2NAG4s-mL3iF7_w_1787065745
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a18e266026so4777831a12.3
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2026 08:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787065745; x=1787670545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZlX+X1VWu30n4FQxr2jVaIi0+ztBEd4ppgKRk/Z28YY=;
        b=hRpcXuj+mIrkUPeuEcNw2S8467aK8NJSWqkYDvcd3wtruoWm13ksJuybIsif5JNVv7
         3WSQ/NBwRYQ4nraZpaIosLYp75uSYMfyS8Z6PIZPAklN2I3FLiRX1VbSxXwv9FZfStqr
         mnrSGpclxy5WO/CsmXXCYrAg4zwUcyr6nnYOR7lcgviM399IW3rv3Qwbq9EmRtxGyNkY
         an9CeGq4ciG4eDcsXo4hiXuTLWTyDm6R6xZHIAwb7fZ6DH2tvY//zHmR70sY1z7FXPrh
         DQ6yvZaAnR8UantNGwJo+2pJz87r247Cj1X6L3QftQXQpVk1+vdyBsGiu3yXdP9TchU0
         +c+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065745; x=1787670545;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZlX+X1VWu30n4FQxr2jVaIi0+ztBEd4ppgKRk/Z28YY=;
        b=GK8UyhbIesRZqpRzRh0fqVNWu/2mlVmY8NYAkXa6YxkAe8JdlQGoW7+zL4hV1sRF/m
         tNk8stpDSde/nXxJJqfcly3/FvIXDvgRAwCx0ElCa8RESFHoUp059NOxoZNKiuAEVqDl
         dRL49MO+2oyOKgFPO64ZtJI5plefgRp9dKCjuatSzjRG5bqJ96eMoxRO+UG8oS+l4iiL
         Hk9ilS06iADzbgsKp+96GtBYi3MnO92/HNS4YLo0gjiT/2/GTp70PreGZFXrYmK9BYd3
         1B7hcUG9rXmumYzePetSANZ3RCQo7Vyr27FfYyBmfzC1eyVEuWOb9CuPGpCZ8GwogAcQ
         sMAQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDSiUIrJy6BngFrVryrMfPxAjNE2vMH8xE7THlupOwnKGvBEIZa07XTbet0ZiwHbdHxZHbxkbacDMvEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyqSoj9gGEke+8FWgqCFqNJkQHCI4Ps2Nt5yg41sBoU8zQkTw4
	QImArcKj8rUKxoLFjfYh3kZeGhsiHx8RAgzc9h7QP8zkphqu3w5W6t2VHYXw5pA/d+BX3G7vFrn
	nfmmR2j6dh205GPVziRkbgGhFyrNg7LVbbjag0hjfty9Udm/Bcq15WTHrmilGlgy5VGCeYZLJ
X-Gm-Gg: AR+sD106RFM1oEX8qmogrEi46MtY9LnHp37DfUAoVpx7EN+WqVIoL+ALK7E5o5Z8Olp
	Zdqq2KLGc1p6TG8hLjVD92NGwP86Tiphul0I0Ps+McVwAzKDY0CDI9ZeGZdOZI3CkOdNTRE9z0+
	mLb/9ubDm0+be4DZl3lEcdjKfO6s0vqykEOaAFquzm2jzasr4m4Q/xjZ8/oTXg6iuyWFT4178jK
	h5SwM3EQN3AvIMaZ4eDWOA6tmAYDTZe2zKIuD//n7ISGrYmh5Ai29y5s/kpyNDDzyOd8d9E+k9L
	A4AyRBOY0CjxK/NOdO9FfawAOMGU8UVgsl2LEshWEkrpouqI0JRKNCZHOQM1ayHP/W0fUqAAhNT
	Ps1ZYaWcbEjHNuu+d1ZOvjdvp0VFFfMzoD7wxjg2r9ic=
X-Received: by 2002:a05:6402:4015:b0:6a3:714e:f5b4 with SMTP id 4fb4d7f45d1cf-6a38a946e29mr16198335a12.9.1787065744743;
        Tue, 18 Aug 2026 08:09:04 -0700 (PDT)
X-Received: by 2002:a05:6402:4015:b0:6a3:714e:f5b4 with SMTP id 4fb4d7f45d1cf-6a38a946e29mr16198193a12.9.1787065744294;
        Tue, 18 Aug 2026 08:09:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d8531625sm2079715a12.12.2026.08.18.08.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 08:09:03 -0700 (PDT)
Message-ID: <08105f8f-c7b7-4921-a907-b4a9a625ee20@redhat.com>
Date: Tue, 18 Aug 2026 17:09:02 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: save page offset gaps in cloned bio
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20260817165908.137682-1-kbusch@meta.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260817165908.137682-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Keith,

On 8/17/26 6:59 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The cloned bio needs to inherit the accumulated gaps between vectors so
> that we can know if this bio can subscribe to the iova coalescing
> optimization. The split remainder meanwhile can reset its gaps to 0
> since it advanced beyond it and will start accounting from there.
> 
> Fixes: 2f6b2565d43c ("block: accumulate memory segment gaps per bio")
> Reported-by: Eric Auger <eauger@redhat.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Tested-by: Eric Auger <eric.auger@redhat.com>

Many Thanks!

Eric

> ---
>  block/bio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 898b2f5ef8c81..33aa439c1bae2 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -859,6 +859,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
>  	bio->bi_ioprio = bio_src->bi_ioprio;
>  	bio->bi_write_hint = bio_src->bi_write_hint;
>  	bio->bi_write_stream = bio_src->bi_write_stream;
> +	bio->bi_bvec_gap_bit = bio_src->bi_bvec_gap_bit;
>  	bio->bi_iter = bio_src->bi_iter;
>  	bio->bi_io_vec = bio_src->bi_io_vec;
>  
> @@ -1971,6 +1972,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
>  		bio_integrity_trim(split);
>  
>  	bio_advance(bio, split->bi_iter.bi_size);
> +	bio->bi_bvec_gap_bit = 0;
>  
>  	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
>  		bio_set_flag(split, BIO_TRACE_COMPLETION);

