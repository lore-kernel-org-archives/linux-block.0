Received: from mta1.migadu.com (out-99.mta1.migadu.com [95.215.58.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4106B455175
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940332; cv=none; b=beeub0YU6Ptu78OVgpxhaR6Q7q0pZki68kEE6AULPevSsAhHxkHTnJFXHl4RxkFLkCgT7YNCz5HVQ6RouycgWmk8NPtDvbbLO+VyMYYhK1AvUw3qyFGZkT2xi0/ShTd8hj17FqgiAq47z7KnKzxiVPWg/63PLkU3Me2LWB1FUng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940332; c=relaxed/simple;
	bh=cnCZ+gc4x6PHqtE0jvXQ8NORTlNmfZNWlaDkGU5s9aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfBGDeHa71e04MDzhkyn4OrHkjzkjAlPCojEi40lTuqegZcRp63wa9HJeon5Vo3DkT+gls72k0ca4otsv+GPWZDPqNhFiBxJWOi+5EqnsSvyWT/C7wzR8yrUUzw4UtzcSua8q+cu29uc3sEae1xYpkAez+mgafYlkj1mA6upXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FeSYh8bJ; arc=none smtp.client-ip=95.215.58.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FeSYh8bJ"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cnCZ+gc4x6PHqtE0jvXQ8NORTlNmfZNWlaDkGU5s9aY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788940329; v=1; x=1789545129;
 b=FeSYh8bJJNib3FN6lpZKtzmXKcD07XWkuIpEwmDlrq72DwrPgmTZ0zPWAELfUif9OD9WZ0la
 U0OB/3GEuP4okApdQpsiOTHOWoVhX3JQdsVo4rUx+440G9WNfKxcAmwvNobsgZSe3PHVL9IuMJr
 n75lcoQX4BX8pWN6zJx6JFQM=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 22872cdbe23cad68;
	Wed, 09 Sep 2026 07:52:09 +0000
X-Mizu-Trace-ID: 22872cdbe23cad68
X-Migadu-Flow: FLOW_OUT
Message-ID: <0de31e94-07ed-4d2a-9908-46e1b87b2ba7@linux.dev>
Date: Wed, 9 Sep 2026 08:52:07 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: cap atomic write size by PI buffer size
 constraints
To: "Martin K. Petersen" <mkp@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org
References: <20260907074111.721054-1-hch@lst.de>
 <20260907074111.721054-3-hch@lst.de>
 <8c16f727-c840-4a8f-94a7-fbe09bc3735a@linux.dev>
 <20260907084621.GA7391@lst.de>
 <90f94bcd-813d-48f9-a62c-3c703c4a71e6@linux.dev>
 <yq11pb3dtzs.fsf@mail.kernel.org>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <yq11pb3dtzs.fsf@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 03:44, Martin K. Petersen wrote:
> 
> John,
> 
>> As for atomics on disks with integrity support, we decided not to
>> support SCSI WRITE ATOMIC (32) - this one is relevant to PI type 2.
>>
>> But, overall, I'm not sure on this - should we always disable atomics
>> for any disk PI? Is there a use case for the two together? Martin?
> 
> I think we were originally just trying limit scope. The two features are
> orthogonal, I don't see any particular reason why we shouldn't try to
> support them concurrently.
> 
> Type 2 is fairly rare at this point. But it should be fairly trivial to
> add support given the existing READ(32)/WRITE(32) plumbing...
> 

Can you please help me understand then how DIF/DIX interacts and atomics 
- specifically, is the userdata and metadata atomically written 
together? I would assume so.
