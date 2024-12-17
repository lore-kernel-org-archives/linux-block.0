Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7451F9F6F
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470115; cv=none; b=sUsyjoA6WfmtVmzLJLGjtIoEQ1Kzbk5lD9dGeTI+LPMOJOLyu1VPPpwMYu726tLj6AWMtT/LKAj+UE3e5PLKVQy4qQd5md2sSSVNUQV0FU0AP5wXGod1dEUXi/zdQXGuGP5H7mBWUbcz7ZwTigsCKBXabaFkCZnYR8dtTw+eVvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470115; c=relaxed/simple;
	bh=xf33B5VvGq5/a1TUwmmuSU4u+C76tBRqOGg8Qyofhxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=larcdCh9DOZD4z2MEXD+Zs4XaAxDl/CjrdNruFROhCqM4aigzQQesYoRdCR17N05F2ssDoxsQNJ3nNThVawbOb+kIXai4oXXu9TMawiz7lk+8niOFmp8OV0oM3aoI0oTIwNkssrmFDQ+aNbfU8JdEe+Ko0R8h6ZXi/uJSyQxpVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BFJUCyrq; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BFJUCyrq"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844ce213af6so195823639f.1
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 13:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734470112; x=1735074912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IqXM5ChAPYgEMZME8KAA8aUZ2jvp6umFJUNiOArjojA=;
        b=BFJUCyrqRsOOcP7F6s8NrRvSv7aYOvbJ+3X2BoLeyMwSDNauwVHS8sBe9oiHAZIs96
         5GwjR/0whNamSaFYqkR8ihfirEayzLKpkqhSoJ9sMAMlcTluhp++to4ZbYoDAETsl0Cb
         foRitIomz1qH6iTchT4VwdJ/HojQnD6UvW90a9I5O4HUZazZslu3q1D7A9sW4ldYRjN4
         OT12kOAp1AKASKkJ9qv+luy4u6qZB8WoNQEQL9F1B8QO3MU6Oj+IlWIQPI3PFMeixdbk
         8ZtXZ4CYfn+JK5vAm/f6MblrACAwcNyXEbz4VaaEKePubuDKoacTVv9NCzd1UgMTPo6C
         KwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734470112; x=1735074912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqXM5ChAPYgEMZME8KAA8aUZ2jvp6umFJUNiOArjojA=;
        b=EFhcdol86fkWQ4+vO6K/M+ZLg/Ah+z2Xtlv9/68Qr/o8SKkioXkk5QYb0soy5CU8eP
         4isI5l6ReRociolvogp+mqMJ4wCi2nxZJjkzn3LLM9+zhmQA8iAldJd3KTiakWB7wsqY
         B/2z2mQzVZslk5OSUMUmmf1ismM2FEUOE+xWUkGPbWdwtQ9bbUozsMJe2cBXu2ynQQ4K
         6+x79TBUhlXYGyfttDeluCmC2GY10dw6HYkfbFxE4L49GWD/LXhoaIuk8QMtL926tpd3
         d1S5Gr7McacGwc5Smnrk/4ye/pk6qzwkF5EE7Nxv5rZoqb3QYMSGJA5gy6a0uwv8X3ss
         VLzA==
X-Gm-Message-State: AOJu0YxMQ32XEREkKuOf2nmWh/YIrrt7EPkbDZLBu1rxN/maVpv6mkEm
	IbdknExnLJrB6f8paru8STZpnanwdJ4pmdoTTdhToW0dP2bLgj20fwF2fbsaQjw=
X-Gm-Gg: ASbGncsNUIRcDIMPpyyaPIWBqQrGGVyIK4B1l46U/buV9QEy2URhCtMwR2IxhDipe72
	bWWfoH9qPXOvvsZg2Ztt8ypcLcktdHEx2bEig5NfRZ9InbZLeS7B3D0Vv0HWkDPsPYDpQlg4jqi
	OFo8DMijJfm4Ar/hdO2OKlEGi5rc5bhHGAvI2oVpjXEhm1k1mWqCHPgUWFTHII10aphCaPwafUd
	jQiSNtPCPBo3N19+Fmlmioc3WCiJutyUq6vdPVpnE43MLZyA8bp
X-Google-Smtp-Source: AGHT+IHpN4Br6+mnR+kFZ1EwAb/Vub1XCuqDNtAg2Y+/5zusGSG+ipJuCCtS2So0nBmL4iirayC0fw==
X-Received: by 2002:a05:6602:490:b0:844:cf31:622f with SMTP id ca18e2360f4ac-847584f1c65mr43061239f.2.1734470112233;
        Tue, 17 Dec 2024 13:15:12 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e0942a1fsm1846449173.33.2024.12.17.13.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 13:15:11 -0800 (PST)
Message-ID: <b806ba81-c61f-42da-ba7d-3b689c89f931@kernel.dk>
Date: Tue, 17 Dec 2024 14:15:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Optimize blk_mq_submit_bio() for the cache hit
 scenario
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
References: <20241216201901.2670237-1-bvanassche@acm.org>
 <20241216201901.2670237-2-bvanassche@acm.org> <20241217041647.GA15286@lst.de>
 <d655783d-185e-4ecc-aea9-875789cfa9b4@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d655783d-185e-4ecc-aea9-875789cfa9b4@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/17/24 12:22 PM, Bart Van Assche wrote:
> On 12/16/24 8:16 PM, Christoph Hellwig wrote:
>> On Mon, Dec 16, 2024 at 12:19:00PM -0800, Bart Van Assche wrote:
>>> Help the CPU branch predictor in case of a cache hit by handling the cache
>>> hit scenario first.
>>
>> Numbers, please.
> 
> For a single CPU core and with the brd driver and fio and the io_uring
> I/O engine, I see the following performance in a VM (three test runs for
> each test case):
> 
> Without this patch:      1619K, 1641K, 1638K IOPS or 1633 K +/- 10 K.
> With this patch applied: 1650K, 1633K, 1635K IOPS or 1639 K +/-  8 K.
> 
> So there is a small performance improvement but the improvement is
> smaller than the measurement error. Is this sufficient data to proceed
> with this patch?

I think it's fine, it's going to be very hard to reliably measure. I
tend to prefer the expected case to be the one checked for, eg:

rq = get_cached();
if (rq)
	...

anyway, as then the expected outcome is what you're reading next
anyway. Either that or

rq = get_cached();
if (unlikely(!rq))
	goto some_failure_path;

If you really wanted to measure it, you'd probably skip the IOPS
part and just look at branch misprediction in perf.

-- 
Jens Axboe

