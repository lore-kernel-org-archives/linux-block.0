Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FE2198E71
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732707106; cv=none; b=lRZ17OWPi6C+CQhPe5hIAWwkif/0+ixjktQWD6g+lgA+rkxrjizbKjcHqW3w62NR2Z5n1Fa5gQ52FTeLB3BMrQzO/8Kcwigdnf8tQxuf/v2+6SYjYuSzuB6FDprVb3G2EXymgsih3HlZWmIcKYa1hE8DhPrKWrBMOt7gWowHWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732707106; c=relaxed/simple;
	bh=S/S2+nfAtIhf5kYxvUXWduf5paYkA/R6oBmFNFAuUqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxlzFMwPCgNRxltvEFq6f5ZXn50473CJZRxMaqCCV3K5nC1RiWUHwwgSziBgbS6mXfBkqlkWgVjlMJGT4hvqBZk72cbPFcS9t/20xbLqzhcmi/Xa3hRZXakWjMzb1aSkaQL95G6f1p3iT1nJs0oBvTse/NC8E3pmQsXWMxFBtrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qL8AQsks; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qL8AQsks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D1FC4CECC;
	Wed, 27 Nov 2024 11:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732707105;
	bh=S/S2+nfAtIhf5kYxvUXWduf5paYkA/R6oBmFNFAuUqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qL8AQsksK9uJ6BDD5FVK69V9glF3rP2ihXub6y+9hh0kiEIFShHyLt8TYtJ+lOQ1C
	 sDtIcZ7n4eu9nmBa2cAoHaK4Qz4+09x/owWAWsy6zZoyfOLxQyC9Xb3fKDPIb5cTNd
	 7LLGoAr7Mg5Wme0f/jb9tilOO2gBxdRTfjmWa0LtPhGSg9fYEdE8ggGfAazQ5aliUs
	 Yndd3hL9yv23YjOQ6catdaJOfA5TG0VSX7H04YGoGhJg3y5+9EQg+Dz3cVMXn2Jt6D
	 V23VcJjv93RZlyyjzPeqqw/l0q6aWk2bUilVqja7hr2lAfnt4U+YTmrLGfgWBbpg/z
	 ek60nW4fK15Vg==
Message-ID: <3bc57ef3-4916-4bcf-ac1a-9efed89fc102@kernel.org>
Date: Wed, 27 Nov 2024 20:31:43 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
To: Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <12c5ee53-dcc6-4c78-b027-8c861e147540@kernel.org>
 <Z0a5Mjqhrvw6DxyM@infradead.org> <Z0a6ehUQ0tqPPsfn@infradead.org>
 <73fb6bae-a265-43c3-a362-3cece4b42bbe@kernel.org>
 <Z0a9SGalQ5Sypfpf@infradead.org>
 <9d224032-254f-4b4a-a667-d1538cdbf0dc@kernel.org>
 <Z0bAHKD-j49ILtgv@infradead.org>
 <52570aad-c191-4717-b91d-a555d9dfda96@kernel.org>
 <Z0bIDopTmAaE_nxQ@infradead.org>
 <0e2dc18f-d84e-4dcf-a5c2-134d579c480c@kernel.org>
 <Z0bfKNMKhLkEHusz@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z0bfKNMKhLkEHusz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/24 17:58, Christoph Hellwig wrote:
> On Wed, Nov 27, 2024 at 05:17:08PM +0900, Damien Le Moal wrote:
>> After all these fixes, the last remaining problem is the zone write
>> plug error recovery issuing a report zone which can block if a queue 
>> freeze was initiated.
>>
>> That can prevent forward progress and hang the freeze caller. I do not
>> see any way to avoid that report zones. I think this could be fixed with
>> a magic BLK_MQ_REQ_INTERNAL flag passed to blk_mq_alloc_request() and
>> propagated to blk_queue_enter() to forcefully take a queue usage counter
>> reference even if a queue freeze was started. That would ensure forward
>> progress (i.e. scsi_execute_cmd() or the NVMe equivalent would not block
>> forever). Need to think more about that.
> 
> You are talking about disk_zone_wplug_handle_error here, right?

Yes.

> We should not issue a report zones to a frozen queue, as that would
> bypass the freezing protection.  I suspect the right thing is to
> simply defer the error recovery action until after the queue is
> unfrozen.

But that is the issue: if we defer the report zones, we cannot make progress
with BIOs still plugged in the zone write plug BIO list. These hold a queue
usage reference that the queue freeze wait is waiting for. We have to somehow
allow that report zones to execute to make progress and empty the zone write
plugs of all plugged BIOs.

Note that if we were talking about regular writes only, we would not need to
care about error recovery as we would simply need to abort all these plugged
BIOs (as we know they will fail anyway). But for a correct zone append
emulation, we need to recover the zone write pointer to resume the execution of
the plugged BIOs. Otherwise, the user would see failed zone append commands that
are not suppose to fail unless the drive (or the zone) is dead...

> I wonder if the separate error work handler should go away, instead
> blk_zone_wplug_bio_work should always check for an error first
> and in that case do the report zones.  And blk_zone_wplug_handle_write
> would always defer to the work queue if there was an error.

That would not change a thing. The issue is that if a queue freeze has started,
executing a report zone can block on a request allocation (on the
blk_queue_enter() it implies if there are no cached requests). So the same
problem remains.

Though I agree that the error recovery could be moved to the zone BIO work and
we could get rid of the error recovery work.

But we still need to somehow allow that report zone to execute even if a queue
freeze has started... Hence the idea of the BLK_MQ_REQ_INTERNAL flag to allow
that, for special cases like this one were completing BIOs depends on first
executing another internal command. Or maybe we could try to pre-allocate a
request for such case, but managing that request to not have it freed to be able
to reuse it until all errors are processed may need many block layer changes...


-- 
Damien Le Moal
Western Digital Research
