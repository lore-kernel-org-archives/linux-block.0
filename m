Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C330F1A83E4
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738018899; cv=none; b=E5lmchITRcSO2I07C/RfOrBgIziZXlBRJYr/6h0PIQpb/5+5QlbUc7cm57gYO1zl05bEXTla7DqbPvimM8eiegnuFrLqUkQxfcH7TmDZu1jeBAT07r8o28h4n4J5S2VURRn2fKp67pp3/BLKM8Os0slJOkf51ioiu72QUWqRElE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738018899; c=relaxed/simple;
	bh=RcnwEWS/FOU8GhYsTGU+z75840QiHy17tsmkwmoKg+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vh6yVWRA7LQQmwRoaLkDCxFjCEcL2bIjXy2tr+ArXdRV40GwKpmt9BGsevtqXRE4G90MK15quY8J+qFgNVbZYwHj1dAC8FsT8KUtvU7DkywOtpgnKHaagDF25BE8Ok2Afi7E6FMdeiORRwJ8pk1+VcwqzjLPX8cURAsR99ve28A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UBwAIngQ; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UBwAIngQ"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YhkSB6XJFz6CmM6Q;
	Mon, 27 Jan 2025 23:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1738018885; x=1740610886; bh=2hMPXbQYu/Ch6uA22ahwOCfZ
	iC5QevKP36VGGR4izEw=; b=UBwAIngQrO1jRjoaqfu5QqdkIE0OE66E6xXy1INl
	LNolY+JYORnpiOCq4YFVyLbHkqw7WoWcayNHyIe0YHPIW7PkCVD7Rn9NocG9XGOG
	7sX1+qvhFyJWdxnACZJEPPMbAIx4wAhuJjzyFUKKJKFfrkykjeyEuK8KOYe4jzps
	6etbjmp06MIYk/CpTDrhlLi3iYubkAKpsfutP6y26GN3CBiTsREhOk3IXun81tZs
	R70uJAyLv8/uEnX2TX7C0cBpcn4+c5IP/u6qgNxBF8lnESSszinmj4fg0msGBXeY
	cl+wUsFt4st4PwKugV0BrV+x6KeVXZhwpZE68t5Z+VmmYw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OBxnuyB70-CJ; Mon, 27 Jan 2025 23:01:25 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YhkS42Jbmz6CmR0C;
	Mon, 27 Jan 2025 23:01:23 +0000 (UTC)
Message-ID: <485f7749-63c4-4d2c-9e9e-6bbedd75604b@acm.org>
Date: Mon, 27 Jan 2025 15:01:22 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/14] Improve write performance for zoned UFS devices
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20250115224649.3973718-1-bvanassche@acm.org>
 <c7fa1b34-3f0a-44db-91b7-6482a15e48f8@kernel.org>
 <3a94f3e2-20d9-4bac-9198-4df4a64a5277@acm.org>
 <d9ef8666-4501-4913-98da-abbd1793fa42@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d9ef8666-4501-4913-98da-abbd1793fa42@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/25 8:16 PM, Damien Le Moal wrote:
> On 1/22/25 6:57 AM, Bart Van Assche wrote:
>> The reason I restored the error handling code is that the code in
>> blk-zoned.c does not support error handling inside block drivers if QD > 1
>> and because supporting the SCSI error handler is essential for UFS
>> devices.
> 
> What error handling ?

The SCSI error handler. If the SCSI error handler is invoked while only
one request is outstanding, there is no chance of reordering and no
additional measures are necessary. If multiple requests are outstanding
and the SCSI error handler is invoked, care must be taken that the
pending requests are resubmitted in LBA order per zone. This is not
possible without blocking zoned write processing until all pending
zoned writes have completed. Hence the need to set BLK_ZONE_WPLUG_ERROR
if write pipelining is enabled and a request is requeued.

