Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E3435CB6F
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474251; cv=none; b=KDNCHEq25DVffgjoozGXyN1MepyiAhP7gVaZPa6EHf3fesCEobLZcTuNpDmV4/jGKu5JA7N5Sk7hjZ7rodTmtsAstb7UZiPb+b4FfLNRdC8ZmJY5YP1kz/K1mo2h0LElIpS844Sb/myvSc5eKxGyuBRqDML+zizulRLM/JhuJCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474251; c=relaxed/simple;
	bh=ZQiRWUiKn75TDkvvKQdmsgZNqu4KpBFkYeZecn5MoX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEltYAuan5xycHTntL4jrfvUCbz8QlksJeqWPJmwmE2DMkxjNx7DSPqhOrRcGmmcEUrTNxH8mT2OtmtGZFxm9f+xEpysCSOLV30VZndJvnlQQA6d0kUNl+EbIHSzZueCD03DaL0hZocCjuV+Iu5MpF7qsuFzLV1tCVByUAumMxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GnEMTBYn; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GnEMTBYn"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-43346da8817so30526075ab.0
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 05:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763474246; x=1764079046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0kMhNQ2x38anZvEGPf80M5+SZuKGHk0AZzfIxLEprUc=;
        b=GnEMTBYnEHFTy8dVQbbEh3y5TsRWZxhiRrDALApHuvHYcRdRcvOKrj4wqnZph1OssV
         gxIPvmRb1neGTP4SlFwOah7rxmuTSsanKl+OdfKlCXEeOs05awKKKlWodWmVVXLW2wKO
         KgyBo9aG/++HPgNJJhVpEdLyTzloxNSHh9xLBpBFp/Tgqux4Txcr6UPO9ePgc8FdiauD
         vf9CrHZo7Oi+5vwpwO4UXFg6gZMZDUcTrRuDFaGkhyspHncujCwmCHKiu6djqa23aN4c
         85jiGlzu7sjJXvi+8fxoxsuC6wIcBbhXkD3wy5MhGc9pABRmePCi/wpkNMWSyVI8XrNz
         iv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763474246; x=1764079046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kMhNQ2x38anZvEGPf80M5+SZuKGHk0AZzfIxLEprUc=;
        b=IG1P5az/hkFGxc5/tpzGFCjv4tk3GfzIwCN8M0s28HUSbkgkdLSPUf8cSFan6fw9ng
         UVTCpnfW6gBEaii3A8h6+Cv+ChP9C2TACtvWhGSbpp+IET0OK9oB0zYhyKL2DVhAr3Y4
         KNRZLSwBD+j1LkuwlLgKbIFSeCAwYqjlh5IEZO4TE6l/sLo3pP8LclwLYePEFvyU/I+I
         2euA1RmkLS2zdodZZ7lu+bypt18Gdw5ajRWbPZiQh4iBpcEbwuGhw/fjKeeyrmbIBiKP
         YhlNWyAMYsrzo+gYxEejKUixnuhEOIbAlVOaXKtXrEFQuA8NPu8u1eQIir8ZaMCins+i
         FRig==
X-Forwarded-Encrypted: i=1; AJvYcCV6m9/Jc+8Y0wEauqAanVHBRmW0NwQEvi/hMgsYCm5K72fiE/1fWWDJqonEradGcn3NyWkSq1T5OlU0xQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVAJ2BJSSsgsGBlq/YykUn22qNfq7M+irdjI8DuU9HzfdXYzdC
	eXa43JQGUKpUPhehARh4bey81Ixi0YsOZ/oEF9lY3Pv+jXxkJJg/B4M4yUgcXrBZVRnZzW5oLzw
	2qS0U
X-Gm-Gg: ASbGncsJ68y+i76ACKp4ZPBHivi+d/BvYwekVGU5LoINan9t5TozXEhbZ0P0vwidwC0
	B+zrJ8RgxorHA3tSMiaLBH4JO9JYlmeIIzR7Vco38wjn/p1SxP+Z2pn/iOS5ASim4O71OWHui0N
	Her4uimuWuZp2iVN1P7Zz+mnEAn1D7/rfRNVRaJNh6ae9LvKm8aBA4Z2lcTkK+Bv6GmImJZvqNS
	gVk7kmFrLeiIYcCGN8JjppCXkz756itgmwwYm0edDYQicFJF2Q3fgas6ebE4ceZB/5Q+4jiqb+f
	3dsXixNJpkjSHwCuHBCWjB5Z+YVyxl9ZIQLQddqxZ0puHSYWvso8f77JpaSCEay7b5OvOPN1EG3
	MgCLCQOZEPhed81V7dvdmh89Jma5M8dQ+IEd0Kwz6Wquv3Gc8tq0wKgTrQOPzSglrvLBUtO3Jbg
	==
X-Google-Smtp-Source: AGHT+IH+cOg8lQG/nlgEgaVfCBm9ihVGSf0a5iV2GSkOuU6lpyqLzigM2jRqcvgyrt4OTK08nQJFHA==
X-Received: by 2002:a05:6e02:1a63:b0:433:3060:f5b with SMTP id e9e14a558f8ab-43592e03999mr35450465ab.12.1763474246652;
        Tue, 18 Nov 2025 05:57:26 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-434838c24a1sm81990125ab.15.2025.11.18.05.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 05:57:25 -0800 (PST)
Message-ID: <eef289db-72fe-4985-865b-c18c235d586a@kernel.dk>
Date: Tue, 18 Nov 2025 06:57:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] loop: respect REQ_NOWAIT for memory allocation
To: "hch@lst.de" <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20251116025229.29136-1-ckulkarnilinux@gmail.com>
 <6f76d0ec-a746-4eaf-abe9-86b51d2ff9db@kernel.org>
 <67472833-fd71-42a7-ac32-26e1da30f3ad@nvidia.com>
 <20251118052124.GA22100@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251118052124.GA22100@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/25 10:21 PM, hch@lst.de wrote:
> On Sun, Nov 16, 2025 at 05:43:53AM +0000, Chaitanya Kulkarni wrote:
>> On 11/15/25 19:50, Damien Le Moal wrote:
>>> On 11/16/25 11:52, Chaitanya Kulkarni wrote:
>>>>    6. Loop driver:
>>>>     loop_queue_rq()
>>>>      lo_rw_aio()
>>>>       kmalloc_array(..., GFP_NOIO) <-- BLOCKS (REQ_NOWAIT violation)
>>>>        -> Should use GFP_NOWAIT when rq->cmd_flags & REQ_NOWAIT
>>> Same comment as for zloop. Re-read the code and see that loop_queue_rq() calls
>>> loop_queue_work(). That function has a memory allocation that is already marked
>>> with GFP_NOWAIT, and that this function does not directly execute lo_rw_aio() as
>>> that is done from loop_workfn(), in the work item context.
>>> So again, no blocking violation that I can see here.
>>> As far as I can tell, this patch is not needed.
>>>
>> Thanks for pointing that out. Since REQ_NOWAIT is not valid in the
>> workqueue, then REQ_NOWAIT flag needs to be cleared before
>> handing it over to workqueue ? is that the right interpretation?
> 
> Having it cleared does seem useful as there is no need to skip blocking
> operations.  I don't think it actually is required, just a lot more
> efficient.

Agree, it doesn't make any sense to carry the REQ_NOWAIT into a blocking
out-of-line submit.

-- 
Jens Axboe
