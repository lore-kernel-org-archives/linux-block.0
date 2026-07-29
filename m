Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7FA48A8A0
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332364; cv=none; b=svJYOh+2AdPot2GritytqiBlQ6jFeC77xxX36y6Pyb8iIYfoItHC0PsS4iUeeh2sCcxiGjFOrgUz1zwLrVmWihHA9PBStnB5BOhRXwBYjHg+Pn8RLbZuBe97OiW4aNs6OqumqBeS4531mk0HZfRO7i52/pUskMtP4rNcdppt8RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332364; c=relaxed/simple;
	bh=uY3sUepmqssMOr1jNQvyXWE6qqQrkaRqI5lsNd3E8OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swb/PSjMkYFy2PKU96kRKUTtn1N+9cr1CgCewkxhy01HWqL6MpbobcUt0NAFfqu2bJXYSDMEjLn+cWMLYDCYfNvLT8BAGEw+zhpssQ2Q5Om7ejeJnw2Vxy164gyTSWEDxTkvQV55Sgrfw+gnLXCoXiQTNnSWltt9vsmNS0rqR5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGVPcDzP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGVPcDzP"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso116087966b.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785332352; x=1785937152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3aN3udKBcENjBD5UHxw3XhgPgHCGso1JhkYTFHwhTGI=;
        b=KGVPcDzP8wQ2SyiaYgiEB/4+DEBMYVALsc3jCB2ht0eAjAMxzC7NXELzSBNNQc9MON
         d+5UWFqymcPii4NKyLLs61jvxSrgM4urA7UkU2HBYDgPFjDRMUOonbQMxjRRz2fM1A1G
         0KQEeIhH9kn1nef3qZipqo46Ff4aokfZS8yASW93kTavs5E/4t210s8/nqPmRCI2xWmQ
         cfiUS6RP81gBjK/rG275PimVCBEjZw1hM2fIi52JuSxl+y5ssYS80UyMSVQF+j+qwWAN
         5FmGmrGXBoIq6mhUzjQD+AoBX6TSFQp9EuI2mNAYYE4/W/exMXsXk9Ptt68mGWbQptup
         dcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332352; x=1785937152;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3aN3udKBcENjBD5UHxw3XhgPgHCGso1JhkYTFHwhTGI=;
        b=LweSoWH4zwZg27lM3qo+gv6ZQlKbXUdbwVT0zN0DNgme26NgEh/VTGt+sbJICThdzK
         kfm7Cup5r4AG6MR5YIPJ5+hLVCrWsoRhdZ1lXijOPlAVy7Vk6eEj1aQm++EihjIG8Dhr
         cIiNWyz/ACX/qLpU0XaxxxHvlqzw9QY+0VwUnOAvj9WGUM5vd4bTtixNnwKMjE6h5NKF
         c9h2gx8wVdaFIu6pbmv+cjifYuFF51ub73aDfSrLl0BL8HBqAhqSI5CijIZaGuei0SJO
         MyO4F0cqbzfCbTDF7h0eu6/BazCycuo0t5JFEgtcc+3V9IgCMeLrykBhkSrlupyppSIE
         FgyQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1O/vT3b/i1lvktUf0k0+S0yIG/0+HPQ5krCETSLEnEIMLHgC/3/orl15ktwEGx/8FBrwFC0+vz6Gv8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMrIBCQdVStjuVtUSZoMCEE2E9l3/g/hBtXCKx3VddUZbcd3C
	nQ5gt0VNOABHwkmMphKkwLxjczaMb26oZVkOxokGubfk/Pnf8lbMQDfn
X-Gm-Gg: AR+sD12uN+WF4DNYI3f8Gq6fIehObaox2W1WWND18W8kIoid4EVHt2nTRCpjIshGtII
	5T/+OBcCs/DH4aaezI2D9oPNp8JtHGFgs6EKIwJXGjgUYMv0g0P/kuY60Z7HWMSjSYuPUAbHEzW
	9lsGrxpNyDe6h4IrEDXtVAnO+NEeMg9th5P1JUBFElu/Er7XnmrHqvyJvQSxQh3ZyiWFBtVqO6w
	yzw3RXIyd8ySLCQvhIynTODgJ5dzy8LY5Lf3avAU5vHrgiPosjrbRhZyTCPehBCXhQ+EhaWB54+
	+IwH5Q1/pKqm6YzRCQz37MJJOOSP0JZSR02X/YclDu+KCcoxNthVVfEATL+frVfP5PF9to3DuhK
	urKeZcf1+T8AzUlBFxBEDknwTw67Vp2AybBdsB8WUYJdy4XCJ5SkO0dcd3RnTGMDin5jEn05Ovv
	dQrD2e9U0T7olzjoQr51pBBWbrYAm8Guvk4JgzmbXr5kH036i6l52yhwYAMvdS6lOvE4axZz4fJ
	gWO/ChwYJGObzlpi3vYXfSnVizrqQ+ve17vaRlntQq0pJoeZwnzeFcGQovpnvNtVYVpPVz5s/UU
	yRQhgMBU/pCYDq9GSGY=
X-Received: by 2002:a17:906:f598:b0:c16:7b66:4932 with SMTP id a640c23a62f3a-c1f721bf58emr374209166b.64.1785332351629;
        Wed, 29 Jul 2026 06:39:11 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83f4de5bsm118685466b.29.2026.07.29.06.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 06:39:10 -0700 (PDT)
Message-ID: <dc72d46b-7b45-4beb-8e36-d810d2a94c28@gmail.com>
Date: Wed, 29 Jul 2026 14:39:01 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/14] io_uring/rsrc: extend buffer update
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <CGME20260728213008epcas5p418dfc10b7ef786e162ade86d14430475@epcas5p4.samsung.com>
 <633d33d8e278999f55126794fce948343403494a.1785274111.git.asml.silence@gmail.com>
 <73317bf9-f7df-43f9-abc2-daa25a675485@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <73317bf9-f7df-43f9-abc2-daa25a675485@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 14:31, Anuj Gupta/Anuj Gupta wrote:
> On 7/29/2026 2:59 AM, Pavel Begunkov wrote:
>> @@ -882,8 +894,13 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
>>    	struct io_imu_folio_data data;
>>    	bool coalesced = false;
>>    
>> -	if (!uaddr) {
>> -		if (size)
>> +	if (desc->type >= __IO_REGBUF_TYPE_MAX)
>> +		return ERR_PTR(-EINVAL);
>> +	if (!mem_is_zero(&desc->__resv, sizeof(desc->__resv)))
>> +		return ERR_PTR(-EINVAL);
> 
> desc->flags  isn't validated here, unlike __resv. nonzero flags should
> be rejected too?

good catch

-- 
Pavel Begunkov

