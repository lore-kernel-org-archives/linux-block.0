Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F61EDA2B
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 04:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750826153; cv=none; b=CtS9tqOiORWa9RDC7wZkuZvYzE0rk4rpdJZ0ipz0LY0RiMScW+8ZZA6AZmSBzJpnQ3xrbJUyZwVuSJyvkhyc5OHRLlxiKaDvBk3dFV4PqYgz4RvQGJGaSjC/OlCDYbfD2sBTulFC2AOh4wwoR4eLSvfYANbEm9Ljsvl5Eap+hfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750826153; c=relaxed/simple;
	bh=DaT/Z9Sok3cNWnvvMcQs+MKnfbHbG1bIDuXp/op2hFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHBSYTTAUcqnFyvqHSJiWEtaDj+7MWWEmhVTthelUkRLCphdiLywN3tTa39vv1mw6NNBVs0bEPY9ysOFjaIyEekoxq3dgvlOE32dIChLCPu/CWuewRoRF31GD+H6+XWaJcc/PGwQChmkikzL48jPh4Om+DYVTvT/btw/rQZ9nMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz0byWZ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz0byWZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D9FC4CEEA;
	Wed, 25 Jun 2025 04:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750826152;
	bh=DaT/Z9Sok3cNWnvvMcQs+MKnfbHbG1bIDuXp/op2hFg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iz0byWZ5zmEZbGh9O9nGO/MGOIr+XFE6CtkFJo5GwPq+8ZFpoBz8SQX28LSQz9Bw+
	 0OOvhhbOOLY4y2Q9LO2Yc82rxEaszYy0S5JT8WjbdDf9aBpZsD5YDLz5z/+s/JhpLE
	 4zxH2i9OLu0iMKlqG3/LpHpibSuBpSnekmsnJEIyA9czP5Da0Q6SE6KZbsBuQjgmuI
	 gMRFa3+GnlZhPk+ilsbXhVOjvbjbf9CBMtInjm7Jyy7XBp0AOnuT3/lJOA4+P4MT1L
	 nYb7+7Gsv6w2whnibiZS1K0uXRNRPnLvZTNQPFdcj/qS7xDeUF5mBxGaYA3EYToVLz
	 o0Ngboz2XiE9Q==
Message-ID: <f4015fa0-cce8-4b00-a2a0-ff5a9c914e9b@kernel.org>
Date: Wed, 25 Jun 2025 13:33:48 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't use submit_bio_noacct_nocheck in
 blk_zone_wplug_bio_work
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20250611044416.2351850-1-hch@lst.de>
 <ea187ee4-378e-4c59-afdd-3ecd8ed57243@acm.org>
 <d18b6d7a-b2eb-4eb5-a526-a5619e50a1a0@kernel.org>
 <547d462a-1681-4a6d-af4a-10d0013e6af1@acm.org>
 <ea9c6463-f602-4fcb-b343-dd1973304abf@kernel.org>
 <cb62c949-db47-4d09-9846-8e02476d6aa9@acm.org>
 <82c56da6-640d-4ead-b0fd-bbe564d4386f@kernel.org>
 <2b6ec966-a88f-40e2-9093-42b27e7cc8d5@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <2b6ec966-a88f-40e2-9093-42b27e7cc8d5@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/25 2:35 AM, Bart Van Assche wrote:
> On 6/23/25 6:18 PM, Damien Le Moal wrote:
>> For a nicer solution, which is mostly DM-based, combine what I sent you to
>> force write BIOs to be split early for zoned DM devices together with the patch
>> [1], which I sent already but needs more work. This combination was tested by
>> Shin'ichiro and he could not reproduce the hang with both patches applied.
>>
>> [1] https://lore.kernel.org/dm-devel/20250611011340.92226-1-dlemoal@kernel.org/
>>
>> As far as I can tell, dm-crypt is the only DM target driver supporting zones
>> that splits write operations "under the hood". But I will check again.
> 
> Hi Damien,
> 
> With both patches applied on top of Jens' for-next branch (2d5a3220c1f5
> ("Merge branch 'block-6.16' into for-next"), I can't reproduce the
> deadlock anymore. This is unexpected because the deadlock happens
> between the queue freezing mechanism and zwplug->bio_list. No
> matter how bios are split, if bios are queued faster than these are
> processed, one or more bios end up on zwplug->bio_list and this deadlock
> can happen.
> 
> Did I perhaps overlook or misunderstand something?

Yes, because you focused on the block layer when the actual issue is in DM.

Any zoned DM target that uses zone append emulation will use zone write
plugging. If in addition to this, the target driver uses
dm_accept_partial_bio() to internally split BIOs, it can happen that a BIO that
was plugged and issued from a zone write plug bio work is split using
dm_accept_partial_bio(). In this case, the reminder of the BIO is issued again
and thus there is a call to blk_queue_enter() which will block if a queue
freeze is ongoing. This blocking is in the zone write plug bio work, which
result in no forward progress: BIOs plugged are never unplugged and processed.
Here is your deadlock.

So the solution is to force a split to the DM device limits of any write BIO in
dm core, before the BIO is passed to the DM target map() function, *AND*
prevent the target driver from further splitting a write BIO using
dm_accept_partial_bio().

Only dm-crypt is affected by this. dm-flakey supports zoned targets and uses
dm_accept_partial_bio() but it does not require zone append emulation so does
not use zone write plugging.

Sending clean patches in a short while. I tested with your zbd/013 reproducer
and all is good.

-- 
Damien Le Moal
Western Digital Research
