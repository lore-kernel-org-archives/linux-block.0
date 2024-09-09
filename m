Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86BA193
	for <linux-block@vger.kernel.org>; Mon,  9 Sep 2024 01:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725847012; cv=none; b=ujKlXw/YnJwh9J4EOWcpkas+snNJuB6jZYmNiFlPaNHFaloPV/1lpioEHFFGcLoHmqDZlMn+0MUR6ntVLUnHErNQENJstRRk7FdqvH2J+dJxMcFCXv3VGvUuDPV3HHf3EhSpacPY18l44Oa+uwWJdx2RRLBp1Pcql7ZAlAnt3hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725847012; c=relaxed/simple;
	bh=D2jk+6RJ4ARoiWSwO5zNzdViMCvGO6AEnBmhXrgAPmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzCIGzrK3SU1X327q158jS0klW7M1SfIqqyQXxS8B9MkoespCee7/cvAiAqX2Xaug9hKuRqlDYjaTut4CupteT4qX6C9pC/tWVlNZMVTCxaNCOacZDKWNtLjUnLZPW2GeEZFsa3kFvapHebqZfbtPXAaMPOb2Dtu7fefkndxSLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzPWr9kz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzPWr9kz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDF2C4CEC3;
	Mon,  9 Sep 2024 01:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725847012;
	bh=D2jk+6RJ4ARoiWSwO5zNzdViMCvGO6AEnBmhXrgAPmY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PzPWr9kzZfHiQ+rSqbBPpWJpWCfh/H1kmkRE3NiqJedR0PVpYGFvwbwNU3Ld8enL2
	 9HAodFauQRol51K3r8AdD0reDvdSb718qw1FmWAl2HfhdBySArRTNINwSRN5+SkEMI
	 L/Dvnh6ukLD0r3khByEuyV7E4uGwzQkKlWJUarqUMbTe1gqQ6uY22ztCPaYZOSFGc6
	 OLafw46xJ5Sb3uf/Nb1DZkeynsXgX49sBJ3WSKsnfCdIccjJSoiDn1DVh3KiQcsc6M
	 f9phs08kxRKMNsSPUNVa4jWYglT1E3hRKlszQWtrJBLbllxy67p1A0yo1QkgIzPSS0
	 QKYke5jeqk3ew==
Message-ID: <7ab499df-f888-4d17-8a29-3f64f17ff71c@kernel.org>
Date: Mon, 9 Sep 2024 10:56:49 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: elevator: avoid to load iosched module from this
 disk
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, linux-block@vger.kernel.org,
 Jeff Moyer <jmoyer@redhat.com>, Jiri Jaburek <jjaburek@redhat.com>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20240907014331.176152-1-ming.lei@redhat.com>
 <20240907073522.GW1450@redhat.com> <ZtwHwTh6FYn+WnGD@fedora>
 <4d7280eb-7f26-4652-a1d4-4f82c4d99a4c@kernel.org>
 <c8fd6c9b-67a7-4cc5-b4e5-c615c37f6b4e@kernel.dk> <Zt5OaPCvM5XC44vc@fedora>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Zt5OaPCvM5XC44vc@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/24 10:24, Ming Lei wrote:
> On Sat, Sep 07, 2024 at 07:50:32AM -0600, Jens Axboe wrote:
>> On 9/7/24 3:04 AM, Damien Le Moal wrote:
>>> On 9/7/24 16:58, Ming Lei wrote:
>>>> On Sat, Sep 07, 2024 at 08:35:22AM +0100, Richard W.M. Jones wrote:
>>>>> On Sat, Sep 07, 2024 at 09:43:31AM +0800, Ming Lei wrote:
>>>>>> When switching io scheduler via sysfs, 'request_module' may be called
>>>>>> if the specified scheduler doesn't exist.
>>>>>>
>>>>>> This was has deadlock risk because the module may be stored on FS behind
>>>>>> our disk since request queue is frozen before switching its elevator.
>>>>>>
>>>>>> Fix it by returning -EDEADLK in case that the disk is claimed, which
>>>>>> can be thought as one signal that the disk is mounted.
>>>>>>
>>>>>> Some distributions(Fedora) simulates the original kernel command line of
>>>>>> 'elevator=foo' via 'echo foo > /sys/block/$DISK/queue/scheduler', and boot
>>>>>> hang is triggered.
>>>>>>
>>>>>> Cc: Richard Jones <rjones@redhat.com>
>>>>>> Cc: Jeff Moyer <jmoyer@redhat.com>
>>>>>> Cc: Jiri Jaburek <jjaburek@redhat.com>
>>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>>>>
>>>>> I'd suggest also:
>>>>>
>>>>> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=219166
>>>>> Reported-by: Richard W.M. Jones <rjones@redhat.com>
>>>>> Reported-by: Jiri Jaburek <jjaburek@redhat.com>
>>>>> Tested-by: Richard W.M. Jones <rjones@redhat.com>
>>>>>
>>>>> So I have tested this patch and it does fix the issue, at the possible
>>>>> cost that now setting the scheduler can fail:
>>>>>
>>>>>   + for f in /sys/block/{h,s,ub,v}d*/queue/scheduler
>>>>>   + echo noop
>>>>>   /init: line 109: echo: write error: Resource deadlock avoided
>>>>>
>>>>> (I know I'm setting it to an impossible value here, but this could
>>>>> also happen when setting it to a valid one.)
>>>>
>>>> Actually in most of dist, io-schedulers are built-in, so request_module
>>>> is just a nop, but meta IO must be started.
>>>>
>>>>>
>>>>> Since almost no one checks the result of 'echo foo > /sys/...'  that
>>>>> would probably mean that sometimes a desired setting is silently not
>>>>> set.
>>>>
>>>> As I mentioned, io-schedulers are built-in for most of dist, so
>>>> request_module isn't called in case of one valid io-sched.
>>>>
>>>>>
>>>>> Also I bisected this bug yesterday and found it was caused by (or,
>>>>> more likely, exposed by):
>>>>>
>>>>>   commit af2814149883e2c1851866ea2afcd8eadc040f79
>>>>>   Author: Christoph Hellwig <hch@lst.de>
>>>>>   Date:   Mon Jun 17 08:04:38 2024 +0200
>>>>>
>>>>>     block: freeze the queue in queue_attr_store
>>>>>     
>>>>>     queue_attr_store updates attributes used to control generating I/O, and
>>>>>     can cause malformed bios if changed with I/O in flight.  Freeze the queue
>>>>>     in common code instead of adding it to almost every attribute.
>>>>>
>>>>> Reverting this commit on top of git head also fixes the problem.
>>>>>
>>>>> Why did this commit expose the problem?
>>>>
>>>> That is really the 1st bad commit which moves queue freezing before
>>>> calling request_module(), originally we won't freeze queue until
>>>> we have to do it.
>>>>
>>>> Another candidate fix is to revert it, or at least not do it
>>>> for storing elevator attribute.
>>>
>>> I do not think that reverting is acceptable. Rather, a proper fix would simply
>>> be to do the request_module() before freezing the queue.
>>> Something like below should work (totally untested and that may be overkill).
>>
>> I like this approach, but let's please call it something descriptive
>> like "load_module" or something like that.
> 
> But 'load_module' is too specific as interface, and we just only have
> one case which need to load module exactly.
> 
> I guess there may be same risk in queue_wb_lat_store() which calls into
> GFP_KERNEL allocation which implies direct reclaim & IO.

That needs to be changed to GFP_NOIO.

> 
> Thanks,
> Ming
> 

-- 
Damien Le Moal
Western Digital Research

