Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E732254D
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281991; cv=none; b=iLyBdOATAUdlfYTw5t94XEg9lewBaKMhm3M3ziDGaqnpUs/p2khcZyvdN0DqM/szpSSzCBpnLS+i1U7w7UmefdSDQGnCR1lC/nZcCuOL73THJLvFLy7648iofIW+VgPP3kIndmlzk9LTGKZRqlZqy3IhLBPJkOj1qhn0/uuqRw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281991; c=relaxed/simple;
	bh=zGQUkk728L+OVMQRWnn6I3XGCVDq5RhtFvWlJYrkX7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbvOPcTqfUAQwloEfrw9lgPXlGf75PjKIJiRd0B99rCEDMk1NMuAZNE1e9b4kIEWL5WzHmy/eIwFSZIzkMf0PcR8NMY8CBXZ6FYNyBSaL7xfuC1YqxCUJ8LjH9KZqYEZK8ihb+Qcy41ptu5G+SAUDHkQXo6noTua1Y7v6M+KvfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma+a2TfN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma+a2TfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EBFC4CEEB;
	Wed, 27 Aug 2025 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756281991;
	bh=zGQUkk728L+OVMQRWnn6I3XGCVDq5RhtFvWlJYrkX7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ma+a2TfNrMjTfWt80uvDdVDuAiLZMs1s3BHLxiXLQenARcYi7bW1yewJxuEz2VJR4
	 lL/CV4okv1aZoxp/T5OGZNZSg6+YX5at7u4jkuk7JZmFKfhm9p5wRKqae9rJ+Jhmjq
	 jRnQ30DiLtCmxdXzVUZcoFJawJwh+LjssKllr22gN+erMp8IfcglDGcaZsJKwJwDcg
	 UNc5TMHA0V0VycMmgj3FMSMIOfJMsA/IinQqvJNXID5zH1IrYppNwRK32nYwGTvJgy
	 F4lUt7U3JNoDJRxscwHZQ2KEWJdFgE6D4P/pfZPzO4BYIlY7wt9R6CO2Id9GA//7VE
	 AnjWfPXmnmWWw==
Message-ID: <abe68354-0a8f-4ff5-b131-5a0fdeb11716@kernel.org>
Date: Wed, 27 Aug 2025 17:03:39 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
To: Christoph Hellwig <hch@lst.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <175078375641.82625.9467584315092336312.b4-ty@kernel.dk>
 <20250827070705.4iWhHGPE@linutronix.de> <20250827073836.GA25169@lst.de>
 <20250827075221.6hTi-i7m@linutronix.de> <20250827080003.GA26652@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250827080003.GA26652@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 5:00 PM, Christoph Hellwig wrote:
> On Wed, Aug 27, 2025 at 09:52:21AM +0200, Sebastian Andrzej Siewior wrote:
>>> this for you, you could also reproduce it before by say doing a large
>>> direct I/O read.
>>
>> On a kernel without that commit in question? Booting Debian's current
>> v6.12 and
>> |  dd if=vmlinux.o of=/dev/null bs=1G count=1 iflag=direct
>>
>> works like a charm. According to strace it does
>> | openat(AT_FDCWD, "vmlinux.o", O_RDONLY|O_DIRECT) = 3
>> | dup2(3, 0)                              = 0
>> | lseek(0, 0, SEEK_CUR)                   = 0
>> | read(0, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\1\0>\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 1073741824) = 841980992
>>
>> so it should be what you asked for. Asked for 1G, got ~800M.
> 
> This is probably splitting thing up into multiple bios because your
> output memory is fragmented.  You'd have to do it into hugetlbfs or
> vma otherwise backed by very larger folios.

and also need:

echo 4096 > /sys/block/sdX/queue/max_sectors_kb

or some large number.

But given that commit 345c5091ffec sets the default to 4MiB, I/Os are split to
4M and trigger the issue. So there is likely a cut-off command size < 4M where
things stop working with this adapter.


-- 
Damien Le Moal
Western Digital Research
