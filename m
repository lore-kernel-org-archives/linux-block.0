Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E5353A92
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179174; cv=none; b=d7dSNbYwXlp9B7H9KnaJR5g/lsq7sgsEtrQnmSstxsc7TBd7pv/MbNjpHxnBzmHm4JiRO/D2G34CBl/D/g79DiZ3O7unscT0HetRP70LqdH1IUIeWLy7ii7zACKDYMEtRO1MKScQ9xXnubbjN7eeAAujftPs5Xv757XoqTCs5BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179174; c=relaxed/simple;
	bh=7US3AUNu91eRz6NqCXEMrk4PFyTLHUGj/o8KeK2jkYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uECtDgZPXl1zgdsXSfUse13zc+Yg4UEGmm7al/LRkmiSBFEnlIHf34/exXM4Z+PmYFmnXrbBic/GyVDqCxveuzTiS+MdPxsdr8CczNHu7mlCjzWaqM+EdUG7LMZEnrXplcbR2GllSWqkZCuxrxCPCi6pdN483/QoeRkKq3pK2r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+UIY6f9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Li9BTUQ3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+UIY6f9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Li9BTUQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788179171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAheAtHw8RYWtMfP9K1ZFevWlBNLOsEnB9rExZKQ/4k=;
	b=F+UIY6f9dLqAS6AcXtY9+fJV0SFH2fAlYpxJXGdK7SJXCXQ1n/BOBA1ARGuf/Z3/JuUpky
	YFSvRuVh88N3z7EsKqa0xZ0m4roqJAMKUFS+PzQReYL0c21ItSRIyyhIwgYvDazXHQPg4q
	4sJmJovrI/YuEj0y1vpOJ+pB6tMV3s8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-fukAHlFzOYGJMPjrhqRn_A-1; Mon, 31 Aug 2026 08:26:10 -0400
X-MC-Unique: fukAHlFzOYGJMPjrhqRn_A-1
X-Mimecast-MFC-AGG-ID: fukAHlFzOYGJMPjrhqRn_A_1788179169
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a1e3cfc8d3so2767255a12.3
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788179169; x=1788783969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iAheAtHw8RYWtMfP9K1ZFevWlBNLOsEnB9rExZKQ/4k=;
        b=Li9BTUQ3re1eCDIkennUy5SZDTwPOQJNcxYPNbYwVVBdUfrY00ZCjsTde9f5Xvne8P
         GPMFGxnm9tcIaYd/JNSArwC88RBxsCsHOXVvNEWVZCJimFxGqYWA+mbGBHqcEte44ecu
         daNE/xqUEuv/Pk9+6isd8897js6iZYk5NgA87Yupknc7JDJirvk68Fytp7PfcmrA18RG
         Q09dlgmBI338EPnEVZpR4wrRQ8WHxHVvEqTKINYOGKOtZVQT8KB8+GbyS9VITZcY5KqM
         qhmaN+zmkfA8DviM2VE6C5kQLNMPY0LF5EmLn+IrnXZAE02At8/kAH0KMBMZU3YD76Oj
         JqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179169; x=1788783969;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iAheAtHw8RYWtMfP9K1ZFevWlBNLOsEnB9rExZKQ/4k=;
        b=irWMepGVfXTwFIOnvo2dEJUUMuFm1782v6Ji2zDIfowAgT5Y3NX+s32SNb5SpJq10+
         D1asvqXyCLxqKEoLv0arwEJuulBBff904TuXb57T7DTChE5JW+grNzorR3DhHZe3anqB
         Vw2uVfijcrwXYsgzZR5sdtOQXAJMGKi4j2QH6ERwn9sirQI8TSWxGHGIgJQIG8gWPsjP
         c3S9BCYD6TyPPGxUBoRvU1MGqTR2cFWNM+kCZjrvfRQbVG0R2q32lX2epnTJ+tg9tcHd
         btfhDowJYFn2Xf4AWlpz7VFsAVK3PrkPgCZfpn/Dr0MdLLdya54gqtA8dRJSZOzrBuTd
         UQFw==
