Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF63134AC
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339346; cv=none; b=WsOQPxDCZcDGlOIRJifSeSKoN7uPlJGYyTCYEbSZUAQ47RQ49G3zkFGYdB+GH9nj73a5JV6mtHWY3cPhkIcT4iC5NVL9dYjt3tV9jfTnL2dir1MRiuR1IVqHZAys0a6BGlzYY4pU7YAiysKLPRKqVgBN862dnQLy1hVC+9skkjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339346; c=relaxed/simple;
	bh=gVsmwc+BxZiIIkkT8x1MuxZIutn7FdbTuGxFv0xIzp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QGIIm1Cm4KTfq7zpB1zGzgsTMxFzMYqcFFr0zWeZF8D+xaYy2+6RR2ADBAr0lsxljGaKL1aYbabyZlQEatYUUmKPEfcvu36j9zoYXsLe/ToH4gkuwh//UzFh3cnwWR8jYUwhjDeV09tNGo5B49bWlqU0e17sB9OlF2/i6bM0U+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=CqdLnYeh; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="CqdLnYeh"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VB5Zf3N73zlgx6l;
	Fri,  5 Apr 2024 17:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712339337; x=1714931338; bh=gVsmwc+BxZiIIkkT8x1MuxZI
	utn7FdbTuGxFv0xIzp0=; b=CqdLnYehaKNQcMqJ3lcfSU68EyR3V2BobbpTd7UI
	GsBjf7TS9Ysn5CRd+AEWQk8WNI3xNe/EormUoSMGkQ9gZWMOJegrny0HhAX4D/sa
	0hpbX37mPK+LchxyGOFkd7+MktkCyhQjTOjd7E9UdtEkuM7gBAxaqulncEaftplo
	odD7tMl0XZfLSCxYIdKKVA76l1ZpWhpmw5aTpma1JUbIwz204bItV+ALDK6z1raD
	lI0wL8PPPm3zBPebggLbPAqeltYZsehG7OXfw2/nIo+xvJreDT2/UogvSIAn6OWI
	s6AgVNI+nf3MRPhMNPJLN7GF3pTgn8ap7BCbRR5sQUddsg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jN92Bl_qVwcE; Fri,  5 Apr 2024 17:48:57 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VB5Zc28zLzlgx6n;
	Fri,  5 Apr 2024 17:48:55 +0000 (UTC)
Message-ID: <5c4073f3-f787-40db-b438-95d4a14dbe70@acm.org>
Date: Fri, 5 Apr 2024 10:48:53 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] block/035: test return EIO from BLKRRPART
Content-Language: en-US
To: Saranya Muruganandam <saranyamohan@google.com>,
 Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20240405015657.751659-1-saranyamohan@google.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240405015657.751659-1-saranyamohan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 18:56, Saranya Muruganandam wrote:
> +# Copyright (C) 2024 Saranya Muruganandam
The above should be changed into "Copyright (C) 2024 Google LLC" or
"Copyright 2024 Google LLC" if these instructions are still valid:
https://g3doc.corp.google.com/company/teams/opensource/copyright.md

Thanks,

Bart.
