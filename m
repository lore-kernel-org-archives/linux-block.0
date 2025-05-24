Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E923BE
	for <linux-block@vger.kernel.org>; Sat, 24 May 2025 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748095571; cv=none; b=kgGtzo4Ed/TsZPIp70PorMWx3wfVJMYMFIyrIk1FMZM7T/94GL/Mo6LvEIFIrIAX/ViPK3S/wmNeWp81168ubUy8C/49aVoxlRUMlgqmnUbuGq7ADeon940SeBsnHcdOxxWoiE6lF8Jgmu5EBi6okZDpVW77hp8p+iJC4+szZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748095571; c=relaxed/simple;
	bh=OEdIkR+Q/JVjvz1WTqBBw8ciDfnX+JYGr37zF56J3Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyaL8JnBpUQud+JA7p2xOzsw/msOIbBkpbT68gbOQnhDa1KmrvI6P1Yse4bVAxexIdu4rK3FElFAizU+eLWaWJwEjy8raNMqMZPW+Mx3GQrOcwlJfDrfFeQXOr0MABynbRQeS85HtRQv9ozW3udJ2MyEUyGILvtoutD1QZEL4Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=lavRmuk9; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="lavRmuk9"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4b4P2R6ZQNzm0gcG;
	Sat, 24 May 2025 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1748095566; x=1750687567; bh=OEdIkR+Q/JVjvz1WTqBBw8ci
	DfnX+JYGr37zF56J3Pk=; b=lavRmuk9DSaUk/jQngbT1xKjkBKv0IrlDxZMsaYo
	pI71BaqCl0AYlPSSvBCf7CA7UClayCzJMU+xo7DY8oGAO1xW5LN/WWj2ufEwEaem
	FdVuAw9B8ZMrbWAZEv+S38g8UDC/ikLDooUYBWKPEThPUObg59ftSblUSRJ5kWkp
	oHD6N6WkYJ7/KV4msN1h4Tskg7lQBPgsF6QEI06noaJeQBAXt4mRMUCrAb73W6Hv
	Heg5bTl/Us280RY+W2iHareZinJR9Ny2D04lN1MD8cY95XfN684GvmJgdNx7S7OE
	XkDFz6ZO4ZnVFKw0rhZ3zyVZm2ExEgtF2P/gvC+rJvsXyQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Qst6ozhDyk0m; Sat, 24 May 2025 14:06:06 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4b4P2J04ZBzm10gB;
	Sat, 24 May 2025 14:05:58 +0000 (UTC)
Message-ID: <a67e1ba3-e231-405f-9927-e6c40db3f71e@acm.org>
Date: Sat, 24 May 2025 07:05:55 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250514202937.2058598-1-bvanassche@acm.org>
 <20250514202937.2058598-2-bvanassche@acm.org> <20250516044754.GA12964@lst.de>
 <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org> <20250520135624.GA8472@lst.de>
 <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org> <20250521055319.GA3109@lst.de>
 <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org>
 <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
 <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
 <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <4128be53-b3be-48a5-8d53-9e0ef40c6d64@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4128be53-b3be-48a5-8d53-9e0ef40c6d64@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/25 1:48 AM, Damien Le Moal wrote:
> Note that our internal test suite runs *lots* of different zoned devices (SMR
> HDD, ZNS SSDs, nullblk, tcmu-runner ZBC device, scsi_debug, qemu nvme zns
> device) against *lots* of configurations for file systems (xfs, btrfs, zonefs)
> and DM targets (dm-crypt, dm-linear) and we have not seen any reordering issue,
> We run this test suite weekly against RC kernels and for-next branch.

Hi Damien,

Please consider adding this dm-crypt test to the weekly test run:
https://lore.kernel.org/linux-block/20250523164956.883024-1-bvanassche@acm.org

Thanks,

Bart.
