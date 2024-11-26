Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7EDDCD
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628651; cv=none; b=pv3eWjsSA5potpk3LcQ5exWEMNO09BVE8QvEIoCifn/ZUyUqN7I70ZofppgGes67FQCgAsuBRrnOZ36mvIMcH5RiyLWyd23JyEhYu2OAagICR8vhf6ihds0UyNBFA0YGwWdyRyv6o9mRS8O0MuJhGXFZFSBR5rTT6E9kxarFFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628651; c=relaxed/simple;
	bh=meVakIWln/BxkQaK/Xej30S4fH9WBmBvvHdc2z0S988=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaGlcmmjfnCurJH19Z4J0KhSm5pNOny3JZhgHoV4+YUfayi0y2TSRRRp5ritYvFft6Uj0vihgK5XdTSlCe3OibpY7yThtyWF3iH0FC4IxdTFNjF1AALXTWxYwir2/jAZWUq9Akbw83zUdC39aj3gC3zXy0QHNjLTQ/GPUvAkehY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=qpi49+5I; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="qpi49+5I"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XyP1j2rgszlgTWQ;
	Tue, 26 Nov 2024 13:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1732628646; x=1735220647; bh=D6LSBoKCHgGegZ2yVp3ajwUc
	tjVsM8ptAnffk0Oc4EM=; b=qpi49+5IugTqWdagcW6Zw3g1FN3Vi9u0akcmmTer
	9aeUA84BA+wnbHi15VdXm5OaPIaz5UMCPLIHDMlv69mSJF1iXbmyoUi/wZevEX/v
	mAN4NhxhycuPn8ZaU1JSXl47hcWph+Yq1V43Ef4ZKRQAAa/s5mHsQQyIdmNeSwu3
	tYJ1d8MD/r0k9PuXzIKiStlWzY20ZRuyANYmiB58Vou0lqdnLS7SMDGF0yel9yNU
	Zrhsb6UabH0fDt0RvXvg6OZz2+d9oxw/Ho/eae/bD+yxKeCgoP0PKIML2Tymhq4Q
	FCZRDcYV4z2NDXgiIhPZwMWeLmLr0pGZKc1Hh/3HdJfM+Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Mkw4i5fhuwwm; Tue, 26 Nov 2024 13:44:06 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XyP1c4YyRzlgTWP;
	Tue, 26 Nov 2024 13:44:03 +0000 (UTC)
Message-ID: <ef0b613a-d692-4b04-b106-0a244bf4bfc1@acm.org>
Date: Tue, 26 Nov 2024 05:44:01 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
To: Damien Le Moal <dlemoal@kernel.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org
References: <20241125211048.1694246-1-bvanassche@acm.org>
 <18022e10-6c05-4f7a-af8a-9a82fdb3bbc5@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <18022e10-6c05-4f7a-af8a-9a82fdb3bbc5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/24 12:34 AM, Damien Le Moal wrote:
> Of note, is that by simply creating the scsi_debug device in a vm manually, I
> get this lockdep splat:
> 
> [   51.934109] ======================================================
> [   51.935916] WARNING: possible circular locking dependency detected
> [   51.937561] 6.12.0+ #2107 Not tainted
> [   51.938648] ------------------------------------------------------
> [   51.940351] kworker/u16:4/157 is trying to acquire lock:
> [   51.941805] ffff9fff0aa0bea8 (&q->limits_lock){+.+.}-{4:4}, at:
> disk_update_zone_resources+0x86/0x170
> [   51.944314]
> [   51.944314] but task is already holding lock:
> [   51.945688] ffff9fff0aa0b890 (&q->q_usage_counter(queue)#3){++++}-{0:0}, at:
> blk_revalidate_disk_zones+0x15f/0x340
> [   51.948527]
> [   51.948527] which lock already depends on the new lock.
> [   51.948527]
> [   51.951296]
> [   51.951296] the existing dependency chain (in reverse order) is:
> [   51.953708]
> [   51.953708] -> #1 (&q->q_usage_counter(queue)#3){++++}-{0:0}:
> [   51.956131]        blk_queue_enter+0x1c9/0x1e0

I have disabled the blk_queue_enter() lockdep annotations locally
because these annotations cause too many false positive reports.

>> +DESCRIPTION="test requeuing of zoned writes and queue freezing"
> 
> There is no requeueing going on here so this description is inaccurate.

The combination of the scsi_debug options every_nth=$((2 * qd)) and 
opts=0x8000 should cause requeuing, isn't it?

>> +		--name=pipeline-zoned-writes
> 
> Nothing is pipelined here since this is a qd=1 run.

Agreed. I will change the fio job name.

Thanks,

Bart.

