Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9408F1754B
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933710; cv=none; b=PjylnGtktTyHJH7/BBbXP8ExAW15tu3ZgbZP5qcQRM2WMwX1RRjxJHCHkG95VI5UeR2+SvHfQ1zcknA/B53SgQ48cXMpJbPpuiSAwNrljpg1dScusgVRkwai3Qiqu1N1yDM/IkdOVkZyMS12HjE684B6bcSKGMD3uJRor3ADoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933710; c=relaxed/simple;
	bh=2Zib/A9xmKijHqztz4pvCkT/zUEKey9ga76Qh04vgfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUPykAIN5pnu4pkWRpiwZWAdMwLfeiS0hcHGN9ky/uPvo8lDncqcULJKMAxrDzY9fdAuoPF9mrvPeU7Lf3SZJBPMdU4+w2XJPscJAQeZUIRTix5WCEuE8zjHazHja3vC70w/8n7TM23U5hJjxwqfynUtmbGbBcLVLaL+pNNzM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=l1x8DM94; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="l1x8DM94"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4b3F9l2xyVzm0djp;
	Thu, 22 May 2025 17:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1747933705; x=1750525706; bh=GGakmPhy3hamGEZuTyZ5AJBh
	7xrIXrw4kicLo4A6GJY=; b=l1x8DM94EjgvXUV+eZoJ0XKGUYko9TS1QiZmwbth
	xYoDz86vTq2uledlBIr4LfzP2AwozT6o2M/tMebURSLu8s/XkIRJnTp13otHF0Yu
	W452K7U/+lOhVASA48lxf9SsVhoifV9roKxXt+Y60sfzIQxHdEiMpYVdSUKfY2Bx
	6zPwuTKY7YmjPYDqx/7PNzndn2wWVwLgc6nMQMnwCmQWQVmTvCsJC/JXto7Kbhe3
	jwi8iwkBy3pnFx42AcZr7sgjRFRQ0PaHa9Y49uxXfBf5uekWDk78FWuILAmWSvYa
	sUyBTpn9HxT+5IzeNcXiXpmQw/mEzqlPUzM3PxZEy0lCag==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YysWLkPlmvZr; Thu, 22 May 2025 17:08:25 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4b3F9c4hSzzm1Hbt;
	Thu, 22 May 2025 17:08:19 +0000 (UTC)
Message-ID: <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
Date: Thu, 22 May 2025 10:08:18 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250514202937.2058598-1-bvanassche@acm.org>
 <20250514202937.2058598-2-bvanassche@acm.org> <20250516044754.GA12964@lst.de>
 <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org> <20250520135624.GA8472@lst.de>
 <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org> <20250521055319.GA3109@lst.de>
 <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org>
 <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/25 10:12 PM, Damien Le Moal wrote:
> I am still very confused about how this is possible assuming a well behaved user
> that actually submits write BIOs in sequence for a zone. That means with a lock
> around submit_bio() calls. Assuming such user, a large write BIO that is split
> would have its fragments all processed and added to the target zone plug in
> order. Another context (or the same context) submitting the next write for that
> zone would have the same happen, so BIO fragments should not be reordered...
> 
> So to clarify: are we talking about splits of the BIO that the DM device
> receives ? Or is it about splits of cloned BIOs that are used to process the
> BIOs that the DM device received ? The clones are for the underlying device and
> should not have the zone plugging flag set until the DM target driver submits
> them, even if the original BIO is flagged with zone plugging. Looking at the bio
> clone code, the bio flags do not seem to be copied from the source BIO to the
> clone. So even if the source BIO (the BIO received by the DM device) is flagged
> with zone write plugging, a clone should not have this flag set until it is
> submitted.
> 
> Could you clarify the sequence and BIO flags you see that leads to the issue ?

Hi Damien,

In the tests that I ran, F2FS submits bios to a dm driver and the dm
driver submits these bios to the SCSI disk (sd) driver. F2FS submits
bios at the write pointer. If that wouldn't be the case, the following
code in block/blk-zoned.c would reject these bios:

	/*
	 * Check for non-sequential writes early as we know that BIOs
	 * with a start sector not unaligned to the zone write pointer
	 * will fail.
	 */
	if (bio_offset_from_zone_start(bio) != zwplug->wp_offset)
		return false;

If the bio is larger than 1 MiB, it gets split by the block layer after
it passed through the dm driver and before it is submitted to the sd
driver. The UFS driver sets max_sectors to 1 MiB. Although UFS host
controllers support larger requests, this value has been chosen to
minimize the impact of writes on read latency.

Earlier emails in this thread show that the bio splitting below the dm
driver can cause bio reordering. See also the call stack that is
available here:

https://lore.kernel.org/linux-block/47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org/

Bart.
