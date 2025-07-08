Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06FC1C8632
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988746; cv=none; b=O8lp1tw/xRs5YNzn5K+bSu73v361QVwTELy/gegRSiVDluy8j5kb1AjyJ8l7870j1+HojPBYBJBQdEc1tPTg7jn/n54D0ybmqYG6Lgcq+dVmGiouhel6lNv4v535fMg49ZLsxw8m80nm8ehjrdQZsptVYlXO4N1SysUip/pumHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988746; c=relaxed/simple;
	bh=tGfGh9c2UzTqwWh1vwi2rPoQL2/OkL4qtzqx7hgAWHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gi0dtCUGQvoMsWnNC5kYoMaWQy7WwFYqhEbw6unOWAwoQ2osvYPUEtuLZTW5EukEefEnZ3hs/x9vh9/94zTQbGb/G+P0+mzgQMP4anMScVavRa5rSjGk4p2lhLQvk1eARqFAgYjj1Jrir09bF4QtAvdSav7hsy2kK2ya+Hy2Gm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ffvTqqUj; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ffvTqqUj"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3de18fde9cfso27520415ab.3
        for <linux-block@vger.kernel.org>; Tue, 08 Jul 2025 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751988742; x=1752593542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZWmeRm3Kcd5Lu3tbKrd+XxI6nkcaZVcZ+1ITj/1BMY=;
        b=ffvTqqUj2188kJv4KSZ8rOPfRv+XhNwopEm71biUkHzZVhqkr6tzLi7OQDpkpfUb1F
         1+r1Tdh0wRC8NQhoyr08pWL/HqagY2dk2hLHgX0dp5pCm3251rIyR04vw4YvyPfOG4bM
         l720SPBcKMM9pzLoqSNKH6OSj8vV5MpW1fXjpfQhJ5M/Qg8iwqrXcfWshUzmbc9fYSCw
         CBURQNbZB2C8zFjuma+qtYXFMwU2zUrEuDjAF2+z69Ejlwu79+sW62tTm9kdw17wEzly
         NqBrn9GvKvh0cX6y3lWloK+nkC6aAVzwJJhQFGSDoiReN7ZFEmXALJ7nsD5Wg92z4aLg
         Q/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751988742; x=1752593542;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZWmeRm3Kcd5Lu3tbKrd+XxI6nkcaZVcZ+1ITj/1BMY=;
        b=bcs2KpmRLm/YAvG1hWcOlTiQRwZj9B+nHFKDrefn976xOiUED4Df9k6z0LJTDa58Qu
         e4DX4iKv+ukhujwi5mLZfSmo2Oz1d4GfdwFosLnz65Eywv7VsyQF5XcUZ04wcoySmk1J
         4inTDjoygbbzyw2d/kZ8KnUR83ipHfvss7o3mAKVC82volxOyqPMeBBwk5faqFlny6Hr
         keT7ecl9gP7vT+yyLf8+KVolahMOZwjDIcW2hIgaAJxqC0j0FJoh7VXlLaNXMJTUW+cm
         0Kg9o0SEUVQUrGW1gU9HsCIQqILTjSy+xZotVs7OBJU6+Vn++LWT4+5OqydArkGYn8IW
         U+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCW8j2EgewWEZ3YKyAjTu1Q0fBm9b2cZfXzCNSxWH+ADK2zQemdN2DBSPmQIqWYiFOC9bmjP4uIiTrtqvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjzjikBiV/SPqaoeMci+xt5zaZsyqqs75Ylyz/UtbYl5SO52ay
	QjlpJ0Abdd6wgZ+L4JKJmDm/1tEAlnlQMauJDyxrcm2OaTmwJOYNUAgHZp/5SC07v6s=
X-Gm-Gg: ASbGnctUIeIfbauPqD81ip3dDtQ0P+D080wS7BNzclfO1n1B4tK8A8kGo+OQrSHA4yb
	woubb0jK+i1e09Lf0X8mF3vrc03ABisNlFH5Ar8vJtpeWDjEDs3zjhf0AN4FwDdjFqDnrWfAxy9
	wfrhhCG0LT/XCf6qtHWhpSrX1jrBa+EhFMuG5PaU+Prub2KT0YHeL2h/Jcz+B9EH2ayoIlmn/pn
	hYgC4NJkl1px8FwwcvLMkbIu6C5e3ihQQzErgw8X2EIpQUqLdPal/4hDF9H1Y2VWo6EsEtbc5Y9
	Zhz5jvtVGDKBqnvROmn3fi/Zvd9oiRe+Q61rPBXPKI0n0dydt11RwHxfZrA=
