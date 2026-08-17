Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DC026B2D3
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979567; cv=none; b=OsOx8uJJ0oylikNYSB0mGQVWPduZD5XH8TdpkSfUy/isU+1QRVJF7pW/ZPYLeuTsVHCrC8XjiyAnpC0QwLH3GHDSK+dCG1gYm2S/5sAhWkDGmqF2XPqgjlh+yVAm5/AmWv6trve4seqmg22QRy//dOoHmvyrT7joM9yZ5b0oEV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979567; c=relaxed/simple;
	bh=MfEkF3AKE27DgUN2O/pRixKNoNRPkgasNUeln56oODI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALZWpR7ZSnolYvnJQGQBy1/bji49ntg1shbpzaDh0Io8m6b8v16kxbvK1BDzwBMTuDhQJtmj9EnusJBh1IIm8fWlbtfMaNGwlzbbUi+aIiosGVcqpTU2o1mrFx0r7iIJHAFTyHigg5D2wTaze/kvVnt0IaQzuBEigG8cB1HOadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOuSoEiQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZD013Hx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOuSoEiQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZD013Hx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786979564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jAUFNzzdASfv0kC6gDPmZTF+BtCSUHVXx7AeXUuUN8=;
	b=VOuSoEiQ2EX8UI3Un7AEJntLQAZzMQoZHtE9gWe9/ZIGVnTEeq14sJGuvnaCDo8GnN7WII
	EGMDh1HDqSGdqiQ6GPQw2HNQ9SJjvVcqm7JeitVHfzYNLNlDdzNHLuRAyakIw6iXyP3DTy
	fgecu5zj6g0elbQd9RjqCJTCn9k0JOA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-Hcs57g_oN76iV2thISpZEg-1; Mon, 17 Aug 2026 11:12:42 -0400
X-MC-Unique: Hcs57g_oN76iV2thISpZEg-1
X-Mimecast-MFC-AGG-ID: Hcs57g_oN76iV2thISpZEg_1786979562
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47fe23b5acdso3039980f8f.0
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786979561; x=1787584361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7jAUFNzzdASfv0kC6gDPmZTF+BtCSUHVXx7AeXUuUN8=;
        b=VZD013HxG/ioCWLQXCYZYr/67MFnknNF3fmXWn4xp+/iTU/7+kDGsM/AfKPyKN7Va2
         QRzp4aUiea41rkET1GSs79q4g019Wlvj0YCU5imNxZYaXFGKGPpkHrNNAvLrjWr5y0Pn
         3ei4s/5dGHlSsNCOJjstfRV+envYPAlH1ID74KK90HKYeMZelZH8MUK6XVLlnOgEqJVE
         wdJAYaJ2BJMKXzsSVbNLmbakYjxqhZlp7oGnuYck0a4R69ylXH9d7hXU5iIl2LXpsPgx
         XFCYr11tohplp3Rc/j+qo4+rZbhEDdX4BEz6smMQaKCI/9v5rzcy/2ml5jgFWFYjKvjH
         /PRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786979561; x=1787584361;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7jAUFNzzdASfv0kC6gDPmZTF+BtCSUHVXx7AeXUuUN8=;
        b=Rl2leagpgza+WKM1P6QZFeI9CHLXoDArpICNhg0HnPzN/U6lQtGvy6nBSzdcJJMwdJ
         83bb5h7PB2DPw7gfTX3+39gHDVVlQ3YvF9dGMbX/zIoL38cHAV3rctD9mDGru/dy4gea
         uBKXqdMtuR8OVwfARZ11hSWbPw7Fkjnz6DBj6dHJM4AjcK6dJ0jsNWdW1CFqtey8Ej/U
         WFOfWducCAe6cZkeDzuZBhH15TsBnB0SSzFTtuQDwUhrge7YmPYHAgy8HSurjI62xrz6
         4efMKAbTv7x17it+a9BW0ap0MRgshXXutz+Aftao3mZqBkqx3M6OcB5vfjo2L82bgDqm
         u+1w==
