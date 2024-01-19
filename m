Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4FD58AA7
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700336; cv=none; b=IwWk52bJc20q9kus1Md5yqyJbyXh6DmVaI9+T4sPQyO+glfou+VOoI3i3NgCbO8waq8faqF/Wk8+vqvVBKWFsvzyvc0A8fTTPK4dueB8ZXyW4FTaJkFimnEMIulzyKPRqmdzdQwQT6QK3C2WPCHwBD61Ev6q9wnK6oOeMWXKGao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700336; c=relaxed/simple;
	bh=XL9DtTTfuY851gbuBUk2IfkNMbF7U+krYQuq/9Wb7eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnORdg10hsH4ecBK0oZcv285/OOqi0cmAUy0OtS3369w53NKqR+gQokesaJxOKOhNnKZ6vXWoPkKW0cj11xyio/cQ2N4l3NL1mXJnkjLCygJL4SL8To/Y5XKJVoP3FymURa/z0aJcUf4ohgU7pk/0KtZTYTgQqan69v0glHMpyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pjWPTFYM; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pjWPTFYM"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso16490239f.1
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 13:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705700333; x=1706305133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w81q7ZYYMDn0rmz9YGOMbYmxBkTkJD+b4cgOreci3a0=;
        b=pjWPTFYMspFhHH6xyL6iQm4e95cOS6Sr7lskBlKTeGrSFlWCQ2CwbIxftP7fxYSM91
         TdwGWbFF9uZP+ITAADjG68382M3OelxgwqpOqm3ZhwO1VJnf7NF71xKZGEsN0J83WHSz
         D8696duvcOsZKlzv8XEDPDHRmMOzETcKMKcetFD9S5VUzyUhGoxRrlKp8guTdn0bXT9O
         DTsEscA3m4eQKzwaMUZ6oTdwORicUks8WXGSGqDtPT5DrZ1QudY3lPPoCwFtRNAjH2V0
         IhE9oYxYZvQmh8AvHKGzyrOa3+XdHf7qZE7bIkcryxVCe9UWU0FE9ao1DG1WyxaFfAyp
         MLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705700333; x=1706305133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w81q7ZYYMDn0rmz9YGOMbYmxBkTkJD+b4cgOreci3a0=;
        b=IJMqHnjGrg9kt9hj0UqN/v7Iyhm8UoFraGQpU/XZMAwtL/JoXVq8/cueUQTeieEPlC
         Rmxc5UbgGu/TxSzmqX8xZOAqmNyA2T4axAsruF+W+dlB+vYQP5keQnv6eMMNYHht2etC
         nWeBrZd+b39Qyk3oH/xmaYQI6GJub6PYMflMqMT2E68x+l7gOO++bemQLScKe/CCfZN1
         qfd7T6EEPtgIVb0ShySheE2lNc3YN+rAIgdqRQpTRSsKxMbR3EDRGiH7yFvMMFxEcSSo
         LzOeY7zkEN2njymwRKhcIjILRWhvvgFQW5AGVbgkR/afaKWnkTN4J9I49SYunM+vjv4Z
         NjuA==
X-Gm-Message-State: AOJu0YxZWoJepaJOFU3gjbVfJPcKn5e06RKr8F/mgSK1mHVRvXtDnlsT
	+8Vhw4wS6zSyt/aY1QYtgjyi5RBIdHT/6EDBVWhueqEu58Ol9dgHhkPQ4RDlMEk=
X-Google-Smtp-Source: AGHT+IEZ7MwAlj/2AVQHt0vLZJCgIM639R5JZkHM4c666ps7wnDkNpJWJW5E+AH/QxzendqT5oYF8g==
X-Received: by 2002:a05:6e02:1c2f:b0:35f:f59f:9f4c with SMTP id m15-20020a056e021c2f00b0035ff59f9f4cmr905052ilh.1.1705700333638;
        Fri, 19 Jan 2024 13:38:53 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bd10-20020a056e02300a00b0035f7f712c78sm5736905ilb.36.2024.01.19.13.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 13:38:53 -0800 (PST)
Message-ID: <772c3422-0657-4c61-9392-0388119902a4@kernel.dk>
Date: Fri, 19 Jan 2024 14:38:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] I/O timeouts and system freezes on Kingston A2000 NVME with
 BCACHEFS
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Mia Kanashi <chad@redpilled.dev>, linux-bcachefs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <54fcc150f287216593b19271f443bf13@redpilled.dev>
 <c8f441c2-d662-43fc-9e8e-fc847428dbaa@kernel.dk>
 <ijsmgkglg2eiy6fswgjj7utrtlq7weiih2afx2cssaaz2pjwem@wonvjbulvgsw>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ijsmgkglg2eiy6fswgjj7utrtlq7weiih2afx2cssaaz2pjwem@wonvjbulvgsw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 2:34 PM, Kent Overstreet wrote:
> On Fri, Jan 19, 2024 at 02:22:04PM -0700, Jens Axboe wrote:
>> On 1/19/24 5:25 AM, Mia Kanashi wrote:
>>> This issue was originally reported here: https://github.com/koverstreet/bcachefs/issues/628
>>>
>>> Transferring large amounts of files to the bcachefs from the btrfs
>>> causes I/O timeouts and freezes the whole system. This doesn't seem to
>>> be related to the btrfs, but rather to the heavy I/O on the drive, as
>>> it happens without btrfs being mounted. Transferring the files to the
>>> HDD, and then from it to the bcachefs on the NVME sometimes doesn't
>>> make the problem occur. The problem only happens on the bcachefs, not
>>> on btrfs or ext4. It doesn't happen on the HDD, I can't test with
>>> other NVME drives sadly. The behaviour when it is frozen is like this:
>>> all drive accesses can't process, when not cached in ram, so every app
>>> that is loaded in the ram, continues to function, but at the moment it
>>> tries to access the drive it freezes, until the drive is reset and
>>> those abort status messages appear in the dmesg, after that system is
>>> unfrozen for a moment, if you keep copying the files then the problem
>>> reoccurs once again.
>>>
>>> This drive is known to have problems with the power management in the
>>> past:
>>> https://wiki.archlinux.org/title/Solid_state_drive/NVMe#Troubleshooting
>>> But those problems where since fixed with kernel workarounds /
>>> firmware updates. This issue is may be related, perhaps bcachefs does
>>> something different from the other filesystems, and workarounds don't
>>> apply, which causes the bug to occur only on it. It may be a problem
>>> in the nvme subsystem, or just some edge case in the bcachefs too, who
>>> knows. I tried to disable ASPM and setting latency to 0 like was
>>> suggested, it didn't fix the problem, so I don't know. If this is
>>> indeed related to that specific drive it would be hard to reproduce.
>>
>> From a quick look, looks like a broken drive/firmware. It is suspicious
>> that all failed IO is 256 blocks. You could try and limit the transfer
>> size and see if that helps:
>>
>> # echo 64 > /sys/block/nvme0n1/queue/max_sectors_kb
>>
>> Or maybe the transfer size is just a red herring, who knows. The error
>> code seems wonky:
> 
> Does nvme have a blacklist/quirks mechanism, if that ends up resolving
> it?

It does, in fact this drive is already marked as having broken suspend.
So not too surprising if it's misbehaving in other ways too, I guess.

-- 
Jens Axboe