X-Google-Smtp-Source: AGHT+IF74BoqvYr1m5U/CIBiWzSBsfRr8+ncgQC7M4gVnHX4HZ+TVCWSBJ0MvtLv+xjPYa/ft18vDQ==
X-Received: by 2002:a05:6602:3e8c:b0:873:1a0e:a496 with SMTP id ca18e2360f4ac-876e491e3c9mr1327548039f.10.1751988740837;
        Tue, 08 Jul 2025 08:32:20 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-876e085968bsm297101939f.38.2025.07.08.08.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:32:20 -0700 (PDT)
Message-ID: <ce06bf7b-d916-4ee8-af4c-3af5f7959b42@kernel.dk>
Date: Tue, 8 Jul 2025 09:32:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1107479: util-linux: blkid hangs forever after inserting a
 DVD-RAM
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ben Hutchings <benh@debian.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 1107479@bugs.debian.org, Roland Sommer <r.sommer@gmx.de>,
 Chris Hofstaedtler <zeha@debian.org>, linux-block@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Salvatore Bonaccorso <carnil@debian.org>
References: <whjbzs4o3zjgnvbr2p6wkafrqllgfmyrd63xlanhodhtklrejk@pnuxnfxvlwz5>
 <1N4hzj-1uuA3Z1OEh-00rhJD@mail.gmx.net>
 <iry3mdm2bpp2mvteytiiq3umfwfdaoph5oe345yxjx4lujym2f@2p4raxmq2f4i>
 <1MSc1L-1uKBoQ15kv-00Qx9T@mail.gmx.net>
 <aif2stfl4o6unvjn7rqwbqam2v2ntr35ik5e24jdkwvixm3hj4@d3equy4z4xjk>
 <1ML9yc-1uEpgp2oMs-00Se3k@mail.gmx.net>
 <174936596275.4210.3207965727369251912.reportbug@pc14.home.lan>
 <r253lpckktygniuxobkvgozgoslccov6i5slr5lxa7oev6gtgy@ygqjea7c6xlm>
 <e45a49a4e9656cf892e81cc12328b0983b4ef1da.camel@debian.org>
 <2ba14daf-6733-4d4b-9391-9b1512577f15@kernel.dk>
 <aG0CmhnEHGtUEkWz@black.fi.intel.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <aG0CmhnEHGtUEkWz@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/25 5:35 AM, Andy Shevchenko wrote:
> On Wed, Jul 02, 2025 at 05:13:45PM -0600, Jens Axboe wrote:
>> On 7/2/25 5:08 PM, Ben Hutchings wrote:
>>> On Sun, 2025-06-29 at 12:26 +0200, Uwe Kleine-K?nig wrote:
>>>> On Sun, Jun 29, 2025 at 11:46:00AM +0200, Roland Sommer wrote:
>>>>
>>>> Huh, how did I manage that (rhetorical question)? Thanks
>>>>
>>>>>> Ahh, now that makes sense. pktsetup calls `/sbin/modprobe pktcdvd`
>>>>>> explicitly, the blacklist entry doesn't help for that. Without the
>>>>>> kernel module renamed, does the 2nd DVD-RAM result in the blocking
>>>>>> behaviour?
>>>>>
>>>>> Yes.
>>>>
>>>> OK, that makes sense. So udev does in this order:
>>>>
>>>>  - auto-load the module (which is suppressed with the backlist entry)
>>>>  - call blkid (which blocks if the module is loaded)
>>>>  - call pktsetup (which loads the module even in presence of the
>>>>    blacklist entry).
>>> [...]
>>>
>>> I tested with a CD-RW, and the behaviour was slightly different:
>>>
>>> - Nothing automtically created a pktcdvd device, so blkid initially
>>> worked with a CD-RW inserted and the pktcdvd modules loaded.
>>> - After running pktsetup to create the block device /dev/pktcdvd/0,
>>> blkid and any other program attempting to open that device hung.
>>>
>>> My conslusion is that pktcdvd is eqaully broken for CD-RWs.
>>
>> Not surprising. Maybe we should take another stab at killing it
>> from the kernel.
> 
> In the commit 4b83e99ee709 ("Revert "pktcdvd: remove driver."") you
> wrote that we would wait for better user space solution is developed.
> Any news there?
> 
> Just asking (I'm in favour to kill the old fart) as you haven't
> mentioned that in a new attempt.

No work has been done there, to my knowledge. But as the current driver
is totally broken and people aren't even complaining about that (outside
of running into that for unrelated reasons), I don't think there's any
reason for keeping the driver in-tree.

-- 
Jens Axboe
