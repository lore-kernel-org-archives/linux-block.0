Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828DCEDE
	for <linux-block@vger.kernel.org>; Mon, 30 Dec 2024 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735601377; cv=none; b=ryz47cl7VeXPinX/5H5nUBV6oIbEH81VA7JScmf+Em93WWVBwEFVFyM/10Ow0bl2PjDAB4y2+yopFZro4/MG+H+UyVMvwaSYhOxDI9syYga9xx0AMNRMmgcQcFSBBSW39ZCoSECnfquKxJKvpBOlq3snCkCqEh/UZW1i6tML6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735601377; c=relaxed/simple;
	bh=Cn33pjKJ59kbTcVfkJ7tUxF8rBsYs67PyHj4JcIWL2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lD+6HeWUUGOPA2R/7NkizUqlby+qWUvsqhKhotxhE2yzmNARVgqOtB5i/tMA1puugEZlSEWcm9SzN8WUQJbAFWSJljV++oehOnqw9aK5hTb6I1dTzPB7bKmUi1MSoXVFkkFErEk7DcZHYZgnsSwkddrPxPUzsE0NgDxe0OVuv88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9ApNlSJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9ApNlSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F352DC4CED0;
	Mon, 30 Dec 2024 23:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735601377;
	bh=Cn33pjKJ59kbTcVfkJ7tUxF8rBsYs67PyHj4JcIWL2s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R9ApNlSJsaJkWWCvK4YusYoRmCTpxpVGJtwmlCCYOsC9rYsXVRHQflkiY74ONlteO
	 XGhPLzCySIkgtIihQ6Y9wMoG3ZAze29ib5atk28VWiL9SmW4w8+bT8iMr70xAg6L6A
	 MdM0/K3F1f9x9VM6EFg5e/xoFPjNrfk3NuVLUCR4J1WIQiH43X7sV/ue/BlJNGBout
	 Io/XpFpsygLGJx+s5LushvItdhXbpGYJohTZEGD4j2e8y+X1Q6U9lPxWwoa/uE2Ufd
	 D/JXNgzEUxAHijhfxOdrTHYp0/OYh9dzy8sjv3CCA0bzDK7jschM0y/SoncHdmDy3C
	 TR4agsGmZGe2g==
Message-ID: <a5114533-8753-4137-b2eb-4c150d25d784@kernel.org>
Date: Tue, 31 Dec 2024 08:29:34 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs for
 atomic update queue limits
To: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20241217071928.GA19884@lst.de> <Z2Eog2mRqhDKjyC6@fedora>
 <a032a3a0-0784-4260-92fd-90feffe1fe20@kernel.org> <Z2Iu1CAAC-nE-5Av@fedora>
 <f34f179a-4eaf-4f73-93ff-efb1ff9fe482@linux.ibm.com>
 <Z2LQ0PYmt3DYBCi0@fedora>
 <0fdf7af6-9401-4853-8536-4295a614e6d2@linux.ibm.com>
 <9e2ad956-4d20-456f-9676-8ea88dfd116e@kernel.org>
 <20241219062026.GC19575@lst.de>
 <cf1e007b-dcb5-43cd-84e2-fd72d8836fb8@linux.ibm.com>
 <Z3Jhq5Z4gLupIrYm@fedora>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Z3Jhq5Z4gLupIrYm@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/30 18:02, Ming Lei wrote:
>> 1. Callers which need acquiring limits-lock while starting the update; and freezing 
>>    queue only when committing the update:
>>    - sd_revalidate_disk
> 
> sd_revalidate_disk() should be the most strange one, in which
> passthrough io command is required, so dependency on queue freeze lock
> can't be added, such as, q->limits_lock
> 
> Actually the current queue limits structure aren't well-organized, otherwise
> limit lock isn't needed for reading queue limits from hardware, since
> sd_revalidate_disk() just overwrites partial limits. Or it can be
> done by refactoring sd_revalidate_disk(). However, the change might
> be a little big, and I guess that is the reason why Damien don't like
> it.

That was not the reason, but yes, modifying sd_revalidate_disk() is not without
risks of introducing regressions. The reason I proposed to simply move the queue
freeze around or inside queue_limits_commit_update() is that:

1) It is the right thing to do as that is the only place where it is actually
needed to avoid losing concurrent limits changes.

2) It clarifies the locking order between queue freeze and the limits lock.

3) The current issues should mostly all be solved with some refactoring of the
->store() calls in blk-sysfs.c, resolving the current ABBA deadlocks between
queue freeze and limits lock.

With that, we should be able to fix the issue for all block drivers with changes
to the block layer sysfs code only. But... I have not looked into the details of
all limits commit calls in all block drivers. So there may be some bad apples in
there that will also need some tweaking.

>>    - nvme_init_identify
>>    - loop_clear_limits
>>    - few more...
>>
>> 2. Callers which need both freezing the queue and acquiring limits-lock while starting
>>    the update:
>>    - nvme_update_ns_info_block
>>    - nvme_update_ns_info_generic
>>    - few more... 

The queue freeze should not be necessary anywhere when starting the update. The
queue freeze is only needed when applying the limits so that IOs that are in
flight are not affected by the limits change while still being processed.

>>
>> 3. Callers which neither need acquiring limits-lock nor require freezing queue as for 
>>    these set of callers in the call stack limits-lock is already acquired and queue is 
>>    already frozen:
>>    - __blk_mq_update_nr_hw_queues
>>    - queue_xxx_store and helpers
> 
> I think it isn't correct.
> 
> The queue limits are applied on fast IO path, in theory anywhere
> updating q->limits need to drain IOs in submission path at least
> after gendisk is added.

Yes !

-- 
Damien Le Moal
Western Digital Research