X-Forwarded-Encrypted: i=1; AHgh+Roy8CauQ7wnSHl2g8bmwUHt6F4+o72suzYXte4yEl+glX4SYnX15cP5X+O6di18pZDLAsU9PxrFNUfPBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrhACV4pbM/61wo/TIGsrh+67uIeGFabu7FwZriYHfmGAhDyab
	6QFOAB/WWFTY1gKwfMhmm4nit9Js/PPlkKlTK9ltRDMaSpxx0A3C78YYP2nkx2mtpGiTYgiFQa9
	gEMIIzY7yjFJ5r/ZTpfzFbiyOdr7+V6i86PNM6OcqRiWfH743k3ot8DdXqA2BSZSL
X-Gm-Gg: AR+sD10C8YwkIFDTW2hZOmZqNO23k5KmRF5xJ7zh9eeidrjNve07p6ppHHA28zJEmP2
	g405sO3/OpgGkV16gL6I5twoTRsvzV46llnX27p2bEjszXrAIVAKqc5HDqAAM/9dY/9H8TM7j1N
	CEGHxzdoYJWMgvxdrqtfxTs/+EHpQ7JMIWvPkpbEQOlMy9qxxlLNCqFxHVy/pThrpYg2/4xQfM7
	qryrcX0R6H9RbSxyFw+PtkUDxZazV8NcXHxbO7Pl0o5uiNdLb1Yrq+ohuSpdjf+VIILStivRddg
	raCKSrjDq+9kBUWXYlPnbT680vNLW40200UBI7ZWO/74nJHSxzXugLzVv0BJPYNj4/s6jV6pUEL
	2PdBASzVGd1UkH+2yZHhJMxi8Xk4AQg0GN7UgqFdTPqQ=
X-Received: by 2002:a05:600c:8714:b0:499:8704:242c with SMTP id 5b1f17b1804b1-499878ca13bmr462810305e9.0.1786979561481;
        Mon, 17 Aug 2026 08:12:41 -0700 (PDT)
X-Received: by 2002:a05:600c:8714:b0:499:8704:242c with SMTP id 5b1f17b1804b1-499878ca13bmr462809155e9.0.1786979561050;
        Mon, 17 Aug 2026 08:12:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c5dcsm5028724f8f.17.2026.08.17.08.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 08:12:40 -0700 (PDT)
Message-ID: <0023a895-7b04-44cd-a90f-c9d587a49519@redhat.com>
Date: Mon, 17 Aug 2026 17:12:39 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, Jeff Moyer <jmoyer@redhat.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
 <1805eed3-90ec-4f62-9d71-e3f898a464ad@redhat.com>
 <aoMi6y2qsnRVembg@kbusch-mbp>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <aoMi6y2qsnRVembg@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Keith,

On 8/17/26 5:04 PM, Keith Busch wrote:
> On Mon, Aug 17, 2026 at 03:23:14PM +0200, Eric Auger wrote:
>>>  
>>> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
>>> index 449950029872a..94d3461b5bc8e 100644
>>> --- a/block/blk-mq-dma.c
>>> +++ b/block/blk-mq-dma.c
>>> @@ -79,8 +79,7 @@ static bool blk_map_iter_next(struct request *req, struct blk_map_iter *iter,
>>>  static inline bool blk_can_dma_map_iova(struct request *req,
>>>  		struct device *dma_dev)
>>>  {
>>> -	return !((queue_virt_boundary(req->q) + 1) &
>>> -		dma_get_merge_boundary(dma_dev));
>>> +	return !(req_phys_gap_mask(req) & dma_get_merge_boundary(dma_dev));
>>
>> I observe a regression on RHEL due to that change in
>> blk_can_dma_map_iova() with a 64kB host. This also occurs with upstream
>> (7.2-rc7).
>>
>> For an NVME device blk_can_dma_map_iova() now returns trues while it did
>> not before. And it seems it shouldn't because it then causes some errors
>> on the dma_iova_link() path due to unaligned iova:
>>
>> [ 4486.655564] iommu: unaligned: iova 0x14c34000 pa 0x000010764d790000
>> size 0x1d0000 min_pagesz 0x10000
>>
>> It occurs when launching a 4kB guest with virtio-blk.
>>
>> I traced:
>> nvme 0015:01:00.0: req_phys_gap_mask=0xffffffffffff0000,
>> queue_virt_boundary+1=0x1, get_merge_boundary=0xffff
> 
> The first thing that looks odd to me here is the page offset in the iova
> isn't reflected in the pa, so I think something in the construction
> isn't setting it up the first vector correctly.
> 
> Thanks for the notice, I'm looking into it.
Please let me know if you want me to trace some stuff specifically.

Thanks!

Eric


> 

