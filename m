Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5A9225D9
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705513729; cv=none; b=jVE2XHKng0KAj1tLnhRJPCAKkEztv/8cR+xp3I4tdtbBJquASgXh/5xWGduA1tE1apnbi9RzYSFDUoQZgRUPW6QyFoRKFc8+aOySZXUh8VrQ56g8IksDL78Ym6I2/7xui653RHp9tV29L69GQVh6TZZMGSQsHa/BsRod6F9IGC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705513729; c=relaxed/simple;
	bh=JvujENCpcsMGh6S24P3OXNHi6pgDD9tZVJPHRdE/ljw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=aS37tY++dyV6rv+GUizRiTGGuO11Ojy0A76/XGLA868SCY6VgxpZsO3Gw7powzzBV1+xmrl30Otg8a1ajNub8DsfOCf0iln62K52/QaBYQzheqsMlwTw7VVjjCc5nS77a/0WuSB8Li/R0ELJr5F1SCmiGLrz5Y53YIsvI6S3n0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PYcgH5Bp; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PYcgH5Bp"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-361319083daso2255595ab.1
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 09:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705513726; x=1706118526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EQC9NIYsanqnP74bCvHtEBj3zQATwxHSwO/bnPWyKDs=;
        b=PYcgH5BpJpDnPSZDl0uW1bk9j/tFNAFHFVZpqBP8X3tXk70PhYLq16Ms+AcWkG3bWb
         QonbBvBygN058/sL3mAkc4WgXNmBi20iEO3znb7Rx1rKwKXSP0X0TEiO5dyfFMetdTq/
         q2Q75RF3n3+mQrkTIZ6/1USVR3+IeEp+R7whtm1+RfGc49smXYFRdWhaZMHtSMnFKOMP
         oTMZU+u/ru6TkfsRqTjXqco2h4q+igG1dt5dBU+SN4opW+n5JKPP0BYlTSfWv+qv6eA3
         ORWZZi/vHM7UdgBlLIA7M4Cwe5obZRApdIQXECRRM/FeO8LUKtLzV+z/6x7+wNl/ZmeH
         dGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705513726; x=1706118526;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQC9NIYsanqnP74bCvHtEBj3zQATwxHSwO/bnPWyKDs=;
        b=WT+enk+/OXgXWsWGm68oPC74i7mxkFrY7vS96kczXUHAzUsmR1nblVBPNAjNZh5bbw
         Viesy98SoaLMs8urpXMUH3h0tVOiYpFib5QYVTln1CpErO/ReytL0eZ6OBjGSGZfi57q
         u0f/wSDHTVt2XxT1sPRTnroIxejdCFNFqaPONHYkgn5udwydz31qxdk4flrXf2H81xKK
         1HjoLM+F0LxyDYRQ2Lr2lKFxRfuDql6e21GSmRQllZ5C5WRQRdIgzybbIPR8V5x9hMUb
         ssP8gIJafYlYXLZtWiXMvSqmEb8IE6rJ1tdR2MR6tIf+vIBjED11oRGc2dVYejdLDyE3
         LjZw==
X-Gm-Message-State: AOJu0YzXmHChKdh96qq14jGxlHVAFSmgbYnNQ2tsfWtEpT0BF8Xao94c
	7rRoxbVwVv6VAO80g9doECoQ+6KTXR+KEsGllP+lhkachtMCag==
X-Google-Smtp-Source: AGHT+IEUEIvv10b+JJwg7Xu8LougIkwfXnz36eWtRwiTe+nB7SDqr3vHRNimePjucL9zCXyuTMJ7yg==
X-Received: by 2002:a05:6602:1229:b0:7bf:f20:2c78 with SMTP id z9-20020a056602122900b007bf0f202c78mr3060126iot.1.1705513725920;
        Wed, 17 Jan 2024 09:48:45 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h24-20020a0566380f1800b0046e3023b444sm513339jas.32.2024.01.17.09.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 09:48:45 -0800 (PST)
Message-ID: <c38ab7b2-63aa-4a0c-9fa6-96be304d8df1@kernel.dk>
Date: Wed, 17 Jan 2024 10:48:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Damien Le Moal
 <dlemoal@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
 <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
 <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/24 10:36 AM, Bart Van Assche wrote:
> On 1/16/24 15:34, Damien Le Moal wrote:
>> FYI, I am about to post 20-something patches that completely remove zone write
>> locking and replace it with "zone write plugging". That is done above the IO
>> scheduler and also provides zone append emulation for drives that ask for it.
>>
>> With this change:
>>   - Zone append emulation is moved to the block layer, as a generic
>> implementation. sd and dm zone append emulation code is removed.
>>   - Any scheduler can be used, including "none". mq-deadline zone block device
>> special support is removed.
>>   - Overall, a lot less code (the series removes more code than it adds).
>>   - Reordering problems such as due to IO priority is resolved as well.
>>
>> This will need a lot of testing, which we are working on. But your help with
>> testing on UFS devices will be appreciated as well.
> 
> When posting this patch series, please include performance results
> (IOPS) for a zoned null_blk device instance. mq-deadline doesn't support
> more than 200 K IOPS, which is less than what UFS devices support. I
> hope that this performance bottleneck will be solved with the new
> approach.

Not really zone related, but I was very aware of the single lock
limitations when I ported deadline to blk-mq. Was always hoping that
someone would actually take the time to make it more efficient, but so
far that hasn't happened. Or maybe it'll be a case of "just do it
yourself, Jens" at some point...

-- 
Jens Axboe

