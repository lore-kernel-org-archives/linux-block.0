Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260405;
	b=G/ON6xUipMD3zbHMQDQWbDydRHvQUqxmqO4otTxhSI1KcTpwJBP00C+OQfeCQ34Q/UtD
	 XMcWbJrCuPbwcNSH8u3DSAV5ZNudR4y6haEoUlm3Re/Uwe7bng4UKnO/FrzfFOOKaD94e
	 feRfxzsQGq6nJV4tQ4TYuRrkTJ6cUe9+fykkl0HX3v0EyMIswOTR/epxqFoSwalROHwxz
	 J/Wnrag1Fidi83Eg+ZsuUEf2HA49DPSKvuzOErmC8/Bk88IjvHkF6a+cP0IMn2Mh0VmHm
	 PS7twUlpqQlWkzC/rsSroiG4D2rIC7386q0Of0AmeNSZK0QCdeqFeShq+YVTu1EQuAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ldQDnVJMuxwbdrhlNN/x1fw3wUEQ1dyieV6ECXYkvOY=;
	b=2uo5OssvIx+1DjofTNWaGydXgAI6EAENgrcFXxTv7+WBlCT8bMLElWtEGUWxE4FT5feA
	 83BRhSeKLZavykG6Tq4FHiyFESM4Xp/sEchmGPj4JL7LIAd5Kx74BwfYOFQJE2smsKF3S
	 8F4A7COyLXLQNW1CNZALtaawZP39/iOKHe6fimw4cTmu74fHUlBI76hREmmWdbg8HllGf
	 KaV6E9VdCp0ZerY4jJQbGRfyDrbep4bNVp0AKEI3sO2Kd77HBYhjUz/tiplxv3tYnkObZ
	 91XCi1uTa6Fopv/ZyaNswJDL+yWORuxGR35AaoBt9OFF9gjvIgWV0VLtUAGB/D7o44w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eQeualRB;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C20606A33A
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 21:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2C20606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eQeualRB
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-89d6bd67045so685934b3a.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 13:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794260404; x=1794865204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ldQDnVJMuxwbdrhlNN/x1fw3wUEQ1dyieV6ECXYkvOY=;
        b=eQeualRB6lOd0ySqBZ/b9AuiQ0mOZRqlwhA8tDZLGJazuDe99UtzYP1DGxLGDfdu/8
         5mGG2ci3cASAT3ZretGO566s+YnhaVSZBFSi2XhpHny3H0tpMvs81H1IVT8tgVM2bigE
         V8GxCH2fudYS0jVH+EdF+u4j3PzvLNBWPXJW0iYuVJNJfHOvjhDv41UW7vdVpp1JhAm6
         okI7Q21rNR82rVn6vB1e573BV2FhU6hUWgswB7TtGFCrKlRYv+eF7BDcmPFY+zDmsXLW
         HkbB74WpTueJK1AgGvsLO0dkrsgcYzNG4uoUPW5zrHN9Xd0OMLrKvofmxFHnNcyg6hiZ
         Ng4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260404; x=1794865204;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ldQDnVJMuxwbdrhlNN/x1fw3wUEQ1dyieV6ECXYkvOY=;
        b=aS+pkuVixFeDL7n5KnprJUe//p0PJolDPSsu8tP0TVW3+Z8JoeVd6YwFhrbpB6q8r6
         vul5i9fy3OOX4VuFfmrJ1V8ozpO9CuIZSCAo3hQx4kBIW3ZGyk1YjMqpyt0qdC9dKtHF
         ArtnYSytU1CeqLnhPy0n2Ho5UEz+JowE/y8Dzv1o+8c05G6KS8bpa+xISbgDofVZAeyV
         1jtfDekXgcMBypk/yT4S2E7llPuG3zfHtPXO8gf1xmanZd0Hn4Xcf3GC6zo/3EIpDKzT
         HhcvIVdDP43neLxYLOZFcZbwoF4vPP1KSFoZJVl6v0xNWY+76rzZew95jJ3Q24Cqn9QA
         U8Nw==
X-Forwarded-Encrypted: i=1; AL+hErEmUAVnwjmlM8ZcziOsalzVnB9sO0uAnM+rQ3YOM3s66MDBkwknk+z1on9sgFIz/QTEEZXPifauN0g2zQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8v9oGeEszNH14eu59zMcnJnUjk9l5Wu8jkbG4NiKv8iPu3K/zx
	A8x+0g5aC6p8EZjoiYxIdRT2BDeW64FRJHDIkt3/fZT2bR8eVwBYJ5i9MoeCVxCj8U8=
X-Gm-Gg: AYBFou2qaouUQESIqKAFtS6fx6VCRIkzElSbdFMvdmZH2S3b7QiuxsvlDmyrnc4+iSu
	/HslLBWN7/A6fVmGUT7lfVkM1WCKu9aeXBV/84dHYtot/EMOIzK5QhmSQm66cqtwmArwcHtn2k5
	ZlMe0KQpMo4PqJgXZ8ksSG4DiXQ6ojlKuJq6cAHM5KqaOcFlYuDLHsllJehPUVAiE3w8D44g6TM
	9hgwBJ5aE5hwYzEUTQGc/WF5Y7Vyi4vU4oXuoWciAqwB5tFlyXomVZ16Yz9YZExSHH+I6UY04lM
	UyWbp5EXCSQ9PsMu3tLTzyBsFIAUMQJLNyjncNouTN34PnDfJkBNTKKdDYmOnOHcgkN66UUSBTQ
	3pG5pbsSRCc+xBCJWs7ZXl0jUJIIMmN/XiDGKP6Ex6rb3tEE4iDkRkG2BxRTPJSXOI34oFG5LJt
	i77DUW80tkK+IOH3wUW2iyg/JljGmgduHlAj1YTlZIQd5cK0Tg6UeoaYxdwdBpd9gGdaeoXsRYb
	eYtnvcGTgbJXq/VRL24yW73Wrb4cqFhnsTN6fW5oBOBBkhuPi8DlpmN9b3f7gfMb8Nnl8SmVja1
	As9QGTbDKbu30PYpboN+ygjXsKDYjoGLeJGvyBVXMwd0lzcR4nkzD5Vc/1hG+MduHUGRG7KZy9I
	fInOiWD/aQF/jlkcBlhHuvFr/LCg0FdjR
X-Received: by 2002:aa7:84d4:0:b0:8b9:66d7:1015 with SMTP id d2e1a72fcca58-8ba97abf743mr333815b3a.12.1794260404201;
        Mon, 09 Nov 2026 13:40:04 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaae3e9dasm123752b3a.34.2026.11.09.13.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 13:40:03 -0800 (PST)
Message-ID: <e33d5a5b-0fd9-403a-8a3c-36370660c0bf@kernel.dk>
Date: Mon, 9 Nov 2026 14:40:02 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Keep RPM_ACTIVE in blk_pre_runtime_resume()
 when already active
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org
References: <20261104112744.1630864-1-stanleyjhu@google.com>
 <e8553327f2610f51d7800c1bbb1544201cead9fe05828d82975a7f4e9245d30e@mailrelay.wdc.com>
 <avBj_fY_cZazcdXU@shinmob>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <avBj_fY_cZazcdXU@shinmob>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/26 4:59 AM, Shin'ichiro Kawasaki wrote:
> Please ignore this report. It was sent unexpectedly by blktestes-ci
> misconfiguration. Sorry for the noise.

I would say this happens fairly regularly, but it's actually
more than that these days. Can we improve on this? It's a
lot of extra noise.

-- 
Jens Axboe

