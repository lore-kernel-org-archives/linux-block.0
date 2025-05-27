Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E827D776
	for <linux-block@vger.kernel.org>; Tue, 27 May 2025 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362808; cv=none; b=TKEwQzu/boAExgHsGA1U2my8MJ3dm4vBR+ylMr+I/IFTaF2HeWrsqHAq3JcL5E6jj988waAMR6REK7gOkxbVouBGyAwAudH83wt8UrVgeqe7WWyzrPQ1YJbTcoet9/tx4uGBcm8pZPWF/xDBp29xqSWQOjre5wev70IjdRyH36Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362808; c=relaxed/simple;
	bh=rnaoUuoPoH/EMUoQjdrKNNgwR5RreyNOCHCyJGN7I7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkVPgRIODyusBHAiDVbffgUcNd9Np8xIyg0Q5E5Oy/FeHwisJIxI+OA1dOaEC5D4YEU+iom27cnu+U87Onsg0awiuGj0hqQ/m1ypWkdEpxEHLogwaIa20F/XXVC/sOYgiJeBqGxMYb+hQV8bwSYBNIRhhbkN8rqrzSkW1xVT4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2SGptYMl; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2SGptYMl"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4b6Hsc74qszm0ysg;
	Tue, 27 May 2025 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1748362803; x=1750954804; bh=93NWBElGA26GSI89t8JXtF5d
	VdbISdGgyD35xo2WGeE=; b=2SGptYMllI5Pon2HSZoT9FGleui/iLO7KkqaEdqj
	xFMZkoCjToJl34wCVtlgFtc3CjYdiAcRGlvvoi+fzSMhGqf3xr6WziOjhamCXgNM
	qENJtZOCLP8/L1Nfz7JsJeDQLD3vRjAV9rcSwC9HeIciWF7Jit9vS+0ZkKHjMzeJ
	C+0glxRvVk2Bno34TzSb6SvblylpEhr+qlH4E7qud5UL14uiFW/YsEKcp6Ykr/ns
	MDYDkp/MKFTfgAyADpIHH/c/ElMUnMDy1LDllEVEfpIBSTRtL8hzuwg2bC+BnL8/
	ip6geE9d/qDmtNkAbrTPk6R9nddcAzMqY6W6Gf5PFMrK6A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id y9Ky6D63ARvC; Tue, 27 May 2025 16:20:03 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2e14:8:7a1:9d43:61a4:3dab] (unknown [104.135.204.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4b6HsV01jWzm0gbQ;
	Tue, 27 May 2025 16:19:56 +0000 (UTC)
Message-ID: <3eae0697-0468-47a6-810a-b97d0f469f79@acm.org>
Date: Tue, 27 May 2025 09:19:55 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250516044754.GA12964@lst.de>
 <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org> <20250520135624.GA8472@lst.de>
 <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org> <20250521055319.GA3109@lst.de>
 <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org>
 <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
 <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
 <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <20250526052434.GA11639@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250526052434.GA11639@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/25/25 10:24 PM, Christoph Hellwig wrote:
> On Fri, May 23, 2025 at 09:30:36AM -0700, Bart Van Assche wrote:
>> It is the dm-default-key driver, a driver about which everyone
>> (including the authors of that driver) agree that it should disappear.
>> Unfortunately the functionality provided by that driver has not yet been
>> integrated in the upstream kernel (encrypt filesystem metadata).
>>
>> How that driver (dm-default-key) works is very similar to how dm-crypt
>> works. I think that the most important difference is that dm-crypt
>> requests encryption for all bios while dm-default-key only sets an
>> encryption key for a subset of the bios it processes.
> 
> Umm, Bart I really expected better from you.  You're ducking around
> providing a reproducer for over a week and waste multiple peoples
> time to tell us the only reproducer is your out of tree thingy
> reject upstream before?  That's not really how Linux developement
> works.

I'm still working on a reproducer for the blktests framework. To my own
frustration I have not yet found a small reproducer that is easy to run
by others. I'm convinced that it should be possible to create a
reproducer that is based on dm-crypt since dm-crypt and the dm-default-
key driver behave identically with regard to bio splitting.

Bart.
