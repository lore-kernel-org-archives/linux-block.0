Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E81917FB
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322186; cv=none; b=bpRMSKY26V2FJaQVjAhWwu5Ei3MFHUCIFQwDe9KI4sGES4P5EJsgjEBleV0zg9YYFVOKx+jigAe3/oaOzFtj18yqrFH2eElpy7OaCo//LGlI6vbXEZsPpetKn3IwUQXroFubsON9omo2ykymFrvkRc3es+z94UnyNTO0wZo/B78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322186; c=relaxed/simple;
	bh=Xp2C0Y9oAvCsCcughH0+h2PMQWW9ZOv2mNOKfFWHfas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fm28SRj8Y9IOFBvnD22x/3yIyB44K1CaJZuBJ3ra6ZBKcdfQiEq/2WXEAs5NeJPVaPRovB0XRIcCXMp5wxZ5basXhBjioxI6yM5tJJcUpH7feRUoiW6yWTCI3uF/8b0v/lXZGFORWoGi3xwyGJg4ruKLiBC85TSvbUYgQGok1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qvdHcbJn; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qvdHcbJn"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d442a77a03so17360995ab.1
        for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742322178; x=1742926978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKP2E1FysZScUULYzm0mXE+4z3JTSIG8YZmNDvW7Ay4=;
        b=qvdHcbJnAd35/ekVVLnK1Reut1qNboq6bX/G9mjxm67qLJuE/l0QKwLBIBBZzvW2/o
         uE9808W+9gIrG4q/rWJWsVN1f3qitil6k1e/FQZMF7JrTgGHBv7WW/cKAoI7pPWYPpow
         oZievUI7G3f1/L/gHm32RK0H2lWbuLsLU0Uo2+egxziB27g6hS02ovi0Kgp24v6goR2u
         5BfzdvTgsE4aHKGxL0huQ9tl8POJckVLBnIsiVlSP3gkawKTYvFnG9Gg4lG0vXU3+Rnk
         dnoGDzr26aHYs8romVZfwv6QkvL9bzr45SIGJDKOBnta/0ikHK9Ne8/jyGdPWArmC9dC
         e6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742322178; x=1742926978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKP2E1FysZScUULYzm0mXE+4z3JTSIG8YZmNDvW7Ay4=;
        b=AMyV2pAE7g7Hcd3KRyTT35OlKP9dgMpnv4rBWaYle9x38/zQPzyrtfREtiUAU3Q/rx
         mXBVjxQnMaK31wvR5fuZfi9L+0NwCu+ZvaeNFIXJ2CmBs/Ly3+fwOntqyJkVGKHrV+Jk
         51RGCk/ePoSLR9E3LzbeUbyZCWn92sZXnhRdOLIqXAJrrzblRrmDCNusgxQUTi/O63F2
         Z3qVxazoOuwSrTdLYvo2mDbaxU9ydiplm9oBY7JH3IoesNQk9DTiMCCZSmYhce7rQ3te
         TDrFyRU3QJxVMT3OksTrtMXnGZByJJkrS8l5XULlgfpO81Bt0pYCrah+qM9tC5+k84Y9
         yQTg==
X-Gm-Message-State: AOJu0YzErEzZ/Dv0+2UUhrafor6o/6Bk+nEBh7zP/+vp11XaTPd0dkGm
	szv3xqE+j7mjstQYMPVfePEkE2+t0l7duzca0kc56t2golh6dddJuK8UnYkcBrc=
X-Gm-Gg: ASbGnctYgwQWNK+Wepk9LgS+AD06Ql4WzHmQWc8c1l8XGxaFtmGsOapQ8YAlZ1rMssy
	EeTUdqUg6xKy+5qAVHKtiRISnLk/oDVwJr8nzuLpLU8P6pn4LB4h6NAX1FZmXBZTe/i4FOPBsZs
	1vxc4tmpCSlURKYYvfZiCK6aXjt6gzNxa20cmXPA+Ap5r/a7/V/cjJMR7lToS8JwHVvijdbIUtr
	O0OCCKVLyu+/puwrefEme6SG8MxpmWdyuqoeIys+GBQFRJYCDRvAm+12dEOr2Y+ua7vMnTHwcVT
	VjHuaOo38/HyvXJy2nueXk3u3CTzJ6iWij6eeS3s1w==
X-Google-Smtp-Source: AGHT+IEyGNkwBM5s6+JUQzqTBbPz/+WZD8nTVLiZ4btFxEykADDQcZxUTat97PvJ6xOBGJ/V9dJrjA==
X-Received: by 2002:a05:6e02:1f04:b0:3d3:fdb8:1792 with SMTP id e9e14a558f8ab-3d483a61c49mr164745605ab.14.1742322178265;
        Tue, 18 Mar 2025 11:22:58 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263702b59sm2826809173.18.2025.03.18.11.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 11:22:57 -0700 (PDT)
Message-ID: <c91dfaf8-d925-4f6d-8ced-06ecb395a360@kernel.dk>
Date: Tue, 18 Mar 2025 12:22:57 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: remove io_cmds list in ublk_queue
To: Uday Shankar <ushankar@purestorage.com>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org
References: <20250318-ublk_io_cmds-v1-1-c1bb74798fef@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250318-ublk_io_cmds-v1-1-c1bb74798fef@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 12:14 PM, Uday Shankar wrote:
> The current I/O dispatch mechanism - queueing I/O by adding it to the
> io_cmds list (and poking task_work as needed), then dispatching it in
> ublk server task context by reversing io_cmds and completing the
> io_uring command associated to each one - was introduced by commit
> 7d4a93176e014 ("ublk_drv: don't forward io commands in reserve order")
> to ensure that the ublk server received I/O in the same order that the
> block layer submitted it to ublk_drv. This mechanism was only needed for
> the "raw" task_work submission mechanism, since the io_uring task work
> wrapper maintains FIFO ordering (using quite a similar mechanism in
> fact). The "raw" task_work submission mechanism is no longer supported
> in ublk_drv as of commit 29dc5d06613f2 ("ublk: kill queuing request by
> task_work_add"), so the explicit llist/reversal is no longer needed - it
> just duplicates logic already present in the underlying io_uring APIs.
> Remove it.

Patch looks good to me, just one followup:

> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2955900ee713c5d8f3cbc2a69f6f6058348e5253..82c9d3d22f0ea5a0fad3f33837fa16146b5af7a9 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -77,8 +77,6 @@
>  	 UBLK_PARAM_TYPE_DMA_ALIGN)
>  
>  struct ublk_rq_data {
> -	struct llist_node node;
> -
>  	struct kref ref;
>  };

Can we get rid of ublk_rq_data then? If it's just a ref thing, I'm sure
we can find an atomic_t of space in struct request and avoid it. Not a
pressing thing, just tossing it out there...

-- 
Jens Axboe
