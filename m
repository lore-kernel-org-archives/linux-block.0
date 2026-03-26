Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626737756C
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540535; cv=none; b=sEDQLo1tKaKY9WCIvQN4koZpQSA1RR9iMMbroYvzb566D0619Mm1Uwl6i6IA78A/0I26QGrlW+i0saw3rmk3sieGvf08kKVLQgIfDRYpv2XN+xozinmfWhHICvsc6mOPOG0AjTJ8BvJBLIjk+zMxwRe0C1j1TElbzMqnVcyIcJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540535; c=relaxed/simple;
	bh=dvPvQxvCCNQSdxFSojp/M9yMNRIhswf1LGnuBRvaBPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yv1WxptpbxPT2obeWUbLiGDUsRyBp84nsoo7/9+nmS1OX9sJDOyrF/0PN58CSAYtzTmG/m8Dp2emOQ6nAMlxOFM+Y8XQu0ooezHaH70pm+s3XmefXrIbTP6DJgc1x6n/2vCdEwspL4RhwAeXk3eD3s10KZ414JIq/bMfDiin9pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZI3PPcC7; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZI3PPcC7"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fhSzV2JM3z1XM0nj;
	Thu, 26 Mar 2026 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1774540530; x=1777132531; bh=cqJQIDf+7taeCrGqwF5aAu9S
	0VTbgkH8QyoGYY+8Mw4=; b=ZI3PPcC7RYflScQbXeV2xBrPaZYBBWIkVfu4Ncc7
	+kofyUNs0X/VHsAUaOJO5O2FuNoX8ZeYD/bxOhCW39JBPqrQeuOa765AB2Wsokgy
	vaqxMsG+VYUBF68TpDbwH1RpBXuVVR6rejteUvvcmtiotSdHLxeK5ypIAiL0iMSM
	xftTRrzn7/7pXvQTj8lTRiX2hu5vJ7qgRG8TffeW04kYmr+bGSJHKQ25vPUPe8Ni
	2zB2Ypiw0f7+1HMsrJBdMv5EtoXJXJISdWtT/NXgLIexlS+zQIyQskhUzMVOpzLO
	06uVI+rGB7i3Brdkm/HN+cLAQbNwPWAstHsIM2/ovvd85w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id J1ZnKZis30ha; Thu, 26 Mar 2026 15:55:30 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fhSzM5q0Pz1XM5kt;
	Thu, 26 Mar 2026 15:55:27 +0000 (UTC)
Message-ID: <16074463-9242-4c62-877c-54b0939ab892@acm.org>
Date: Thu, 26 Mar 2026 08:55:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/26] block: Annotate the block device functions
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Marco Elver <elver@google.com>
References: <20260325214518.2854494-1-bvanassche@acm.org>
 <20260325214518.2854494-3-bvanassche@acm.org> <20260326062507.GC24071@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260326062507.GC24071@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/26 11:25 PM, Christoph Hellwig wrote:
> On Wed, Mar 25, 2026 at 02:44:43PM -0700, Bart Van Assche wrote:
>>   	mutex_lock(&bdev->bd_holder_lock);
>> -	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
>> +	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead) {
>>   		bdev->bd_holder_ops->mark_dead(bdev, surprise);
>> -	else {
>> +		/* bdev->bd_holder_ops->mark_dead() released bd_holder_lock */
>> +		__release(&bdev->bd_holder_lock);
> 
> This sounds like ->mark_dead also needs matching annotations.  Or
> can we have a way to annotate the expexcted lock context changes on
> indirect function calls, as that would be very useful in general.

(+Marco)

Agreed that this would be useful.

Marco, is my understanding correct that Clang does not yet support
adding lock context annotations to function pointers and hence that
adding this support would require modifying the Clang compiler?

Thanks,

Bart.
