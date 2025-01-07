Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8802C155300
	for <linux-block@vger.kernel.org>; Tue,  7 Jan 2025 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284106; cv=none; b=YW0v05Kw5gKKAlzDIFoz+EJw2/e9RbLeFD7qtVF0j6IvHNfXfZqjbxHzJ301sZoOQ6rb0KlxSAuNktqMY/gw7akRtPL9bbch7NNCWXnqePqihE/pY1j01r1jzvDj1Ne6QOPkmNULWONYCtI/TdC2h93+UGMVtYG1QnPrOPOc0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284106; c=relaxed/simple;
	bh=ajK78RXyq1O94Pl7HhaSLJC+8DH32J/R/vN4Y2P3VV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uggJJDXo1tFUX9VGHz6oC/O25WRbTCu/BO+ohwoezRzJnPSI9MvnJ7KgU0drCq4yqPEsSVS5qjnKBdGFtUB9vVxqxRaYRXOJpIN5ZjHszqQhqCQltSY9lTmQJ4crR4Jr0v0bY2DMGGG/4LDlj+5z+VCoIDzd9XwWO0yYXrKrIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qhOy6O3S; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qhOy6O3S"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a81324bbdcso124009565ab.1
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2025 13:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736284102; x=1736888902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1uKAunzPNSW7Biux9bsGQxRAKRn3CJRvoHvnghZtPTk=;
        b=qhOy6O3S+eB8dPaMfuLVgyXEyVMiOnYqmHzP00QGdYT3QtqZ/jYeqN2uG3WgDT2aIE
         w0JHcXvwJLWsPsWyAMXUYl5itoNV+ODdw/W8JVjZ0SqevylvzhT+kJF50hG0cEqKvC7v
         RZbUwSRzL6rsmjzvKpynS9sFKy1q7oxTuAjuwynInvaODAlIMJ/BY+PU6ucR/rN0/Kux
         +vBRgbf2Bh/ikkOOAQ/5xoaRW7KHaw1Ou15q3Mu4toE5/1kKYBp1twxBKrx5vS/huxqA
         OhlouaT/y7O7WJovtzbG5yjnsA+Laq05uGgZEHq+ESGqZ8E7lO4UpW3m2QY9dKLqDd+D
         FTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736284102; x=1736888902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1uKAunzPNSW7Biux9bsGQxRAKRn3CJRvoHvnghZtPTk=;
        b=VEu1doIFOueYh+pUuSGHqgqd4be408/nAnLCnsZpfYp+0KuXsgm3vyUcPTqi97Dt/J
         2i5yFtnGLACPdUDuaLrw19i4tQ+CQ2gag6pSoCpuQ01/XKxSqRBzbIy26SGk0/LqDO3p
         LERtjERgirIGS6BARkthBoyGIalC8SjiPfcpUnbSPIGiu/MjnmHKHVHJlQ3xOMNBWQQJ
         IbiaqOlwTLOKm+uauvs6rTxejYtb0RVKX9AqcQYOVSF6VSdhWN195ss45HnsoQyZ6rST
         E+p42l1g5BEMcs9bjickotyNowIbYm5oLQjKkcpplDYPt6lMreoN8LLJA5g3ZY4jLRdX
         AhLA==
X-Gm-Message-State: AOJu0Yx8c542NAcR1KNf34t4lfgnKgTgwZM0O7S6ETezZ7bKgVJEHIPE
	JG31m6CNgP8+y1bXy9r1N3Vv/LPv/um7A0e9Lsmibl9a5U/0dI+WEoRNGyg8+Qu5qAaVr0zMIpj
	f
X-Gm-Gg: ASbGncvjuH3gcbVQsZ3oNQQKkdn8JIzLE7463ISd+v5O8EQE5hdg7ejPiktCxfoPqce
	uu5sKvLVEOhJL1DyVJjk+ujiLtQ0AbyZgu0t8fTogHH7Tmm6C0Wd4qbubG0gxPdOM4/L4gcluSy
	0eMcohtgrvRp9uxGh+57b1dBeQiOryfGjc+vqfn2lz8PqLDqnpOtIa9BWaTaB66m52SfmREP3q9
	Pw0i6k/lmBhzbVx+uRk1gguPsZIO+gmYM0VzlYKIg5hCtxLfQqG
X-Google-Smtp-Source: AGHT+IG4HooKJfms91Zj4kscDkD42FmDoLBdlGdTJsBXIj3WiAYT3Rkur5LErVb097BEOXlqob9eoA==
X-Received: by 2002:a05:6e02:2607:b0:3ab:1b7a:5932 with SMTP id e9e14a558f8ab-3ce3aa72788mr6290785ab.18.1736284102312;
        Tue, 07 Jan 2025 13:08:22 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0de05327asm103411045ab.1.2025.01.07.13.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 13:08:21 -0800 (PST)
Message-ID: <3a1314db-ed44-4c22-8fc1-0cf672003026@kernel.dk>
Date: Tue, 7 Jan 2025 14:08:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] New zoned loop block device driver
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de>
 <98be988f-5f6a-489d-b0e1-2f783c5b8a32@kernel.dk>
 <20250106153252.GA27739@lst.de>
 <0f2eea00-e5e9-4cd1-8fe6-89ed0c2b262b@kernel.dk>
 <20250106154433.GA28074@lst.de>
 <5f57ff26-2c87-45fa-bb91-4f68492bac85@kernel.dk>
 <606367a7-9bb5-48e5-a7ef-466eefd833fb@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <606367a7-9bb5-48e5-a7ef-466eefd833fb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/25 6:08 PM, Damien Le Moal wrote:
> On 1/7/25 02:38, Jens Axboe wrote:
>>> I think this is a valid and reasonable discussion.  But maybe we're
>>> just not on the same page.  I don't know anything existing and usable,
>>> maybe I've just not found it?
>>
>> Not that I'm aware of, it was just a suggestion/thought that we could
>> utilize an existing driver for this, rather than have a separate one.
>> Yes the proposed one is pretty simple and not large, and maintaining it
>> isn't a big deal, but it's still a new driver and hence why I was asking
>> "why can't we just use ublk for this". That also keeps the code mostly
>> in userspace which is nice, rather than needing kernel changes for new
>> features, changes, etc.
> 
> I did consider ublk at some point but did not switch to it because a
> ublk backend driver to do the same as zloop in userspace would need a
> lot more code to be efficient. And even then, as Christoph already
> mentioned, we would still have performance suffer from the context
> switches. But that performance point was not the primary stopper

I don't buy this context switch argument at all. Why would it mean more
sleeping? There's absolutely zero reason why a ublk solution would be at
least as performant as the kernel one.

And why would it need "a lot more code to be efficient"?

> though as this driver is not intended for production use but rather to
> be the simplest possible setup that can be used in CI systems to test
> zoned file systems (among other zone related things).

Right, that too.

> A kernel-based implementation is simpler and the configuration
> interface literally needs only a single echo bash command to add or
> remove devices. This allows minimal VM configurations with no
> dependencies on user tools/libraries to run these zoned devices, which
> is what we wanted.
> 
> I completely agree about the user-space vs kernel tradeoff you
> mentioned. I did consider it but the code simplicity and ease of use
> in practice won for us and I chose to stick with the kernel driver
> approach.
> 
> Note that if you are OK with this, I need to send a V2 to correct the
> Kconfig description which currently shows an invalid configuration
> command example.

Sure, I'm not totally against it, even if I think the arguments are
very weak, and in some places also just wrong. It's not like it's a
huge driver.

-- 
Jens Axboe
