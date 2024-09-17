Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD518C22
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726577290; cv=none; b=eS6DkKm2t2t3wNEHYC16rjCSeYMbLL66JG2tCemify1qxH9LiJ2l3Rko8i+uv4gjMxNXB8+mScpqqNdZP7I686n4SUKqQYwKoVbn2e9CZQU7DEFUIMe9ULbQPE1adDsux3+FVCjxsVg19RfFpj8er5FQGyjPcAbnkQAxq8P+ILk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726577290; c=relaxed/simple;
	bh=VlegMEh40ZgGWW+TigEg7E5U5Pn+OE+h6sKR36SONvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWd7elh75BVCJAQL2KNqnEZR/a2Pg/8VggkKBQ0q9JG7Q4c/a7v8m/NZJeGgtVTiUAZlBDUZ5T7knlmXqT53OPQbEo7G4vZ0g/0HqiK/SrJmUws2yA63Hk1rUB4tESIX7T9ooaQItPspF8OAIBFRN95UBvpHpVW7mj2/tBDcXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcgPHmeD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcgPHmeD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF884C4CEC5;
	Tue, 17 Sep 2024 12:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726577290;
	bh=VlegMEh40ZgGWW+TigEg7E5U5Pn+OE+h6sKR36SONvo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GcgPHmeDXomYYY0zj/sLb8Mq0ZsPr6P9DpaAzHW8VRlEGSjhgufAc/l57/slalhFy
	 E+SIZAPhe6t/0pi3Jegq4CczTLrZjo4qnCekN/OYoEZ2EV+UHfDyOtYn7XobMIzGNJ
	 xUnu26fBmCxddgUngOQjbhOaZpMxUB2522Xg77aKwuVCXa6HVuz2WeN53r+cPGrxcl
	 vTcM+CPhJIgoB8NN64qK3ihm2ijC98jPfR8Io10vxpYi8++xPvBPLruX7EjvivwZVW
	 fpiV9JBlKvbJm3txcyUpw9TKqvNv9ZF1Z0bCelAlrFo6QnTn6tNLHdWRDm4WbFV6qQ
	 fBybiSJAJcQKw==
Message-ID: <5ff26f49-dea6-4667-ae90-7b61908f67cf@kernel.org>
Date: Tue, 17 Sep 2024 14:48:06 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix elv_iosched_local_module handling of "none"
 scheduler
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Richard W . M . Jones" <rjones@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
 Jiri Jaburek <jjaburek@redhat.com>, Bart Van Assche <bvanassche@acm.org>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20240917053258.128827-1-dlemoal@kernel.org>
 <20240917055331.GA2432@lst.de>
 <CAFj5m9JZe5g07YNVh6BL8ZixabRTrhx-AELxTxFNm9STM7gNzA@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAFj5m9JZe5g07YNVh6BL8ZixabRTrhx-AELxTxFNm9STM7gNzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/09/17 14:33, Ming Lei wrote:
> On Tue, Sep 17, 2024 at 1:53 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Tue, Sep 17, 2024 at 02:32:58PM +0900, Damien Le Moal wrote:
>>> Commit 734e1a860312 ("block: Prevent deadlocks when switching
>>> elevators") introduced the function elv_iosched_load_module() to allow
>>> loading an elevator module outside of elv_iosched_store() with the
>>> target device queue not frozen, to avoid deadlocks. However, the "none"
>>> scheduler does not have a module and as a result,
>>> elv_iosched_load_module() always returns an error when trying to switch
>>> to this valid scheduler.
>>>
>>> Fix this by checking that the requested scheduler is "none" and doing
>>> nothing in that case.
>>
>> The old code before this commit simply ignored the request_module,
>> just as most callers of it do.  I think that's the right approach
>> here as well.
> 
> freeze queue is actually easy to cause deadlock, and old code is to not
> do it everywhere.
> 
> Probably it may be more reliable to replace 'load_module' with 'no_freeze',
> and not to freeze queue in case that 'no_freeze' is set in queue_attr_store().

load_module or whatever the name you prefer, should NOT imply that freezing the
queue is not necessary. Switching the IO scheduler is really one such case.
Switching the scheduler really needs to be done with the queue frozen, but the
scheduler module loading needs to be done with the queue live.

> queue_wb_lat_store() need no_freeze too since there is GFP_KERNEL
> allocation involved.

No, because again the attribute may need to have the queue frozen to correctly
be changed. To avoid hangs, what is needed is to force a GFP_NOIO context before
calling the attribute ->store() operation. Doing so, any memory allocation that
the attribute change may need will not cause re-entry into a frozen queue (which
would result in a hang).

This is easy to do with memalloc_noio_save()/memalloc_noio_restore().

> 
> Thanks,
> 

-- 
Damien Le Moal
Western Digital Research

