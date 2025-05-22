Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49367148827
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 05:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747890759; cv=none; b=lnV9rERpCdQYJiRlKAivz6pQrREODRyAPtHRpj0RpfzQ7q7jGEgNDCaHyb4EgRVaVqSyjxynhUDtBg+WlRswSels/ZnwG3m5u//vkD8s8GMMNjtRptR935ajVdP/AWKs2C6OmDnKRqLnJL+cZMTSUEFZlgaLkAVpsoj+h0g+3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747890759; c=relaxed/simple;
	bh=A/finqJYmBmQ5ZVkwqy1P1GV8gIrZ+qZDivS8Q14pyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgpwE1SRxOaR4/jPUigE+AyxH79KZJhHD8BsaAu3ndAirPtXeO15XYrX9l0CfrVvY39302ZcmZC31Zf63Frycc7OQNuo4Zu9lf4MO3ln8d38pDKcGuYTZmRc9vfrgLFS9uXwgvdtGKxBdTxSXMl8ZajcZMCcTQERrolXIo3jhpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfRsPx9N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfRsPx9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA706C4CEE4;
	Thu, 22 May 2025 05:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747890758;
	bh=A/finqJYmBmQ5ZVkwqy1P1GV8gIrZ+qZDivS8Q14pyc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bfRsPx9NmppKDCoV9ggyFKgYoCsepzk3/uMpPkl31DdcPlPkS2TKsttItOH2kH/z1
	 5nKAdu4gnKarrm8yLcNtrTWesDR5bArAVj24d2X3Uhg1250sPtNUFPVuUR+XkSh9sJ
	 d97pnw1anKcVghrIHKGO/v0RwspA/HFgpRja9sEcK7ENyBXA7u6rpGJmx8wxjGrJSo
	 6Op/+7vKJIcniR3ruwLe6lXlIZ3HDoE3bBH6xXE5m8VwwC1Qju7HHYvJ4kvUYtvlDW
	 FJluvNKB2kRoUh7VxJi5n3Z1tQWEMEm79yi1/1Q94vQvhGE8PuHWjnSkyTevENnnVZ
	 6KWsdMgfLGtQA==
Message-ID: <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
Date: Thu, 22 May 2025 07:12:34 +0200
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
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 23:18, Bart Van Assche wrote:
> On 5/20/25 10:53 PM, Christoph Hellwig wrote:
>> On Tue, May 20, 2025 at 11:09:15AM -0700, Bart Van Assche wrote:
>>> If the sequential write bios are split by the device mapper, sorting
>>> bios in the block layer is not necessary. Christoph and Damien, do you
>>> agree to replace the bio sorting code in my previous email with the
>>> patch below?
>>
>> No.  First please create a reproducer for your issue using null_blk
>> or scsi_debug, otherwise we have no way to understand what is going
>> on here, and will regress in the future.
>>
>> Second should very much be able to fix the splitting in dm to place
>> the bios in the right order.  As mentioned before I have a theory
>> of how to do it, but we really need a proper reproducer to test this
>> and then to write it up to blktests first.
> 
> Hi Christoph,
> 
> The following pull request includes a test that triggers the deadlock
> fixed by patch 2/2 reliably:
> 
> https://github.com/osandov/blktests/pull/171

+Shin'ichiro so that he is aware of the context.

Please share the blktest patch on this list so that we can see how you recreate
the issue. That makes it easier to see if a fix is appropriate.

> I do not yet have a reproducer for the bio reordering but I'm still
> working on this.

I am still very confused about how this is possible assuming a well behaved user
that actually submits write BIOs in sequence for a zone. That means with a lock
around submit_bio() calls. Assuming such user, a large write BIO that is split
would have its fragments all processed and added to the target zone plug in
order. Another context (or the same context) submitting the next write for that
zone would have the same happen, so BIO fragments should not be reordered...

So to clarify: are we talking about splits of the BIO that the DM device
receives ? Or is it about splits of cloned BIOs that are used to process the
BIOs that the DM device received ? The clones are for the underlying device and
should not have the zone plugging flag set until the DM target driver submits
them, even if the original BIO is flagged with zone plugging. Looking at the bio
clone code, the bio flags do not seem to be copied from the source BIO to the
clone. So even if the source BIO (the BIO received by the DM device) is flagged
with zone write plugging, a clone should not have this flag set until it is
submitted.

Could you clarify the sequence and BIO flags you see that leads to the issue ?


-- 
Damien Le Moal
Western Digital Research
