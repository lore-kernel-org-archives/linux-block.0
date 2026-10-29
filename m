Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279028;
	b=KYh0fHufXMn3bDxOwRYSHemt7Ezgl7XLS60ts+wDhubyCUOVJ43ii2XZmDqdWGgJ0aJa
	 Au1k1/jh1IMaxi1IoeYT39wQj1Y/GkQRMO4WrsXyJ06NAjlITn7u1qk+b75hCcpX3OKU6
	 hl29J4Bh9Y/NGjUllx8RWvKhFp78S7N1buCwTZEW2TOjQpbxfZ2SlG/oz+wLyqvFMFVBA
	 7u7ON0XRm376rdEVTkg5ZlW24B1EEVr6j7kFp5MVIQjUFuUZjuZ15RfZEliUZgTcPaRQU
	 ZxRF5kQeW0v4txreTX4npOS6NLQSrGUbfYl74n/JzdWNZZfhuly8fOYO/ZCrKyicV/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iBpXwSp0hiTGx9t0LY/ISHQuJFil/53otbVRqjQnRls=;
	b=bOS0AwxdqeQ4Dv0/3Mgra1HcvPnnhJS5/PXSnqBTX7C/fK4N6y/N7LR34gI8Uv0jcwJr
	 MUjE7Be0KHzLTL2jbUhEyXn2nYu6KKQdtkSHWjOwX5Q9puaYdU6Wa/IaPKxdcdCZ+UE4k
	 Iz/JxGP55Pj+M4kVmx0KPuDOVuVkjyEGicXfcbzaZ82RrM+toGcNbgPdRTSfs3qfq4Y1l
	 4dwdSE7Q+5BD2ct0BGJJ/aZ4Obtu8Ilsk3D7mENKTS+3uuieSd5inb2DHXHyFUuU8dCrr
	 ubI1KTuHtGSwnImZz9x4DrrJp/EQxPSlEFVHXrsskSDAGYH4m7z6JW35yebuprIr6+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OGAWOj+A;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F996606A31C
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F996606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OGAWOj+A
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1931ff67a29so1320938c88.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 06:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793279026; x=1793883826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iBpXwSp0hiTGx9t0LY/ISHQuJFil/53otbVRqjQnRls=;
        b=OGAWOj+A9RVIk9h3KKkwyWN8NZQQ9K0dgrTN4/eDKCvHDAp5WSbpw1IjbjMvTtNps1
         NOTbZTOukHywha2OlLHJfSnQCt81KfwaQ0Ai7y/gboNsIDpNkc4gW2U794qP3ilnqV0t
         q7AW+feIgALFnbwKmN1wDnwWuDvhT4tkB7MEM11L2upUIJ7X0mwyXZ2S/Dw2cDOvxhFW
         ZZFMharQ0+OgIyhkZTuCl6Srmz1MdcQc9lYKL4bfPImCxvHrV5PaenHmQWYK0I/LmOrx
         4ezQyMGyRdxUlbH9Qlw89fh2L3lKKZ1O24pQ1MH+tLU/1u+pegei/g4K9aGTMmtg4zaE
         7hmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793279026; x=1793883826;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iBpXwSp0hiTGx9t0LY/ISHQuJFil/53otbVRqjQnRls=;
        b=i5rBYf4fxeFExjrDUocCSmhYJNopJ7ShyusCibrQTNDWtPtf9GjiG40Lrv4ONkr9Af
         1R84yf/CRR+yF7bDRvFVe1kDuNLnpOJgjotru3h/UYeES9PEJc+1PZJ4Jtat0TVwjpr5
         3E0lTSbDQq3daS1p/4FCqfvTNYNAfocExzROrYxNbTZv5DSDwWFn6vfiLD+QltlZUPN3
         O6YSP1eyj3NSjbyMRSrhaaS5j4qHgmMqX2z7qhJq1yHpUpcwyD4Iqj7z4OimgPl95155
         vceUzRjr0fUoPGtukDUNSJO1LR/CIqlwvPV8T+77EcHEMxECsX5U6+tvdkUVkTk8FXYL
         vFrA==
X-Forwarded-Encrypted: i=1; AKwUvBzKHhrhEBwqO1beHkYnC6Tne/a2pf438X8PzaODmbaiipSI8hHDT5+v9336oGkKkMF/5il6oj9bSqEY3A==@vger.kernel.org
X-Gm-Message-State: AFq9FYIxAfQWkxa42tWiwr/GienVG81zsZ74ahDuj/bqFPGfGjhbHt5o
	vWul6oTFvqhXIoGfjZTGtC5mcIfQpDYhWJB7iQh8H1B5hMFjSDItLsX6C6+KQlvDLIg=
