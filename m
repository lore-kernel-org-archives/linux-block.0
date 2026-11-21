Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294799;
	b=EtrnXrC2V+QxJ6UB5ksqAFpd6I9IBAlJrvkoOG5bJKWhrj197F7c/Tx32DGH8A/8UzGT
	 gz6dMVE+9LeO2+WkORrAIFVmQWXSuGHxy9eGfb2Mtech1vtf1bcIdp8mxykoqMQa0/fh7
	 EA908xJ2rt7Wjxh/rcp8nkVwXWxfvBkKbxUxk2+Gvy12CYIo5DQIIMrLxtsdDLwGrFTSE
	 tnZ4zWwjmdaQtphB+/WXiiBgXhg89vt9tCghPGEZxwGSn2znDOrCZQytuDXVGCCdOMNMx
	 BuBh0M8Az83eOOsoZf4B3hpENGqJWeRgGG563dp3UJDFgBaxfgzNijUw45T3dXTI2rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=rNw2ecWt+pedjRV7G84Ccjw1Wl3MuYIFanxv93/iz/o=;
	b=2SWmP3VqMleik1J9K8MUQCyWhqPcn3A3FL3v+nKa2Zy4G+P5YOBK4EdybESJTIcUEf2I
	 qt1bN5yUKmPaVhuf4Xi+3oPNZxOHuoHnegLI3NA8Pz2HTKzJ755GvczUFvq7S0Ts3rEPD
	 bUVYhvA6KjI3IMdVSrszhXQ5xrO7YRSSJ8IaUyCim464HIJrj7wp7tFDx+8Fch8ANbPNw
	 j2BMhNfBLKeaa2HE3R214OLZ9ecEntNRUhA03FAGCbYyix0wbziPOso4tvxsXl9MhDSJi
	 //HmSBI4W9ZmqnD7GFa/pEzAEu5XllTRyxOYvFLK3IgXbkwZ5/tFDYXdpPXRPl8O1Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=lvjj7xOd;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D8606A32C
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 20:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F02D8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=lvjj7xOd
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a2af4c8d00so3737157c88.0
        for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 12:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795294797; x=1795899597; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rNw2ecWt+pedjRV7G84Ccjw1Wl3MuYIFanxv93/iz/o=;
        b=lvjj7xOdw3xTA4GkmGztyREs3+ozvUTHWhnvNJgZ+DxBrXYHSARYgIVqE0UJyKYRJq
         dm74/jbZ4y1n1sd270cLncz7f9DBhoAY/Mp9/Gn3QmQNW8Bais8ObIngA4JAHKprOgvQ
         Gwng0HJDwDlfNxVJ942VYOyzl9eRWgTBJDgWm3QahlFJh9C2oLG4U9PKC+V12BS6yRWv
         zCQQZu+JszG9I4DyzAXIxv+3suJ6jXc8mA4sQoy2yZv+oOJPYsld2bxYfmdxhTy1JylS
         vMTHUUXnUaDZVf6mJi8j8hEZp35f39V4wUcQ6K/fivTDUCBGDyBOPzrh0K/eipCO3ArQ
         WB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795294797; x=1795899597;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rNw2ecWt+pedjRV7G84Ccjw1Wl3MuYIFanxv93/iz/o=;
        b=V6Hq0xRYJc6UBZ5L6/ep0BlY+eh6PPxmkDe+zitQM3ChPY9d09wGlWb59cnWdrbrXW
         Okh/wlzcyxR9+5QffojwSdCNEQke0dHZ2ysuEP79tIF5xk3ZirfcJ1A4DCPdYr1HyCvn
         tJXGxRLXjCP3eI54Jj3HRw7xDzQPvrLUieCYOxvofXuk5wLT4Rca9rd6V2ztA9KxTO5K
         DUBBts7LqgLa9+fyL5z5N803MEyOKcqPbuofDi0Wc6oxvWvGQL+LM5fwCB3SzihDMcou
         bdGe1fdvRinv79WhmMKhL8aNnfH+7cAswgvjuM6M4SWu5oGXu2Grl4IYzZQu6QAxADRV
         7skA==
X-Forwarded-Encrypted: i=1; AL+hErFbc8SwGaz1ubNzpd6F5X6DnODAdsxAbLFQp9jc67k3V6ADUXf2uwnwX1QUevBq0QQh/KMUfrpwNFtQDA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/imlvyQCylzp/e9Fqx1r0BR06YSLMpBOq9njGNnVNGZOd+DTgW
	+wXr8qvGGNzo++E/q8ssTCkZA6n/Q8g+0axJOaxQIAmhREO2JXmMw0Ri9C5Jcl83ujo=
