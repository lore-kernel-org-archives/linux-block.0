Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FCC40B0F2
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373565; cv=none; b=d+giJr1OPREjbgE6cujtrhGdgr4nSPL1TN0O3ugJkAbr2Fs+mWMZaQPHBquqHRlnd93EuFqeZBZKHPMMnyXc3apqXkeF7kekPpYqd4aS9IxAn1u33MBvQBK1b1ZgDFdQqFew448hByy1ZJS5uf7Uxx4pst6gKpaD0zVYNzwBwBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373565; c=relaxed/simple;
	bh=gGa2dfj7Ba8n3c6Tqhnr2+TZtTEUTmxzYQpruZO7h8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMb8/8lHvc5xGx+1qDZJdIcGle3G0SYcBVkCobmKdGxD+StZTjJf/cuP+v6HCEUtj4B2cWq5MrakiESwtXd9UgJRiMAVQtijnioOcAnD4FNn/qmWXKHScsxwLHc/2dkseUh+zYgSLm2B6ts9sAzQdgfAX6WhscpGh9eDAkiq6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=flzdk0sz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="flzdk0sz"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso1734376f8f.0
        for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1786373561; x=1786978361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xWT9igA0JIdyHy32MUg6eJ3ofaELJzxqELVmEcQys1k=;
        b=flzdk0szW8Mr/eS9OIIVQeRbGsgyvF26jb5l8VYNCT2F62k3uVi1Uvl/VlvxN1TUVb
         2y0tnUePto33UT5t+KegmK2buWp7w66yUGZ9s1y+nwAbuubeffcZbtGDBxkipYICPeaR
         3WORN7/BTlXJupLitiwS+f6FPmBszqeQjjTh0LKSL50wUMm3PTMk//lUywTTZFBo+Jc8
         K/WAhX5C5AEaiLOoGGaePvoiXxuwbZv01/6kRH9b/DqrCRD84ZZePcKDJE/2mtSkT2lF
         PKhPauk1ziOKXOSe48+65yYDzX5n+LeAHFm5ifqJqmMKKz+JXl4oFlLE+NPKKmBID4bq
         n/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786373561; x=1786978361;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xWT9igA0JIdyHy32MUg6eJ3ofaELJzxqELVmEcQys1k=;
        b=H6FntIA9hZ83LNhbbdJ4VRUkCqzbP2c8p1QjRKrRyeoDmQ+faHELkyTWL9z5nvvZTF
         +r98FxookOccCs9qY7+bD7XnJ1eBXzJHY2Bd3zN2lCiToKxI9Kt8JdfS7IyJ5jG83iJC
         WzRF31CxXgk31Hgt4wpWtJ0BJmwMPxiDaTIy9SxGvz21DZ13A4OKJEjkq6VyopEF5rtJ
         aK31q6GC15ZXuCQNI2M1jRQcGMZ8MKCWTPzZglIaCw6NsK+s8Gg+TrGacQXPdJJ41mHp
         dRVkg6WCpszYXRBPp+29Ioo5iZfHeL4dlz5HmF5Qw+WD8tlY0/tT7pI+fyFNkvH9m7YG
         igbg==
X-Forwarded-Encrypted: i=1; AHgh+RpLqhctjq3EgA6AXMnVu5kA+qOEWV1YPOEPCgNfrJtSvdAN7SMXfs475TKOoCLaTqQFGTdoZFtsCtcPWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhxG2APkgNzCBvgUxo/RdPMm8L03m2+2WCrm/H/4vm0n6j4Vcr
	MCi3Q6QFiVyKPrGiAqvltZnxWZ/9+k8pWhRmVI8kNeNwR10OFjkXvVTq1qh8F5jIEX0=
