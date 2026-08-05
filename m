Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CC13E8C65
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965145; cv=none; b=oy2lsxMACEHoiaQ56LKnWeeJgBJedXbYlZFOCsJsJkwS4s9bQ3XO8ibIeciSGVDPmWPmFADMdaiKQdJ/00G1QVRi+Mr1hWOwPuHIFrAgz30V97rtdJYthlmqzylq8W9H270agNNY8r0Nb0P2fYnMQl6sCrcNAhTFqbfPZof1Q5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965145; c=relaxed/simple;
	bh=48aaTZxR3SmvFDd3bU3MH/C18wa2y/iPmzo7dyLEYvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jele2+Rf70gMtcTu4LN0kdnw2vy4KneJAANcrPvRh7enw1uXgq/MRdloxOvJJYjgMKMn83tesqd0wXaiZADyxEvaZEl/xwjrbJLfwH9BqwJDhKU/gsKAB4UsZc/9hZUx1Ho/2O3v9TlyQ20N2p7AwqQO7HdW7EPyv9O15V7QNtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=fMkBh+QL; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="fMkBh+QL"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hFk3L2sSLzlfvpy;
	Wed,  5 Aug 2026 21:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1785965132; x=1788557133; bh=48aaTZxR3SmvFDd3bU3MH/C1
	8wa2y/iPmzo7dyLEYvY=; b=fMkBh+QLXmPLDXgZwoOWzyeKuLz8nO/A86JgLxtE
	GsNB5n8/5pyhIr2+OmIeR9YSmM4ySi/ykeMYqNg/amW2IPeLPTZUXFPXSdX4lLCJ
	SkWGqSninHnomOszkNcL4hTMHARy8j9qdI2VPKM9OJCM1vJ6MaZZssbBN1DdsGIa
	3ZT5bYY3t/+KpnZLWuvqb2ok1I2FXkxhxHnHfUatL3C63EW5VQheuHsnVlGkvbk7
	g2gQdJD/U4hJVc8XwjEv/mAvdVf1BhLSXmQubv+9xgcCpFKA2Wy+E8vmgbWUTQqb
	z52lth9eX5so+dCeSXYDA8mlt+rV3Smhg8qfeXidjm+i8Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uVF-ESLPZf1F; Wed,  5 Aug 2026 21:25:32 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hFk3H0DhNzlfvpN;
	Wed,  5 Aug 2026 21:25:30 +0000 (UTC)
Message-ID: <c3ede15a-6089-4f00-84ff-278c30d37f46@acm.org>
Date: Wed, 5 Aug 2026 14:25:29 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] block: introduce disk_for_all_zone_wplugs()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20260805022719.735323-1-dlemoal@kernel.org>
 <20260805022719.735323-7-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260805022719.735323-7-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/26 7:27 PM, Damien Le Moal wrote:
> Introduce the helper function disk_for_all_zone_wplugs() to allow
> executing an actor function on all hashed zone write plugs. This helper
> is used to simplify the implementation of blk_zone_reset_all_bio_endio()
> and queue_zone_wplugs_show().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
