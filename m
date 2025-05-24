Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D36EC8F0
	for <linux-block@vger.kernel.org>; Sat, 24 May 2025 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748076485; cv=none; b=mDHrLbFUxE7QdFRhx7yVEM+JKbsFNKKU/z1rE44k/0qhpl+xg2+uyevA/OalUYRm/pzU6irP8Pf3ewosKfal5xQOvFFzjnuje703nxfcDJC/KPbw3txaoo/vKjvEX955FbEr/fjYY6y3kPjS5aWtvc758jlVWZp9Z6z3wpRLZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748076485; c=relaxed/simple;
	bh=flDxqf//8d8l1OigLZnSCiaHac2jtb0MB45xQgidV/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqolRIjDaHOc20xrJJEvWfcIk0kYRUOBOLQD/K9alodcCFS77GiA9E5bBbaJwXPoIbFz7xgboUic1p4QaWaIPD6l7ne47aTxlabZpfsoinuS4v10yYlFdmesShDJHn8g+y4BKfyNlZtOg2vclJ78H05OlajLuI6QaJupSsMwijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L73xkmWw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L73xkmWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0571C4CEE4;
	Sat, 24 May 2025 08:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748076484;
	bh=flDxqf//8d8l1OigLZnSCiaHac2jtb0MB45xQgidV/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L73xkmWwwaj9D4ra5byK1cyhG4HScHqxowsNAsYKdabHjmOcbcsgmz2DsyS/4Koam
	 JhhiFQRZ7xfZodM9pmahRjETap5V7Ipk1eHWwqLabgzSD/DEPqoIvABkUJzwGA7794
	 +wLKBKVUqwigU34/8TW6PePigSgskKPQVHSSMGOZvMNcexJzro2XfRejPsKDUxW6bd
	 J/nsLpGs5qHQ7Qx406aVhYhE75eaYOVa6yBt/PSAMQjqBk2t2OcxKEEW3Ku85Pwswl
	 HsZBKXdWmFxiuAkP7hhaHcdyw1NHHaCxyHCSxewPPURvJgrWT7U1wTpi/LcHikqjcq
	 Hn+rk+KPrVKNQ==
Message-ID: <4128be53-b3be-48a5-8d53-9e0ef40c6d64@kernel.org>
Date: Sat, 24 May 2025 10:48:00 +0200
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
 <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/25 18:30, Bart Van Assche wrote:
> On 5/22/25 11:02 PM, Damien Le Moal wrote:
>> On 5/22/25 19:08, Bart Van Assche wrote:
>  > [ ... ]
>> Which DM driver is it ? Does that DM driver have some special work queue
>> handling of BIO submissions ? Or does is simply remap the BIO and send it down
>> to the underlying device in the initial submit_bio() context ? If it is the
>> former case, then that DM driver must enable zone write plugging. If it is the
>> latter, it should not need zone write plugging and ordering will be handled
>> correctly throughout the submit_bio() context for the initial DM BIO, assuming
>> that the submitter does indeed serialize write BIO submissions to a zone. I have
>> not looked at f2fs code in ages. When I worked on it, there was a mutex to
>> serialize write issuing to avoid reordering issues...
> 
> It is the dm-default-key driver, a driver about which everyone
> (including the authors of that driver) agree that it should disappear.
> Unfortunately the functionality provided by that driver has not yet been
> integrated in the upstream kernel (encrypt filesystem metadata).
> 
> How that driver (dm-default-key) works is very similar to how dm-crypt
> works. I think that the most important difference is that dm-crypt
> requests encryption for all bios while dm-default-key only sets an
> encryption key for a subset of the bios it processes.
> 
> The source code of that driver is available here:
> https://android.googlesource.com/kernel/common/+/refs/heads/android16-6.12/drivers/md/dm-default-key.c

Well, this is an out of tree driver. Not touching this.
Unless you can reproduce the issue with dm-crypt (or any other DM target that is
upstream), I will not even try to debug this.

Note that our internal test suite runs *lots* of different zoned devices (SMR
HDD, ZNS SSDs, nullblk, tcmu-runner ZBC device, scsi_debug, qemu nvme zns
device) against *lots* of configurations for file systems (xfs, btrfs, zonefs)
and DM targets (dm-crypt, dm-linear) and we have not seen any reordering issue,
We run this test suite weekly against RC kernels and for-next branch.


-- 
Damien Le Moal
Western Digital Research
