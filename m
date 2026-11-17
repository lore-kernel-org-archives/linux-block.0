Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956994;
	b=qo1TYj+bb0xvCoAk4Et1HB9czdYgnOUu7KgLJxy/uA3EQcS+Yr/Erd87SObgAg5qfax4
	 7fbg3LqGv+nnI4lq21bSo+ft0PnErw/uXWxrr8sAQRZgfPFyymbI/Kx5PPgfb9ip0sj3v
	 F6g6hgRx+w9v3VGvk26IDehzMvoeBNyEnKfBzXv7r8CWIB9p7Wvy73YLDL4S8k2xEyiTl
	 gDL+KDNglzd9aCUhT+4+Edh2QakR9gjctjkQPkn8bj7vH2PIDhk4i583hcwsmY66BEOmv
	 GWAg2q53fFGr76XjX+dwBQjV9poNB4WTkh9ndhl9BQ54MMhLgxNMScVTjQvCKaYP/IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=SHpyW1CWFJLjKcm3NfOT8JRyLPTCBetkFVNqjx/iX8I=;
	b=arzZgdvtTugkvgMJksUzllZsQog/lBW7vTt5ktKhroFT/pEyOsngu375mnyPZbmnZcBP
	 ZetdPmWOAXgFY/8zGLG0Q2jYDsiN5GQi3BhZ9A/qo4nm8527eA/vl1I3dYJfQZjlcb15d
	 6OpaF5XfY+lQdC8q8P8GGHVaq/BazWInxOmvonCxYWO4/tuQxGt2FS2J9mzyOC+Jv8ncd
	 6f24wZTr4KgZ3Hm4IJq1bfN2xQuN39DKcEE79xlbcxAed27efdy43kwoxLhq/PLfTQW+O
	 OX9JPt/8seE+xdIn1PKm0ItNQGGLcLLG0A25Pyd2Ztic1ci8hnjs/3FxNXpw7XENlSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=f9GxYiX0;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B5D606A31C
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 23:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48B5D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=f9GxYiX0
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-85c1135c286so236605a34.1
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 15:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794956992; x=1795561792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SHpyW1CWFJLjKcm3NfOT8JRyLPTCBetkFVNqjx/iX8I=;
        b=f9GxYiX0qHdXaC+RBeP8es2bBWFHXyNL4kWyMfWWiKs4TQqXv/j1hF802m50uDTrlg
         kTbXcG8eSnD6+QKEPkKsrgg3psBRJvqnafndsm9AD56MTBapsVV44DmisCPCpiMlN1Qg
         Zk/lgkr8/dq4JvQb2B51l5WchDTbTdxYl8RTXezHpkIJFOrLtvKnJ6YrNlN1uqsKBO/R
         uH8MMPDu3KnT8Zi6MZbF5dQoqYe1Jimj11PWNynczntiqHuKBWC6l7pSd4cNNDADLzV0
         wbqcYjtO9/71DwUrSqB8sZZk2kw3KGRJxRAExdEJ7wnqLUqjhgpZM9DVkVLaf+DKk8lz
         jr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794956992; x=1795561792;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SHpyW1CWFJLjKcm3NfOT8JRyLPTCBetkFVNqjx/iX8I=;
        b=ruy5FSeuF8zIoCGtzNXGdtr7D2YRarihVQgUsSmZf0cpA0+CFsN/rHGS6qe5NyytC1
         b/RGVTX8QkwkzGILm/88udQ+YgOagZ3ZrfCGrXYnmoSG/18nXLdpszMCbY8OSI1KP3QU
         L6Pq42HV5BH5b1FRlUkpYyKotRXpKSgsp/6yESvwS5qO0odkjb+D1DDjz9CErvLg3urO
         eMw2pdauauAqWuR/o9QLTKQQhWkGOLoklG4Yu9oLWy6qguZmyR/5dJgk/O3uJMliN0tk
         z0DFvi8BotRw1v3KqRZwtoIMt9FIaBpWkvit/ME7ZDtmHj8kQ32AR+vNBvqCSIgB85iX
         eypQ==
