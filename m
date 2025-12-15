Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com [209.85.167.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E543B8D56
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816427; cv=none; b=MfHV8FYVaXRT4+5TR3VoFU1VXtdxEVJWllPfT6V/I8kfF6dKcNWQQtNxmyd4bjkCE0BskMKAvIVSZ9DxjrylxlOwzHDR7ah0uKgFhDmWCD8TYbs9ub2C7mB4LVSEtgDORXNTxPrXEFkR0XBMwl14217ygBvRZFgT3lIkmNUoNPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816427; c=relaxed/simple;
	bh=qqh34P5uaN59huJB6RXJLp9fVZCpldrzPRcPHhCXrUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iydlJ1uDic2z5559P3q41fmCpG1UTBMC4F58h2Owvp7HqLeJbakvt/6G3XWcVQOCaIwpdJdrLH5PWZmVEdl5lugibobfQW7/PRztmc25CazKvxuMBzA/hzTJw9aWRIT4d2OHr9qLhc6RpkYe450rqbo4CeUBhI42uJhEwybcRb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mL+XG0IF; arc=none smtp.client-ip=209.85.167.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mL+XG0IF"
Received: by mail-oi1-f196.google.com with SMTP id 5614622812f47-450b2715b6cso2160238b6e.0
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 08:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765816425; x=1766421225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOeEbLkJ4NhNzPDHOpRcyVg6rwLKPErmDWJiIVC5mM4=;
        b=mL+XG0IFWVrbRZDftOqqjfMXtNSlO9f3apc0k7qpUoItN4t6xripKUjSzauDnIsqFb
         oOrcVsHuJ7JI2f7R+utR3qLGo7JcZG0zkdAHupjqoWSoW9ZE4cHLu2oyVDFiMTjTbsRF
         o1/eGrRwbs5UNYTkug7RXBtQbt48RdUfw1HWCkj9Ex99GgdCDU6l9ENuE4jtdY6mjmaF
         23+HDovK5J3bKKlMujl8cjSl1Br4Nnu7QNO4MQWibtqTaUPxAZztx2TcDBOYCxSkMIfo
         vKUTDiNR6a4LHiKE8wOvI8/7GDBKKJt8vXmR3kOzJBGhViTy6gGIEkEJ0NS5/fsfEOno
         q86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816425; x=1766421225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOeEbLkJ4NhNzPDHOpRcyVg6rwLKPErmDWJiIVC5mM4=;
        b=KYcOtfpk5ZPsK546zXAIuxGvgsH/5KvTMHGwdXNHXEHeiN9KaaCeQkXRLIhsk5RZAc
         yTGHNLwoNUBC8dy1QGQN6wNqNyweZcOFbgjNkKGGh0Em5sHVbIR/jEq/pMXlVun3ccd+
         tumPgKLOO6NVOO2WHEGBm1t0HgaPtEBcwUC88YZhZOBzAz6u+aCejbljxe4GchgNpFtL
         rmG7zCvqLu1K3XflidZmqyGrn+/uHHv9eMyNk+PYssoe914fi5FcvHYwBkryYmRGf6X0
         WokqVUa/h0U/NihAwANaqwLpAZIsnYM4e+d3nlYToFZfM84WLPWs0rtGFasHp7S92SQs
         EFsg==
X-Forwarded-Encrypted: i=1; AJvYcCXS2yOFWINwbkbXIfYjaVp9xRxspPTBnUJCY0Ag74MUUvLumkxRezaamBEgrGyFUmX4qwthBz7tzC9oIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvN74Q/0vBSmS0FHqCYkO8Aby7YXALdhT4qJtQmEPdmqFoOaaG
	NLc/XXY1l1o2XWZfow4iruf+IyvaU00r3V2C+fc+T/RUaiUzF9S9vlVmVFEzQmbQ19E=
X-Gm-Gg: AY/fxX6xqXgVjzaWZRQ1lqPuye5UW8nsP0jEctQ/5t8UW6fzZWlu7cZMnBUO0KrNSoH
	/RWv+GDYMCAHRp4cnMuqOdCAidv235KioGdOLkT6x5fHWKgRtkqHALcVyAhA9xS5T1FWJXwq+UI
	QuuNZYfy539o4nrdhFoeOYj2HR0ksLvdmbtjaWZ4PF9kQY9ac2EqKuRWQa9j+gbwGmmnuBIB26a
	ROhQSRU8FCOluWBr1M80IaiS/HhfZUfYefB6qwFs9UeDqiiO9Fwh5ZMAXXwpVO+kT59LUclmO5G
	fwZQfLuCzh7DpjSzm9qtbbFwwaYk6/oLhtGTyOgC8wnUFeYr/V81bhAj3uBOc3yWguPl6PR9JCC
	UhpTMpynBhHaT8TwopTB16gDaNPx2W4Hk8y981BsDDpV7EWWwQ8bA0zeOFW7ToFrTp4t3Inx/Qf
	NkdC9jS3w=
X-Google-Smtp-Source: AGHT+IGCrHrQigzG5irmY6fvZHnILsW9Av+YdHaRrG3TJtP7ymKohcpyueiYU6zKEA/9ee1hWHdqcA==
X-Received: by 2002:a05:6808:bc3:b0:450:730e:d109 with SMTP id 5614622812f47-455ac989e89mr4518931b6e.48.1765816425269;
        Mon, 15 Dec 2025 08:33:45 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45598cf4858sm6448712b6e.11.2025.12.15.08.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 08:33:44 -0800 (PST)
Message-ID: <2ed0737c-2b2c-4f99-858f-2a4bc4a477ae@kernel.dk>
Date: Mon, 15 Dec 2025 09:33:43 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: retiring laptop_mode? was Re: [PATCH] mm: vmscan: always allow
 writeback during memcg reclaim
To: Christoph Hellwig <hch@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20251213083639.364539-1-kartikey406@gmail.com>
 <20251215041200.GB905277@cmpxchg.org> <aT-xv1BNYabnZB_n@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aT-xv1BNYabnZB_n@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/14/25 11:59 PM, Christoph Hellwig wrote:
> On Sun, Dec 14, 2025 at 11:12:00PM -0500, Johannes Weiner wrote:
>> That reasoning doesn't make sense to me. Reclaim is always in response
>> to an allocation need. The laptop_mode idea applies to cgroup reclaim
>> as much as any other reclaim.
>>
>> Now obviously all of this is pretty dated. Reclaim doesn't do
>> filesystem writes anymore, and I'm not sure there are a whole lot of
>> laptops with rotational drives left, either. Also I doubt anybody is
>> still using zone_reclaim_mode (which is where the may_unmap is from).
> 
> Yeah.  I wonder if we should retire laptop_mode.  It was a cute hack
> back then, but it has it's ugly fingers in way to many places and
> should be mostly obsolete by how writeback works these days.

I'd be all for that.

-- 
Jens Axboe

