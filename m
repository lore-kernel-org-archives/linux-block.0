Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A7B33ADAF
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416863; cv=none; b=J3/Z/h+1urew+feqL1iktrqJntM1zjB8rBFgZy+n0k4fKSH4vDKd42xyYjiQIVWEpKy1/cirJe6ZJ4Eq7K5EZlq3SmgLpOJXoqcyl0UZCYz5VbOOkaMySDzIMRkFMC7F1hDEpSauT9M1Oh06fRQAg5Oyu1dLMzXywIN14kHcarg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416863; c=relaxed/simple;
	bh=ryYJrAaZmKglwpy0Cg/3Un0vgg1CRg6FOICmFqhI8pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YYqwUvO9TAl04UoUaKAoGC+foweaHT+H8r16vcuAr+h+R+2kb+zSZTbXPndy59hsIea5MiC24qhQ+zlK6sX82V0kUjuYn6PFVwEhThi6Zpq/X4p76ZTErp5FeTcjy1zUHvekB37LrNhEFVTFsLIPI6UX6PebbsAtUxqcnauEEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=QCH/et4p; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="QCH/et4p"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4drwJZ0CjBzljbX7;
	Wed, 14 Jan 2026 18:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1768416861; x=1771008862; bh=RZAunSX7EOYe8t7iR3OwV2J4
	ogHTyLrpaCnXWnb7Q6o=; b=QCH/et4pTmVC/MMlmGQwyLjvyqW1p2kIck6cYDAj
	v4rIuEKHLBx4ClORU8YGBotoUHY23DHdeyJbI0IskTLR2a8x7oPLA1iYIrpQ5Jqu
	oA//b1q6nxzV/z7MiNEX06NFqD2I6YZzGqW75+AfFSogylMVve+77CQoTN8WKjGD
	bUQTUY4nG2JNQffKFzPphuJOlKh97P2uhtrF8uFWp4wlf8WylJS+gxqs4W+ZnIoE
	YDjw8iqMpVREV7lbEdwPlJvv9zLmY8rP8+Y2qlUSXDQ8gRFn54pG7lQSoZU/bNN/
	cvJ+5OdpnlOJ6N6IvUUJuYLA1BLVvQTAxMZtgbKUnlMfiA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RcXDSqHDY4lE; Wed, 14 Jan 2026 18:54:21 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4drwJX4FX6zlh1Mn;
	Wed, 14 Jan 2026 18:54:20 +0000 (UTC)
Message-ID: <bbdb5f17-a016-4273-a299-066990fbea33@acm.org>
Date: Wed, 14 Jan 2026 10:54:19 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Improve some comments
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20260106070057.1364551-1-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260106070057.1364551-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/26 12:00 AM, Damien Le Moal wrote:
> Here are a couple of patches to improve helper function comments.
> No functional changes.
> 
> This also gets rid of the "XXX" strings in the comments, which makes
> temporary coding easier as XXX is often used to marke places that need
> some more attention when developing.

For the series:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
