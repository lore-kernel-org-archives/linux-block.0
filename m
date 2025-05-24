Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95CB13C8E8
	for <linux-block@vger.kernel.org>; Sat, 24 May 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748101002; cv=none; b=as7JfqiUq0H/HIxEmjYSjFDkXT5alfjuwCuNKG+e8ETFezZg8Z0WdafRf5OXa2zzZwTaix1TkXHgGlGPfoL+A2DGZGDNYK+2uS+PSNzk5rWFTH7ZdO6DRLLJd+/K8EH5cXdWo3KNescAUQqF3NBxOtYkGmmXw6ZvDx8AzCfqGd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748101002; c=relaxed/simple;
	bh=/GglxHihHrVRRXGrMIYZ2jyVaXs+phP2PDRwzBSzNQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5XdLO0sx7fEqBhJO75fHt8ZsVHMmwYGOY3J6TWLyOaaeNT1L/hBVYJUE+isQ906oPiBnO+5O1VzNJoToeGYAWXdsHvFJWhbVFQ74aC1VPf14cR9pGF4XZWFaIdYZONwsO23Z6XSvI2yvVIREW0CkDm2OcA1RFO1ZzMbaKVjjrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEN74HHq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEN74HHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFD9C4CEE4;
	Sat, 24 May 2025 15:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748101002;
	bh=/GglxHihHrVRRXGrMIYZ2jyVaXs+phP2PDRwzBSzNQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aEN74HHqhjfw5JGdUJYkMVbtjjeS2EqiTCzEFOTzUzhCc+VXnL/xV1eiec5u8ZUeU
	 SlgxvZ6to9ch12RgGzkDq3sFJxompQ+KLdkWlkvvgLIdnAmfyLSUWLkyzj0YV81aQ5
	 mzBBQELQfJ7YczfuZ5q0w9v4pX5JHkgNVlAoKsfi1NhkZ33I6gUQiuE6VUpaOkOJHn
	 hYACsPMRzHuD2iLLDFt/MPx9RWsVNm9H7u0big4/58iCRKadb2GHb5jSn6L0xCKxBF
	 rPudBChfnwELI3T+4+437AM729UoP68AtoxMZ9eL9sRJSB1NbkZ8FegUz5v3/vduzE
	 qAB+fkhiBw1eA==
Message-ID: <6365a731-0864-4564-b2f6-deeb4e3760f3@kernel.org>
Date: Sat, 24 May 2025 17:36:36 +0200
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
 <4128be53-b3be-48a5-8d53-9e0ef40c6d64@kernel.org>
 <a67e1ba3-e231-405f-9927-e6c40db3f71e@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <a67e1ba3-e231-405f-9927-e6c40db3f71e@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/24/25 16:05, Bart Van Assche wrote:
> On 5/24/25 1:48 AM, Damien Le Moal wrote:
>> Note that our internal test suite runs *lots* of different zoned devices (SMR
>> HDD, ZNS SSDs, nullblk, tcmu-runner ZBC device, scsi_debug, qemu nvme zns
>> device) against *lots* of configurations for file systems (xfs, btrfs, zonefs)
>> and DM targets (dm-crypt, dm-linear) and we have not seen any reordering issue,
>> We run this test suite weekly against RC kernels and for-next branch.
> 
> Hi Damien,
> 
> Please consider adding this dm-crypt test to the weekly test run:
> https://lore.kernel.org/linux-block/20250523164956.883024-1-bvanassche@acm.org

We run blktest too, of course. So when Shin'ichiro applies this, it will be part
of the runs.

-- 
Damien Le Moal
Western Digital Research
