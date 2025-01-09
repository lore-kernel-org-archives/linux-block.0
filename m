Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C5D188722
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736443989; cv=none; b=vAKFExdNBPfxwY6evrGQj79Ru280ZGfJ2Xd+Zb9aWjv6yl2IySMbP2KhLRqsjQHI0hP5r/ae9aIBDGvz9BxuSd7s1LIRJjr0nJY32lSvIF7zI2LUjZSwCKSCI9o1/T5Ir3wxgwA3RWMigMFZGqYSIyjavJ/2OvRj2raekTjntz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736443989; c=relaxed/simple;
	bh=OHhcC4lliPVK6zB79f9P67pGXso0xTJy7L9BZCijFrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJEahEgEXVXTGUQvMK/B7lo5a97PtCijKEk0v36vIMYxqV9Qc0wN94fzjaiROf5vlDxb8GRx8jGTjB0hQ0sLbbZibvNRtvRL7XsLmX6gN2NeQwKTiuVU5YO00LdO7q60vX/9o6veYmYmdZ0UjLrHBzTo0IE5acqliBbOfFIKyIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=G64V+d3/; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="G64V+d3/"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YTX1T0y56z6Cnk9W;
	Thu,  9 Jan 2025 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1736443979; x=1739035980; bh=OHhcC4lliPVK6zB79f9P67pG
	Xso0xTJy7L9BZCijFrc=; b=G64V+d3/n5nyvj5HootJy/IaDGis7HrZ3rZstjYe
	aCGB5bicwQPpGqAoAuPZRscwgeH2a4m3LrXtE1ro7WrlH5rA2JKsduDNBBUw9Em6
	Ijst8O268HUYibCOMkfdRex7VBl2hPnMTZ/m9SiZl5O50aKkRlQ17evV5vcE9IZl
	NezASGJeE/mwRNMLcgNDTNPxh+3ztmUk0A5r5wgpMLUrK/y43pPonoWCCCuGqigA
	I9r0/IxRXduBifhtecd0FzJxQGt/0k19DTAcXlotd+2130D7KLn6rx0V8m55TwiN
	C/pYXYPs5gxLguF5udeNujZ2AuxKtH1YQc95zkknHoN6Ng==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eJMbs-Eo0yjl; Thu,  9 Jan 2025 17:32:59 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YTX1P62rKz6Cnk9M;
	Thu,  9 Jan 2025 17:32:56 +0000 (UTC)
Message-ID: <d2951075-e9e8-460c-9dbf-34bfeb942aa4@acm.org>
Date: Thu, 9 Jan 2025 09:32:54 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Semantics of racy O_DIRECT writes
To: Travis Downs <travis.downs@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Cc: linux-block@vger.kernel.org
References: <CAOBGo4xx+88nZM=nqqgQU5RRiHP1QOqU4i2dDwXt7rF6K0gaUQ@mail.gmail.com>
 <20250109045743.GE1323402@mit.edu>
 <CAOBGo4w88v0tqDiTwAPP6OQLXHGdjx1oFKaB0oRY45dmC-D1_Q@mail.gmail.com>
 <CAOBGo4zdDQ+mV_5X1Y0J2VpV8F63RsBs66Xq4CHPtpBu9MFebg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAOBGo4zdDQ+mV_5X1Y0J2VpV8F63RsBs66Xq4CHPtpBu9MFebg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/25 7:01 AM, Travis Downs wrote:
> Do we have a guarantee that the unmodified bytes will be successfully
> written?

That seems likely to me.

> Can this cause some corruption/inconsistency in the FS or block
> layer?

As Ted already mentioned, if there is any driver in the storage stack
that requires stable writes (e.g. a RAID 5 driver) or that assumes that
data in flight is not being modified (e.g. a RAID 1 driver), you will be
in trouble. Additionally, since typical storage controllers use DMA to
transfer data, and since DMA may happen out of order, another pattern
than AB00 or ABCD could end up on the storage device, e.g. AB0D.

Bart.