X-Gm-Gg: AZFdTZfYf21f1HZIf3Uuqy3RrlNUU5aAePyGJC+1XnHpqujlyP9p7JtnytmxmnMWp1d
	nECppflle3W5rvfcMby+jof+V5K2k5FKSOC8dp09Vc4MNg3hHB6U/T2Ry1IYw5Dn2XkMMXfPF97
	YRBC56LRU2g51KSLr/vzfYsUoHmCuxN518medVO3Pg/+11rF/hlr6QTTkUCK+yz1/g4hO3CegWz
	yhfXomdT7qh866Ic6p9eeKVOTy4AIWRLI/EX1G0zUeqXPJyOK43riXRc09Zyu2VHI4qi6y+WllK
	tHT7FCder5SxDDtKb3Yy+ULWJ+2CPvZivuUhIaRVb57sUzhegyVqvWm8cN4gJ9KHSkmW1O2mv2n
	YUBzNPTIqXqK8VKkIBdZGmMs6R/j0RwzNuIkuRvbYPr4ATbudToTL8r4Gq6xH9/KG7gGAiIHMOI
	pJ/MYEd3BgOTXvS3iD5IOKZFwfoXh01CzZRL/vIveCksNaoy4ORoKICp5SZmBz1b8KqEmY2EYBG
	3/HCqk1RjyQf35/ey0fcqkFM46pGwQngekgEjFOl/ddGXPfFIp/9G780iUc12txZeutZgRwNAZG
	wnTUEK8hcux87/PG3TH5L7sf5Jr7utaEWsuuTHyk2ziZ4/P8I3vkIvjq37wM4rXPc0zYpFrSRJE
	Fc4d42+e66dZlpLagwyr+i3MW7mzaFxGLmN6jpXR+MxfCvJPL
X-Received: by 2002:a05:7022:b051:20b0:1b4:e533:ff50 with SMTP id a92af1059eb24-1b556912ca9mr7773791c88.40.1795294797090;
        Sat, 21 Nov 2026 12:59:57 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c3052sm16445888c88.1.2026.11.21.12.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2026 12:59:56 -0800 (PST)
Message-ID: <c4da472a-1f3f-4676-95ac-89a4a3ce4a4a@kernel.dk>
Date: Sat, 21 Nov 2026 13:59:55 -0700
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
Subject: Re: [REGRESSION] ublk: dispatched IO intermittently never posts its
 fetch completion (v7.0)
To: Luciano Lo Giudice <lmlogiudice@gmail.com>,
 Ming Lei <tom.leiming@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, regressions@lists.linux.dev, stable@vger.kernel.org
References: <CAFS5DSFUi28HgX8t5bRRGVqPkOZ+VqrP+LtyMiwPQhyRpTxFTg@mail.gmail.com>
 <556c4720-0159-4874-8d5b-6379566f6d4a@bsbernd.com>
 <CAFS5DSEhgk8fJgAwEn+-U-7vnBchCrx6L1uReT3Upm+AA22=Wg@mail.gmail.com>
 <CAFS5DSEsdz8Eu1vmeCkE+6eeXgk+9yS6EwqyHSeD2jkq90DZaA@mail.gmail.com>
 <CACVXFVPEaJ6oPOaoZZo_XMpywHCzFWSYCrKG=srEDpCqPRp=Dw@mail.gmail.com>
 <CAFS5DSEp13YPLwRut2OiQfQqO70s6whbLWmEQ14mt8_JjBfBRw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAFS5DSEp13YPLwRut2OiQfQqO70s6whbLWmEQ14mt8_JjBfBRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/26 10:52 AM, Luciano Lo Giudice wrote:
> Hello Ming,
> 
> Thank you for confirming the apparent fix in 7.4 as well. Do I
> understand correctly that no fixes to address this problem will be
> backported to 7.0?

As Ming said, 7.0 is not a maintained stable release. That means
no further 7.0.x releases will be done, and nothing will change
that. Also means that if you're running 7.0.x you've been missing
out on a lot of fixes that have gone into all stable releases and
upstream kernels since then.

Just get on 7.3-stable.

-- 
Jens Axboe

