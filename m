Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274571;
	b=LzqX+7JKMVhmPQdPdp4tvi9U1p/MzmZXaBfTeH3gldPelHTFGNslUKT2JH+Pzy2q+yz9
	 b7QUVk0zXXNCJJ6rZ+sN6Au/EWSlFSEzgDfT++HHJ3IPXjKsLeB/0Q3dpmdurL6s3kVEI
	 K+WpM2DkWY5o6ehqtWxuo7kq0A6N6FhbCMRWv3FLZrmhjUlqTUGnG+lZH6+/DqOhMj4hd
	 LNZc+SpKOBzhshsG3lKtY6MfcwH07dHdjoZp/rswWADTBWmnKl+b3EXp2dyLjc/qFjECh
	 cMeeLOjLva3y+gUrVhWimFHkqm2OEUFLhSiHC/zSATlLu8Wr1bCzlYVFz/OXQtI2PBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=FCw1eh+zll3pWoqaatCy7myexZavDZmLzkFXmYf6ums=;
	b=oOF78vUG54Rm7o2X2XwF0wneh7H58USAP90LQwrdvytdjwS/S9/WPYr26Mctmbs9iGHm
	 qJg6sBqouhSQwQrdOTw8QBMctO9PX72zBo6TGMFd4zT+p3aq/Th6lDBIaBBObChNqaCg/
	 OJuwaHzTBGitfGCr8QP9u4wMOp3k/6G0z8h6uEQLWLXG4F8CQh5n3yJHmxHYK7PCc5XtU
	 Wh/HbVEwrq/CZYyESYhU7hV2frwRheFXMctsMtdxMaiLgedGS2SyH/ZLUXdV58czLzlNE
	 RupHfjUby+65CAf2X7r99KuJXceRXK2NN4YEwKAwWL1KqOj9GqawsDLXFNpVomegpzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h3Xo5hX7;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6B9606A31C
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 11:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F6B9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h3Xo5hX7
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c45111bebso936354f8f.0
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 04:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793274569; x=1793879369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FCw1eh+zll3pWoqaatCy7myexZavDZmLzkFXmYf6ums=;
        b=h3Xo5hX7oFlQbY0kG8AvLpofPrpv2NX4ocI0/9Zjh0hB88fJCUIyu233H2BNcE9Ndw
         OPBNnHHXFFP/854i+TiilbTJVQJqu5j70L2SalUy2paH045EbTIznQQgUfdW0crlReeJ
         7QqL5D9EQwuORIoDOGxZV+BrxRAZs80vlMQQjvafEnUWR1cbmxaCBxTYkYDyXjW2VdPJ
         l8MxktR1kChB0S8Vk6nmrk0uhTSdC04uhOmw19zirhwTIq+caibdpgyuLgmB98HNwKDF
         DdTnHZoz99y0I8JmKy8gQrXPkWGJBbGGtllrvwpE3urWPoulne0e6szKqtj5cAqdcH/T
         rFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793274569; x=1793879369;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FCw1eh+zll3pWoqaatCy7myexZavDZmLzkFXmYf6ums=;
        b=i6vaF2Hn4COKEmH8MrT+sQAm75ywcQ/QnjRELhr3JumqN+2Q7Mx7CbrqNTfK3Y6mP0
         9i73+3SLx+QZZnBziLG21JP916ggpbOYT7YWbQplu99050Lakj4LjspL3TgYCLQWAFDV
         P0DIWiJ/uS3nobnOv5U2BjUTI8PLVbbSZtkTwqvZEp5kFXZvaPxPxWGNwur8EnURUzPS
         MU8l+/ggqIl2Da/T1WhtCjMt5bkA8nk0O3V4ICWMs7HX4H+4CrsabdyS5+32MXs5a8Zh
         T5tOQJFne8oJJbqMVx2iw+LKaQc+Nn9P0j7bVZmeAgERdklV26x2JsHrR05isUvWRbvn
         6J6A==
