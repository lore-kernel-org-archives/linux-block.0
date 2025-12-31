Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C32BDC32
	for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202580; cv=none; b=kc+Wjj7EKhTxs/FBi1sbSjkHhcT0cUyqNdC6ia27nEgfgQ9KH4AdyA7P+HNpKTLCIONZ6dmEpcUqUHEJhZFW0UUljuYxRuan2VM5bEl/+IlDc0WS0YQE1o8XDjLlYAQ/U+WF2qVNdSQ8vBzYFIi1uv9Rr+4oJH+kkXtSYnCcmIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202580; c=relaxed/simple;
	bh=Umu9Z5T6MB1JXXj1jGYkaLwvHPYFQEVFOey4XNHOi0s=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IKUpDcT/4ro7QMy1DD1we/8uVcvG5b2moXGDxKgTk3RgYUUgZfqtdY2sRbGtwMYWo8c2PjmOKluL4zAFHOYrYH/JGT+acUjOxvnxowHBK5+qaboAd2qSNp6dS+tPMmoSUBxlaUPRMY1s7rYn4tS5d/zmJegBzgDx1Pgj1f+DlyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUaCXPC0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cti02kjO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUaCXPC0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cti02kjO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767202575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+hPaZspsreAv3BlbsaDeG27kbGxsQkCDH5b5xlUDn0=;
	b=dUaCXPC00STyPH5dRgaZrCDA6oegajlm3h5WhS69DffIGceHIdORvuBCtq8RLiz1jvvEE4
	ts6KOuwujVqq9PNtCY4J/PfYTbVVRQVIxgIHkTKPSPYrZdvCQTdwgfrpUqJTiJL99Lbvx1
	jAM2qkE/WDXb24v4g7cRkj6mBAL72Sw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-aYMIxsKUOWmEEUYaW5a8Jw-1; Wed, 31 Dec 2025 12:36:13 -0500
X-MC-Unique: aYMIxsKUOWmEEUYaW5a8Jw-1
X-Mimecast-MFC-AGG-ID: aYMIxsKUOWmEEUYaW5a8Jw_1767202572
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b9b9e8b0812so18672364a12.0
        for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 09:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767202564; x=1767807364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D+hPaZspsreAv3BlbsaDeG27kbGxsQkCDH5b5xlUDn0=;
        b=Cti02kjO/vgsLYU4FS/iI8NjqcKbjB56kjURtridVO3ayOiDjBxg8pdBjsIisF/WOh
         xqXbYXyJON1ojfFoxF6BtzA6LhBZ/hJAHFmCUyaoMGjUXq/A+1BBiHwmsy2yt5Gfvo4T
         B2D50vU6f9233HSk9+dJiEBbBUwXG5lre/xfzhN0/fKMdYinzINCUIJFROTydHoxPKmB
         z11gigJEhjmgkv7BMr5JuHzYLCEF08iqkAtP03sBME6qtMho30QosEKBy7pq8zJQ6Rch
         2LfHjkuaQcxejJwGs3De5GLlYtFHU8im9mIlKcHSriDMWjhTRFvmBzAEq1xKzaXPDB++
         asWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202564; x=1767807364;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+hPaZspsreAv3BlbsaDeG27kbGxsQkCDH5b5xlUDn0=;
        b=imS/F7zh18mH84AhzrtM75aaRV6XCA7tJBPw72lBbveGWmq+FYWJuddLOXWohmb2oz
         VO1HKOFZg3izb4zx9cjujTofQ27xmzukeWmt6Z4xHy7p8ca1iEguvamrd4NohzsjeFDN
         +rORhQrHCJKzy96xIOg7KeAi3ZWso7jL6DLFGqEPfX/pg/IdN5FjCDA5gjTfLfTsITBd
         2zT6e+nMUtUP15Fb9aqFTeu2B3uFi+WnhDzssPn3rwfyEL4U9a+ftzJUQ6fXaXY3sH4y
         Sljf1a+7UDu7CPp+z4g3B7Q50P9scNh1aCFVJ1NXnqKV740yoQ++BM+INLcfoZVOGKNE
         1cdA==
