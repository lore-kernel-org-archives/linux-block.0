Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35EF1F8F1A
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732727478; cv=none; b=J9T9pLvag6BPlU2YToQDLo228UzToh6HbIwyVfPICx92O38uYxhHIQhT0hXlUjz01BL7Rox4ACpO/mu6Jxlsdr64vHTsucUIc5rJIoa4jVBboMHpE/+wgPkI9qd5WbRH2X0ZFqgRLzpCKZgPxqoRqYrtoMDYE4eaQQHS+F36vVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732727478; c=relaxed/simple;
	bh=6eoIFwAJ6g4HQl4yMMsadIg30t3ip8Dg3rdEFRJcHM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nC4zqxS3EepYQ41qbLZMf7wfNDZdJNDL+Q+NpJTXzxI0pNa+kkb6Llzd9RV6T7TyNQj2/X3kVIWq/iVW0s1wdVB4RtzY+ZaF6EuC8yxsB3lEFwr/futp15vzHEny92YYPHfOviYEr4kzvK4dDleA2Ug1ksecomM4bOlI8lNCIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EpOycpDL; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="EpOycpDL"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Xz5Z623b2zlgTsK;
	Wed, 27 Nov 2024 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1732727468; x=1735319469; bh=PrfMqo7XxxLsES8DpF3qxy6T
	F7oPdzZwjbrrcetn2HU=; b=EpOycpDL/4RF8tOG4DuM+rmtxkpRWSA+mSuH7X8F
	txc9tkSBNt33p10B3zlsfv2XlFeiZ+K+SeInYSP1FvGDJR5JGaXs6avYh1Ee5ghA
	JjcpFz92E7uCtIEsxXU2QOVSUIgmlCnKZxP9hjx5ZN/2lGCE57j72xrb81iKbm1/
	U5k9i/cx6WPR233/AIjd/KOMOyp17mrSIK66uN3rLXHpryAFrQLdNpaE2jQcC1Di
	vQ48C85VZSO5oGk2fclPJPa8abQqIL1EQnX5SxmBZ5CtJHoYRzcKGK55zfbPTVjG
	dDFbccyAzdBHXDu+f2qRGeNadIQKZ+CkoMVKy0KlQMKV1w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id VoS51wV_7T70; Wed, 27 Nov 2024 17:11:08 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Xz5Z21MKhzlgMVj;
	Wed, 27 Nov 2024 17:11:05 +0000 (UTC)
Message-ID: <31d02cd4-ba0e-4294-9ff1-a114fa266f15@acm.org>
Date: Wed, 27 Nov 2024 09:10:56 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
To: Christoph Hellwig <hch@infradead.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <20241125211048.1694246-1-bvanassche@acm.org>
 <18022e10-6c05-4f7a-af8a-9a82fdb3bbc5@kernel.org>
 <ef0b613a-d692-4b04-b106-0a244bf4bfc1@acm.org>
 <12c5ee53-dcc6-4c78-b027-8c861e147540@kernel.org>
 <Z0a5Mjqhrvw6DxyM@infradead.org> <Z0a6ehUQ0tqPPsfn@infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Z0a6ehUQ0tqPPsfn@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/24 10:21 PM, Christoph Hellwig wrote:
> On Tue, Nov 26, 2024 at 10:16:18PM -0800, Christoph Hellwig wrote:
>> Did you trace where the bio_wouldblock_error is coming from?  Probably
>> a failing request allocation?  Can we call the guts of blk_zone_plug_bio
>> after allocating the request to avoid this?
> 
> The easier option might be to simply to "unprepare" the bio
> (i.e. undo the append op rewrite and sector adjustment), decrement
> wp_offset and retun.  Given that no one else could issue I/O
> while we were trying to allocate the bio this should work just fine.

Yet another possibility is to move the code that updates
zwplug->wp_offset from blk_zone_plug_bio() into 
blk_zone_write_plug_init_request(). With this change the 
zwplug->wp_offset update won't have to be undone in any case since it
happens after the all code in blk_mq_submit_bio() that can potentially
fail.

Thanks,

Bart.