X-Forwarded-Encrypted: i=1; AKwUvBwDXhGnwcXoxggaUuXtQAKo+BBQdwXfNdTX403VFdIh+l+xsUq4dbHvwn1D43XcqWAdrzrv4YsuFej7HA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2FDR/v7wWQhXJcyQOeAuZ9EYUg/7FOKGq3T4FJK2ArHvBijv4
	ZCb1eBNXhfs6Cq2qcutDqPyGqwEa6gFzCEQ8Rn3pXOPFXAfCYO3IM+hd
X-Gm-Gg: AYBFou1Ok7AE8Bz0J6f1/Actw1PZfeBkIzu41yg8IXNfkL7sPHpzpT95u8nTmXF1l6z
	HdV+l5StBb9bH3VPm9lW8Q8dFpp0cZdo92RkRGhpPY/PuEMolrFp3D1Z8WZqoW+JtvNk8udI/rh
	0rtz8RQOlHZbfIXFNel7mGhbZTF87ebhGAQ90eIV0pF0vrIDwbnnmTWwEdxpUZNQsaHQWsxnvLN
	ERrv9A7pVKSuQAsl6gHQQ5lJlnZAxmYEckIV5M4JlDAVfNo+rP1T3tHiZyl/PO0ag0BmNfiOSMF
	F8VUpsoQdcfwrZys8k0WWyxwxuGgOPk78t99pj3DoXG286XysISP5qJ/IOIhT3PzTet6N7mVuPp
	ANz3nwDSpLB2pr74lthQdWnqxITrJ9i8ijWbcECZ/R6TxdUr+mVi68HsV2DABCXvgw3KirPHRPF
	T1jyHBBYRKl67cxVHp2NyChPT85usXFP7pfE/BbtEJRgEI1ZP0idwRIU68dQRirOHRE1KNM2AsS
	8baFHtTbz89WoiUsm41F1wQSg5A3sI95NDBIfiIFy9gEKvr+cEXpk3FQ8/ftq7igi5TnJi7+UC/
	OR7np2pIcg6H4ed/DG4IZw/k2UzHMwME5e6QaIXJN2LQ3rl8WO11Em42R20y9m/Js8jXKMhBRiT
	IMilYVt9ms70RpqiJI9sKRNgXDWIOasjiU0U3Dr6hoU+pMGqvKWelBtG20fijTWDgjySuTh8isE
	11Iw==
X-Received: by 2002:adf:e743:0:b0:48d:fd4d:7fbe with SMTP id ffacd0b85a97d-48e5d284f96mr10145661f8f.2.1793274569561;
        Thu, 29 Oct 2026 04:49:29 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4d8dsm35406607f8f.36.2026.10.29.04.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 04:49:28 -0700 (PDT)
Message-ID: <9d7703c6-c502-4c2b-a896-3fe251198a3b@gmail.com>
Date: Thu, 29 Oct 2026 11:49:30 +0000
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
Subject: Re: [PATCH] block: don't use the bvec fast path for dma-buf bios
To: Anuj Gupta <anuj1072538@gmail.com>, axboe@kernel.dk, hch@lst.de
Cc: kbusch@kernel.org, linux-block@vger.kernel.org, anuj20.g@samsung.com
References: <20261029105330.1427462-1-anuj1072538@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261029105330.1427462-1-anuj1072538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 10:53, Anuj Gupta wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> bio_may_need_split() reads bi_io_vec, which for dma-buf bios aliases
> bi_dmabuf_map, and interprets the map as a bvec. Always run the full
> split check for dma-buf bios.

That's odd, I recall adding a check to bio_may_need_split() before.
Thanks, let me test it.

  
> Fixes: d88e44f43e93 ("block: introduce dma map backed bio type")
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>   block/blk.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk.h b/block/blk.h
> index 50abfd932886..27b568cedc43 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -404,6 +404,8 @@ static inline bool bio_may_need_split(struct bio *bio,
>   
>   	if (!bio->bi_io_vec)
>   		return true;
> +	if (op_is_dmabuf(bio->bi_opf))
> +		return true;
>   
>   	bv = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
>   	if (bio->bi_iter.bi_size > bv->bv_len - bio->bi_iter.bi_offset)

-- 
Pavel Begunkov