X-Forwarded-Encrypted: i=1; AJvYcCUx5ZhBqIJxjAJHDD8EXj4oi4dX5i5bRJd4jWulyZsHQGDey6X7idCjnvd6JmJ+sMV5akniNyQgtBmnnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyP69oDZgDeD/4y+/5/gQe6rR3FOMWYQ0nC/zrF/iQNdtR79+2l
	uY2DwfQy65m9wJ1q0/BV+Tu2ZrfDnIPrhRGP4U3KuxHS8w+DW1Ihok5MOBxDp4a9s+gNCZVpQTZ
	8OLTqERaM4eGQTb3Ylyimz3mYn7C5GJiDPtKI+7eLgyhzpkhboxMKOMbBR98fOmfe
X-Gm-Gg: AY/fxX6JXDGq3q+llxkAPzCtjrKPrZAjGMsDwvHP7SwJboQlKQw2bkMVVlN5CDolusA
	XHSeQKOHhV/0D4zBYeil/I0feUll7jNpspH+c8nxW4LhKTK44hA5Ia60b6xY2LcFprQWkzTWgCB
	eoPkA8YAlZlwWlTTownDm3gf3Nq6sVuFUMGm4bnOwAWA8U5vsWVl/CUQ/UVzzEtf0S0poyeIVIi
	L0uS5wWdE9Z7ZZW7Pqs8P1Xv+RgRFVZFKEmV9bHse4EmIj0o6F7DGyPUcs5ir/X+OQqfu8coewC
	9k4fHQ7ytLZlsgP+UPy0dAQPidDXXoVtbRRnj9G995Cms6HquVTyOIIeQ6iEE5/TFOryycLzou8
	2efYBTH7tukpOkF7lvi5hI/Ln85lfg0Lhcq2w4wwygrT8NBSz
X-Received: by 2002:a05:7022:6722:b0:11d:f464:38b3 with SMTP id a92af1059eb24-121722a9757mr33784143c88.2.1767202564074;
        Wed, 31 Dec 2025 09:36:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi3paBF328Dvc54FaF7ePmfKoOt8e8CqfUvXWomZaBGFhC0nmzfA+IqOZP166rR45yxweuTA==
X-Received: by 2002:a05:7022:6722:b0:11d:f464:38b3 with SMTP id a92af1059eb24-121722a9757mr33784129c88.2.1767202563623;
        Wed, 31 Dec 2025 09:36:03 -0800 (PST)
Received: from [10.61.55.87] (syn-184-074-098-043.biz.spectrum.com. [184.74.98.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ff8634csm87792829eec.3.2025.12.31.09.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 09:36:03 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f4228e20-62ff-4701-b6ce-59c99188d7b5@redhat.com>
Date: Wed, 31 Dec 2025 12:35:49 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] doc: Add housekeeping documentation
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-34-frederic@kernel.org>
 <370149fc-1624-4a16-ac47-dd9b2dd0ed29@redhat.com>
 <aVVAfb2eaeyd7l-h@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aVVAfb2eaeyd7l-h@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/31/25 10:25 AM, Frederic Weisbecker wrote:
> Le Fri, Dec 26, 2025 at 07:39:28PM -0500, Waiman Long a écrit :
>> On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>> ---
>>>    Documentation/core-api/housekeeping.rst | 111 ++++++++++++++++++++++++
>>>    Documentation/core-api/index.rst        |   1 +
>>>    2 files changed, 112 insertions(+)
>>>    create mode 100644 Documentation/core-api/housekeeping.rst
>>>
>>> diff --git a/Documentation/core-api/housekeeping.rst b/Documentation/core-api/housekeeping.rst
>>> new file mode 100644
>>> index 000000000000..e5417302774c
>>> --- /dev/null
>>> +++ b/Documentation/core-api/housekeeping.rst
>>> @@ -0,0 +1,111 @@
>>> +======================================
>>> +Housekeeping
>>> +======================================
>>> +
>>> +
>>> +CPU Isolation moves away kernel work that may otherwise run on any CPU.
>>> +The purpose of its related features is to reduce the OS jitter that some
>>> +extreme workloads can't stand, such as in some DPDK usecases.
>> Nit: "usecases" => "use cases"
> Are you sure? I'm not a native speaker but at least the kernel
> has established its use:
>
> $ git grep usecase | wc -l
> 517
"usecase" is not a proper word by itself, but people do use it some times.
$ git grep "use case" | wc -l
694

Anyway, you can keep it if you want. It is not something that is worth 
arguing for. :-)

Cheers,
Longman

