Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058DA202F6C
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910189; cv=none; b=gOretLApKEQ6lRfCg4kg46wQeK21gmq6MHKIvOa925c563aGzt8YzGWxl9uX2ec5dkj2dIAOr0iGnOKaZhkjv6cFT7SlMtBCktClUh4C5zOknp1OJcNjOkOPlVCK+D7J5dGlofjtnjiFLHWhIdc02mFM/lZ6JpjGHM0HgqYmS24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910189; c=relaxed/simple;
	bh=gQv+cuJoQR/8fWDiCsDSf5X8qIx9DbLTtJU85CFj//E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmLBy773UZ7Vyvcui+tOyl1YTG8Kum7G47ZD1OV+yeljLaS1FrmljvKVcJOzaDYIUNq4DO8Hy7nWfDrdK354l94i86ca0BEWw6ztIcfa6Kch5+1led12f1/B1QVOMVasKu6QIEGPzbLZI+epNcbiDbeiksl9f45iaW85xWOkaPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flQAUjHo; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flQAUjHo"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2feeb1e8edfso63157681fa.1
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2024 08:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730910186; x=1731514986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HA/d/Z9HyomhTibUVgabDNdZo8diPPOAH/LWnZYh1Vc=;
        b=flQAUjHouA1rNvHBXrARSLIYu7kBe3z8PsBWWJyMUxmjgmAD0+g9gjBDeWk6lRSHtd
         tlY/qoG8l2s78alPTPGVzeh4uFEIUArjgPJLU5DeSh88xSD7NN+Lk9JwsT6QUVipK4BL
         CTi1+16xkz5ALp1xJdjIxxHQiqlYYmBkXOXC6r/oohoUFUpkagv8aLbnfmNJBcNGo4Zo
         nhYkVOQkovftpxNAug2+dMZGmvju+7AJ+yJtdKipxtj0AXuDrnNO39SaX79PZRy6WxsC
         FKrlgOreP/lgnKEC4w11hdwQRt0T/W0WLS/CEWu/nbhdIqw1q1s3IacgAkAftrpjxYzL
         nWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730910186; x=1731514986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HA/d/Z9HyomhTibUVgabDNdZo8diPPOAH/LWnZYh1Vc=;
        b=g4pSogwfPzsf2cKkYa/9oDButhDJsANNjtQOYE8GWTJ115C41VNoyBDSZwyRoyzqlp
         RftuS9qmfxbeQ9Z9tPgpPyRYLTxa7aQUmI1V+fcjtIwz0Yp0GSbdwmpNU18Eb8YHRdlE
         LFkoi4Rh2guixioVg1N/ykcLkOrTJ+cHY3h89CY3Kj92h5ClslMbWhZdOjvvJDs1B3hU
         0gKt7pDUXtg1lTmkvOpT63aLP5yJzMPj+6EfpYdbwT6O4ddhc9nM+WURh3+o26A71wPk
         Jw4F7yHTmZLGhrEReokiyHdyTdafXmnr3BdGUNsfnCrTRtCgfL2HCUhyFvu665UvdeJ9
         hwJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOsQ8TL/WkkHJXi/7I/ZHj5D7ElAwIv9mVyvbOnpgq/Wlfm3onYQ/DQK5y6NGaXsRAbtYfhru6l5HXkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4BKl3nEOopxpDXBnTtWZ+4OVNQJS81F093YpytjqvpCPkc3k
	rqfXJOJ4fh+T4gDtmphvg22HwTAgnxZNqnTc5voenPsEmvTB4FDw
X-Google-Smtp-Source: AGHT+IFw/5Y0f9sdkNhYA7Kkd9XGdFIkkWPI1lJhBpUx2qygFe/jEt9OrweBr+vtfjWEa3sLxLMR+Q==
X-Received: by 2002:a2e:a902:0:b0:2fb:4db1:1ab7 with SMTP id 38308e7fff4ca-2fedb82fc9amr178058881fa.39.1730910185806;
        Wed, 06 Nov 2024 08:23:05 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:2454])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17fa445sm299452366b.169.2024.11.06.08.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 08:23:05 -0800 (PST)
Message-ID: <eabf4f2c-4192-42d5-b6cc-f36a3c7ad0f2@gmail.com>
Date: Wed, 6 Nov 2024 16:23:04 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] zram: support compression at the granularity of
 multi-pages
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, chrisl@kernel.org,
 corbet@lwn.net, david@redhat.com, hannes@cmpxchg.org,
 kanchana.p.sridhar@intel.com, kasong@tencent.com,
 linux-block@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org,
 nphamcs@gmail.com, senozhatsky@chromium.org, surenb@google.com,
 terrelln@fb.com, v-songbaohua@oppo.com, wajdi.k.feghali@intel.com,
 willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com,
 yuzhao@google.com, zhengtangquan@oppo.com, zhouchengming@bytedance.com,
 bala.seshasayee@linux.intel.com, Johannes Weiner <hannes@cmpxchg.org>
References: <20240327214816.31191-3-21cnbao@gmail.com>
 <20241021232852.4061-1-21cnbao@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20241021232852.4061-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/10/2024 00:28, Barry Song wrote:
>> From: Tangquan Zheng <zhengtangquan@oppo.com>
>>
>> +static int zram_bvec_write_multi_pages(struct zram *zram, struct bio_vec *bvec,
>> +			   u32 index, int offset, struct bio *bio)
>> +{
>> +	if (is_multi_pages_partial_io(bvec))
>> +		return zram_bvec_write_multi_pages_partial(zram, bvec, index, offset, bio);
>> +	return zram_write_page(zram, bvec->bv_page, index);
>> +}
>> +

Hi Barry,

I started reviewing this series just to get a better idea if we can do something
similar for zswap. I haven't looked at zram code before so this might be a basic
question:
How would you end up in zram_bvec_write_multi_pages_partial if using zram for swap?

We only swapout whole folios. If ZCOMP_MULTI_PAGES_SIZE=64K, any folio smaller
than 64K will end up in zram_bio_write_page. Folios greater than or equal to 64K
would be dispatched by zram_bio_write_multi_pages to zram_bvec_write_multi_pages
in 64K chunks. So for e.g. 128K folio would end up calling zram_bvec_write_multi_pages
twice.

Or is this for the case when you are using zram not for swap? In that case, I probably
dont need to consider zram_bvec_write_multi_pages_partial write case for zswap.

Thanks,
Usama


