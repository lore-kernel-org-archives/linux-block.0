Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040E1F869F
	for <linux-block@vger.kernel.org>; Tue, 21 Jan 2025 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737496645; cv=none; b=KXhnA8j/iGgTykyOlDZHUCA+Hqgse6Y0bq626wZRhBSClu1moLTLQNEIG++l/6TLaL+digafTQhBRCLfrAAKXfj9qbnp8OxKCZMomPFkgDYp++PcLuZobhnSLJad3tiPY1STFP9SiIecNrJw3ci0mxDfx/p6DOSj7COVk6cAwxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737496645; c=relaxed/simple;
	bh=Xw5siE1fekp9E5nlBGIbQofx8w2vkdJgusDH9L2piCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRmATSoJ5SX0R17/RPlHKRfuRc5gez5/hmW7V4rRV0D0MhDLkkqRgadJT1e3TonLEsPVQACwZTC9TqQTsIIAG7f9whTSVO0Lzdyfv43fz82ioKSwTH9+14E78Uww8LaosBbzem0Hafx4LUWT5CIvtbB4hqUwyDooFLr5Yn9owec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ICt00gPW; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ICt00gPW"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Yd1Js0ldMz6CmQwT;
	Tue, 21 Jan 2025 21:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1737496633; x=1740088634; bh=GhoHsn0than8CVQB7N9Uj01M
	THN7wKM2wp/OZQMYUxE=; b=ICt00gPWy1CMeXl8JsuRFi1PgCBTw/fLph/SbwE+
	bByjO9+7RnZpqOGeExtQuuoMgwhDctFc09DAeG1t05VPr02IkYjby+MGKdxiP1SC
	6q2eCwzp4UqRigdG/B50e30hNGCTdsrLnuIVs3QNR0V5+Imsgt54q+UBOB/2caAw
	XZq4XgBhAls74uyiQh5V/XPwJ1tispt3EeRkYJYn0oxC0zEUwpsdH0U/237NA2z4
	T7bcPVzTfkSB96gapQ3IZ90hZhib1zr1lTdjXd6b7h2hqs8o/jnyMiv26AiJdwkI
	Gq2oOmx7EWFouKSVsK6t7is3aeHqsCm3FBClc9OGcjaMLw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id e8N8P6AgJ-Vz; Tue, 21 Jan 2025 21:57:13 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Yd1Jn1R1Vz6CmQwQ;
	Tue, 21 Jan 2025 21:57:12 +0000 (UTC)
Message-ID: <3a94f3e2-20d9-4bac-9198-4df4a64a5277@acm.org>
Date: Tue, 21 Jan 2025 13:57:12 -0800
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c7fa1b34-3f0a-44db-91b7-6482a15e48f8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/17/25 2:47 PM, Damien Le Moal wrote:
> Also, patch 14 puts back a lot of the code that was recently removed. Not nice,
> and its commit message is also far too short given the size of the patch. Please
> spend more time explaining what the patches do and how they do it to facilitate
> review.

Regarding the following part of patch 07/14:

-		disk_zone_wplug_abort(zwplug);
-		zwplug->flags |= BLK_ZONE_WPLUG_NEED_WP_UPDATE;
+		if (!disk->queue->limits.driver_preserves_write_order)
+			zwplug->flags |= BLK_ZONE_WPLUG_NEED_WP_UPDATE;
+		zwplug->flags |= BLK_ZONE_WPLUG_ERROR;

How about setting BLK_ZONE_WPLUG_ERROR only if
disk->queue->limits.driver_preserves_write_order has been set such that
the restored error handling code is only used if the storage controller
preserves the write order? This should be sufficient to preserve the
existing behavior of the blk-zoned.c code for SMR disks.

The reason I restored the error handling code is that the code in 
blk-zoned.c does not support error handling inside block drivers if QD > 1
and because supporting the SCSI error handler is essential for UFS
devices.

> I also fail to see why you treat request requeue as errors if you actually
> expect them to happen...

I only expect requeues to happen in exceptional cases, e.g. because the
SCSI error handler has been activated or because a SCSI device reports a 
unit attention. Requeues may happen in any order so I think that it is
essential to pause request submission after a requeue until all pending
zoned writes for the same zone have completed or failed.

> I do not think you need error handling and tracking of
> the completion wp position: when you get a requeue event, requeue all requests
> in the plug and set the plug wp position to the lowest sector of all the
> requeued requests. That is necessarily the current location of the write
> pointer.

That's an interesting proposal. I will look into setting the WP to the
lowest sector of all requeued requests.

> No need for re-introducing all the error handling for that, no ?

The error handling code has been restored because of another reason,
namely to support the SCSI error handler in case the queue depth is
larger than one.

> I am going to wait for you to resend this with a better "big picture"
> explanation of what you are trying to do so that I do not randomly comment on
> things that I am not sure I completely understand. Thanks.

I will include a more detailed cover letter when I repost this series
(after the merge window has closed). While I work on this, feedback on
this version of this patch series is still welcome.

Thanks,

Bart.


