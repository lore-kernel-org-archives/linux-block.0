Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242C13BAE4
	for <linux-block@vger.kernel.org>; Thu,  5 Sep 2024 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548284; cv=none; b=Cx9RZAjlgZKOCPMbSCT8jlz0NIKEbIReb6aS/+3C6yQpw4OYwc6HJSV2yL7TUV8w4WL7ZPx3KEIsQ8CF6tl5VH1CAO0URDaQtmZCxdiDcvOmK15FQGlzVAoavUK9x1Q86dlRf+T+Oq+gCLfZkcYWBGOAnzzELmBjmZXZbB0uRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548284; c=relaxed/simple;
	bh=qkdylFrYxPBtqZPts4Ma1yNl5ACuHu6AyhAQ8qAqhik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFDofUHzz3WdOBfjNuyVmSpDcediRHqfJjDO2dPWlPxV1ZJc4a/4UirlylQV+m2FyPIdS0/Bw6WiJep/o/PP0ro+QuiPPS1cXUX3F4xHabBnhRaSxtJTEJhf57QNmwAouHWiVZqHda/BsK4KDpi/FfQvgQ92tnDMrpjudGbMmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Yq/x+7KF; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Yq/x+7KF"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82a73a81074so35316539f.3
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2024 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725548281; x=1726153081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwMSgdKK4T7OWHQ1XHsH47cjyRLdPZGncShDIYZkPQI=;
        b=Yq/x+7KFvvl//dwlJhAzQhZzJ+k/qfKUtJAR2L/3faWxv+9HFMCfSY0Z4t3JQe3UHK
         9Xo4fGMMpnnwJP8KP4C9TEtGV1Ltr/7phu70/wtxlFZ1gPGt07bc5KEtvDhgOGsVaXy4
         ZyKzdH8OJDzz2Te4Jr/pZaZJDMz7nFKy1vf2VUNpHTROu0n2hTkJ7OVjh+1j9/pQWRm0
         XfQGaRDELBUM9DAc9aJYYEhULAaLtiq65XtONT8F3RXuGeROo/6rySP1fvRbhlxIumTC
         tAulZbvmRcmdmfm4yBhsPo+yyIWD7xfDZftdBVcvxi9KYFQBudcUv27kY7ttXYgnAx2c
         loRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725548281; x=1726153081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwMSgdKK4T7OWHQ1XHsH47cjyRLdPZGncShDIYZkPQI=;
        b=LvgLvUmuHppsKIaXmXrFEKawKJA4h8eOK798fn94UlQvDNBxPJ6aHzf9YDAcf1P1/y
         cVSiBu4UvG3Z0I16E20VroPSYb8PwO03RD4dSUTLYnuu5v/cQqn2UbdaLv1ft75usTb5
         MU+43s4pgOXxLG23w3meFVWXg2V7BqlGuaohiqyd0JJPwodIJTBK6XhJtBZahMObxiav
         otIPJzwwUILE/dmdbGd9V3dwokkaJKDoJtFUwHuCe2uxHlxOQ+Ucgq7wIcRXZUNypFra
         55EMi/a8IFsDmibGD+/iCQZ5/iBjmpOMLM3EZzb4fuzreVrpGUilVQTCcNSSxG6gOeuk
         QvvA==
X-Forwarded-Encrypted: i=1; AJvYcCWQWjcfCcp4zpktr7XNGkuGCkhSNslVxoDlw6qryVF/89BnCaQmVdWnMI/2qXLMMbZ22/aQnm3u01GIAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOwhvgIkJEibyCteD7QpHR9+1iWXXk9lMHVtNdgDBlctAeKYvg
	9Dr+Ec4qqZBmcADljsCjXxQNphdUvgf82JM4ahWGDqdSzzpwM1eCrt+jh4dfVDo=
X-Google-Smtp-Source: AGHT+IEsSobY4EdKF2x9XozUrAbLQoax/dmtQHbxkJc6dSyRwnw8LX3DnDLD1VzxuHREHRAA4mjXzA==
X-Received: by 2002:a92:b741:0:b0:39f:5282:3ba5 with SMTP id e9e14a558f8ab-39f52823eb2mr127192325ab.22.1725548280983;
        Thu, 05 Sep 2024 07:58:00 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d04d77c0f8sm1543722173.95.2024.09.05.07.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 07:58:00 -0700 (PDT)
Message-ID: <805c9f7b-49fb-444e-a81d-5b9d457bf262@kernel.dk>
Date: Thu, 5 Sep 2024 08:57:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: move the BFQ io scheduler to orphan state
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Paolo Valente <paolo.valente@unimore.it>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6fe53222-876c-4deb-b4e1-453eb689a9f3@kernel.dk>
 <CAPDyKFoo1m5VXd529cGbAHY24w8hXpA6C9zYh-WU2m2RYXjyYw@mail.gmail.com>
 <d8d1758d-b653-41e3-9d98-d3e6619a85e9@kernel.dk>
 <CAPDyKFp4aPXF6xuuQf6EhGgndv_=91wsT33DgCDZzG6tyqG9ow@mail.gmail.com>
 <dea642a2-85f8-445b-ab84-a07d41acf2e2@kernel.dk>
 <CACRpkdZnc_6T6tQtCDZvWh_QMFqm6OJm+7Dk5A5W8UC5hV95rA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CACRpkdZnc_6T6tQtCDZvWh_QMFqm6OJm+7Dk5A5W8UC5hV95rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/24 7:03 AM, Linus Walleij wrote:
> On Wed, Sep 4, 2024 at 4:07?PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 9/4/24 7:59 AM, Ulf Hansson wrote:
> 
>>>  Surely BFQ is being
>>> used out there, so it would really be a pity if nobody takes good care
>>> of it.
>>
>> Probably not a whole lot I think, at least on the prod side experiences
>> with BFQ haven't been good.
> 
> Which production? For singlequeue devices it is pretty widespread.

We tried it at one point internally at Meta, and it was not pretty. Now
it's just disabled so people don't inadvertently pick it (as some people
like to do when fiddling with things).

> It is used in Fedora, RedHat and SuSE as default scheduler for any
> /dev/sdN, /dev/srN and /dev/mmcblkN (i.e. anything singlequeue).
> 
> Example from my main development machine with Fedora 40:
> $ cat /sys/block/sda/queue/scheduler
> none mq-deadline kyber [bfq]
> Laptop with MMC card reader:
> $ cat /sys/block/mmcblk0/queue/scheduler
> none mq-deadline kyber [bfq]
> 
> Maybe we should propose these rules to the main udev repository
> so that they also go into Debian and we get even wider use?

I know you like to push for it to be the default, and I always push back
because I don't think it's stable enough for that, and now we have the
added complication that it hasn't been maintained for quite a while.
So no, I don't think so.

There are some bugzilla entries too that never got resolved or moved
very far. Some of those may now be invalid, maybe not. Impossible to
know.

-- 
Jens Axboe

