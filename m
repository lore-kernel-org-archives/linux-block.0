Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB0C291E
	for <linux-block@vger.kernel.org>; Sun,  8 Sep 2024 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725753775; cv=none; b=qIC2oas9YI3mAcreGcBHrftNdirQ2mNX4pCc1QX5iz+iWn5faHu29e+XXh7n8cxem6K14DfhvbVT/pkbSYr3SkY0Rsd0dRkmXn6HJxA5/DvgjEqUHpCEpHlYsRQQE02fgOIlkXEHktA2x5xXAf3yu1JShAOWZe8suG9KNBlAAuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725753775; c=relaxed/simple;
	bh=kE60d914cAFFZfPyXqWhcKu7KyqhiornfMYdZxbm/wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxRcDHNA6HVUB0UbYTzmfedrBD4WbrhkKsGJrHrTA790W/UWdkKWc75sxumF4vfPblTd+emjpsV6MPcAmZ35fNX7Iw+UV/rqIj7Ck+CRoz7YUJk0AdEmPNkzojWW9dMn68vUJrcsYydyev8SNX+WHsTboBmZqENVMf4RgbWTPrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FquorsDZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FquorsDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B65FC4CEC2;
	Sun,  8 Sep 2024 00:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725753774;
	bh=kE60d914cAFFZfPyXqWhcKu7KyqhiornfMYdZxbm/wA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FquorsDZef7BReUQhtGaG2w3xk9GlfmsMiixW4jnRQPM557DoLDBa+Uzk7hW9KxA6
	 PPfulsGbXG+KdQ0Ovph+5swjzunWyCb6gCFPdeRPJMtqvSRkszljCMHZswzhWAKcWy
	 IxzK8wJOwkOhWFPeyAG0bGHtD2GWwVUmpDhmn+h6+1fDAfejiRG83qAOPMkQbHcRkA
	 ZrIiKvlesrRbxwwJm50b+OtuPWrSsU9rDNOjqyJT+Wpui5frU8xSyXpLEVxpwVu/IL
	 Wd9NawoAjdGxHKw4rxLu3LdNCd9KVXhDdQY8GyqpAoBg+wdJdpSzYsanHlYOuf2COe
	 6TA9SpqxBlyoA==
Message-ID: <2d50513f-bdcb-4af1-b365-e080be43d420@kernel.org>
Date: Sun, 8 Sep 2024 09:02:51 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: elevator: avoid to load iosched module from this
 disk
To: "Richard W.M. Jones" <rjones@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Jeff Moyer <jmoyer@redhat.com>, Jiri Jaburek <jjaburek@redhat.com>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20240907014331.176152-1-ming.lei@redhat.com>
 <20240907073522.GW1450@redhat.com> <ZtwHwTh6FYn+WnGD@fedora>
 <4d7280eb-7f26-4652-a1d4-4f82c4d99a4c@kernel.org> <ZtwhfCtDpTrBUFY+@fedora>
 <20240907100213.GY1450@redhat.com> <Ztwl2RvR0DGbNuex@fedora>
 <20240907103632.GZ1450@redhat.com> <ZtwyxukuaXAscXsz@fedora>
 <20240907111453.GA1450@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240907111453.GA1450@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/7/24 20:14, Richard W.M. Jones wrote:
> On Sat, Sep 07, 2024 at 07:02:30PM +0800, Ming Lei wrote:
>> BTW, the issue can be reproduced 100% by:
>>
>> echo "deadlock" > /sys/block/$ROOT_DISK/queue/scheduler

This probably should be:

echo "mq-deadline" > /sys/block/$ROOT_DISK/queue/scheduler

and make sure that:
1) mq-deadline is compiled as a module
2) mq-deadline is not already used by a device (so not loaded already)
3) The mq-deadline module file is stored on the target device of the scheduler
change
4) The mq-deadline module file is not already cahced in the page cache.

For (4), you may want to do a "echo 3 > /proc/sys/vm/drop_caches" before trying
to switch the scheduler.

> 
> That doesn't reproduce it for me (reliably).  Although I'm not
> surprised as this bug has been _very_ tricky to reproduce!  Sometimes
> I think I have a definite reproducer, only for it to go away when some
> tiny detail changes.
> 
>>> This seems like the neatest (or shortest) fix so far, but doesn't it
>>> "mix up layers" by checking elv_iosched_store?
>>
>> It is just one exception for 'scheduler' sysfs attribute wrt. freezing
>> queue for storing, and the check can be done via the attribute
>> name("scheduler") too.
> 
> Fair enough.
> 
> Rich.
> 

-- 
Damien Le Moal
Western Digital Research

