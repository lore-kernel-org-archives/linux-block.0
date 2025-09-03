Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF1C1547C9
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925916; cv=none; b=C8AfAse54nKwgw2aZNwD9AE87B/J8H73dScP7gVyFDNI15xnFHR9r8QIIl1TGtVuUG94NAy15gHygLPX8F8ixUOJOBTbHfbc6GqlCHvaowPjx7EzPRDKVw040/Nq6fbrwzPnRzhdi2e42mcF5ISAllo/LAXfBXEYGGS1dYIxWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925916; c=relaxed/simple;
	bh=oIAdwyS6V7cNG3PICAGr8FPX311Ej2gMCiTvH3BFGZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSHT5FXIXq5oWCCahTdm6/7BMbbKTVzPC+cvCu18cFJLguf37CUF0aFU1qtRPvAPpYHf9vcHtvvaUEMUdy7uqDk8YshM/vw1Vy44D9H5DgQJfQG74M/9SMUFaMD6qZ/HQcEHrgbHFDQqs7pN8ChCCh3Mo5d16gcqIPcOZKNSt1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=amx6DrWm; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="amx6DrWm"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ecbe06f849so1349735ab.2
        for <linux-block@vger.kernel.org>; Wed, 03 Sep 2025 11:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756925914; x=1757530714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ToS85QZTL/LCAE6JPp2MXF2UeEtivmLWOi8NPiDPlJE=;
        b=amx6DrWm26K9KEmn0m0xmFB3zSG0Vwb61zHHrN6IhY12kwxNDc3Qdaw+p5ELUlrLyS
         TMKNFyPqT1NLeqI/OSO6Ep+lliQ57He3p3l2fXyGEpPFSDdl7DSED7jcMaQImOu+QiGN
         l90Kmzoam1eaAiED9h0rjmvNELzAypuYgxNATw4168jZIc6+iM0bURu6IK49jC3O8zoe
         p9A+zYtvMmoy9jLbzwsbbu4b/YkjEBlp/3ZyvTLjF7ytiJ54BWCCq3hmeaB+mAGouSsK
         7HG7utI2jAniKZO0Lc9UpwF9F65mf2BuSK4VlofkDhzue3j8XPQozEP3BUrCfv0kh6wb
         5NVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925914; x=1757530714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ToS85QZTL/LCAE6JPp2MXF2UeEtivmLWOi8NPiDPlJE=;
        b=qS+1fKpGJG4EnRfAtNTm/jaGoDdGkYXQxR9j1Uj1NONRvBDRH39dm4A+daBK2xaC6M
         vgSGrCgj/5e2+D6prug6x2HdkBK+wZPQmEJdt0MgL8AP811FygBzQvdGnMS9CoLdhrBD
         A7y9sJI4Xe3Rmj9lKiraUc5iPO8R6Yq9LfZHIPvRqfwO8N5F2E9FRiYNrPCOmZ/vE7l+
         1CNFLHVcmz6byaCO7EiN3Tb2wblk8u6E9KQU9gPJsntQlbq3dMzwCutc/76OI+3Znzlb
         UbUnw/YuYcLDKU938uxPufu/jGKVA9tBloEeEksyMyRCUPo5yc38bBrG2euC0qqEB7zZ
         hvVQ==
X-Gm-Message-State: AOJu0YyHHmuh3Mm3vcwCRqXZkxyYHYnTbc0QAabT2xUnJUy8L1CmWp/R
	rMkwWK8lYIZmYY2XE8CCGz+d+duIqqQal0h5XaTFIAdMLbAXPhLthgLzsszPaDgHvQ4LC40DHIX
	UpFZO
X-Gm-Gg: ASbGncvFPB8rN0eYMzYy/8MeKl7lfJIum1chTa2CVnDD82RHM/kHBzMV8xGHS7OmcvP
	m5Ugnh5OuTmTJAiJGi0w087NVY2aVZXRynhYsbTpaZxDDBtYiqBIaAJXnU0OHXPHZISwrd84Xnz
	eBVQOfh/RmMImVzalLzJncXA9HOwR1yGpYKFL+JLqJ5jWrDUm+2S2n3Iic2ANT7flHAZuBj3SOK
	6ycjThUUROPq3uwiCfVMt0Zwse4agGu4F1aUUHK8LmCxJWmi/fqTtZ0l9xIntwpbvTWmvMu0cNJ
	ejTZlNjWyK8WRAAEDq7IeGJHZwWwI3MSn7viVV+2BBPR3/MyGsaBqFWn4vhtbtl5XY6npktzMbJ
	VcN+hosRi7GF2Q4uYOA==
X-Google-Smtp-Source: AGHT+IFRLfzeRs/gCp9RAk0Dx97MxxaDZtDPy7H97v2ijo+UKHSjkn1BYZ8XDjh7aDUGY7camRffCA==
X-Received: by 2002:a05:6e02:3a06:b0:3f1:e16e:f5fe with SMTP id e9e14a558f8ab-3f4021bf204mr274384145ab.26.1756925913996;
        Wed, 03 Sep 2025 11:58:33 -0700 (PDT)
Received: from [172.20.0.68] ([70.88.81.106])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f3de24e801sm54902905ab.6.2025.09.03.11.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 11:58:33 -0700 (PDT)
Message-ID: <b0de8c00-050f-45ee-9a77-72d12159fed5@kernel.dk>
Date: Wed, 3 Sep 2025 12:58:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCHES] convert ->getgeo() from block_device of partition
 to gendisk
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20250718192642.GE2580412@ZenIV>
 <c821c881-76c4-4dde-a208-bb9e8f3ea63f@kernel.dk>
 <20250903140936.GK39973@ZenIV>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250903140936.GK39973@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/25 8:09 AM, Al Viro wrote:
> On Fri, Jul 18, 2025 at 03:20:02PM -0600, Jens Axboe wrote:
>> On 7/18/25 1:26 PM, Al Viro wrote:
>>> 	Instances of ->getgeo() get a block_device of partition and
>>> fill the (mostly fake) geometry information of the disk into caller's
>>> struct hd_geometry.  It *does* contain one member related to specific
>>> partition (the starting sector), but... that member is actually filled
>>> by the callers of ->getgeo() (blkdev_getgeo() and compat_hdio_getgeo()),
>>> leaving the instances partition-agnostic.
>>>
>>> 	All actual work is done using bdev->bd_disk, be it the disk
>>> capacity, IO, or cached geometry information.  AFAICS, it would make
>>> more sense to pass it gendisk to start with.
>>>
>>> 	The series is pretty straightforward - conversion of scsi_bios_ptable()
>>> and scsi_partsize() to gendisk, then the same for ->bios_param(), then
>>> ->getgeo() itself.   It sits in viro/vfs.git#rebase.getgeo, individual patches
>>> in followups.
>>>
>>> 	Comments, objections?
>>
>> None from me, looks fine:
>>
>> Acked-by: Jens Axboe <axboe@kernel.dk>
> 
> Which tree would you prefer it to go through?  Currently it's in viro/vfs.git
> #work.getgeo (rebased to 6.17-rc1, no changes since the last posting);
> I can merge it into vfs/viro #for-next and push it to Linus in the next
> window, unless you prefer it to go through the block tree...

Assuming it merges cleanly with my for-6.18/block tree, which I believe
it should as there's not that much in there, I'm fine with it going in
via your vfs tree. Which is also why I provided my acked-by. It probably
_should_ go in via the block tree, but little risk of complications
here, so...

-- 
Jens Axboe
