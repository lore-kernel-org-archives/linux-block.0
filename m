Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE4D2B9C0
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748276; cv=none; b=ED20eldnuh1ycglWlpsbJhgQrLpyx596P5+WAdJG8npbgJbE0szs1rzqQL7xOZoZPdCFaqhHosp87gb5As39GqvEkUowOljimyPC+Isff46sY383QS0foyXXogmqiiHNdbtvTIWxuE7QP5dACfqQaROO3WFXjaYZhLfSN+KrsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748276; c=relaxed/simple;
	bh=yQEL5aSZS52kyWkyPOSK8MYQaHwfIJRHUjxjWYHEZJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewLhoMILqFY+EWenqn20iPbDsNnVy66x6sxUWYQ9ObOBl5DAQzU2SlXwZxDXVxyPqaBSPBEixyHzSvYdFMZ6l3OiUuoOh7yNyn36xlar6osmim4J8lU7Msb2GqXk8sON158aYkDpX6/ov/hq6vrs1JRcUQJvhzlUTawIKUPKAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s8xnjEQg; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s8xnjEQg"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d9ef422859so70757939f.0
        for <linux-block@vger.kernel.org>; Fri, 03 May 2024 07:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714748272; x=1715353072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnxzZcX85LnxpKbnvkV8WeJtndn8CYoaqIk3h9I9i5c=;
        b=s8xnjEQg9lMAvrCFUoixhpghG2VN7yr+3poPDUgaV75yUhrOhtV7uhTseT/oBpOyNo
         FBDe/Y9b/3QbUCKnWRU4tC9zqrELJkoQSJuHBxObbr3Zgr0gPm6opNQp3diI/6l3jL8+
         Xcn54L1nH0D3E6nDNEuiGT/iWeBT0bDyBcYtYMZdG8EkZSK1KLhWznomaNId74ClvcHB
         uCDMW2NlcoI8A1224PG/19tAaitDTY+PKb4rGXqJ3SW4DFaYgbsKPB0EPVikpjteFPp1
         ASop1TwOOUJwYXqIs+euH69j0jQIKxHR4W2uh7AGQ6izZ+3s/gXd0scMjIiXIUgbKUb2
         sTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714748272; x=1715353072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnxzZcX85LnxpKbnvkV8WeJtndn8CYoaqIk3h9I9i5c=;
        b=wjIjBcLewUEKnbdqLEl04/j+XeEdxfuKhz+ZNDgXUFsXa46anJiIokaUkmFcwHNkkV
         0oGVBdeSTpyZPrq8ShYOa4Y2T+PG/tepnXpVDun7XX7wbqILBPLvDysukEGCQ49xwXtG
         leHHO/phHDJ7ovI3yaEmru5CBuopuQU/fu8ZuxDF18Pf6AHM74FhgGJRSLGYxNM0OLeT
         8jEny4cKqAxU3b8r5l6XoEkGdQ9DiwCNTCqpTh15WQD1MS3JqTGu5N738cBLIDbOCR9H
         bqKJJmv5PvrWCEqph2uSH9+C2b5Av2YcihZzVgOhOVwKOFYHYvnsnzzjv9rUOZP6Yjfq
         KupQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWd6hzZVfRKirD1cNEz3j5VNqNUPsj13KBJ5gGV3xkpg3BxP46KbqoebthjmpTJ60N4S5rdhGkre6rlmGHTJOAjSVFIktPhd8DfdE=
X-Gm-Message-State: AOJu0YwOhenJ/6lHHv1CEwpdsoBMVHQ6W8wWF0SwUyEverYpdGeSzhCO
	wxcqMu5rbhBmg3dH5iLsxJnTTcGILt+kdeici9Qmk0uWddRpze8dUdB8sYZCVDMCwhLO8wHpOTH
	/
X-Google-Smtp-Source: AGHT+IH3kgZ4Zl09pwDRB7AnA8wQvb5mzy7AA6ApNsFO3mhzcPiwjhzeFgmA+pU5COSJFEQR1dkXhg==
X-Received: by 2002:a05:6602:2557:b0:7dd:88df:b673 with SMTP id cg23-20020a056602255700b007dd88dfb673mr3209040iob.0.1714748271783;
        Fri, 03 May 2024 07:57:51 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bm10-20020a05663842ca00b004883b81b7e7sm820116jab.28.2024.05.03.07.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 07:57:51 -0700 (PDT)
Message-ID: <b515b17d-f88a-45e5-a854-99856b8f7965@kernel.dk>
Date: Fri, 3 May 2024 08:57:50 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: add a partscan sysfs attribute for disks
To: Christoph Hellwig <hch@lst.de>
Cc: Lennart Poettering <mzxreary@0pointer.de>, linux-block@vger.kernel.org
References: <20240502130033.1958492-1-hch@lst.de>
 <20240502130033.1958492-3-hch@lst.de>
 <6e70dd3f-381c-4435-a523-588ce2fafb39@kernel.dk>
 <20240503081612.GA24407@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240503081612.GA24407@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/24 2:16 AM, Christoph Hellwig wrote:
> On Thu, May 02, 2024 at 11:05:54AM -0600, Jens Axboe wrote:
>> On 5/2/24 7:00 AM, Christoph Hellwig wrote:
>>> This attribute reports if partition scanning is enabled for a given disk.
>>
>> This should, at least, have a reference to Lennart's posting, and
>> honestly a much better commit message as well. There's no reasoning
>> given here at all.
> 
> I'm not sure I can come up with something much better, feel free to
> throw in what you prefer.

Really? You have literally nothing in there! It's good practice to
include reasoning for why the change is being done, particularly in this
case where there's quite strong reasonings for the addition.

>> Maybe even a fixes tag and stable notation?
> 
> This is definitively not a Fixes as nothing it doesn't actually fix
> any code.  It provides a proper interfaces for what was an abuse
> of leaking internal bits out.

I'm looking to bridge the gap between when we yanked the old garbage
interface and now added this one. So yeah it's not a pure fixes, but I
think we should still tie them together somehow so we can do a proper
stable backport of this.

-- 
Jens Axboe

