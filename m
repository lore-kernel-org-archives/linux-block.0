Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9161635AC3C
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792726; cv=none; b=IylEB6NItMVT/QAOAYg46PXxbZ9iCbVWL9jOPQPjqG/RZQnO+RTP4+WBCJ7ACpqF4gK7Is33XI6SaL1plF32tJ02h+IpXrOYVGEQVsijSw7waGKu7rzuECEO8V8uMlO1vN0kUmDIIma1K3VLQRD/okmRSDKzUeujJDu9Bxm1roI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792726; c=relaxed/simple;
	bh=FK4nuECWzh/2cINKiJS9Y1w/QvpKWO46HahbEljsyGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeMhkjqx3BCxzDvBCTe7MQVwX1YnWIMv6XcvzJJ55u8wpa40Og7wg2t50WiqRmqCKMetEUXA6meJhG9WABFQoODdfZlfj96sK58b17uCmtaT9ZDcahDIneCp89Mo7zc6uTshJBajLO9ylUlzD5bKVrRPbkvurKdpiTyvImhbvxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=HQKJJhgX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="HQKJJhgX"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4720f3bf164so100439f8f.1
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1784792723; x=1785397523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FK4nuECWzh/2cINKiJS9Y1w/QvpKWO46HahbEljsyGI=;
        b=HQKJJhgX3Hpl3ppNoFquPeiqoZrhP3jSwCEo0h2hydimR0E8Ycvv/GYt2HTWVgnuhI
         sf2yD+GSsuPE2tXVZf78Fzt/nVZurHaEsrtj/jh8k9Zxvorz568sbFHG5XEVYEo/b0bf
         HzKZugvionrYMamph9fItcTvKwKVcGFZRkfdetnxs761tyj4Um8u6zoOsHbPWld8f5GY
         9ScNDn4UAlBcXVdTlwo4LUzSZnGk82OAEGRMy2Oh/cXizEGRtTyUfQGwqo+x82ZQVNhz
         pZQbZr8ECNlJPPdP0CDJzg2bI0J7P3v6sb2vYUFJ9WUXBXNwr9hzOxWJXQkRQ79O6ruC
         50pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784792723; x=1785397523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FK4nuECWzh/2cINKiJS9Y1w/QvpKWO46HahbEljsyGI=;
        b=f0hmqe+Gg9G+M+vM39/H2SYtW13uGFe48tH/YjrzaXERfr0K8aKv1zkBI45mcXCn6x
         6Jp8PeLiHGCce9+kFeuuzl6fCeIyMObJjz8bqjqHNblBcGqP2NCwpmBF4gaihvaorN9d
         9Laq2Kk2+GGrlEAHJGlNsBJ3Lf/hGMiJuaMOHoSuOCHzuwmr2tXGSno0S2v2ftMSWcUP
         VMMD5V0GEcUVtIot8xtNXKi3q4boY6u9jBRhqX1CbnV9m83sRiEI8Xou4KrA3dXO0nsf
         B/Cd+3FraR+hNWkKkGGz9EOV2Rp5lLCUHgP3BUjbX7ZOlevArYFtq/nljCfHql0DpHbC
         SZ+A==
X-Forwarded-Encrypted: i=1; AHgh+RrlfJHYiAPVsMbtWmVIDuhlbTASVwZO12LvLvvR0lDIFLJZuaZwIb22A6u6aPGiVxz0uc7m+yAO12ogsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7Pd+YNG+86hcC4BRYhMWThua5gT/jDL6gSWAhaztCf+0j3t6
	9cGaL0Ii3OOcbwAZ7eqibDOEceErIivKJjUVk/PT+f26/HWJ4Nupct6ME3LxPo525Zo=
X-Gm-Gg: AR+sD10PundMeRXaFDcQLvnFrF75W3pFwewyFaj3jf8L0XnuFOHkUmSg78Vq8iOBWCT
	vfxyWAIlPlrtWPCAnT0EvMhw22xmkky622FJyMg0OPvV5cXHXfXfK67CF7JjgUizqIEKICxofYt
	s07pYstG3YQJKI3+Ty0zPV7VP0p+tHWhjdAeEyYQLJJg8FJAmoVLwVt+BvbljrQ/3hXBU8/zwDd
	4KM2gvgDjKBzV7iJIBl7ervcyUvkyaZMNfEBGl/M+hhGdEFlE0kjZrKt9d6S6q6v5ecx9QnaAbK
	PfwbtJ6OoTPuzIZELycTHcDp3BUMpBZO8NlSdJ4hEokLO7DkKDpXw2iShDY4a216oBoMz5qGZzB
	l1/JtPgrqnoqlq6cyAtpxQntvJNUz00Fnp0Q9awGaIRA+r7roGlLOvsxdRxY0FPNvhfgshb1LYF
	ec0L6ercak3K3jujldyTocN3w7k9JMzoH0bZloqbl/fsf37g==
X-Received: by 2002:a05:6000:1acd:b0:47f:70f2:ccf6 with SMTP id ffacd0b85a97d-47f90215a85mr1739490f8f.6.1784792722721;
        Thu, 23 Jul 2026 00:45:22 -0700 (PDT)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6dc25sm13663180f8f.33.2026.07.23.00.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 00:45:22 -0700 (PDT)
Date: Thu, 23 Jul 2026 09:45:21 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drbd: reject out-of-range sizes when draining data
Message-ID: <amHEWfR808gFEanV@linbit.com>
Mail-Followup-To: Linmao Li <lilinmao@kylinos.cn>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260713023434.288279-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713023434.288279-1-lilinmao@kylinos.cn>

On Mon, Jul 13, 2026 at 10:34:34AM +0800, Linmao Li wrote:
>drbd_drain_block() receives the peer-provided payload size through a
>signed int argument. A wire length above INT_MAX therefore becomes
>negative. The receive loop still runs, converts the negative result of
>min_t() to an unsigned length, and may receive more than the single
>allocated page can hold.
>
>Commit bd910a7660d2 ("drbd: reject data replies with an out-of-range
>payload size") addressed the same issue in recv_dless_read(), but the
>error paths which discard payload data still use drbd_drain_block().
>
>Reject negative sizes before allocating and mapping the temporary page.
>
>Fixes: b411b3637fa7 ("The DRBD driver")
>Cc: stable@vger.kernel.org
>Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
>---
> drivers/block/drbd/drbd_receiver.c | 5 +++++
> 1 file changed, 5 insertions(+)

Yep, same thing -- DRBD usually chooses to trust its peers, but the
consequences here are pretty bad and the fix is trivial, so let's do it.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

Thanks,
Christoph
