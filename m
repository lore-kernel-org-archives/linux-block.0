Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532961F61C;
	Thu,  4 Sep 2025 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966118; cv=none; b=Z5VhQxdVrmzmhMW469iNRZYPIMWOsdkxhXf5p2OwphcwuWzlEY5U8vb0cvNnhByhzIBijn2t3uApKELK6pAYQ2X+AwPg3RCzAx0FKyHS/CCO9QhjPLKvKgU8Yo55p7lBSyRCX4AyyLet0yQUCujuZZ/uWP8r20pjaXuktZQxpyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966118; c=relaxed/simple;
	bh=PmZFJJavb6Kwq93U9mkw4U/klXTp2W/31GQQ7sn+wws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqA5REeek1VsjYlckGsB0IMYdf4mFB1CTYktL5erDW2DZ3XmmtnmWobhn29hbyc8Z2VbdwcPKOPJzr4W3pYQ/bpEwAb2FyedgPqf7JPTtiPIfSoxlyHSBaZlMIK7fdX0tP57fFCKvPtS21v0D8LCbEjm9gipjUy1JlGXGjg2kds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=au07x3TM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="au07x3TM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4F1C4CEF0;
	Thu,  4 Sep 2025 06:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756966117;
	bh=PmZFJJavb6Kwq93U9mkw4U/klXTp2W/31GQQ7sn+wws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=au07x3TMJQ7ulcaCzRTpdroHWQ4RICbPmium6XlYuUvNyvw2iXHLsiAZofIlD0YOg
	 fB1opSBxi6GuGE2pTVGN5rjNlmRTYK6bpYfNb3P1Fks1umaehTcGtS6keATZipjVnT
	 iNC9jd1MEhhtTC8/Pp/o/Y76fKkLfaXH3G5f0GE1dGelR0wZfPCb80Zj1WycP9kRq9
	 Ks9mTO+RnvQQE0FTwHf2tF6e8H0/VqrPNxrXEpn3R2qLdxfJOWxgXaILANP3a9rHpd
	 bX93N++yM/BC5nn2m3up5wzRHw+m8ejy2SOtLRIIXorxR2oVNDp+M5YHKp6WAa3azs
	 mVS6bZaOcLItg==
Message-ID: <5561e689-03be-4cb2-9cd6-788accfd520a@kernel.org>
Date: Thu, 4 Sep 2025 15:05:37 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] elevator: avoid redundant conditions
To: Markus Elfring <Markus.Elfring@web.de>,
 Liao Yuanhong <liaoyuanhong@vivo.com>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250903121405.386483-1-liaoyuanhong@vivo.com>
 <a8d29094-2db3-495e-8a71-9d11992c4d9c@web.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <a8d29094-2db3-495e-8a71-9d11992c4d9c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/4/25 3:05 PM, Markus Elfring wrote:
> …
>> it avoids writing out a condition that is unnecessary. Let's drop such
> 
>                                                          Thus?
> 
> 
>> unnecessary conditions.
> 
>   an unnecessary condition?
> 
> 
> Would a summary phrase like “Avoid redundant condition in elv_rb_add()”
> be nicer?
> 
> 
> …
>> +++ b/block/elevator.c
>> @@ -240,7 +240,7 @@ void elv_rb_add(struct rb_root *root, struct request *rq)
>>  
>>  		if (blk_rq_pos(rq) < blk_rq_pos(__rq))
>>  			p = &(*p)->rb_left;
>> -		else if (blk_rq_pos(rq) >= blk_rq_pos(__rq))
>> +		else
>>  			p = &(*p)->rb_right;
> 
> 
> Would you dare to apply a conditional expression here?
> 
> 		p = (blk_rq_pos(rq) < blk_rq_pos(__rq)) ? &(*p)->rb_left : &(*p)->rb_right;

This is far less readable.

> 
> 
> Regards,
> Markus


-- 
Damien Le Moal
Western Digital Research
