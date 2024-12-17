Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971411F758B
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465495; cv=none; b=GvyOYbttHmIogzbEVoRFXo252d3nL8HzuoBcW+qtUVmyQ37wrOnQOqltk+ilU67ny7MJYqh53i93yUYZRy6nPH0Kj0rUIk3tVbT/pgoMI/Yh31u3PF1cO5+8Zxd3gbWCoDrZ0rMIPbxVhXwxdZv8bxIM3YfvCKR44DdYHRv8EtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465495; c=relaxed/simple;
	bh=UnvBIXC3ldkNp7evp6fGMPhmh8+yi3fB7ajmH6+6BQQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VIdnnULVZQ1a9gRXzPU0TZIAgo9aI73SB9Q2AzyI/fCXidPmV3YCqZ2rEbBWR1riLyo3tYQAdf6B3zn59KoKuW1ekbZM9xCOY3XfKf1qtWS5KujW20aBgRAU0y7H8QMpqOFRN4Q4+0+bb65m+yuesavyCz13Q+nuXOVWqeWgXg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xRWzzOn5; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xRWzzOn5"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a7e108b491so48527005ab.3
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 11:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734465493; x=1735070293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+tnT2q6KuOf3Nam94RIaXeeFc2nOYRoOvjzUKW8b+9o=;
        b=xRWzzOn5d/6KXOMIq47JaQpCnfszkshxAzQ1KfCkU0g0cZu3KJ4iemfoLdyxzTlpvQ
         cTo06Kj/RtII+zRsSeJq3v8jdJ4bVQdDjbj8hb1t47y4nJKHW06qLjKrU1cKtmyrBM1b
         bF7iyaecM8E1EpoB90RdQmMbOM/WesjB0NxVlZX6pLQGOm8QWow6GNCN92URV8jiyvXX
         Havc8zoUfwNBifmmZPCSRWLDguJ5wNc/iomKm4Rma7GnXi+fYznrvVvDJ4KmmfxYou3o
         PegPg+ecIsglNFFFZf+tLKVCAB1euFTk04k//zByCuCqr0T20CRWToVOozuXa1dTTmsW
         j9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734465493; x=1735070293;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tnT2q6KuOf3Nam94RIaXeeFc2nOYRoOvjzUKW8b+9o=;
        b=UZBF1AyiJkKaxGcX3ozOiGhrqBk899TKbpNq/hX9Drw2EFLaLMiaaBi7QmnC2l2G81
         Lu8Qmk6hLrqjz23uFvfeMoLBYcmFnG6hNQICz5SpJ66u/cHDzd18eZQFhV+Zo7YnAqE0
         pTu0VzGwQ0VhQ8fNB4gMkVLfAfkHji5tYm8G9avYSslruMGnekGwSnEpq+/AW1SIDre/
         AvaGMdG26nMwlpenPE/f5z+6Um0x5Ov7k2Sk41fJdmd1zVlVtGjFaIo+hLT4ZjAwB1A+
         vz8FvmucDqp864a0ZlzZEqRQCKBSgOuj5s5M2PL9xpbGs5apPVfATT1fu3rnepIA7H6l
         lmLQ==
X-Gm-Message-State: AOJu0YxXVdeFbq06sJnTn9h9Tcggp+tVzbnUiHEGUWZjUqhcU/SUoWSm
	io4BBs8mrmE+UCZ7nugALO0yaVSYIFvRwmjUtbu7aKqFsGpU8dD2REL+3FxvOy0=
X-Gm-Gg: ASbGncv6GOvhx6pQ6IH4//CVxAEP6TaxUNyQNdWas9zhoTrp/P098z4QYTRQgWr7XB0
	4SQDoYcVRrfO2fTHgDeM6mkvQ3PblJJFrW9eXeCKRcVpwVVwwQ0vXgv4msH23qqlV8GreIvGTBg
	pZ7gLQomeyu5B/IDCohu5aBkdlOdZOvgsgyAKivOKFMlioTAW3uhLgwrdwiMbZtdu5hBBZ7Eqxw
	Tm0oQWYizgyWmdw7MjpfQiQLipMoWeDkTGAHkseikVdpOhsJRI0
X-Google-Smtp-Source: AGHT+IHTf2IGPqpm1ry8cilRlQcSbbBbsJpf/oWPzJS34G/Jk4VY4IjGJnspIcRDvESzbHJhBMrOHQ==
X-Received: by 2002:a05:6e02:1d11:b0:3a7:6e97:9877 with SMTP id e9e14a558f8ab-3bdc5b99a46mr2713695ab.24.1734465492741;
        Tue, 17 Dec 2024 11:58:12 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e378ceb9sm1810285173.136.2024.12.17.11.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 11:58:12 -0800 (PST)
Message-ID: <fb292dc8-7092-45c1-ae8a-fca1d61c6c9a@kernel.dk>
Date: Tue, 17 Dec 2024 12:58:11 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
From: Jens Axboe <axboe@kernel.dk>
To: Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche
 <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <20241217041515.GA15100@lst.de>
 <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
 <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
 <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
 <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
 <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
 <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org>
 <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org>
 <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk>
 <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org>
 <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk>
 <f41ffec1-9d05-47ed-bb0e-2c66136298b6@kernel.org>
 <e299e652-2904-417c-9f76-b7aec5fd066b@kernel.dk>
Content-Language: en-US
In-Reply-To: <e299e652-2904-417c-9f76-b7aec5fd066b@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 12:54 PM, Jens Axboe wrote:
> io_uring does support ordering writes - not because of zoning, but to
> avoid buffered writes being spread over a bunch of threads and hence
> just hammering the inode mutex rather than doing actual useful work. You
> could potentially use that. Then all pending writes for that inode would
> be ordered, even if punted to io-wq.

See io_uring/io_uring.c:io_prep_async_work(), which is called when an IO
is added for io-wq execution, io_wq_hash_work() makes sure it'll be
ordered. However, this will still not work if you're driving beyond the
limit of the device queue depth, or if you're doing IOs that may trigger
-EAGAIN spuriously for -EAGAIN as you can still have two issuers - the
task itself submitting IO, and the one io-wq worker tasked with doing
blocking writes on this zoned device.

At the end of the day, expecting device side ordering and allowing > 1
in QD will always be inherently broken for zoned devices imho. Just
don't do that... If you allow that and expect ordering, you're always
going to be chasing cases where it breaks.

-- 
Jens Axboe
