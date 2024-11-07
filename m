Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292BB21620A
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001495; cv=none; b=DORMAvdIUK8+E7hbc1G5suhLrE+STIX47bs3x52C0NHVb10ItKyI0DmBzBGnDXwsHgt/D2QXwdMOm4ogyeUhP1KMDHk8shp+B8oTW9P37k1L6PD5UwUdEQjQ6anA4QzFzAngzt6KunZY//l92zGXcjDIQxKCG8wZedSMap0tigY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001495; c=relaxed/simple;
	bh=lExmPJLTzM72K9IPc0ryAt9HDNze223GukOeTfvtu70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nbe/l7S+IyHUdWLuwLBHdArFnd2/hfJyXow2w/9JgPU0duDcdYYwf5veaoTB6IhP4PxxZbOM0JbF/mQSLan2eg6dLddaTkiZiZwuH4NHhMXY9Fhtf+q+JcjspHoekF2vb3OqP42/2UjM7g+C9nQxfTM9Amzp8SI9Wf15DyKg/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=DQmi1pD1; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="DQmi1pD1"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XkqG71SYCzlgTWK;
	Thu,  7 Nov 2024 17:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1731001484; x=1733593485; bh=ov8Q2qcnM49FM1WPh2CIoc4h
	4QOxMbH5PytE77kvb64=; b=DQmi1pD1ol9oMX+txHNKw5o0vzvqbbS6ix+yOafy
	0/kitu4F3UoRF4mJCuiA1tKVHySQhIqLAZXky/J1jCreIcNN2Ro6lOPSoay7vRJ1
	nUqEyCOlmmEBVu8z4tJDtJ6Y0YGapc1UZ3g+6i7U4TRansUJsJ920z7j+nI/LMLB
	QsgkdB5N1M3uviKtF9hIwB3x0cnN+5rkwZZfEU6HIyMw+J2nBmA6wUsaSrR45m+9
	yYywpjDcVfAA0dHGtI2093eKTRYKY7KMzInbyY1Myg4gjk+jnLIRoCsoI9+nDQxD
	gm5vWUs4Rcce1GMuWeFJLBpZ+yQZ4kUYLOO64112eVT0PQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5g6b7YpWAJa6; Thu,  7 Nov 2024 17:44:44 +0000 (UTC)
Received: from [IPV6:2a00:79e1:2e00:1401:1bb1:75b9:b21c:8470] (unknown [104.135.220.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XkqG34s9vzlgTsK;
	Thu,  7 Nov 2024 17:44:43 +0000 (UTC)
Message-ID: <4d1036a0-efef-45f9-ad4d-f644467a88d5@acm.org>
Date: Thu, 7 Nov 2024 09:44:42 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: get wp_offset by bdev_offset_from_zone_start
To: LongPing Wei <weilongping@oppo.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, dlemoal@kernel.org
References: <20241107020439.1644577-1-weilongping@oppo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241107020439.1644577-1-weilongping@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 6:04 PM, LongPing Wei wrote:
> Call bdev_offset_from_zone_start() instead of open-coding it.
> 
> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")

This is not a bug fix so the "Fixes:" tag probably should be left out.
Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

