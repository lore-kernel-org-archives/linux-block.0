Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01DD1DF247
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906117; cv=none; b=kAo4BsBXu4BP+m5c345hQeqPnIKb6YwEnbohVIcf9m7d1y0KdQegsz79jyN/+hacltvSoFJfM0rA4AerNdoH1bp7JMQ+f50VUKixpFL0KcyDLOeQeVOiSR1fz4vLSHL0tqj/L2PErfsBjDrJPcH73Ev5ITPKNgXT8QX5unkPtWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906117; c=relaxed/simple;
	bh=mI87ONyrfsdIccibGrLHNw6DKQhtCF27Su6JcV1xmhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbbR70/vY5tiFIZBh408HcTe8SqdkRjcGdz5xY+LC+U7qqqHhS5001+GBywwHIpLa8d+KwZujeH3kPhsHbGXpvVZufqgzt/TiSVMz66igADDXdCCIER9x6N2ujIhtvBHPWFS6bt8yfJmM2lensHemGgMVhhTqhSXRRBTOYuQP9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sDW+x7M5; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sDW+x7M5"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83abcfb9f37so274379339f.1
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2024 07:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730906115; x=1731510915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHucz0Nh6HKCiVFTyjOpd7Ni5+roDQnO4ocJ2GfplS0=;
        b=sDW+x7M5uJLUOzl2cnlwYczn0O/hgYrcH1g7qFmWc/y3mhqvjZS4G9uaFL/BQUrmWc
         iZFKkPZ2El2NV3C0tIh650libS2cXjwBgzadEE4FAeHQUF2eO57Z+G8knf9XZ33LH1Fc
         IgtpLYUKHHzTumHcLk80KGYd2dGjqb8nGdz1xiQgVjGQpaay+MaxxvZe/jHMeWHnE/qk
         cZwqjSX+tLTr8hfq6KzuslQbsVINu4rE1ZqULJxwcMtlv9G29X6UmzBzL8e+dzUiiQ2w
         NS5rDUacwUPqymSMiZeOERma3vyVuKQ1sOv9F+WrJOh4YQx6v8Cvp5mfENYBRVUjuXNF
         Ri4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906115; x=1731510915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHucz0Nh6HKCiVFTyjOpd7Ni5+roDQnO4ocJ2GfplS0=;
        b=Lq0tHNi/pf0Vt93WrhWkPOP0N64kwvZfvD0DMZCJ0SMfBa+iCpIoauwRE5B5l/Oao0
         a5IvRyR8eAzC2t3UA1fLeHmLwlyOpTe60NQZnhVTheKJysCodAlyjXjnOTCuaFU0WHWe
         H7bnw0+Lce2mAOmIrPaSWqVut9UafhGpsadhLzPCIBA1PW20JRrQQ4HJPHWJqxabgAoi
         3JRQmNkXDtRl81216VBc/VCfZ3FFsHhZkRlF+O3jmbQI1wGrcOBWrTJfE3vsuXG2vdrn
         CaJtc41ra62sgt/Y8ClaGhMCzq+4rQRknc8IPa20WnMsIQIdSaTCDEAwgwqLaM+sUM2k
         Empg==
X-Gm-Message-State: AOJu0YzXAMfH+1KdguEMJFl597IYo875pSfTO81vtBd+0THFDZ46aHBm
	ecp+1tEmGXsj5mLrfGP8u5DJFgdEGvgbmOAcItBFGD9OIWGsHyx1YG32vtrRUDTYQ+xWY7vWvKj
	TaZ0=
X-Google-Smtp-Source: AGHT+IFKCDyN6WkCDr4ZwVsLnYfqxZODDnEoArzdPxCJqBHdrLb+CI4bzAtvm4yIDKuaEuZKb83FEQ==
X-Received: by 2002:a05:6602:2c8a:b0:835:45f9:c2ee with SMTP id ca18e2360f4ac-83b1c3de174mr4303326739f.4.1730906114893;
        Wed, 06 Nov 2024 07:15:14 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83b67bb8455sm314414939f.31.2024.11.06.07.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 07:15:14 -0800 (PST)
Message-ID: <e27c7b11-4fa0-4c51-a596-67c0773a657a@kernel.dk>
Date: Wed, 6 Nov 2024 08:15:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 4/7] io_uring: reuse io_mapped_buf for kernel buffer
To: Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>,
 Akilesh Kailash <akailash@google.com>
References: <20241106122659.730712-1-ming.lei@redhat.com>
 <20241106122659.730712-5-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241106122659.730712-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 5:26 AM, Ming Lei wrote:
> Prepare for supporting kernel buffer in case of io group, in which group
> leader leases kernel buffer to io_uring, and consumed by io_uring OPs.
> 
> So reuse io_mapped_buf for group kernel buffer, and unfortunately
> io_import_fixed() can't be reused since userspace fixed buffer is
> virt-contiguous, but it isn't true for kernel buffer.
> 
> Also kernel buffer lifetime is bound with group leader request, it isn't
> necessary to use rsrc_node for tracking its lifetime, especially it needs
> extra allocation of rsrc_node for each IO.

While it isn't strictly necessary, I do think it'd clean up the io_kiocb
parts and hopefully unify the assign and put path more. So I'd strongly
suggest you do use an io_rsrc_node, even if it does just map the
io_mapped_buf for this.

> +struct io_mapped_buf {
> +	u64		start;
> +	unsigned int	len;
> +	unsigned int	nr_bvecs;
> +
> +	/* kbuf hasn't refs and accounting, its lifetime is bound with req */
> +	union {
> +		struct {
> +			refcount_t	refs;
> +			unsigned int	acct_pages;
> +		};
> +		/* pbvec is only for kbuf */
> +		const struct bio_vec	*pbvec;
> +	};
> +	unsigned int	folio_shift:6;
> +	unsigned int	dir:1;		/* ITER_DEST or ITER_SOURCE */
> +	unsigned int	kbuf:1;		/* kernel buffer or not */
> +	/* offset in the 1st bvec, for kbuf only */
> +	unsigned int	offset;
> +	struct bio_vec	bvec[] __counted_by(nr_bvecs);
> +};

And then I'd get rid of this union, and have it follow the normal rules
for an io_mapped_buf in that the refs are valid. Yes it'll take 8b more,
but honestly I think unifying these bits and keeping it consistent is a
LOT more important than saving a bit of space.

This is imho the last piece missing to make this conform more nicely
with how resource nodes are generally handled and used.

-- 
Jens Axboe
