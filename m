Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB4A17837A
	for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731536832; cv=none; b=WbhHpw0n43nWJqd7sjBsvM1yG+Z4rnWw95gn3FhSJH1U03exh5kJ+xeoYJttrfJkZk1JMyjEoRFolP7Uh2bTVCBmR/QeLG+A6wA+gUk1AyglD9UBi5P69EZIRs7+EQJzQ0SffXY21EPlKN0nn394g/7QKdgMc0n5h3515FlRERo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731536832; c=relaxed/simple;
	bh=nsozifW1bJaUXQvcoeJUy8/Gj7E4/mT/cosGv0myfXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AT8kRHXyfRQVEK/qtbxopZAr1zx7lyq41LkpA0POrqdGXAf2lQcbd/vnJd3c2y78IDxilkzqWgi3WRomA0YcAE1pyHVjamc8VZ36x7y63GLCDsgDgrfyn7Ptumh/hU9jwKwSC1oC0f8mrKgjkb9XtYL0nNUpdoWrHkWwHEMl7CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LQv2vNHe; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LQv2vNHe"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ee3c2e79aaso3236662eaf.3
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 14:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731536830; x=1732141630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gk4zJTuuGCZq8YdlR7rEOEIOkX+EpzyKcyBLyLJ6C58=;
        b=LQv2vNHe3c6J/Xk7LKaqBSbsVu98sNAgAr92qlbs0SCs5PffOC3OKJGJ2iGr79I9B5
         zGR5dXRgl69nmqXYVLtToMm9vEnVoGI93x6pH13pHDBxcg/56wluYTNvwzHA6g9TePce
         JDT333v3qP7Ny/dOA7uABo2hFGqoWvRIRt9RAnkI4mDBsBh6x71igvmQPi64kBbDCyVl
         K3JmIGRfPqGFoMoOjf1+VAz/iT0uiVL9wnNef2vc1ZyI6l5Ong/52Vg4eVffSD+4T5B9
         kp9KDZeo1oJXbFr1gf2BIrtTxgrnsnKddqtm2gU46ry4pL82Wafp+yddh6KntZn5/RoN
         Jh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731536830; x=1732141630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk4zJTuuGCZq8YdlR7rEOEIOkX+EpzyKcyBLyLJ6C58=;
        b=oViJ4czgxeb7atFF1a0KWfE23WoipRcZwg1nVDtI6GaJiGMPWz987RadhqFgOKlLLq
         OG1MSttOiT/BKYbYlfVodi7eHhwMeSH0vXJflpz0Mjm4R5ZU2mf9I8/oBueqlmG6oat8
         Pm4RH7Hoyoitu6AP07Qma+STVvCAxR4MnW7bZkK0imQTKFNTV7XlJ/kAhxmZAfS/yQvk
         jrecb9q2XJUEKcIaHSo0L3+282+SrzG4RBhcpghRMdsb4jAzPK7QQNV4mmNtEL+wjjrw
         fq5UbkoFsZQKODAIpCpBmplXZGT7iKmOdn4fLaXwUeI6THn16QzTGOEM++zGtYcs/m2r
         HbHw==
X-Forwarded-Encrypted: i=1; AJvYcCUpyPY1JEmVd/XVW5EnsG1oef1I2NOwgAgLKiNIst3c2VAuBT1DG5cC2DA90GE0uog79LtVEEQjnm7ZFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPLsbw+qjxDlGituPR++yMNJJVvlNPP2P6EZKf5N6wfEHciCr
	DNnA+28bOEEIIiQXGjSnk8bUcpjFUvs5YqNpgSfsUGL4S0QZubEEIuiHJz2BkSo=
X-Google-Smtp-Source: AGHT+IGoqd96MY7bfoXv+9tibkBAuG/6TDsL/wWWwAgL5vAB2DYrndf+hvSgNBskdlUVxt9rcbSY2A==
X-Received: by 2002:a05:6870:a58f:b0:288:570d:8fe2 with SMTP id 586e51a60fabf-2956010ababmr20540208fac.11.1731536829597;
        Wed, 13 Nov 2024 14:27:09 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e9351aeasm1230872fac.54.2024.11.13.14.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 14:27:08 -0800 (PST)
Message-ID: <0376df05-0b60-480d-84b8-76dd2d58f1a8@kernel.dk>
Date: Wed, 13 Nov 2024 15:27:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: don't reorder requests passed to ->queue_rqs
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Pavel Begunkov <asml.silence@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
References: <20241113152050.157179-1-hch@lst.de>
 <eb2faaba-c261-48de-8316-c8e34fdb516c@nvidia.com>
 <2f7fa13a-71d9-4a8d-b8f4-5f657fdaab60@kernel.dk>
 <8156ea70-12a2-46f4-b977-59c9d76a4a65@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8156ea70-12a2-46f4-b977-59c9d76a4a65@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 3:23 PM, Chaitanya Kulkarni wrote:
> On 11/13/2024 12:51 PM, Jens Axboe wrote:
>>> Looks good to me. I ran the quick performance numbers [1].
>>>
>>> Reviewed-by: Chaitanya Kulkarni<kch@nvidia.com>
>>>
>>> -ck
>>>
>>> fio randread iouring workload :-
>>>
>>> IOPS :-
>>> -------
>>> nvme-orig:           Average IOPS: 72,690
>>> nvme-new-no-reorder: Average IOPS: 72,580
>>>
>>> BW :-
>>> -------
>>> nvme-orig:           Average BW: 283.9 MiB/s
>>> nvme-new-no-reorder: Average BW: 283.4 MiB/s
>> Thanks for testing, but you can't verify any kind of perf change with
>> that kind of setup. I'll be willing to bet that it'll be 1-2% drop at
>> higher rates, which is substantial. But the reordering is a problem, not
>> just for zoned devices, which is why I chose to merge this.
>>
>> -- Jens Axboe
> 
> Agree with you. My intention was to test it, since it was touching NVMe,
> I thought sharing results will help either way with io_uring?
> but no intention to stop this patchset and make an argument
> against it (if at all) for potential drop :).

Oh all good, and like I said, the testing is appreciated! The functional
testing is definitely useful.

-- 
Jens Axboe