X-Forwarded-Encrypted: i=1; AKwUvBw/bvRX7w5EDR+2EAYTIuDILQ8wyJSMgx1pr3c8FM1eGqEOFNezS9mBz7k6R4jZKE7gXJClQJicZAELug==@vger.kernel.org
X-Gm-Message-State: AFuF++n75Fb13iUWvKwyh21VDAeCKoq5l14sdStBehCKdMzAw4setHJE
	EtwOLptxb5fFbegxVwZZyrSjKO+An4ULXnbQ8beuATD+U8IOKDACnPxK8At6gxRcQ44JBmku1cX
	FGUE8+l7ISsd70qfZ8lH/bdLMIxDIN273f6VlNjvqXLVBYtUHmOheJ0beG5sLKV71
X-Gm-Gg: AYBFou0Vs0mRZyf/Li9oQMOmYOfHu+o2eR1cKLUhuSq+tdbwCeGGsIsWmdrQB/mr56M
	EvhKl9mzoq+4HD0upTlOfPO4LfrfBcB7K7O/q5VnezrE6A+gcgVSWXvExdQKBvX2u7lXjpEwuHG
	ZlwAeSR9CMJqkE8Sq04FfaJ7S6X4c2vv+4I4q6Q0+J1PfOu9/QKjg+QU+1SHZCDAV7Fr7SLKYhj
	Rpy+Fmm243p7grJGNZlpeqqw0hzGG8HmYxK9dXy/5yZUFdm9GhgqHlah6zGpAgEltAcq13pY3eQ
	v5sE3JASLbEF6IytM6XoL2t+G2GQpBBTGaohWjc1BQ9qIZTBpO3Qpk1ymbk1tdxzZs5JXP+Qw9W
	3eSB2qS5Y4q2PKjf89rxqrDTH4Xzqc3C35xNHnHyqh4M=
X-Received: by 2002:a05:6402:460b:10b0:6a6:3798:ac01 with SMTP id 4fb4d7f45d1cf-6a63798ad4dmr5183827a12.17.1788179169311;
        Mon, 31 Aug 2026 05:26:09 -0700 (PDT)
X-Received: by 2002:a05:6402:460b:10b0:6a6:3798:ac01 with SMTP id 4fb4d7f45d1cf-6a63798ad4dmr5183795a12.17.1788179168881;
        Mon, 31 Aug 2026 05:26:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a63fad67easm1645477a12.25.2026.08.31.05.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 05:26:07 -0700 (PDT)
Message-ID: <a31c539d-3554-4f8a-8ff8-a313a554d4f1@redhat.com>
Date: Mon, 31 Aug 2026 14:26:06 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] block: save page offset gaps in cloned bio
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>,
 Eric Auger <eric.auger@redhat.com>
References: <20260819154937.3903312-1-kbusch@meta.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260819154937.3903312-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/19/26 5:49 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The cloned bio needs to inherit the accumulated gaps between vectors so
> that we can know if this bio can subscribe to the iova coalescing
> optimization.
> 
> When cloning for a split, the gap only applies to the front bio since
> that's as far as has been processed. The remaining bio can reset its
> gaps to 0 since it advanced past the checked vectors, and will start its
> accounting from there on the next split check.
> 
> Fixes: 2f6b2565d43c ("block: accumulate memory segment gaps per bio")
> Reported-by: Eric Auger <eauger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

gentle ping on that fix. Could someone pull it?

Without it we see NVME I/O errors

Thank you in advance

Eric
> ---
> v1->v2:
>   Added code comment explaining the reinitialization, and a more clear
>   change log.
> 
>  block/bio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 898b2f5ef8c81..f95b63c0604af 100644
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
> @@ -1972,6 +1973,14 @@ struct bio *bio_split(struct bio *bio, int sectors,
>  
>  	bio_advance(bio, split->bi_iter.bi_size);
>  
> +	/*
> +	 * The gap bit is set when splitting to limits and only applies to the
> +	 * front bio that was split off. The remaining bio will calcualte its
> +	 * gap value when it is subsequently split to limits, so it is safe to
> +	 * re-initialize the value back to 0.
> +	 */
> +	bio->bi_bvec_gap_bit = 0;
> +
>  	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
>  		bio_set_flag(split, BIO_TRACE_COMPLETION);
>  

