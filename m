Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E7926AA98
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355084; cv=none; b=L+gSDi3s0GNzKJQcimEFVBBPfVK5lELxAoISZjBvR5P22+2z62on+0bCJff4kC5LXO4oBO67KpHaf9vysc+kpen5c0yGNbiIx8KOaOV45et3VXCB274tRTx7lwzFPombQpNZ3U4W4IxQQ0HE7XruEwIg4AfM9ein3pSH6L6Wdp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355084; c=relaxed/simple;
	bh=rR+Aw8ZkFyyUehrB7FqtP1ud0TJdDJoMWuLaY2fvv34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1SV+KRTw+N6jI3YO2hiR0x12DMVHcvtEXViGGBdHGJrZzjXVm0vwS5k4biyaxMnXMq1LhhDSDIo+mFk8efeIdJXRbZ0Vi0LJNRuiP4mq4QL04/tqkolcHwkWdZyLTwOKttrEltOvjRmhyMnSwyEVnITkCmgYZ5yZ0uKdZmA/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Go59UsUx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Go59UsUx"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so9672905e9.1
        for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 04:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753355080; x=1753959880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xs+GM0sWLbiRwwRNL4JsmKo/LUSIYXZRK1+ghW1AF8g=;
        b=Go59UsUxrwYqkl43RIJbOlVq9fvag/mMOII9MVVS4T3vNCtFJq9PxA2CsRUShePzZL
         d+UlbFH34qtwz3RnlV4E3nah2KoxXWLT86whddxyFk1RZRweDjup5n8YE4gEcwqTSOV3
         CoCQ++lLy9kw4LPAPN2Mx/k6Sq+aF2ZdaSWiudE1guaFLzogPlZye6KxF9n0foL3Nfwa
         7BOcbS9JhnsRhwOGgM/uTSNSZKr/AXL9cx3wQfBf/c+wenTA1ZxcFk4F8sBaaLsl2NHX
         MhWoqiTGzHma++Gupyi30f5wxbC5um506UB+o/9A8M4TlyaGYJQTQFG41vXUno6DIDl7
         ao/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753355080; x=1753959880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xs+GM0sWLbiRwwRNL4JsmKo/LUSIYXZRK1+ghW1AF8g=;
        b=OZZKwqQeLg19mkJt8UEk8nNy0mT0S8Y7D8+eMUfaOzLlrki1ka4I7wKsb0cfs1PMQj
         A8JsFmYxzQDI2M2RiJE/3U3zMdQl5dvrDkQtVdlbEuloN1AO+abR6q6K2jTUQLOzHlWx
         CtB8z7Iwx4GyHvF7cKly1VZtGtGsPSdOi0Qq/ViTcmUaN60FcRyihvaOBN2Xn5xpEZ1A
         EaxmTJpizJKu67622+EBLwvAvVzkOd4LE/kCfjbgEwmLxwAn1NdeBvjxk8N6IAMvg0EE
         Beul/Ggj+HdEA/U7/ZgkpA8Oo6/xtBiqo6JT6U87o4R00e9Qrydgz5GmHqj+1WXLWEt7
         w++w==
X-Gm-Message-State: AOJu0YzCtEoKdt+lNWWee6ji6BdqrXHUGWgs79AegzTsFfhJkDKxb8pn
	qJ4e5hyjAY82aSAjhzgUX8Bk44CV0cNweBAMSwMlhXAQFzkbTPSAAKZZxt44qBZxups=
X-Gm-Gg: ASbGnctjScmzdMg63MQ3KrdvljEpUB2aK3sI+rwG8JTnApJo0CaVKhrvbYiCDvNTB9P
	/eQRnB0J+heInZVdfWWItXJ0QbaSDWQwframWtRaRjevAmOyqKkF72oWYqx+6PId8RUWw/SUFaA
	Ko9mCTuglofjBJdn88Mp78MA2o1b4zkvicJwA40rFPUKO6iE8D7kPhGY/DBcqjHJibTlIVonaQm
	U9F8rDGuLNPZdm4t97y4pqSv9bTOEJA4ppWI6X4YYZx61YoHpDJri3Dqhv1EGbHD4Sw7xX+5y1o
	w0uQWCZji+0hyv584fHJCCP5irouJzUXa6vDsLlZoxTZ/tPUez/kO3VHIDPAVpTNb1Bhtg4yeTH
	PijgoMILGAP0Y72WggVqOOrrQKT5yXdDQJjOtTSsoIM5Ic0w=
X-Google-Smtp-Source: AGHT+IFaNGoQrcJ1dkTybNQpuKegaJh336gmO6mPGzFqW5Mc5602FrRog/qzEy9pPnJUCsTf3x4y5w==
X-Received: by 2002:a05:600c:1d93:b0:456:2771:e654 with SMTP id 5b1f17b1804b1-45868d256dfmr48896675e9.24.1753355080239;
        Thu, 24 Jul 2025 04:04:40 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? (megane.afterburst.com. [2a01:4a0:11::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc60585sm1852355f8f.5.2025.07.24.04.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 04:04:39 -0700 (PDT)
Message-ID: <2969b760-2f7a-4cbb-895a-097dbd88974a@suse.com>
Date: Thu, 24 Jul 2025 13:04:39 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] block: Enforce power-of-2 physical block size
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de,
 dlemoal@kernel.org
References: <20250722102620.3208878-1-john.g.garry@oracle.com>
 <20250722102620.3208878-3-john.g.garry@oracle.com>
 <f0605f62-0562-420a-b121-67dc247638c9@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <f0605f62-0562-420a-b121-67dc247638c9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/24/25 12:06, John Garry wrote:
> On 22/07/2025 11:26, John Garry wrote:
>> The merging/splitting code and other queue limits checking depends on the
>> physical block size being a power-of-2, so enforce it.
> 
> JFYI, I have done an audit of all drivers setting physical_block_size 
> queue limit. I have doubts on a couple, but it seems that NVMe may be 
> the only driver which does not guarantee a power-of-2 physical block 
> size - maybe I even am wrong about that.
> 
While there are no real checks on the physical blocksize (all what
matters to the block layer is the logical blocksize) I can't really
see how a device can have a physical blocksize which is _not_ a
multiple of the logical blocksize.

Wouldn't that be a more meaningful check?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
