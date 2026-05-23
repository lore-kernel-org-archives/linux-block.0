Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4825B0AA
	for <linux-block@vger.kernel.org>; Sat, 23 May 2026 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779544585; cv=none; b=RHvsBEuKsTMq7pEhTRbdCT/R4xziQIMFVCUb678DDxELp0kbOJAWA4FnnpLMSx9D7cyjrQwJMEHe1PBlF4idjOWpBR9yv25xvjVYSRsOkvAnK4KTH5CyO6UehKWCQJjjIK4ujZx9yv3c1DFi0YW5hSl12RmzC5zxtK3gADFyVkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779544585; c=relaxed/simple;
	bh=IQrjNrvQ/MIKMylnDMD+1/kJcvZ5OH6hPD8Hp7/iOIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrzEd3J1ntOlwNv5eQi3+UYw7/sJGdYSH8MQVZOWeBGieIqe+Z+uv00RMHtpwT1ok1FAuPW1tdZzKRXrktKPlFAu9rm5a2shgr5QUtnr3Y/BqtTvDKE8noup8dImiBZ/lG8wGwVubpIUErf+4VfZuCkq+kNVUO1y894K9UuTnF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=u8dBGuBW; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="u8dBGuBW"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-69d8e55e76fso823947eaf.2
        for <linux-block@vger.kernel.org>; Sat, 23 May 2026 06:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779544583; x=1780149383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmyc9diXCNhqzK4Rcicl3F8fH3GjZpu9eBl3t98hlwg=;
        b=u8dBGuBWSxbU0bDEna7ctJkp1J9RCKUFMrSdSamrLmO+vej8aqesgKHjjrkUW4xBJJ
         sUmX1E6YZiM69yb50RtHa7amabVkpFsTaQHLHJ+PL4HUxhTspaq9wQ2LfT7jfq0ol8Ge
         XhoSMpt/hLXzc1F5MQhnUTkT33J+1YWlGuPdIlYsG/5XhHoHYV7dBoYd4oYe3MO6Lt3z
         Lo8GYYbtACT9GJCr7byke2VimLAzZ6hTYasVgn2hysq2vaiI4OXnt+5J9d2s3V5DtHTr
         rs5byzOSF/dum3r8Xe+OwbO18RJ5Bfj1FQUgtQxkysAZimR4wtK5Aa5XGG4/Bt53YiI1
         WezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779544583; x=1780149383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmyc9diXCNhqzK4Rcicl3F8fH3GjZpu9eBl3t98hlwg=;
        b=KH/NHD95+FXLnXjlDJb4Afm08cyRCe7b3SclNToqUjRuMrNfKFp0g02rpjzcGMHLp3
         GBDgG1g79oD+OsNnFMmwg8PE/kv9jEYFYrtyI8+7GzXEfykzQb+gqd/sCI2VH26WhXnP
         E0DnnAf+6mobl/vvTHbkt11hHgYDPX78P/Q7toKVaP/OIPpkNwyJ36X9hgGaJ8IaBOsv
         wx0pZdRprxHfypwpKWUfQ+zju1MSe6PC8Q+sToaBxC50iQMojCVLPGShbx4IDut82tge
         3z8ur3b2zWEk2BOK6ctYE9gLYM/w44VGoMpRz0c1uwYhd1EuSXAl24v2v+h1b01cdR6V
         curA==
X-Forwarded-Encrypted: i=1; AFNElJ9x6q2XeKJfMuQBPvzeDRK7VD73QAgCplPh7aJFmRxrGnD7TGBsdlSIMCgt857XNqJoP5M0z6nkseiObg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLVaAZF9rhwIKMdf5SWpijNKMcLW1Prk1xK3brrQzHlBvEbs0e
	yTT2Q0UeXa/XZw+RMbEKfm2bWjt+h7jmd1/eapgj9IIykvjFp2w/hfTV/F6PdCJQCLI=