X-Gm-Gg: AYBFou2vVl0cqeHqGoEbq7elzsQTvR9KSytSmtBKVMoMGGRWEEOjVTY603eu9PA3t0J
	l2Y/XUVoWbGKPSKgZ4IMEUBP3QCHWttnrw444wnucQjLxrvOKVcfMj5l8Wy0hPmV0dH+noCm//k
	HGauibv/uAy7YgbMfh90jCRo1dzz6YviCyX72kpB8Rtkafim4budhGqOtUlS2NDwijVbH0VPCrA
	CCXrXQXi6Pi64OHm6XbYGMrHCwBdmxzutOAKNB5jpPBGHWr6OvCpp2qOUEus/tQA6gQw4TknBqq
	JPsfkVPPrRC5IU/KrkIp+k4XKw++/nbUeVxIxZWPh0CTm8eqQoRS235gbjagkcmcRD6u+yHQmQ4
	nWRWLylVapDwIwtOFUWg8RPwMF24ifgbU3YfaBmh0qDYNRkyJBLdqT+UhEPWMXq7X33SRAbmDip
	KGjzx0T61g5YYTL3js5BKgZyPqUfTMH65hPh2md8GT1/Cs2OEUCMF45G83/fYL+OJS7r8AP9UKJ
	GKif/D/eDXPNV64R1X9E2HNuyTx/iqJQoTahQQuKMsM92aIJ2wEGC5Hea+mU7LYr/VtPuyZBwoe
	7xuaBHB7cHQLGdM57+VmBy0PCuLo+u566fhLpaENs3WQTyNvlaSZQofSTBbNDw727ijhmA1C3hR
	zCtRXp6svANyR
X-Received: by 2002:a05:7301:550b:b0:368:72f0:353a with SMTP id 5a478bee46e88-36a2044bb90mr8519213eec.38.1793279025910;
        Thu, 29 Oct 2026 06:03:45 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23908542sm18226134eec.10.2026.10.29.06.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 06:03:45 -0700 (PDT)
Message-ID: <d9d30ac0-102f-4578-96c9-c7c4b4f05b88@kernel.dk>
Date: Thu, 29 Oct 2026 07:03:44 -0600
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
Subject: Re: [PATCH 18/98] aoe: don't free a device with its work queued
To: Bart Van Assche <bvanassche@acm.org>, Josef Bacik <josef@toxicpanda.com>
Cc: Justin Sanders <justin@coraid.com>, linux-block@vger.kernel.org
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-19-axboe@kernel.dk>
 <20261028234917.3067347-1-bvanassche@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261028234917.3067347-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 5:49 PM, Bart Van Assche wrote:
> On 10/28/26 09:41, Jens Axboe wrote:
>> @@ -356,7 +358,9 @@ flush(const char __user *str, size_t cnt, int exiting)
>>  		spin_unlock(&d->lock);
>>  		spin_unlock_irqrestore(&devlist_lock, flags);
>>  		aoedev_downdev(d);
>> +		spin_lock_irqsave(&d->lock, flags);
>>  		d->flags |= DEVFL_TKILL;
>> +		spin_unlock_irqrestore(&d->lock, flags);
>>  		goto restart1;
> 
> Setting DEVFL_TKILL only after aoedev_downdev(d) returns leaves a race
> window open while aoedev_downdev(d) drops d->lock and sleeps in
> blk_mq_freeze_queue(d->blkq):
> 
> 1. ataid_complete(), rexmit_timer(), or aoeblk_gdalloc()'s error path
>    can still see !(d->flags & DEVFL_TKILL) and queue d->work during that
>    window.
> 2. aoecmd_sleepwork() does not check DEVFL_TKILL either. If it runs
>    before freedev() reaches cancel_work_sync(&d->work), it can call
>    aoeblk_gdalloc() (hitting WARN_ON(d->flags & DEVFL_TKILL) if
>    DEVFL_TKILL was set in the meantime) or set d->flags |= DEVFL_UP
>    again after aoedev_downdev() cleared DEVFL_UP, letting new I/O enter
>    and hanging del_gendisk() in freedev().
> 
> Instead of setting DEVFL_TKILL after aoedev_downdev(d), how about:
> 
> - Serializing flush() with a static flush_mutex so a second
>   aoedev_flush() caller cannot enter pass 2 (freedev()) and pass 3
>   (kfree()) on a device while the first caller is still in pass 1.
> - Setting d->flags |= DEVFL_TKILL under d->lock before unlocking, then
>   running cancel_work_sync(&d->work) before aoedev_downdev(d) (and
>   keeping cancel_work_sync(&d->work) after timer_delete_sync(&d->timer)
>   in freedev()).
> - Checking DEVFL_TKILL at all three queue_work(aoe_wq, &d->work) sites
>   (ataid_complete(), rexmit_timer(), and aoeblk_gdalloc()), as well as
>   in aoecmd_sleepwork() and aoeblk_gdalloc().
> 
> Here is a replacement patch against the same baseline (checked with
> checkpatch.pl and syntax-checked with Clang; not runtime-tested):

Great thanks Bart, but can you make it an _actual_ patch? I can't
apply this, the commit message is referential to the original patch.

Just send me drop-in replacements, and I'll replace whatever gunk
is in my tree now.

-- 
Jens Axboe

