Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A701C01
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 04:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737605793; cv=none; b=OyZw+OX3BBXIe9zz5vXaFSmkTqsqeOHT22fQXl1MEvTeAspmp6+EwulBiQpmhS0sOMvvNseSTeKjCHT6zalB6kJgKEybRXwid52uS8nyeLqUQIL77hhUMgG+7bmzS4DWR90CyJWsKsI0Ph6uaVLuWw89EE9zqa1YM7aSXNYHqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737605793; c=relaxed/simple;
	bh=uhPORGszX70/emIoQkur7kSlhJV1APVAdnpF0U/6mug=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=M69jvZCCJH+IRhG0eehnHVAlhphw1k3N4cUoB1KOm+RGe1BTK3Z9prfx08hOkqpht7XPn/ywrDtgdjUue1cnk6ZELMNu6f8ditXo87HZhVF8Mad3jplS72BRu/MU87b0wYFpbxBWDXo6eLI3kI4UIOAafhbD1dZO30CiZl/QVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmC+7oJe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmC+7oJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF8FC4CEDD;
	Thu, 23 Jan 2025 04:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737605791;
	bh=uhPORGszX70/emIoQkur7kSlhJV1APVAdnpF0U/6mug=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=OmC+7oJejt3E2/TxCzfOprIgKiuyKHKP4zNPAvhoKmpLFW2m/H6MwK64ZQKkEeYwK
	 ppi8ZEu2xnbdvgG49qFLUhz/5ooF31YQRjuRdqSlw2XB2isP2EaJBRziU2C1Uq+N3V
	 mVu8u8Ra2E0C0XTpu/3Jj06G87HbW16fKa+rRwA1WzLYX8VTzHETsLspT8vb7RWltr
	 mm5pETm6z8C2uUuB5APMIS4h+lfXVC3I4zg2HXYHRIOqphmIfeDcpEhPK3r8lgstqy
	 PM6KrrKcd5V+bp8mT7Nyt+S30XdoSoyuVqcfBKbuGzplIGXXQqNvuB2VEAlvmwwo58
	 +eYsQGqY0ejaw==
Message-ID: <d9ef8666-4501-4913-98da-abbd1793fa42@kernel.org>
Date: Thu, 23 Jan 2025 13:16:28 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v17 00/14] Improve write performance for zoned UFS devices
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20250115224649.3973718-1-bvanassche@acm.org>
 <c7fa1b34-3f0a-44db-91b7-6482a15e48f8@kernel.org>
 <3a94f3e2-20d9-4bac-9198-4df4a64a5277@acm.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <3a94f3e2-20d9-4bac-9198-4df4a64a5277@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/25 6:57 AM, Bart Van Assche wrote:
> On 1/17/25 2:47 PM, Damien Le Moal wrote:
>> Also, patch 14 puts back a lot of the code that was recently removed. Not nice,
>> and its commit message is also far too short given the size of the patch. Please
>> spend more time explaining what the patches do and how they do it to facilitate
>> review.
> 
> Regarding the following part of patch 07/14:
> 
> -		disk_zone_wplug_abort(zwplug);
> -		zwplug->flags |= BLK_ZONE_WPLUG_NEED_WP_UPDATE;
> +		if (!disk->queue->limits.driver_preserves_write_order)
> +			zwplug->flags |= BLK_ZONE_WPLUG_NEED_WP_UPDATE;
> +		zwplug->flags |= BLK_ZONE_WPLUG_ERROR;
> 
> How about setting BLK_ZONE_WPLUG_ERROR only if
> disk->queue->limits.driver_preserves_write_order has been set such that
> the restored error handling code is only used if the storage controller
> preserves the write order? This should be sufficient to preserve the
> existing behavior of the blk-zoned.c code for SMR disks.

Your patch changes BLK_ZONE_WPLUG_NEED_WP_UPDATE into BLK_ZONE_WPLUG_ERROR for
regular (no write order preserving) zoned devices. I do not see why this is
needed. The main difference between this default behavior and what you are
trying to do is that BLK_ZONE_WPLUG_NEED_WP_UPDATE is to be expected with your
changes while it is NOT expected to ever happen for a regular coned device.

> The reason I restored the error handling code is that the code in 
> blk-zoned.c does not support error handling inside block drivers if QD > 1
> and because supporting the SCSI error handler is essential for UFS
> devices.

What error handling ? The only error handling we need is to tell tell the user
that there was an error and track that the user actually does something about
it. That tracking is done with the BLK_ZONE_WPLUG_NEED_WP_UPDATE flag. That's
it, nothing more.

I think that conflating/handling the expected (even if infrequent) write requeue
events with zoned UFS devices with actual hard device write errors (e.g. the
write failed because the device is toast or you hit a bad sector, or you have a
bad cable or whatever other hardware reason for the write to fail) is making a
mess of everything. Treating the requeues like hard errors makes things
complicated, but also wrong because even for zoned UFS devices, we may still get
hard write errors, and treating these in the same way as requeue event is wrong
in my opinion. For hard errors, the write must not be retried and the error
propagated immediately to the issuer (e.g. the FS).

For a requeue event, even though that is signaled initially at the bottom of the
stack by a device unit attention error, there is no reason for us to treat these
events as failed requests in the zone write plugging code. We need to have a
special treatment for these, e.g. a "ZONE_WRITE_NEED_RETRY" request flag (and
that flag can bhe set in the scsi mid-layer before calling into the block layer
requeue.

When the zone write plugging sees this flag, it can:
1) Stop issuing write BIOs since we know they will fail
2) Wait for all requests already issued and in-flight to come back
3) Restoore the zone write plug write pointer position to the lowest sector of
all requests that were requeued
4) Re-issue the requeued writes (after somehow sorting them)
5) Re-start issuing BIOs waiting in the write plug

And any write that is failed due to a hard error will still set the zone write
plug with BLK_ZONE_WPLUG_NEED_WP_UPDATE after aborting all BIOs that are pluggeg
in the zone write plug.

Now, I think that the biggest difficulty of this work is to make sure that a
write that fails with an unaligned write error due to a write requeue event
before it can be clearly differentiated from the same failure without the
requeue event before it. For the former, we can recover. For the latter, it is a
user bug and we must NOT hide it.

Can this be done cleanly ? I am not entirely sure about it because I am still
not 100% clear about the conditions that result in a zoned UFS device failing a
write with unit attention. As far as I can tell, the first write issued when the
device is sleeping will be rejected with that error and must be requeued. But
others write behind this failed write that are already in-flight will endup
failing with an unaligned write error, no ? Or will they be failed with a unit
attention too ? This is all unclear to me.

-- 
Damien Le Moal
Western Digital Research
