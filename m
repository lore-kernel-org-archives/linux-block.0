Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189177DA8C
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747980163; cv=none; b=Iouyzt/Ri9CFi0NDZfPQqzaMBLCmmlzunC9+ST/3z31M7h/GAoeSFC/3gk887hoF+hfgmkpEpnY7vx6eoPPfcPWwHJNPf0uLd5x+I5ptk6pQYkIWHLWaFRjPUjKWCoLDA0r1jqKv4tR3NB9w3ockrHQFXBsL4M/+Lg9d0ht0cRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747980163; c=relaxed/simple;
	bh=alOf9JAa+z4RPcPNVbok+ZLLpLB1RSCpNBko/OTXvlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWhq4dCKUd8FOMKJT1VazkZTx57XbdxZTyJv4WTQ/9LJlgCyFcHhX0OaT4aJo0VXiVP0aKZmt/NPcLkGUzrelQCcZsNS5atsDTEzV/3sx6v9dg97A4l1z4Bx5pH70LfLlE2kP7pRyXy2HiX0IY+tBOXu1BbaAHfSaNbB/j7KOgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdaXITpa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdaXITpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88031C4CEE9;
	Fri, 23 May 2025 06:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747980162;
	bh=alOf9JAa+z4RPcPNVbok+ZLLpLB1RSCpNBko/OTXvlg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qdaXITpaw8CEid6vRlc78VZtkV0JFGwUmxM3S/1gSWFNIhzRWYgBvZg8t61+fl1z0
	 g4xeGKRb5IvPXtLkEh7gUZuc/7ZJN66OMAjy8E3wt3Nn32BBmzcSni8OjWzjwWlysL
	 jv1qVD4aeHkFxIaNmfoXBbvKKfKWQ6e88Wp58ZCGr5Pj9ePgdDvDKbT7f6gl65xUk+
	 PAfECDn9h4Vh7EpF5CTwU8dFhgTHhmDpIJv2tIgxICQkhxjc65F42AlKNx6SVnGnGc
	 19VGBIKj8E5OtTeHTN3g/m+pyLYaN4EImUHq71dh79KGjDKewhG5DDEBw+0vALcBeg
	 C024dfcwnG84w==
Message-ID: <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
Date: Fri, 23 May 2025 08:02:38 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250514202937.2058598-1-bvanassche@acm.org>
 <20250514202937.2058598-2-bvanassche@acm.org> <20250516044754.GA12964@lst.de>
 <47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org> <20250520135624.GA8472@lst.de>
 <d28b6138-7618-4092-8e05-66be2625ecd9@acm.org> <20250521055319.GA3109@lst.de>
 <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org>
 <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
 <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 19:08, Bart Van Assche wrote:
> On 5/21/25 10:12 PM, Damien Le Moal wrote:
>> I am still very confused about how this is possible assuming a well behaved user
>> that actually submits write BIOs in sequence for a zone. That means with a lock
>> around submit_bio() calls. Assuming such user, a large write BIO that is split
>> would have its fragments all processed and added to the target zone plug in
>> order. Another context (or the same context) submitting the next write for that
>> zone would have the same happen, so BIO fragments should not be reordered...
>>
>> So to clarify: are we talking about splits of the BIO that the DM device
>> receives ? Or is it about splits of cloned BIOs that are used to process the
>> BIOs that the DM device received ? The clones are for the underlying device and
>> should not have the zone plugging flag set until the DM target driver submits
>> them, even if the original BIO is flagged with zone plugging. Looking at the bio
>> clone code, the bio flags do not seem to be copied from the source BIO to the
>> clone. So even if the source BIO (the BIO received by the DM device) is flagged
>> with zone write plugging, a clone should not have this flag set until it is
>> submitted.
>>
>> Could you clarify the sequence and BIO flags you see that leads to the issue ?
> 
> Hi Damien,
> 
> In the tests that I ran, F2FS submits bios to a dm driver and the dm
> driver submits these bios to the SCSI disk (sd) driver. F2FS submits

Which DM driver is it ? Does that DM driver have some special work queue
handling of BIO submissions ? Or does is simply remap the BIO and send it down
to the underlying device in the initial submit_bio() context ? If it is the
former case, then that DM driver must enable zone write plugging. If it is the
latter, it should not need zone write plugging and ordering will be handled
correctly throughout the submit_bio() context for the initial DM BIO, assuming
that the submitter does indeed serialize write BIO submissions to a zone. I have
not looked at f2fs code in ages. When I worked on it, there was a mutex to
serialize write issuing to avoid reordering issues...

> bios at the write pointer. If that wouldn't be the case, the following
> code in block/blk-zoned.c would reject these bios:
> 
> 	/*
> 	 * Check for non-sequential writes early as we know that BIOs
> 	 * with a start sector not unaligned to the zone write pointer
> 	 * will fail.
> 	 */
> 	if (bio_offset_from_zone_start(bio) != zwplug->wp_offset)
> 		return false;
> 
> If the bio is larger than 1 MiB, it gets split by the block layer after
> it passed through the dm driver and before it is submitted to the sd
> driver. The UFS driver sets max_sectors to 1 MiB. Although UFS host
> controllers support larger requests, this value has been chosen to
> minimize the impact of writes on read latency.

As mentioned above, the splitting and adding to the zone write plug should all
be serialized by the submitter, using whatever mean is appropriate there. As
long as submit_bio() is ongoing processing a large BIO and splitting it, if the
submitter is correctly serialzing writes, I do not see how splitting can result
in reordering...

> Earlier emails in this thread show that the bio splitting below the dm
> driver can cause bio reordering. See also the call stack that is
> available here:
> 
> https://lore.kernel.org/linux-block/47b24ea0-ef8f-441f-b405-a062b986ce93@acm.org/

I asked for clarification in the first place because I still do not understand
what is going on reading that lightly explained backtrace you show in that
email. A more detailed time flow explanation of what is happening and in which
context would very likely clarify exactly what is gong on.

So far, the only thing I can think of is that maybe we need to split BIOs in DM
core before submitting them to the DM driver. But I am reluctant to send such
patch because I cannot justify/expalin its need based on your explanations.


-- 
Damien Le Moal
Western Digital Research
