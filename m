Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AA04A2D
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750698752; cv=none; b=DzYkVs8mrfIQNo/uJrEq8RAe5tYAR1K4tvh+aSf2GHXNcrMj3SAX1Mhx1JXkNl9SHoO659QjshIVl5Hx99FpJ+VaJzVzBAtxVTUKfqiTeLlf9OoDky59xYp94w6qR9RUpxgH+jng0AEinqotsNCkxQCDWvGheG1Uby8n26QjwwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750698752; c=relaxed/simple;
	bh=+8eS0yzqANhrdUUdDxmtWhUVQ//7uY4UWBWsBeymWT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLUyfaTL94BkQDMB2Zx1YfZ1iMF499bFq/6gKgTvx+Lq6IOSp8zgKXEvcJooOjSzosh2dG4wkFnAEhfJC8ipuTlQx1GhsyWJJo9sFdJw805S/OWMxaJyZs7hAP1fBhnAyR8zmRDp+HwHYLOsDhSuY4Xmc/TQkKxa3szavmosFZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=eo9iOsTo; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="eo9iOsTo"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bQvld3pfBzlgqV3;
	Mon, 23 Jun 2025 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750698748; x=1753290749; bh=hCipjCtBsI3oppbCmcHQ1+zK
	+ZZ6cUHFUfMITmpwt0A=; b=eo9iOsToDy87qxYLGQ0pPo0rvJK2rD4V+CLH/v2f
	UyD/p7Yx8auldW39PPYFwofZAiDaeRc60JFEtuqTHlnhRvlsa1hrwmfakFvf1gHE
	5Eed/eDv9JPRhzpVHq7WisdOv5MF8hGbNR4EqElPTgjt409nFudK2v9f6ytNdhH8
	tZEGExItfd+aYH0q2rVtykeolIaY70HnIvBQA+OSbK81XMLw7xE02eTmyP2q+Qzx
	oL0C9SOdhVgW82/VeqW4+dFw8sEqMjpNKxHY12HleE4e9H3qfCRND8lKFHVxjKDW
	Ip5Pkn/02Jw8UlVHGY/KznqTYV2D1ULRwfjomlAxWPQtcg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vleq4iM76QgN; Mon, 23 Jun 2025 17:12:28 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bQvlX4wfvzlgqTv;
	Mon, 23 Jun 2025 17:12:23 +0000 (UTC)
Message-ID: <cb62c949-db47-4d09-9846-8e02476d6aa9@acm.org>
Date: Mon, 23 Jun 2025 10:12:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't use submit_bio_noacct_nocheck in
 blk_zone_wplug_bio_work
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20250611044416.2351850-1-hch@lst.de>
 <ea187ee4-378e-4c59-afdd-3ecd8ed57243@acm.org>
 <d18b6d7a-b2eb-4eb5-a526-a5619e50a1a0@kernel.org>
 <547d462a-1681-4a6d-af4a-10d0013e6af1@acm.org>
 <ea9c6463-f602-4fcb-b343-dd1973304abf@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ea9c6463-f602-4fcb-b343-dd1973304abf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/25 6:29 PM, Damien Le Moal wrote:
> On 6/19/25 02:13, Bart Van Assche wrote:
>>
>> On 6/17/25 10:56 PM, Damien Le Moal wrote:
>>> Can you check exactly the path that is being followed ? (your
>>   > backtrace does not seem to have everything)
>>
>> Hmm ... it is not clear to me why this information is required? My
>> understanding is that the root cause is the same as for the deadlock
>> fixed by Christoph:
>> 1. A bio is queued onto zwplug->bio_list. Before this happens, the
>>      queue reference count is increased by one.
>> 2. A value is written into a block device sysfs attribute and queue
>>      freezing starts. The queue freezing code waits for completion of
>>      all bios on zwplug->bio_list because the reference count owned by
>>      these bios is only released when these bios complete.
>> 3. blk_zone_wplug_bio_work() dequeues a bio from zwplug->bio_list,
>>      calls dm_submit_bio() through a function pointer, dm_submit_bio()
>>      calls submit_bio_noacct() indirectly and submit_bio_noacct() calls
>>      bio_queue_enter() indirectly. bio_queue_enter() sees that queue
>>      freezing has started and waits until the queue is unfrozen.
>> 4. A deadlock occurs because (2) and (3) wait for each other
>>      indefinitely.
> 
> Then we need to split DM BIOs immediately on submission, always.
> So something like this totally untested patch should solve the issue.
> Care to test ?

(back in the office after four days off work)

Hi Damien,

Hmm ... it is not clear to me how a patch that modifies when bios are
split could address the deadlock scenario described above? What am I
missing? Additionally, hadn't Christoph requested not to split bios at
the top of the device driver stack?

The patch that I posted one month ago is sufficient to fix this
deadlock. See also
https://lore.kernel.org/linux-block/20250522171405.3239141-1-bvanassche@acm.org/

Thanks,

Bart.


