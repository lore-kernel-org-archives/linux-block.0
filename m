Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB93D1CA4
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779694154; cv=none; b=o3W+cFHfGMZyUxFuOYRIiZMW7jmGovoJkECEvZR1nacjiP06FPDmjqztkKAui0qrztiBdVHQapuOcQEpyD8vxZs2iz5FzSkYVv4FSy0GKex1bLdHjoLNZn82LITs89FrJ7QqxHXMAnEVHAl52pprId9j6QaD0F3io2RglmxhAN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779694154; c=relaxed/simple;
	bh=Dg6xOhAfC8nAS8w2UlP1hkcGBI6/eEQ9ST3cagLZT4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTCbwqMN0QrnUFavWbHhK4H10DfGGOnr7zZz5tfLZWGfWcHPU9Kzc3bmhYKOqpyDyzDvtnnnTzzOBRSK+VrQKS0HPf+JnQwzImRrSQflH4to7/8yHOOxVjztBQZVVO3wrD1fM1OLwzoCmarpSGL9bUtcXLYYuBEXjkR7jrniEVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlHC2Qlk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlHC2Qlk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4904127c32cso18242365e9.2
        for <linux-block@vger.kernel.org>; Mon, 25 May 2026 00:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779694152; x=1780298952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+/CremarURMLXbq9HZsozt2//0CtuRcgdYp3OMzrIs=;
        b=UlHC2QlkIb4XLnXGJy7wJ9WEAIolGMLkGZ4XYlME8S5AEhdyWcsYCae0wgtAz5uZ6+
         wDxbJJc9Qcy9N4zpjKC7zI5pmqbWBoSZDbWXiLTEehoIUXCaj34l+WX6RaOvip1EfiRN
         BWYI+Lt8tA7PBSZL/Rc7fB0gydpI+H2O6cCgLPmW57JUpG8J7z0/QgZ2aUm1B9SPftOE
         Rp+dcu5/00PDGT9i0OHnPZ0cYSSdG0yV5Eq+2sDJGN61sVIoGEdfy28aIcecT3IQko+W
         ZWSGztFHDohN0gSU1UiEHLFPN28TmZTWsrNkupph4hd+MoKIvQjrfq5Tc9IWiVAk6hog
         kHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779694152; x=1780298952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+/CremarURMLXbq9HZsozt2//0CtuRcgdYp3OMzrIs=;
        b=LNWkFA1Xieh+T0BlDDjKEZTA+WEFf2qEWlFNycI+yppDxAlwMoYzAwGN+8blF4hSP8
         QXQfj9qOzgSvJvyUlBfooMv75s0rxplj/D9bv/QP5AdFs4ExtYoj30srpv5F/A9SoObE
         Dpjo02laV6+kh45i8ORJBmeQm6dDziaRranX36JNkUR1sV/9get8sAok4sylSAHMQyDu
         Da7fF8Liy2h23T3c5rd9wcYQU20SdHfemnfqgTNwo5/x3DHmUdyOPBhIaGsuc5efFH3K
         Ca+gKTAL0rwhNVg8RcS/STVFdRN1ndO9W0lcY5I6KfQssLb+lCHq5TmDL6T6LnhRaXwt
         U/cw==
X-Forwarded-Encrypted: i=1; AFNElJ9t0HqpVSPz3T9bG/0QOmh+XKwSDMxbTq4G30PEBefb220Xn+F1NJVf6MstoToicyUxWWnGxStm2oFYEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNIfDIgZsQiJiNhDUfbTnhZecoYHBSZQz0A3w4fn6Fsj73blAb
	dBh8A+Q4EYQGlt7IssLEec5/vS9f0lyJapQr/ipr5VYSXl3/Bc0sOWwr
X-Gm-Gg: Acq92OFgFZ+IIXqZuobOMwOt9bKunGRQYpRoBUcsofa+latRQff84O3hySxvSBSCXlr
	gnZNgNxLA7KzzDN9vk1zvRu24yAjp635gW/de++FSnGJnqCqQF61XcuyskLA+RjLAcCWe3TH+xR
	ptJP+pcrJwTK4UKfS9S5wLegPmIVu6dP8wcpb2uyvFmErJQIAvq48I/VuXpHE732oZR4/MfAu21
	S8kloDwnWjxqPGC4SOMAVCUAWEkmgil3pY60tAcfMZVI+KBGBK9wtkQWVJAa0lZyrOQGDn3cL2I
	AilVUJQ5Ogc18ydNH+PjCh9Ah525Sp615LU0BLyYagFHAShaXVLXpwWRVhtbhlhfDDVR2oqb7wv
	QKAZHFLLGFARP00J8H+dDUAnOML0tTQnh7aqB8ieHTOPHuVx7jbqlja4aywMlsl8GVkmHHl/zno
	wz49l6HpyocdwNHqNqUfty7TECS/1XeSrd15tUgJu8eksugn2VUeRVbDi6HNKFoFvXsPosztuBe
	qk2vqCnYcMCe/16b68EQ7sfn/JUpCxZmXxeRzG55ly4H+A4cfE7Oh7EdExNFDHeIyOHZ4u5AXGb
	ajNQW5IqoG0moUoRHlFu/Ek=
X-Received: by 2002:a05:600c:c4a1:b0:490:1640:8269 with SMTP id 5b1f17b1804b1-490426d1a16mr227253215e9.18.1779694151663;
        Mon, 25 May 2026 00:29:11 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d4cefsm81771025e9.14.2026.05.25.00.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 00:29:10 -0700 (PDT)
Message-ID: <57ae2e2f-8523-4cba-ad77-920535edd236@gmail.com>
Date: Mon, 25 May 2026 08:29:08 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513081929.GD5477@lst.de>
 <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
 <20260520083043.GA18893@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260520083043.GA18893@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/26 09:30, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 11:29:54AM +0100, Pavel Begunkov wrote:
>>>>    	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
>>>>    	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
>>>> +	BIO_DMABUF_MAP, /* Using premmaped dma buffers */
>>>
>>> Shouldn't this be a REQ_ flag as we should never mix and match bios with
>>> and without this flag in a single request?
>>
>> Do you mean adding both and propagating it from bio to req? submit_bio()
>> takes a bio, so we still need to set it there before it reaches blk-mq.
>> And there might be bio-based drivers using it in the future.
> 
> I think I forgot to reply to this, so let's do this now.
> 
> REQ_ is actually used by both bios and requests, so if you set it in
> bio->bi_opf it will automatically get propagated to the request, but
> it can also always be tested on the bio, including by bio-based
> drivers.

Ah yes, good point, thanks

-- 
Pavel Begunkov

