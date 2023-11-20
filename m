Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mLl5jXAI"
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A392BC
	for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 15:19:02 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc703d2633so10440175ad.0
        for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 15:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700522342; x=1701127142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnOBTCQ9+nRW7d7hGg7yNZ/aZJcC73wKnOgLg+ML2Mk=;
        b=mLl5jXAIeM7VuIlv8I9P7XOiUgqlmvFfWcVut+gy0pL2Hw0JIdMiC1f2kG5oJ2+2p4
         uUbHghyIzqseX9LeR04UD7me3ubslwOkfyRFHu3jheqBiLtiIsck9l0XVLbbX41qPved
         JcnO/Ev0XkLurb2TdDDpSaTQm2KSd1lRRxlESYUfClScbmdvDGRyNTRBjTRP0MpgYa4t
         jQZOdZkWUHkkL3+mOdbXHm00tuYto978NXK3uU4imgRvzWJSqS/3nZp+zKW3blSiDkFN
         r5f8I87Ww58QbM4xqUJw+k87wa9Vin6B5/w/Fv1uOUBsSS3zRAoabddEg6TieSwUjjN/
         mqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700522342; x=1701127142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnOBTCQ9+nRW7d7hGg7yNZ/aZJcC73wKnOgLg+ML2Mk=;
        b=hdpA4eVNT2CYoMgCGmy0dhiHWO3Zc5ZdaldGBT1gnpVP7lW+JIaqlDQY5Nvy9EaVkL
         qVbcVLttMJFrFGzVuV8lyjgK3yTrXW1nMt2aTerOB2i8Igqb13xVQz+yE3uHGF6axASF
         UnTfAOAdhPxq9Za1BXJ8eVE/IfpDZ9MipT1yVgNCNd+9xI3cGCmecFxpjr6EqcQSkrej
         fgHjA2bvRp1/UnmcN+Di+JMS43DOWYOdL082M4qCw3u7a3m2Dt4KzaUiTGuC6dv1NelA
         1bQUXqSaH9TAMpajZuD584Eq20W8pFJWbyQQR4UfDGkI+VViQvDAtSJi9H0z+MkhehmU
         zfrA==
X-Gm-Message-State: AOJu0YwQyBNydKpON6BcKopo5SSgR8WqXyI/YOF+WrKxMqpn8Tnic5B4
	OZ83Rt7OyVwn4ZPzZjfJlEPbIg==
X-Google-Smtp-Source: AGHT+IEHr/jLVxb+HhXgXcdOLcZeWZ7nxeRgUVmob9UsD/JyCgmNIprja4FDgcnfkrYzUwMQ/r6zBw==
X-Received: by 2002:a17:902:cec7:b0:1cc:3c2c:fa1a with SMTP id d7-20020a170902cec700b001cc3c2cfa1amr11754119plg.4.1700522342032;
        Mon, 20 Nov 2023 15:19:02 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902c1ca00b001cc55bcd0c1sm6605408plc.177.2023.11.20.15.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 15:19:01 -0800 (PST)
Message-ID: <8f70b7bf-35c9-430b-a52d-ce7a11a20260@kernel.dk>
Date: Mon, 20 Nov 2023 16:19:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/5] block: bio-integrity: directly map user buffers
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Cc: hch@lst.de, joshi.k@samsung.com, martin.petersen@oracle.com,
 Keith Busch <kbusch@kernel.org>
References: <20231120224058.2750705-1-kbusch@meta.com>
 <20231120224058.2750705-3-kbusch@meta.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231120224058.2750705-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/23 3:40 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Passthrough commands that utilize metadata currently bounce the user
> space buffer through the kernel. Add support for mapping user space
> directly so that we can avoid this costly overhead. This is similiar to
> how the normal bio data payload utilizes user addresses with
> bio_map_user_iov().
> 
> If the user address can't directly be used for reasons like too many
> segments or address unalignement, fallback to a copy of the user vec
> while keeping the user address pinned for the IO duration so that it
> can safely be copied on completion in any process context.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/bio-integrity.c | 212 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/bio.h   |  12 +++
>  2 files changed, 224 insertions(+)
> 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index ec8ac8cf6e1b9..b761058bfb92f 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -91,6 +91,37 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
>  }
>  EXPORT_SYMBOL(bio_integrity_alloc);
>  
> +static void bio_integrity_unmap_user(struct bio_integrity_payload *bip)
> +{
> +	bool dirty = bio_data_dir(bip->bip_bio) == READ;
> +	struct bvec_iter iter;
> +	struct bio_vec bv;
> +
> +	if (bip->bip_flags & BIP_COPY_USER) {
> +		unsigned short nr_vecs = bip->bip_max_vcnt - 1;
> +		struct bio_vec *copy = bvec_virt(&bip->bip_vec[nr_vecs]);
> +		size_t bytes = bip->bip_iter.bi_size;
> +		void *buf = bvec_virt(bip->bip_vec);
> +
> +		if (dirty) {
> +			struct iov_iter iter;
> +
> +			iov_iter_bvec(&iter, ITER_DEST, copy, nr_vecs, bytes);
> +			WARN_ON_ONCE(copy_to_iter(buf, bytes, &iter) != bytes);
> +		}

Minor nit, but I don't like hiding functions with side effects inside
potentially debug statements. Would be better to do:

	ret = copy_to_iter(buf, bytes, &iter);
	WARN_ON_ONCE(ret != bytes);

which is also easier to read, imho.

Apart from that, looks good to me.

-- 
Jens Axboe