X-Gm-Message-State: APuU4Z/6JWlwvxzmkPois5pIZ8o1ODJ+/J1sittzKZjCLtr7g5GyOykl
	mP87h/ITp5F5F3QI7HnPAF3WKC6FQdJhmypkJOn03BUsngDhqtPVb4XBv4GwOMaxuVljSE6gef3
	nM8LVcrQ=
X-Gm-Gg: AYBFou0dLYCWkSZbDJRzHQv/xuhDh85zVqSKuXMqVjTogfjud8AmNTKhFhMYLn9KWJM
	f2mM8kRxFtS3Dj9I84iZCeW/bZRL4xnmePc6nkrGwbtcWITAVHymlFJLzPklacu/+A+IhWoZM9/
	Ubwmm7OLY6znHJ28XTx5KMCZB04XSE9KyUu1qTGpxeg04fwgptl5p/U+xALxXB3SaYjLv/T3E7d
	R5TddpqhRpPDFyZeD+y/xzLUsNHLVZnNm1Brudc/2LXVNkPeldXibnNfS9QRdQj6fHaQXmaGRhM
	EjbXCUuC3gi5j6++dUKC1iP9jEGUJXcXiXevxZp8xFwQzLWDqlyKUpEe/hBilCcfu7+Y3BCgEVb
	1u+pk6FiDFlKqFNKOrStRBxZ/KtasnaEk7A2GD9TIDg90zKmQHsC11yGXUj2ws8Eq4oaPe2xwSj
	yx9W5x2YJmpgdf+kM6PZb3iB64LVT7QSddR49t4gB0z1GelqJGG5Gqa5bWhZcR/trzjl/oNibHI
	U06Ini1pT1prucIGl1r0u88yKqM5zYul94sWPBjPYXLdfmbUxtUvzynvZgZiG10fxWrVLN1qfs4
	9bJs8D2ypDT1FVj48hCTWBb8oSfKAiIzdTrYwrX/Rp3lEDJo4Vaaq5Bj8RxaeT7mVTi3klCrQbi
	B+0eEAS430Bxpyw6DSA+O34TbNeGo5UMnEeEBVaSxsfLcr6Q=
X-Received: by 2002:a05:6830:6510:b0:862:a901:21fe with SMTP id 46e09a7af769-862f0956526mr793667a34.29.1794956992008;
        Tue, 17 Nov 2026 15:09:52 -0800 (PST)
Received: from [192.168.0.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f02123fdsm716369a34.14.2026.11.17.15.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 15:09:51 -0800 (PST)
Message-ID: <cfbce18c-2a13-48ca-b2ac-938ad40ae892@kernel.dk>
Date: Tue, 17 Nov 2026 16:09:49 -0700
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
Subject: Re: [PATCH 0/8] nbd: Defer request transmission to a workqueue
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Eric Dumazet <edumazet@kernel.org>,
 Aibing Chen <chenaibing@cmss.chinamobile.com>
References: <cover.1794865298.git.bvanassche@acm.org>
 <3868f992-20ee-4b04-9416-40a5a333cc27@kernel.dk>
 <8de875b7-e7e7-47b8-8cf9-6d07c791a53c@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8de875b7-e7e7-47b8-8cf9-6d07c791a53c@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 4:03 PM, Bart Van Assche wrote:
> On 11/16/26 6:47 PM, Jens Axboe wrote:
>> Something like this _really_ needs performance numbers.
> 
> Hi Jens,
> 
> Measurements for the most extreme case (4 K IOPS; Unix socket) show about 5% less write IOPS (310 K -> 290 K). I think this is acceptable
> because anyone interested in peak performance will use drivers that
> yield higher performance, e.g. NVMe over TCP. I will publish the code
> that I used to gather these measurements soon.

OK, so I take that as -5% at high queue depth, what about qd=1 type of
results? Agree that nbd isn't the end all of networked performance, but
it's still nice to know what kind of performance hits we're talking
about. And either you didn't/don't know, or you're holding back on us a
bit here... Because I suspect the qd=1 results will look considerably
worse than the 5% drop.

-- 
Jens Axboe