X-Gm-Gg: Acq92OGMnJTNCcIGN76RDYkctiYmnYvFAuGufz/u82f3H2RTqcAJsCOvny7pAIo4QGq
	jSGcydk1f/9A1Dc64X3r/sPQ3Wg+6Q1s2VPuBcz9KP3nghcqLSH0jNEGOWph9gP4tpT3GfmRdsf
	ug3cnPg8vjLYwJPypA1pRQ6aESg/ParCWMqR1M//KVCYf8LNRh6gQq+CQ0roJBuz5OeVBbeJnLE
	RiEb3Of3y2JGH9kWSU9uVyOnHc76eaOJISOYowL4l6FL8GxDeQEp95jHnMBfBzRj/JwoWLRsGyC
	f9Q0n2ibThkf0mCWQcql3gO5dFiIR1X67wNd9XSyypOAs8X21J1/FLPH+hzcxkI5rNN632NsN5G
	qST1GELj2jmiE3VHQpmDDla9spLnYP813+t02vdAJEShzJofBMGi7MU/rt/Kqfvy0dkND480dUb
	5mghOWYfQ2jKPC28xM4Bxt9fp99UZ1lSIjeX0A/YKFOIX4TFJ/pXRGMLJvrSAo2Pvdg3bszI2Be
	6PdSB05e6FqWRRqFAK/
X-Received: by 2002:a05:6820:7185:b0:69d:8c39:4159 with SMTP id 006d021491bc7-69d8c3943bbmr2132831eaf.47.1779544583030;
        Sat, 23 May 2026 06:56:23 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d83aafca2sm2491066eaf.15.2026.05.23.06.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 06:56:22 -0700 (PDT)
Message-ID: <95233011-744b-4383-84c6-8ace373fa275@kernel.dk>
Date: Sat, 23 May 2026 07:56:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] blk-mq: pop cached request if it is usable
To: Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de, linux-block@vger.kernel.org
References: <20260521190253.242065-1-kbusch@meta.com>
 <ag-WUymW2vwVyMJB@fedora> <ag-1EoopSdp0JZR5@kbusch-mbp>
 <ag_XoloTHEgt3Y8s@fedora> <ahDT-JZZGyyTXyii@kbusch-mbp>
 <ahDe25f1Dw0YBsOL@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ahDe25f1Dw0YBsOL@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/26 4:55 PM, Keith Busch wrote:
> On Fri, May 22, 2026 at 04:08:56PM -0600, Keith Busch wrote:
>> On Fri, May 22, 2026 at 12:12:18PM +0800, Ming Lei wrote:
>>> On Thu, May 21, 2026 at 07:44:50PM -0600, Keith Busch wrote:
>>>> On Fri, May 22, 2026 at 07:33:39AM +0800, Ming Lei wrote:
>>>>>
>>>>> BTW, as mentioned in v2, the request may be added back in case of merge,
>>>>> but seems not a big deal given blk_mq_free_plug_rqs() doesn't free requests
>>>>> in batch.
>>>>
>>>> We could introduce a special goto label for the merge case to push it
>>>
>>> It can be done simply by replacing the added `blk_mq_free_request` with moving
>>> it back to plug list.
>>
>> What I'm worried about is hitting a blocking allocation, then the
>> cached_rqs list is freed, leaving the current request from it the only
>> one still holding a queue reference. I think we ought to re-enter the
>> queue in that case.
> 
> Hmm, I may be mistaken here. The block allocation doesn't call
> blk_finish_plug(), so the current plug is left intact; the other
> queue_exit goto's are either from non-blocking contexts or a
> successful merge that holds queue references in other ways. I guess
> there is no queue_exit goto where unconditionally pushing back might
> be a problem. So yeah, sorry, maybe restoring it to the cached_rqs is
> a worthy optimization to make.

Yeah should be fine, we also discussed this one the other day. Want to
send a patch for that? Just mark it as fixing the previous even if it
isn't a bug fix in the strictest sense of the word, but then we ensure
that if one is backported, the other one will be too.

-- 
Jens Axboe
