Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD962189B83
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736194469; cv=none; b=M1bzw2OK5w3up7g1w2TzCES49MoGwcm4Qb0SmUpCVgLSeTpC8w3hOObtZRUgfTDXxp8z1pjWHogrPuK6rfSxZmGwzwFo+1rfjXoBwMxG+Oxb1HTYojK313J87/4wUfhIrbc2yvJKZrkZtY21eVwSJrOK4H05UisEH6eOwYlp7so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736194469; c=relaxed/simple;
	bh=xO/1pMDQ2QiGkkhgCv+w+VTJfXaMFl5QtJOiWJ+Lywk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhbeb789okTAmoCBUU9mHTiQdjDsAH4TTTXMPUuOdTHpNup6hk2D/mVue8bkttU6BHce426lzvMF0BlLnqW+tuFfPVrSpTjD9DLsDaFXMARu6Ns/O0n3UCcfE1HOMT8pToXR7HGinYq1FzimjN++1cAAorOZt+m4zxi7SZl7kHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=S+mS0wPn; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="S+mS0wPn"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YRll63lK3z6CmLxd;
	Mon,  6 Jan 2025 20:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1736194463; x=1738786464; bh=RpqSN51l+yBQhjD8+lOkHKPa
	Dx7KYbSHEH97T05V0M8=; b=S+mS0wPntDZaoJeHR76qJc67CkOY5LZ7j3n2W5hj
	Oa+BqRidNk8TJGqTXNcTrPJmrieCTBLe6Zv9tzWnTztJPLHIc76dfv/d1VScxGM1
	O4+MQ6KWkHTeQkFRNod8223RUO7VhkUitrXsJ06YqCugn5JWS8nNjE8ak6lgGoB2
	HyghQsLDZ4CGoqkBJsF8NLgXbIffDoTvAgX6zih6yaJWsdwUn9iPBYfcG2UNMwMO
	ZhUc/B4FRQlxBSW37TvTRjNKg8QOAlEwuZ+Y6LdnWtqrfRaYyr/CQi193ZDT3YwF
	na0e4/7LVH/K8N1dmIInRX7Oj5mSjS0M1bzRicz/09x1pQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BooiZBV3EaIC; Mon,  6 Jan 2025 20:14:23 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YRll22PxNz6CmLxY;
	Mon,  6 Jan 2025 20:14:21 +0000 (UTC)
Message-ID: <d7b466f4-3de0-46ff-9a60-63fa6df6dbd3@acm.org>
Date: Mon, 6 Jan 2025 12:14:20 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
 <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
 <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
 <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
 <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
 <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org>
 <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org>
 <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk>
 <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org>
 <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk>
 <20241219060029.GB19133@lst.de>
 <b6a65de9-626b-42e2-a55f-28470ddee416@acm.org>
 <741838c3-63d8-4b1d-9639-edf1b0bc024d@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <741838c3-63d8-4b1d-9639-edf1b0bc024d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/19/24 3:10 PM, Damien Le Moal wrote:
> On 12/20/24 02:12, Bart Van Assche wrote:
>> On 12/18/24 10:00 PM, Christoph Hellwig wrote:
>>> If you rely on order.  If you are doing O_APPEND-style I/O on  zonefs or
>>> using a real file systems it's perfectly fine.
>>
>> Using zone append operations defeats two of the advantages of zoned
>> storage. One of the advantages of zoned storage is that filesystems have
>> control over the layout of files on flash memory with regular writes.
> 
> Zone append still allows that: you can still chose the zone you write to.

(replying to an email of two weeks ago)

Zone append does not allow to control the LBA if multiple writes are 
outstanding for the same zone. We have use cases for which controlling
the file layout is important. These use cases are loading large files
and applications as quickly as possible. At least for UFS devices
sequential read performance improves if files are laid out sequentially
on the storage medium.

It is not the first time that the desire to lay out files sequentially
on UFS devices comes up. Others have worked on this before. See e.g.
Jiaming Li "[RESEND PATCH 0/4] Implement File-Based optimization
functionality", November 2022
(https://lore.kernel.org/linux-scsi/20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com/). 
File-Based Optimization
(FBO) is a mechanism for requesting UFS devices to organize logical
blocks sequentially, e.g. logical blocks of a single file. Note: my
employer has not been involved in the standardization of FBO and has no
plans to implement FBO support. We prefer zoned storage.

Bart.