> I think that conflating/handling the expected (even if infrequent) write requeue
> events with zoned UFS devices with actual hard device write errors (e.g. the
> write failed because the device is toast or you hit a bad sector, or you have a
> bad cable or whatever other hardware reason for the write to fail) is making a
> mess of everything. Treating the requeues like hard errors makes things
> complicated, but also wrong because even for zoned UFS devices, we may still get
> hard write errors, and treating these in the same way as requeue event is wrong
> in my opinion. For hard errors, the write must not be retried and the error
> propagated immediately to the issuer (e.g. the FS).
> 
> For a requeue event, even though that is signaled initially at the bottom of the
> stack by a device unit attention error, there is no reason for us to treat these
> events as failed requests in the zone write plugging code. We need to have a
> special treatment for these, e.g. a "ZONE_WRITE_NEED_RETRY" request flag (and
> that flag can bhe set in the scsi mid-layer before calling into the block layer
> requeue.
> 
> When the zone write plugging sees this flag, it can:
> 1) Stop issuing write BIOs since we know they will fail
> 2) Wait for all requests already issued and in-flight to come back
> 3) Restoore the zone write plug write pointer position to the lowest sector of
> all requests that were requeued
> 4) Re-issue the requeued writes (after somehow sorting them)
> 5) Re-start issuing BIOs waiting in the write plug
> 
> And any write that is failed due to a hard error will still set the zone write
> plug with BLK_ZONE_WPLUG_NEED_WP_UPDATE after aborting all BIOs that are pluggeg
> in the zone write plug.
> 
> Now, I think that the biggest difficulty of this work is to make sure that a
> write that fails with an unaligned write error due to a write requeue event
> before it can be clearly differentiated from the same failure without the
> requeue event before it. For the former, we can recover. For the latter, it is a
> user bug and we must NOT hide it.
> 
> Can this be done cleanly ? I am not entirely sure about it because I am still
> not 100% clear about the conditions that result in a zoned UFS device failing a
> write with unit attention. As far as I can tell, the first write issued when the
> device is sleeping will be rejected with that error and must be requeued. But
> others write behind this failed write that are already in-flight will endup
> failing with an unaligned write error, no ? Or will they be failed with a unit
> attention too ? This is all unclear to me.

I propose to keep the approach of the code in blk-zoned.c independent of
the details of how UFS devices work. That will make it more likely that
the blk-zoned.c code remains generic and that it can be reused for other
storage protocols.

Although I have not yet observed reordering due to a unit attention, I
think that unit attentions should be supported because unit attentions
are such an important SCSI mechanism.

Since UFSHCI 3 controllers use a 32-bit register in the UFSHCI
controller for indicating which requests are in flight, reordering of
requests is likely to happen if a UFSHCI controller comes out of the
suspended state. When a UFSHCI controller leaves the suspended state,
it scans that 32-bit register from the lowest to the highest bit and
hence ordering information that was provided by the host is lost. It
seems to me that the easiest way to address this reordering is by
resubmitting requests once in case the controller reordered the requests
due to leaving the suspended state. Please note that UFSHCI 3
controllers are not my primary focus and that I would be fine with not
supporting write pipelining for these controllers if there would be
disagreement about this aspect. UFSHCI 4 controllers have proper
submission queues in host memory, just like NVMe controllers, and hence
request ordering information for submission queues is not lost if the
controller is suspended and resumed.

The SCSI error handler can also cause reordering. If e.g. the UFS
controller reports a CRC error then the UFS driver will reset the UFS
host controller and activate the SCSI error handler. Pending writes must
be resubmitted in LBA order per zone after the SCSI error handler has
finished to prevent that write errors propagate to the file system and
to user space.

At the time a UFS device reports an unaligned write error, I don't think
that it is possible to determine whether or not this is a retryable
error. So instead of introducing a ZONE_WRITE_NEED_RETRY flag, I propose
the following:
* Use BLK_ZONE_WPLUG_ERROR for both hard and soft errors. Hard errors
   means errors that shouldn't be retried. Soft errors means errors that
   are retryable.
* After all pending writes have completed and before resubmitting any
   zoned writes, check whether or not these should be retried. For UFS
   devices this can be done by comparing the wp_offset_compl member with
   the lowest LBA of the pending zoned writes.

Do I remember correctly that residual information is not always reliable
for zoned writes to SMR disks and hence that another approach is needed
for SMR disks? How about setting BLK_ZONE_WPLUG_NEED_WP_UPDATE for SMR
disks instead of resubmitting writes after an unaligned write has been
reported by the storage device?

Thanks,

Bart.



