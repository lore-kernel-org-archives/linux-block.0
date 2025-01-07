Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770B1F4289
	for <linux-block@vger.kernel.org>; Tue,  7 Jan 2025 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284249; cv=none; b=Je9j3ArLDMuXj7FEiYhEsfJd24MfdT14WmLRTxQCUT7Zz878nZYIvWwgsn4ETYVZsf5nemOMy/QJAlhQkvGcUKgB7onknmiie8LqZyc0O+ed+kyX8Q1RRllNYeEMti4eI0/7cdad2acC/68we09gqo0V8Rw/lA5JsnPdQpssVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284249; c=relaxed/simple;
	bh=bfNiDvyyx7qhUityr421yj4aSLY2Rzm0lbZJ4IVYp3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryWMQ4XyhawKn12Lsjkr00k+9xiWrYlvYBv7Rx9PwdyXqfo8e7vErT4hRnn7I216mkKd5os8briPUC8idm2TC+07CkmbQwrKbubM2mDlOnXu05SKP1c550/loUHGdFAw4L/DjM2bgT49kIEbEIqYTYNCmqm5oiEas1c4OLPPACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Bl+19n7t; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Bl+19n7t"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844e55a981dso631765839f.3
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2025 13:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736284246; x=1736889046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83K2XNnz/iqgOoPPg3qHJnPphRK/d4Ei+N3hZFxkUvg=;
        b=Bl+19n7tG/mpFYkLyP3BZDvr3H8sHe9tUBq3og1OYSQHkkFhePRQVDkwiXC4It5vJE
         5UtOyw7G4+m77UpnWdwN/YNER80+nr0c+cP2qGjF4CxEZVa6ATwzfX0n1kbeCkRt0MVs
         fyNW3R70NQKQv75INGCChwKvEA/w0HEI3SIs5s7nRW4JnrNAuRjMujaJTy6hgNAGrIKJ
         F+f4yMX5mOLZYPOySwSU8HGVvr0/5tGzFbWqQRJfEnX3ejcuqpqbNI+pE4JRu7N1cADR
         LDwxjiZSsBS3S4XRhJv8gDNTRjkA74PxPqubHJBEPYV5jnlgGskkLcBdz4m73swCL1fX
         XGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736284246; x=1736889046;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83K2XNnz/iqgOoPPg3qHJnPphRK/d4Ei+N3hZFxkUvg=;
        b=n+qcsD3Sn5ZZ5jKH4RKhWw1nbqPhC8107mvJm7IlYRNrK6A4uKPcJQwgSblAPVQnIZ
         OW8FPwajxy0VQISmM2V/itXgTFT7qHQDSTC5RmSagbPuBgcZybSCEfrnN8L4SGrNVvPA
         6EJdxKT5p2UCgN5kWvspSk6I3HUiT/CZidzDch/7YGCyLo0675q8LQy2JV5h4YSeRtXV
         UpPA5L2ZQfFcTbMtg99lwYjT/h4M0zawdzCiCPpVuycdQB3CP18Lo1jGZ0uZ1edK9dxB
         k3qN3oZMcIe8yrlkuaO3NYUH0eEUb8NliQ3vFSiU4E6ORa3ukV9qX6lWk3KLO8kcgXbx
         aSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy1c5cH5lhYCzbYu7kfKnnFwjdbOP29MUv/2LXaHbXDtVM1VGjprShicpvQWbhbx3nwVwGFG7dhGH5Ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxJvj3PAYBXll3lUQezP2px7tKw+gzFx47BbTPiIKz5711QuXs
	re/NoRSudk0D0ZJIPvqBKTBDsFoLxZcuY8UD+5Sfeb56lzB2iHuXhWTUNRJ+sev51741Hk2ds1V
	P
X-Gm-Gg: ASbGncvBpy1m+jK9Em590E2L+k4HqE6mh6oFlgeg/6rkg8zZhyN9l4AIhkFvDX3Va8B
	gV6EB1mYuji2BVq9LuNtXJ5lSapRlLMYM2/AUj3Hoe7Ihd732ZNp7ah6P/fD8zWzJNIlXoTZtBH
	NDBNWW9X0CwLCrb+ztzGttKd0AvAct4qIsuLFvz/fZIlmNmdd/FUEdRjHrdo3ZwUpN2h+CKgW3n
	6z7q1wRtxV1Jq2vXqxtWwbFrU1sVGBS4aUWpHiAAFyD5akX8lpt
X-Google-Smtp-Source: AGHT+IE7bw3JCpJgyK/qY6da49pYx3FffJxVt+/jAW53C5pXT6psrPGT4mvajowgQ/e9vuLbKH1Qkw==
X-Received: by 2002:a05:6602:378a:b0:843:ec8d:be00 with SMTP id ca18e2360f4ac-84ce018a26bmr50572539f.13.1736284246308;
        Tue, 07 Jan 2025 13:10:46 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf7eaf0sm10136103173.68.2025.01.07.13.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 13:10:45 -0800 (PST)
Message-ID: <4358e12a-066c-4d5b-b686-945843443353@kernel.dk>
Date: Tue, 7 Jan 2025 14:10:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] New zoned loop block device driver
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de>
 <98be988f-5f6a-489d-b0e1-2f783c5b8a32@kernel.dk>
 <20250106153252.GA27739@lst.de>
 <0f2eea00-e5e9-4cd1-8fe6-89ed0c2b262b@kernel.dk>
 <20250106154433.GA28074@lst.de>
 <5f57ff26-2c87-45fa-bb91-4f68492bac85@kernel.dk>
 <20250106180527.GA31190@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250106180527.GA31190@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/25 11:05 AM, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 10:38:24AM -0700, Jens Axboe wrote:
>>> just not on the same page.  I don't know anything existing and usable,
>>> maybe I've just not found it?
>>
>> Not that I'm aware of, it was just a suggestion/thought that we could
>> utilize an existing driver for this, rather than have a separate one.
>> Yes the proposed one is pretty simple and not large, and maintaining it
>> isn't a big deal, but it's still a new driver and hence why I was asking
>> "why can't we just use ublk for this". That also keeps the code mostly
>> in userspace which is nice, rather than needing kernel changes for new
>> features, changes, etc.
> 
> Well, the reason to do a kernel driver rather than a ublk back end
> boils down to a few things:
> 
>  - writing highly concurrent code is actually a lot simpler in the kernel
>    than in userspace because we have the right primitives for it
>  - these primitives tend to actually be a lot faster than those available
>    in glibc as well

That's certainly true.

>  - the double context switch into the kernel and back for a ublk device
>    backed by a file system will actually show up for some xfstests that
>    do a lot of synchronous ops

Like I replied to Damien, that's mostly a bogus argument. If you're
doing sync stuff, you can do that with a single system call. If you're
building up depth, then it doesn't matter.

>  - having an in-tree kernel driver that you just configure / unconfigure
>    from the shell is a lot easier to use than a daemon that needs to
>    be running.  Especially from xfstests or other test suites that do
>    a lot of per-test setup and teardown

This is always true when it's a new piece of userspace, but not
necessarily true once the use case has been established.

>  - the kernel actually has really nice infrastructure for block drivers.
>    I'm pretty sure doing this in userspace would actually be more
>    code, while being harder to use and lower performance.

That's very handwavy...

> So we could go both ways, but the kernel version was pretty obviously
> the preferred one to me.  Maybe that's a little biasses by doing a lot
> of kernel work, and having run into a lot of problems and performance
> issues with the SCSI target user backend lately.

Sure, that is understandable.

-- 
Jens Axboe
