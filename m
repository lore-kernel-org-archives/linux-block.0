Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EE039A04D
	for <linux-block@vger.kernel.org>; Wed,  3 Jun 2026 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499343; cv=none; b=nCpQyans6PY7cu5/4uGn1P9GkoxqwttRpWeqO/HKuUydjbBstQw2huLWNdfgcxFUnz+Ev/jZ00Osy5AfrBjV0oLvAiWOqnmNltkGzZV+lhhBHfIcE5q5iRPYL4lPAluX1Nul/4YBh9aF6NiV8/MY5Z/gnSkKCPQshFn5f2cem1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499343; c=relaxed/simple;
	bh=VGcwjx3DPZjE2hgdTexOWATae4GqcZm3OWlDTiWj77g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARCNAIjeZBs3pOW7dSZiDCcGTXr0sTXlp4Cn7OgT7xlrLrmv9K3ez51lJEGp/2+nZaWIX5M9hSekTIAauZxXEvrIOUgSsVp4OsdZthNB4ahtkxd4HBfMaxpsZripllXdJEL7IgLRxy0B/Ot4rGYo+y5z8R6GER0EC7hAWZ+nq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=G5IJnpJ1; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="G5IJnpJ1"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-440f9c48b85so332091fac.1
        for <linux-block@vger.kernel.org>; Wed, 03 Jun 2026 08:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780499340; x=1781104140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Rgl+7P4bys3k8olUkjDrUmY90i/4VEAqR/MuDk3aF4=;
        b=G5IJnpJ1fpzebgCXZZYBBDP1JPUgcjL1XHLreTHoWERY0Zxub8g4n8/p1U5SSEARfG
         zCqQfBImBa1qHBfb+vfAPE+1eT71YVdJz2Wgi4IpumpvHoR5nFjqeQIIl0F3JiZ6hBMo
         91uT/Josj3QjW3NxgXODqwVsbZRC+DMByiRrJ2DUE6nTlE4xBbtdpY1gxJV763Tuqbny
         lM8fVqEgVXpNOGCpMFHYSdo4uEjgfjuNXzTLRYU45wuzN0h4ptWV7Pg6WPeUK5BLyRww
         KLKaaNNFPQRRNMJfTEJbehB5WTfU+6XiC+G3VH7w4G/JGEnEiPcZQY6Geqoc6Q4pAd/e
         8JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499340; x=1781104140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Rgl+7P4bys3k8olUkjDrUmY90i/4VEAqR/MuDk3aF4=;
        b=liNZC1EZOIV9Iwmv9WMWWTxBQRTleyck7Yu2HAMgWXfEprWm67REgodUKA5sP2g37Y
         mWIybGiRg9tfyUqjmmLWkDKelKiJWW/R9SSzPieICc8Bw6FDmXwx1u4z0yidFARHQs5/
         WAuALWP+Y4Ftm5Dhd08t2Aq4ecHEI9/ZJfE+5IMdYpuc60dooqhAEWiatpsxkrUekl2t
         DhL6G7wCsHJgkH4eWxtIlVwqiwUKinSgJrqCE/sF6CR2NaOCYTsWZrwBgZI4sn/np7bN
         OVFVasbpauedC7ySMu/kcHCYiFE73kkXPCKo/KnAE8JxL2VBh4VfeF1UGiqN1z2xhK0c
         zJ0A==
X-Forwarded-Encrypted: i=1; AFNElJ9bGKk4d4p+cxh2C671yfjVKLeffvmfxcdipWA3TKHNXdD/VjukrRo/zhUDHambHnzmS40mtjyI3r31Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTuuBteICgv5n1jYq+fylruXZYjzTOD1yN6XIS1wCHw32y0Ndn
	FA8iXts7TZDcdVFZ5LDWk1WSXy+7fzoya9Gh3npHIcEyZBlFdrVbCPlQWCWrasVrKkgc3sVlPgw
	VjohL
X-Gm-Gg: Acq92OEwQTbMQCBybX07zwjpRN/ucMvnaTHa+l2gy40rjI0cksVQ2mwLiwwD/aUPGu3
	F1PNfzK4ptlAJgpOE909giHUvXSDvPUu4GjVq95xG+pMvlCRxOSxyzwkOfRKNHG5cpKWhCvWi16
	KkyTuCDSEQG0HHrdEsI9/h6eGAWfcTD6HdVq1QpZRe1hMEzymQ2tTd6vB1i5wDGIosFYwskrLYz
	GisQUiuR6H5h5sW6VCz/9vVloZLLCZPvI84evAemIi3bfl/FhO6IHcti4+BN8jbB54IGnzIbSBf
	7Zr7vf0LsdMg/zL0HBAZfUJNtCjnoO1frbcqpwZES8f0i/loLKS0pEO2VZEgPDNwfag5wusMUwc
	k2cXj+8wpXwSv8SoHf6hM99Y6/0XwnQ+Ok/68i3mtRsrwnDh1Frux16Vc5AcrbRXabWLa37Moem
	7l9+k4mv0qo1sJpbVKBLkWPxpo3qn9yRINKdDocTqrI6G6W0khB5ExGxEkRu8Euc13SHaO9a90E
	JjFZQFmvE10jisCRgI=
X-Received: by 2002:a05:6870:9d98:b0:43c:33e6:275c with SMTP id 586e51a60fabf-440ddd8f4f0mr1723868fac.9.1780499340586;
        Wed, 03 Jun 2026 08:09:00 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7c42c33sm2468388fac.6.2026.06.03.08.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 08:09:00 -0700 (PDT)
Message-ID: <70200e71-bc14-4f1e-aab9-16b27efbb3ec@kernel.dk>
Date: Wed, 3 Jun 2026 09:08:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] blk-cgroup: fix blkg list and policy data races
To: yukuai <yukuai@fnnas.com>, Yu Kuai <yukuai@fygo.io>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>,
 Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1780492756.git.yukuai@fygo.io>
 <1686f891-599d-4cef-8f38-420033355f2d@kernel.dk>
 <189b8601-87a6-423a-b267-9d550c31c086@fnnas.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <189b8601-87a6-423a-b267-9d550c31c086@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/26 9:06 AM, yukuai wrote:
> Hi,
> 
> ? 2026/6/3 22:35, Jens Axboe ??:
>> On 6/3/26 7:27 AM, Yu Kuai wrote:
>>> This small series fixes races between blkg destruction, q->blkg_list
>>> iteration, and blkcg policy activation.
>> In spam: Authentication-Results: mx.google.com <mx.google.com>; spf=pass (google.com: <google.com:> domain of srs0=eh6w=d7=fygo.io=yukuai@kernel.org designates 2600:3c04:e001:324:0:1991:8:25 as permitted sender) smtp.mailfrom="SRS0=EH6w=D7=fygo.io=yukuai@kernel.org"; dmarc=fail (p=QUARANTINE sp=QUARANTINE dis=QUARANTINE) header.from=fygo.io <header.from=fygo.io> if you don't get this sorted out, your messages will be missed as they end up in spam for most people.
> 
> Thanks again for the notice. I think I finally figured out why dmarc failed. 

This email looks better!

-- 
Jens Axboe