X-Gm-Gg: AR+sD10rOmPyKZFH0+u/MLTadzn4purwp0J1eR4GUXRRrwZRlw0lJ0jECzW+gZRbkZ/
	Bh1LR5a776rRw1G9RfZE4FAffl/Guhkbyam9Ko8QdOcUEn4kjWmFnNqyE7gcb59HFRi+3ysi38k
	IfXptWayMZWcO3xICt80eKPXTVSd0I7c+aGLkIFCeM4TbVe+8c8WYVq4k4xGesuf3TPh/P4DlNd
	JyKmmdMW7E/vpheKnJttD2g9cR0fxGqLaNmFGyLGrCjOSVkj3sSQvrrmly44U5XC+wcFrmPgwEn
	3sNL8jERXegzDydn6UNnF0uj9y+DaiZD3Syhezqqb/fmQ5+VO1v0H2VVOXLNukZwPDZQdQRK1Mx
	aoqjPp5+EOFxBWMoAHQyAlso5zaclbxT2PXW4LEPuRrnk7q68bYT4TVnMIUJXe87TfQZbE54r3E
	xRxuEoC0hjqtLrFPOydk8op4zzKRuXUX0TlpXZSGr9Ft4LOduQ9AGzWpXChRDVakhIM0e1XSHtt
	oKGQhvUKt47y1NYGIH9siaomEcgGgQtIVSrqFjxJw==
X-Received: by 2002:a05:6000:1446:b0:47f:e770:13e0 with SMTP id ffacd0b85a97d-48130e9bbf5mr25653333f8f.7.1786373561057;
        Mon, 10 Aug 2026 07:52:41 -0700 (PDT)
Received: from [192.168.178.55] (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f8b9bsm41742190f8f.25.2026.08.10.07.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 07:52:40 -0700 (PDT)
Message-ID: <bcca87bc-ec44-4d6b-bcbf-93343e582123@linbit.com>
Date: Mon, 10 Aug 2026 16:52:39 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drbd: increase maximum CPU mask size
To: Ionut Nechita <ionut.nechita@windriver.com>, Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Joel Colledge <joel.colledge@linbit.com>, drbd-dev@lists.linux.dev,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260802110552.50757-1-ionut.nechita@windriver.com>
 <20260802110552.50757-3-ionut.nechita@windriver.com>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20260802110552.50757-3-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Am 02.08.26 um 13:05 schrieb Ionut Nechita:
> The cpu-mask resource option is limited to DRBD_CPU_MASK_SIZE - 1, i.e.
> 31 characters. bitmap_parse() reads the string as comma separated chunks
> of up to eight hex digits, each describing 32 bits, so 31 characters
> describe at most 112 CPUs. A full mask cannot be expressed on anything
> larger, which by now includes most two-socket machines.
> 
> Sparse masks can still reach higher CPU numbers by padding with zero
> chunks - "8,0,0,0" selects CPU 99 - but that only helps when few bits
> are set.
> 
> Userspace has already moved on. drbd-utils carries its own copy of these
> headers, where DRBD_CPU_MASK_SIZE has been 256 since 2023 ("drbd:
> increase maximum CPU mask size" by Joel Colledge, in LINBIT's
> drbd-headers repository). A drbdsetup built against those headers is
> rejected with -ERANGE by validate_nla() as soon as the mask does not fit
> in the 31 characters this driver accepts.
> 
> Raise the limit to match userspace. 255 characters allow a full mask for
> 908 CPUs: a leading chunk of three hex digits followed by 28 chunks of
> eight.
> 
> The cpu_mask member of struct res_opts grows accordingly. Two instances
> live on the stack, in drbd_adm_resource_opts() and in
> drbd_adm_new_resource(), which is uncritical at this size.
> 
> This only relaxes an upper bound, so an old drbdsetup keeps working
> against a kernel with this change, and a new drbdsetup keeps working
> against a kernel without it as long as the mask string still fits in the
> old limit.
> 
> The new size will likely be too small again eventually. Describing the
> mask with bitmap_parselist() would avoid that, but the list and hex
> formats are ambiguous for the same input - "8" means CPU 3 in one and
> CPU 8 in the other - so it would have to be a separate attribute rather
> than a reinterpretation of this one.
> 
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
Thanks, this also looks correct.
Just one nit: in the commit message, you reference
drbd_adm_resource_opts and drbd_adm_new_resource; these have been
renamed to drbd_nl_resource_opts_doit and drbd_nl_new_resource_doit,
respectively, in the recent netlink refactoring commit.

But for the code itself:

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

