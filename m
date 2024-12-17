Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259EB1F7567
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451627; cv=none; b=kBSCVgH4StJ7h6a1EsUyqmDz4/LZ0I4gvszmjp+HQaFmhJ7EygUG3z9cz4QIe0LxXZ4TBWWWFeESI/DPOXSLs4dkGnahJ+tyzEfaraN6DovW/exkjxMdAxBkNp3SCc/D51R+n1aeJWMU6BwsJDW2ic/qTWpdu49T3zKqhkmDaz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451627; c=relaxed/simple;
	bh=CwCGCpkesm9YaZdE3kKQYootMDwAuf1TrnNYqmI7PkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hdeg47qmS5Pfc0co7tlw55ZPKznycdClQwyrwqsEAlETtZPhzt4zWn62DIP2n3RT2u05+HwCNJz3XkcKrZZ6Ygxdh7n+I6dh23x6G3P5cYIpyh8e8zkx8MCi7WEMm5+xlJishxHHqCq738ZNKpCeN2vpPskp5HJ40qAvFi1TtG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL4LP8T7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL4LP8T7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A79C4CED3;
	Tue, 17 Dec 2024 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734451626;
	bh=CwCGCpkesm9YaZdE3kKQYootMDwAuf1TrnNYqmI7PkQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OL4LP8T7ZjbK3cJ8MUjKlg4dIKaMl4gA3rme+4CeOVfYG7xB56aUSsEgxcDMx7qXg
	 idlzLeM8CGTo3btr8reialbNHrkQAEO3m92uULY41BZkCuoXEjDU7Q7EnuoJhJkSt0
	 6qXk4GySWiWXnYEUs98YH3V/sMMOCFTGo0pYOWi+cgLqFW9qRoKr72dBWU2B8uAcIj
	 +H8ckyWtHOM11djCQpjxkVJn2PogqU2wjhC9QWGT23jgBppLBYKVM8XcuX8OEz5tiJ
	 hbghQZuhG7WbiLIj/BS8SqiK6jDnY22UWgiDkxq9PrMWt1gdCyDDOp9hGybZUTzLcs
	 J392E/F5Z4rUA==
Message-ID: <a032a3a0-0784-4260-92fd-90feffe1fe20@kernel.org>
Date: Tue, 17 Dec 2024 08:07:06 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs for
 atomic update queue limits
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20241216080206.2850773-1-ming.lei@redhat.com>
 <20241216080206.2850773-2-ming.lei@redhat.com>
 <20241216154901.GA23786@lst.de> <Z2DZc1cVzonHfMIe@fedora>
 <20241217044056.GA15764@lst.de> <Z2EizLh58zjrGUOw@fedora>
 <20241217071928.GA19884@lst.de> <Z2Eog2mRqhDKjyC6@fedora>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Z2Eog2mRqhDKjyC6@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/16 23:30, Ming Lei wrote:
> On Tue, Dec 17, 2024 at 08:19:28AM +0100, Christoph Hellwig wrote:
>> On Tue, Dec 17, 2024 at 03:05:48PM +0800, Ming Lei wrote:
>>> On Tue, Dec 17, 2024 at 05:40:56AM +0100, Christoph Hellwig wrote:
>>>> On Tue, Dec 17, 2024 at 09:52:51AM +0800, Ming Lei wrote:
>>>>> The local copy can be updated in any way with any data, so does another
>>>>> concurrent update on q->limits really matter?
>>>>
>>>> Yes, because that means one of the updates get lost even if it is
>>>> for entirely separate fields.
>>>
>>> Right, but the limits are still valid anytime.
>>>
>>> Any suggestion for fixing this deadlock?
>>
>> What is "this deadlock"?
> 
> The commit log provides two reports:
> 
> - lockdep warning
> 
> https://lore.kernel.org/linux-block/Z1A8fai9_fQFhs1s@hovoldconsulting.com/
> 
> - real deadlock report
> 
> https://lore.kernel.org/linux-scsi/ZxG38G9BuFdBpBHZ@fedora/
> 
> It is actually one simple ABBA lock:
> 
> 1) queue_attr_store()
> 
>       blk_mq_freeze_queue(q);					//queue freeze lock
>       res = entry->store(disk, page, length);
> 	  			queue_limits_start_update		//->limits_lock
> 				...
> 				queue_limits_commit_update
>       blk_mq_unfreeze_queue(q);

The locking + freeze pattern should be:

	lim = queue_limits_start_update(q);
	...
	blk_mq_freeze_queue(q);
	ret = queue_limits_commit_update(q, &lim);
	blk_mq_unfreeze_queue(q);

This pattern is used in most places and anything that does not use it is likely
susceptible to a similar ABBA deadlock. We should probably look into trying to
integrate the freeze/unfreeze calls directly into queue_limits_commit_update().

Fixing queue_attr_store() to use this pattern seems simpler than trying to fix
sd_revalidate_disk().

> 
> 2) sd_revalidate_disk()
> 
> queue_limits_start_update					//->limits_lock
> 	sd_read_capacity()
> 		scsi_execute_cmd
> 			scsi_alloc_request
> 				blk_queue_enter					//queue freeze lock
> 
> 
> Thanks,
> Ming
> 
> 


-- 
Damien Le Moal
Western Digital Research
