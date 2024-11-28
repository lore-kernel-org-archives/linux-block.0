Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD04AD4B
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732771676; cv=none; b=khjUxbaOxAEyQU9kzoztwPNkNV9INXXqHbrCJ11L0PxrbtVsDFD8R/kAST7sX3hoXJtRfBS/gDN9qfX5SfB9kygM8Ke4QJqz93TGgp3vsrU2TPkHBxcBSIs+IRlZmnsmRjdHNwFPYplRUPxGdBcqfUdN47Jt/Z2RqMf3fCJS5sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732771676; c=relaxed/simple;
	bh=YSrQzcQI32kqAAjbVhZoMwvAqd5AGtnfM3GFWBkuFps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIdQs/Rw2/vKVTwVrh4RO3IQrDz7FW6XlZu/KjVqPF1vMCDNpQ+KYMppkcvSKlDA/cl0QKZO/5vsWPLzzcNlZnCx6u7cnwVvOeFXv5fqWaaRkez1p+xmGYYrBI1PUCBMdzXH6c7HDq70AuORuYk+cxCqPvTMX2lCH7pVr9qYvyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjS7KFtz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjS7KFtz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877F2C4CECE;
	Thu, 28 Nov 2024 05:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732771676;
	bh=YSrQzcQI32kqAAjbVhZoMwvAqd5AGtnfM3GFWBkuFps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PjS7KFtzw/MoLMrBmdbQlhwFPsV7+jGjgGvr8vNU3qzqoac9ixBMUqDgwjkA7El/7
	 r+hZUqq3rHBLNCuF+ssNY6ycuIYWeqQi4/WeVtfy8Lbm6HLU934jxYZ4GDuC85wk2h
	 7lbv/XT4q9Jc9Og/ivIXROk5ZJ74jeHScg8BacB0MdZ/xygi5AW9ET3WAQoexEuUSs
	 gBkNcIJu52m0eXiNLmQ3TspfEsitfQLBIiTzousbAY8Q3pc18OyjfazzSURkgZ4z3y
	 aX9fakVlZCMLhNafD0XiDLNhLrCG9JGsCFNd/HewHs+iTMup15mJU2tEm2j2lMdzWo
	 Ms3dRjcSaAMiw==
Message-ID: <e82c10b5-cf68-4418-b060-862496367dc5@kernel.org>
Date: Thu, 28 Nov 2024 14:27:54 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
To: Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <Z0dPn46YnLaYQcSP@infradead.org>
 <2b7afce4-fa13-47b6-a3ed-722e0c11e79f@kernel.org>
 <Z0fhc8i-IbxY6pQr@infradead.org>
 <16e543dd-c4e6-4f79-b401-8030d7ba1514@kernel.org>
 <Z0f0B6Xf-jdc_fx-@infradead.org>
 <43c0f15e-7f3b-4ed9-bde9-dca2cff57afa@kernel.org>
 <Z0f47wft_sVto7pM@infradead.org>
 <a9ad27f7-b799-4322-ba05-944abfc0fa88@kernel.org>
 <Z0f8uAFz5C60fung@infradead.org>
 <684a3b59-776a-466a-8323-d92c0502e7a3@kernel.org>
 <Z0f92dX_0_eQlDbL@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z0f92dX_0_eQlDbL@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 14:21, Christoph Hellwig wrote:
> On Thu, Nov 28, 2024 at 02:19:23PM +0900, Damien Le Moal wrote:
>> Sounds good. What do you think of adding the opportunistic "update zone wp"
>> whenever we execute a user report zones ? It is very easy to do and should not
>> slow down significantly report zones itself because we usually have very zone
>> write plugs and the hash search is fast.
> 
> Just user or any report zones?  But I think updating it is probably a
> good thing.  When the zone state is requested there is no excuse to
> not have the write plug information in sync

All report zones. That would cover things like an FS mkfs report zones putting
everything in sync and an FS or dm-zoned doing a report zones after a write
error syncing single zones.

To do that, all that is needed is a default report zones callback that syncs
write plugs that have the "need update" flag and then call the user specified
report zones callback.

-- 
Damien Le Moal
Western Digital Research
