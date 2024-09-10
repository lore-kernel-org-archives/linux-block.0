Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA4C156;
	Tue, 10 Sep 2024 04:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943545; cv=none; b=MwNJg/c7BXZnRFjIgWzQxnVp3gC9jS1adAYLjH/WKZV9ZmzuTO3Xm72DnqWXgbkS+ZQrdsw8TrFf3K6D2HS/6PvEFuZiWGRLSVkH3PEexMBXSe9n1G63AdFGlRloGmDgh0ulyD3acZNbcZuFk1K8yqGQynp0jKg7tVkGE+5CE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943545; c=relaxed/simple;
	bh=DpO4SfTNR7cQazmETA0EG7veH6h4k339DJdZUuW/Chk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FlUkL2zZfHkJACHKNElUKphk9TYhkhiOVgJc9J3vBoCps7rHFTY4u9kjT+0ewwCxJVrP7IvneSIznbWJ7u0nPL5Kh7pq6zFRXbbENo4pTpLlg07KxYFnkCQJ8KMtVIGhYUIrIsmo2M3i6NMZ7Ccu69sLSjUhCmLYmAUT5orhPoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBjYzdfB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBjYzdfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE20C4CEC3;
	Tue, 10 Sep 2024 04:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725943545;
	bh=DpO4SfTNR7cQazmETA0EG7veH6h4k339DJdZUuW/Chk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lBjYzdfBZtL6pngUjaJ6z6MVf0Xs6MXzik1nHnDbqgSkyaLJ5PEkbpDt6mIEk3i8p
	 9114mWKtmNP+UgeBRm1b46lcWqRc+0bPFRYo4RIzCRkC7TDMHz+nrrRRU8d0gGqOFt
	 Wpmc9G/kGJsRhLc4drADC54QZBnDU6RIR3O9WTs8oon/f5e2uUhf4Y873AOnj8rsi8
	 Yk5ac3KbJR0sh8yCDVnZrhsfSynZ+lI6bACpY6xGNMnkQIG6HLZpXvRu6OkpOY/lQz
	 MJ6YkpdIItvijRuyRVfm0O1BBCHxk4280BU9kRz6ogEejIctsPnF+E78ByYuJzTKcx
	 YzfXYU4Oq7b9g==
Message-ID: <5b4a15be-1cb2-4477-8f17-b808612d10d5@kernel.org>
Date: Tue, 10 Sep 2024 13:45:43 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] block: Non-NCQ commands will never be executed while
 fio is continuously running
To: yangxingui <yangxingui@huawei.com>, axboe@kernel.dk,
 John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 James.Bottomley@HansenPartnership.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 damien.lemoal@opensource.wdc.com
References: <eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com>
 <922e3d52-9567-4371-9a43-6d51f716a370@kernel.org>
 <129e1e4b-426f-3d5b-b95c-d386c90cfe06@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <129e1e4b-426f-3d5b-b95c-d386c90cfe06@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/10/24 10:09 AM, yangxingui wrote:
> 
> 
> On 2024/9/9 21:21, Damien Le Moal wrote:
>> On 9/9/24 22:10, yangxingui wrote:
>>> Hello axboe & John,
>>>
>>> After the driver exposes all HW queues to the block layer, non-NCQ
>>> commands will never be executed while fio is continuously running, such
>>> as a smartctl command.
>>>
>>> The cause of the problem is that other hctx used by the NCQ command is
>>> still active and can continue to issue NCQ commands to the sata disk.
>>> And the pio command keeps retrying in its corresponding hctx because
>>> qc_defer() always returns true.
>>>
>>> hctx0: ncq, pio, ncq
>>> hctx1：ncq, ncq, ...
>>> ...
>>> hctxn: ncq, ncq, ...
>>>
>>> Is there any good solution for this?
>>
>> SATA devices are single queue so how can you have multiple queues ?
>> What adapter are you using ?
> 
> In the following patch, we expose the host's 16 hardware queues to the block
> layer. And when connecting to a sata disk, 16 hctx are used.
> 
> 8d98416a55eb ("scsi: hisi_sas: Switch v3 hw to MQ")

OK, so the HBA is a hisi one, using libsas...
What is the device ? An SSD ? and HDD ?

Do you set a block I/O scheduler for the drive, e.g. mq-deadline. If not, does
setting a scheduler resolve the issue ?

I do not have any hisi HBA. I use a lot of mpt3sas and mpi3mr HBAs which also
have multiple queues with a shared tagset. Never seen the issue you are
reporting though using HDDs with mq-deadline or bfq as the scheduler.

-- 
Damien Le Moal
Western Digital Research
