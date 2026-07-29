Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32EC43B6E3
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321454; cv=none; b=XsnxaXMirX0+mGN6YDyqnqszlOJfHZD/N1evkHppA1X1Fo2Qp/7x4JumYApS5Eq1oyfAMZdFiLRO2vnMuUhPOW5Y11piypykOa7jyVJjMXyWHETtZEtfUPWXbJlP10J0T6m/Ne/EsLgUpADi9msmH9H5WHSNYGSvrIgeX0CnflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321454; c=relaxed/simple;
	bh=KMDBHWwtyZpTu40an4MnGq08B+PKsj/C5jew5swtPtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrKfziP35DOQYRNghWlg93qE1zfJymUmZkpW094AtghdF5fPQQKQNjhvLgCMBlhoHNnIP523hK1UX5IHFZhxQOgEOaJBHyLZWZQSg+lgCI6M5h7mLOWWjDCvzNqOJ1UrA62tXs31Kz2vipQaJAecAK2Ld7s66wEc0p5KIFfln4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQuApLte; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQuApLte"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba3e6so1096115a12.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 03:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785321450; x=1785926250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p8KbmJYcU1SAlCdU+OP1hBT5okmuW3fRl/0GYAxB+Rg=;
        b=UQuApLteJB9kKcT40XOCwRqmqtd9RC2KId41eJaievdgrQkAkYSBBD3tGi/u/fez2H
         wEj2YyP+qYvRZa4Xtb8VcOAWrjOaeRZICTY9aIFaKTVNuRWxM+CziTXGSrcKYbSYG6NZ
         y4dx/mcV4IB2wRg7eosVnKv9HjbGYw6trbjjsQXNwJ7ddaVp0aqZSyyvGyhhhzks7Aag
         9AB/FWkuXdmVgpfxoSsRPTW6Y25+o4N6kZa1DfBxZefcNyFwXULJk8t2as6huleg4iNM
         gL+plUqY3hdAwGxRONuYMqTwo7vM0we09dnFCaHO01nkbW4UsbTgf4dRtgYw1fJ3wLhF
         KgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785321450; x=1785926250;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8KbmJYcU1SAlCdU+OP1hBT5okmuW3fRl/0GYAxB+Rg=;
        b=nLDijf9I9oxUckZaeUlf61Ctg/1VsLrkoFZf5BDTmaELUQwXhn8Bf+hBWJ+J3cW2zb
         H8BN+RKYKJKd7L8RtbELDPNdE6DOcfPxhm3Ya4DTRZUQY/sazdA5+jEHqT0Xw5HD/MCN
         9uyyfPx2ybrXtddSCQORiEK7OPa4OhU62eNh2WJECdGkcKoKZHx4f4GSWeN/wDm5LT6t
         2UZhzm7tlIQgyvRR51ZikJwbMeRSgHLAWjuJ25p520QE5bMZWVLep+uNF9Rw5t7CDGE5
         lg4puybaqxACRfVphaJx+QS8OYqsHqESgDLCRh+j9KZY/NLQguMHOEVauTbTb7NA4Uz4
         +KPA==
X-Forwarded-Encrypted: i=1; AHgh+RoM+8P2ClzRI8uAFXmijRocW4AVXt9d/EI5NnG85GiH5VbXUX1W3jUwQV9tsGvxn3AKZq4e8ShhIbsa6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6DDUTida/Y94e0W/tqwW8sYUWejDzAbLi7CyCR2HsxsQIWDaX
	F8YHbvn8WESvCfWc/ytDrZYNZGTVmst/+Z2IeQFTL/U8fv+QxNmZrI4N
X-Gm-Gg: AR+sD124EMSRuwUw/0eIwy3uiFLZWEP17HjZtaq9H7o2KC07kh/9INttwNIjKqAPD+L
	dlC01hhI6SwlVIoEFc8iEZ5FDZM5QxsnSQHra97dlD9aV3CdHqgf3uSgKbgvNQfq8RKxmPvixIy
	jFaftztf7n9TcvsN+3yH7Cy28iBUB3zFO8VpeVPLrbOAA4qO9iXWkg+3GQRTluKl26IO3gQUJqP
	QNgIVSvQ3M9W0t9H5Rbm8Oqs4orXDcXPSw0bR1iNoxmw7ip2LjtP8BrYKM/vUB3mQ9w3HNOEFtW
	TwGfNApSO+/4EhNy3URRmxsJmjSOgBbp+jK7ag4rwkN+zgszJPhWWdyj3n1CPJICKDGZL7qO2u+
	4tQQC2HuBOJjGThfS7GRxFPcF9Rnh0Lt6lxRgkgVvrwM/RGxyVbEy045qrWrFwOftTAHak8kn95
	4pmC2c54mL/h7mmdy/R/3PzTMLNFuFYxjbc+em6o9msSZZ2Jazr42IZBOFUyEQZMIICh2Mx600k
	AcjOnOrpAPTEuJ/RF8IGRQeAr1s8qyBZkzM5dtaGuenSmzKdoBfEMFzmDhXPuD4hfiQOZu84uIV
	OKAWH3g5lMAKCYF3GUc=
X-Received: by 2002:a17:907:9617:b0:c1c:62b4:1ebf with SMTP id a640c23a62f3a-c1f721913ddmr365145166b.60.1785321449861;
        Wed, 29 Jul 2026 03:37:29 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f84026c47sm93918766b.63.2026.07.29.03.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 03:37:28 -0700 (PDT)
Message-ID: <340dd033-2a45-49e7-afd6-95dbbbf624da@gmail.com>
Date: Wed, 29 Jul 2026 11:37:19 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] dma-buf: introduce initial file I/O
 infrastructure
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <bc20381e8daf85ac58811c344325d8192cde9d1e.1785274111.git.asml.silence@gmail.com>
 <20260729065927.GA9534@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729065927.GA9534@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 07:59, Christoph Hellwig wrote:
> The method name feels a bit convoluted, but given all the
> previous discussions I don't care too strongly.  I'll leave
> the dma-buf side review to those who understand it.

I assume you mean this:

+	int (*init_dma_buf_io_ctx)(struct file *, struct dma_buf_io_ctx *);

I agree, and all dma_buf_io_[ctx,map] look clunky, but I don't
see what I can drop out of the name. Suggestions? Maybe I at least
should make the fs op sth like "register_dma_buf".

-- 
Pavel Begunkov

