Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD431B9831
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734384140; cv=none; b=nDJ33CJY+07+divBMCOvVsgZdZn/9u8dnqBw9fPhkyTwSAeIccN8Ym+4dY0C6XZwEOXwfTmrrENlRCQL2xIdjG2uGWsVlgKmpynOHcCCEsfhW+KWos8rv5a5IUO0GYtqF8ViR8W96my8UFng7T++rLAuqyi9SdUNaWNjjnNpUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734384140; c=relaxed/simple;
	bh=DVEbIzzI9xHHAsGqcZ5nuaoD36bbwlo4zK9QY2emh00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUS3XBe8RtCE7H0ajaSOVwebsB2aq7TrwRxl94qfU+dEvz8/OkL9gjxBVjLxWYWH1Hfw0tYMCjFOVDmj2+nsDRIiaZFSeKkC+mxtw0OLk9grAmxAm1jrzNwQrV2pX3FDn+6tPmTKEZ1GQYymrkYsDPC7eNCGS6bfFXEGbe8gHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=IGfI69x1; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="IGfI69x1"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YBtF63sv5zlff0B;
	Mon, 16 Dec 2024 21:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734384137; x=1736976138; bh=91SXVQZ4saQnY/izo+9OjNsw
	OBVkyfZmjgoAzPHLw34=; b=IGfI69x1MKxY/gHtrcoSojkbpKVVHPLk06pIZ6Vq
	oBZfQLBvZlRw+pRcbWYsl2cVlIWR4897hm0gD2eswmo42s9DIouwHgB9v/VvPU3b
	cleAuoynB3w24fj3xz8Ss0xcisDiZxUCsjApegMS04IyE/O4pXn3RUAw8hGxeaac
	8iP6zc0TOpHB6BajDHG9HB+7FLi80ZZbFOxPKL99E7tnqNTb6JFJfhk6FqrzQeix
	YmPM3Y2zW0OPDGuvOhbbIfW3RibofkuOftZop1Dqz0rlCY+5xF2P/3nL/6zpj9EF
	xTFQ+6GoDuqVZ4y8cuPSFn+kPu7Wn+90BP+LbNlO7080pA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ubDcW0kNhhap; Mon, 16 Dec 2024 21:22:17 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YBtF44f2Kzlff09;
	Mon, 16 Dec 2024 21:22:16 +0000 (UTC)
Message-ID: <955aacae-7dde-41a2-8eb9-3bbeae8c3d18@acm.org>
Date: Mon, 16 Dec 2024 13:22:15 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <ed186d84-1652-4446-8da1-df2ed0d21566@kernel.org>
 <ba8caf98-8b09-4494-add8-31381b04cd33@acm.org>
 <3bc4b958-73ea-47d4-9b94-299db1f7ee3e@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <3bc4b958-73ea-47d4-9b94-299db1f7ee3e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 12:54 PM, Damien Le Moal wrote:
> Yes. But I am still confused. Where is the problem ?

Here: 
https://lore.kernel.org/linux-block/95ab028e-6cf7-474e-aa33-37ab3bccd078@kernel.org/. 
In that message another approach is
suggested than what I described in my previous message.

UFSHCI 3.0 controllers preserve the command order except if these are in
a power-saving mode called auto-hibernation (AH8). When leaving that
mode, commands are submitted in tag order (0..31). The approach
described above provides an elegant solution for the unaligned write
errors that can be caused by command reordering when leaving AH8 mode.
I'm not aware of any other elegant approach to deal with the reordering
that can be caused by leaving the UFSHCI AH8 mode.

Thanks,

Bart.
