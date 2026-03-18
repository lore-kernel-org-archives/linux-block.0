Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D7373C03
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773868440; cv=none; b=Acq1UgMD7DoOIJ4PwcJbgbX0vgC/55cSsSeV8pf58elmJIxkfUJ6ySEnNzJCqi2ZuCw5GSPR+Cjr9N2SUGUfFZUSwVA91eZQ0PEnpRIKHr+cSkxAQb4T65WzfxgmL43Ly1fUfgs4RVmbk84QPO3Y7rXEXHTxkeC+vLuGU++kBdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773868440; c=relaxed/simple;
	bh=s2NRFJyBQz5oiptd7hu2gPq3H2m/wAy1m114TV5rCh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=th9UkY3kvfFzS0gZ9i9XHJchSTsxiaBgsG2A+Y7kVAur9dRmzyoNczzH3RQyBt+MeWHf+IvttEC5TQiZh6/e3IkwCepJkhAYehFVlqNi/MkLz09RIB4V8FTGa+k6YtTv5f/xs8eOae4IbB8DdrNyqB7RrvfoKwwMeInbtCP4CYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=wyNFBTPm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="wyNFBTPm"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-482f454be5bso13620725e9.0
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1773868436; x=1774473236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2kU43AlMQDJ+y4iCNAzBB3zEZFAq2dkQy3AbLDN39A=;
        b=wyNFBTPmN3ZkKk2+gIkRTOxtdDqvQFhcTm436M891jABmrJunV9tITfBJ/SgrhcrPB
         /ux70Xg1uKxZuoc+HXlai26r6HnxH1GnkX5QPPCU5JFiCaWbJhZHF31sQkIPtLeFtqX7
         RtVLerLONG4TR95eAvRG6zng8IdKfRQRgpNaDI7pGA5nr3+JOtFGlbcXjcyem9puo2ji
         asE6xd3MhXpsni8xEeee6akhwoJGTBSaIHhWkKnDLKkOYIF2LsxRsZ7wsjVp2LWOKSEt
         uFOZTbRxWDQizrQ5jFDhVYmNk1+RsWBtGVJ9uRvf/yxk9nzrf9u4B/pIFXotzfi4KUz3
         Osbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773868436; x=1774473236;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2kU43AlMQDJ+y4iCNAzBB3zEZFAq2dkQy3AbLDN39A=;
        b=EUC3/nZJfV8NcsFtu7e3G2ZsjvBwN52nZfy2aeIO+/qkLpDUVhCrx4gDRM/FvIxczS
         awBHPxnglBljLU2QlgCXV22V7NaDP8QLINGTxo39Ald6FM+QoLTlgwHBC7G3AIf/nlBi
         XmEAtFuGH8p9YmlmgiOp4319w2R021StEM1/ew3VUPHdpEW6Xb6y23xMeNQSeYXw9alK
         2cd2Dy7i6JpYzi0MlUSVPMWXGgs1+o0Epnv48WUJPK43scsrIhJveNuW91VMVnYmph8v
         fUgs+evbs7Uas1yUgLJJN/nukIpvPHkEpk8EBnGswZmbSos26A7sn7E/xr+r35MHPGKx
         iuyw==
X-Forwarded-Encrypted: i=1; AJvYcCXfv9WDB0/aGgqhUKwN3zI+WMezbyZ8qHWuavlEV24I36f4CKEHO48bk0GfLPpZoSQ2Ox6A3onlJE1j6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsuS4hXAbNckb4lpa7alR05KiodUAlZuU96VKzkrGqzf4ANsOV
	jm9uTYuDvEhEt00rMFGk4r0B/gUtEloOs2uINxxCjqUWVbFFtZfzm7L0az5gBXQILkU=
X-Gm-Gg: ATEYQzy2uy93SSssWXI4+wS83zZwq18I+BjB8gnERuG2Ve8jLGOJiE2SqSsz+76P34x
	cEUcKWWgDY8u1qmwK+zg3qS15WyEJOEtddpU/ucGBPnOr+VA82e9SE/YNJNCL2JBcT+1Hy1Trgg
	64rZ9yd1oMviPQQvBajNHUsaCH1piDfgU9wd+64jUcx+mUTOr/nhfwM3jUa3fLAGf3R8MJpwhE8
	3YCp+fRIdvgx+58W6bV/9BIQv/fFg3s+/XVKc8wXIpEwvySWJ6sL7Td6kzRfCvMsLaqcnwjGRM6
	1qEHGtdrZB/M+zqc0hg65bq3GzLV3fjFOy7Gd69bRwoUUw2AW6xAdCyoyLMD/VvkxeCZTUOK+94
	4SBX1g3yNF8FMe2Lqac5u0lCzGOubteVYvdZbR9hr09H64NuRzpPjGsDBYQuEDRoiEaZGY+b2td
	IPCW/xzTjYDzlYGwsT9bu9k7g2BgaZjaJ+6GVOPYceCXUkMl2ipgyqtdglb6lDeIrBIFN+Azhhi
	uVidN+U9JDf6p8=
X-Received: by 2002:a05:600c:c493:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-486f8b32877mr19492525e9.8.1773868436229;
        Wed, 18 Mar 2026 14:13:56 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4bc0187sm30798895e9.29.2026.03.18.14.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 14:13:54 -0700 (PDT)
Message-ID: <f67a657b-bec5-404f-9435-a69f11b7e396@linbit.com>
Date: Wed, 18 Mar 2026 22:13:52 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drbd: Fix typos: "receive_peer_dagatg" ->
 "receive_peer_dagtag"
To: Jens Axboe <axboe@kernel.dk>, Colin Ian King <colin.i.king@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com,
 linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316202549.33978-1-colin.i.king@gmail.com>
 <ea558bc4-3efe-4eca-9da6-56f4a5302056@kernel.dk>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <ea558bc4-3efe-4eca-9da6-56f4a5302056@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Am 18.03.26 um 20:05 schrieb Jens Axboe:
> On 3/16/26 2:25 PM, Colin Ian King wrote:
>> There are a couple of typos in drbd_info and drbd_err messages.
>> Fix them.
> 
> Doesn't apply against for-next?
> 

This is against the drbd-next tree, which is included in linux-next
since a few days.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Next/Trees#n267

I realize this is a bit awkward, since there is no way to really know
which patches target linux-next and which block/for-next.
Is there any specific way we could handle this to make it easier for you?

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

