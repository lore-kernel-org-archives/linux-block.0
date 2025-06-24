Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C0A1FC8
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750728056; cv=none; b=QuJPeOIG5Fp6X4LkJqR7UGj7TgmkS7eOf8xfiN/rAM4A97CyaCUDOMelIVvactXeAg8Ypozw7KnGdmjfsU2PMyRCvoC3ZdIxV5bqMzHubHKm2c0N+nmODBnFkuXpRMPhj5QleH8K96zOzn1csQyOdb1bpCuY+CNgMp3myCOp1KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750728056; c=relaxed/simple;
	bh=LpSj5/e0ll4ZgoVkTHo7G5fDEepa85jzmhCrgB/edc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UC1I5yveb0uGmfoWEOo/QEOF+CpJekNBjy3hrKWFo9EUnAA0cFGCaTvB6NcoKv4tDiyYT347QC9sQ0Ho6Hc4lvsJpfHlhyrYSeY/2PnIRqSexeUsTwWfvPR+0zkCwaqItrQxfb7W3MrLffN398QoB+gykkgRm2xuQwKLioJDVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srP6acos; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srP6acos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E0EC4CEEA;
	Tue, 24 Jun 2025 01:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750728055;
	bh=LpSj5/e0ll4ZgoVkTHo7G5fDEepa85jzmhCrgB/edc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=srP6acosBei3Y4IiZNlZl8adTj1bgYqdP82FOI5t0ayDhfJXsra4azPsbRJ2BhEmz
	 IpYKNvBGt3BmgPz99Pg1aIx5Blgf9ZR3kiJgEXTqqxCWWuR7yxUM3+NIeWcNH1TCtj
	 6IDvMMqJCIfX9ssoCkwMw8noEyl6utsDqAjuf54n6Qfh7Sv3YHtTCpJgAXQ50/PHS2
	 UM5PQ/sK/BOFMg4+MMHEtN3mLG/Dw62tcxlY6Ai5cHYvyg86MUBpOhN3351s9nmaXU
	 Q83vimSsLRbzQlIua+agzkeNDqxsSHx3xl9OIbTbQmZISmwRS6JfaZG6iJlOBHaVvx
	 5wdERN0u+sUCw==
Message-ID: <82c56da6-640d-4ead-b0fd-bbe564d4386f@kernel.org>
Date: Tue, 24 Jun 2025 10:18:51 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <cb62c949-db47-4d09-9846-8e02476d6aa9@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/24/25 2:12 AM, Bart Van Assche wrote:
> On 6/19/25 6:29 PM, Damien Le Moal wrote:
>> On 6/19/25 02:13, Bart Van Assche wrote:
>>>
>>> On 6/17/25 10:56 PM, Damien Le Moal wrote:
>>>> Can you check exactly the path that is being followed ? (your
>>>   > backtrace does not seem to have everything)
>>>
>>> Hmm ... it is not clear to me why this information is required? My
>>> understanding is that the root cause is the same as for the deadlock
>>> fixed by Christoph:
>>> 1. A bio is queued onto zwplug->bio_list. Before this happens, the
>>>      queue reference count is increased by one.
>>> 2. A value is written into a block device sysfs attribute and queue
>>>      freezing starts. The queue freezing code waits for completion of
>>>      all bios on zwplug->bio_list because the reference count owned by
>>>      these bios is only released when these bios complete.
>>> 3. blk_zone_wplug_bio_work() dequeues a bio from zwplug->bio_list,
>>>      calls dm_submit_bio() through a function pointer, dm_submit_bio()
>>>      calls submit_bio_noacct() indirectly and submit_bio_noacct() calls
>>>      bio_queue_enter() indirectly. bio_queue_enter() sees that queue
>>>      freezing has started and waits until the queue is unfrozen.
>>> 4. A deadlock occurs because (2) and (3) wait for each other
>>>      indefinitely.
>>
>> Then we need to split DM BIOs immediately on submission, always.
>> So something like this totally untested patch should solve the issue.
>> Care to test ?
> 
> (back in the office after four days off work)
> 
> Hi Damien,
> 
> Hmm ... it is not clear to me how a patch that modifies when bios are
> split could address the deadlock scenario described above? What am I
> missing? Additionally, hadn't Christoph requested not to split bios at
> the top of the device driver stack?

DM already calls bio split to limits at the top of its submission path. Not for
all BIOs though.

I encourage you to look at the DM code more closely to understand the issue
here. What is happening is that DM in general does *NOT* split write BIOs. But
a DM target driver is free to do so using dm_accept_partial_bio() and that will
cause the reminder of a BIO to be issued again but *NOT* necessarily from the
same context. Because of zone write plugging, this may happen from the zone
write plug BIO work, thus causing going through the queue enter which can
deadlock with freeze when a BIO for the same zone is already plugged.

Zone write plugging heavily relies on the fact that once plugged, BIOs should
*NOT* be split again, as otherwise we can deadlock. DM dm_accept_partial_bio()
breaks that contract.

> The patch that I posted one month ago is sufficient to fix this
> deadlock. See also
> https://lore.kernel.org/linux-block/20250522171405.3239141-1-bvanassche@acm.org/

I do not like this. This is playing weird games with the queue enter/exit which
are very hard to understand. And I think Jens will not accept this as he does
not want to see zone stuff all over the place (and I agree).

For a nicer solution, which is mostly DM-based, combine what I sent you to
force write BIOs to be split early for zoned DM devices together with the patch
[1], which I sent already but needs more work. This combination was tested by
Shin'ichiro and he could not reproduce the hang with both patches applied.

[1] https://lore.kernel.org/dm-devel/20250611011340.92226-1-dlemoal@kernel.org/

As far as I can tell, dm-crypt is the only DM target driver supporting zones
that splits write operations "under the hood". But I will check again.

-- 
Damien Le Moal
Western Digital Research
