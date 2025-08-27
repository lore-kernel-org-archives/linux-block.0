Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFEB2F3C0E
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756285491; cv=none; b=KFa2HkTY+90EYeUKqfJ/XdFZOuVcsin5ThGtRd614U1qQiBNZjVA8oodIp6lv4OTkWyXz5jEizzCw1Et0mjcpYKnchq4cfgE/r1XXRB3Gcezr05KEb2OBq9DQur8JYcBVAm04kaysrnV/pyb0ZeU44SZox+RxZlGVSJzTP7mNgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756285491; c=relaxed/simple;
	bh=h8Nh6vjagkTKh4v7APxW+XLaKYxIafmSdsb9jWC3U8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ulywh8biypliRWYKN6aom3Qo+8bNT6UitTNjyLah6hzytifw9DI5h4G1qAColZuYryAIUpm/zA0YjlMrLXrh8VPKgh+Ul4bw+kS8bwrGqwNhVrUzRw8e8iTm41pNY18ov1AwpTzN+mhJ9ILp9lTceV6agrpKw8Ruoc10f2KVb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8a6eFvL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8a6eFvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0727FC4CEEB;
	Wed, 27 Aug 2025 09:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756285490;
	bh=h8Nh6vjagkTKh4v7APxW+XLaKYxIafmSdsb9jWC3U8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h8a6eFvL7RFwGj+3incQ3Jd/LRsY663tu2RxCs0Lm/DKKuJH7ffregwUuU442sifv
	 2z04h5z5t4Ao/y8SOw1ActdrBZNzseCZE00tMZlvPHOR95mQeGrnSzpC2SE2+VFKAN
	 vsFcJG+caYW3gCWSSkxB032YdX1gTgQF1fcJ28pySfIqPVZHPe5iOtIgYgVonYHD2u
	 CV1q8sqe9NFtYDC9dhCDn94BXyfIou3ELu8tEVGGrf2h76zaYKN8VmnrDUZT31FwZu
	 gkRVQZS4ulsMiri2YXCGu7y/casAkudFkaedIoCxLUe12bpcHoChQIBeVJX4ppfxg6
	 AL2B+WObD8n5Q==
Message-ID: <ebd83628-162c-4f5e-9563-8713cbf5854e@kernel.org>
Date: Wed, 27 Aug 2025 18:01:58 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <175078375641.82625.9467584315092336312.b4-ty@kernel.dk>
 <20250827070705.4iWhHGPE@linutronix.de> <20250827073836.GA25169@lst.de>
 <20250827075221.6hTi-i7m@linutronix.de>
 <39ac5089-794c-4e50-a090-6dabf4a60575@kernel.org>
 <20250827084248.tLS5-C5i@linutronix.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250827084248.tLS5-C5i@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 5:42 PM, Sebastian Andrzej Siewior wrote:
> On 2025-08-27 17:01:49 [+0900], Damien Le Moal wrote:
>> Don't read a file. Read the disk directly. So please use "if=/dev/sdX".
>> Also, there is no way that a 1GiB I/O will be done as a single large command.
>> That is not going to happen.
>>
>> With 345c5091ffec reverted, what does:
>>
>> cat /sys/block/sdX/queue/max_sectors_kb
>> cat /sys/block/sdX/queue/max_hw_sectors_kb
>>
>> say ?
> 
> | # cat /sys/block/sda/queue/max_sectors_kb
> | 1280
> | # cat /sys/block/sda/queue/max_hw_sectors_kb
> | 32767
> 
>> Likely, the first one is "1280". So before running dd, you need to do:
>>
>> echo 4096 > /sys/block/sdX/queue/max_sectors_kb
>>
>> and then
>>
>> dd if=/dev/sdX of=/dev/null bs=4M count=1 iflag=direct
> 
> | # echo 4096 > /sys/block/sda/queue/max_sectors_kb
> | # cat /sys/block/sda/queue/max_sectors_kb 
> | 4096
> | # dd if=/dev/sda of=/dev/null bs=4M count=1 iflag=direct
> | 1+0 records in
> | 1+0 records out
> | 4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.00966543 s, 434 MB/s
> 
> It passed.
> After a reboot I issued the same dd command five times and all came
> back. Then I increased the sector size and issued it again. The first
> two came back and then
> 
> | root@zen3:~# dd if=/dev/sda of=/dev/null bs=4M count=1 iflag=direct
> | 1+0 records in
> | 1+0 records out
> | 4194304 bytes (4.2 MB, 4.0 MiB) copied, 33.1699 s, 126 kB/s
> | root@zen3:~# dd if=/dev/sda of=/dev/null bs=4M count=1 iflag=direct
> | 1+0 records in
> | 1+0 records out
> | 4194304 bytes (4.2 MB, 4.0 MiB) copied, 57.3711 s, 73.1 kB/s
> | root@zen3:~# dd if=/dev/sda of=/dev/null bs=4M count=1 iflag=direct
> | 1+0 records in
> | 1+0 records out
> | 4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.0264171 s, 159 MB/s
> 
> They all came back but as you see on the speed side, it took while. And
> I see
> | [  191.641315] ata1.00: exception Emask 0x0 SAct 0x800000 SErr 0x0 action 0x6 frozen
> | [  191.648839] ata1.00: failed command: READ FPDMA QUEUED
> | [  191.653995] ata1.00: cmd 60/00:b8:00:00:00/20:00:00:00:00/40 tag 23 ncq dma 4194304 in
> |                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> | [  191.669306] ata1.00: status: { DRDY }
> | [  191.672981] ata1: hard resetting link
> | [  192.702763] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> | [  192.702964] ata1.00: Security Log not supported
> | [  192.703207] ata1.00: Security Log not supported
> | [  192.703215] ata1.00: configured for UDMA/133
> | [  192.703282] ata1: EH complete
> | [  248.985303] ata1.00: exception Emask 0x0 SAct 0x10001 SErr 0x0 action 0x6 frozen
> | [  248.992733] ata1.00: failed command: READ FPDMA QUEUED
> | [  248.997889] ata1.00: cmd 60/00:00:00:00:00/20:00:00:00:00/40 tag 0 ncq dma 4194304 in
> |                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> | [  249.013107] ata1.00: status: { DRDY }
> | [  249.016775] ata1.00: failed command: WRITE FPDMA QUEUED
> | [  249.022011] ata1.00: cmd 61/08:80:40:d1:18/00:00:00:00:00/40 tag 16 ncq dma 4096 out
> |                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)

The drive is not responding. So likely a drive/adapter FW bug.

> | [  249.037135] ata1.00: status: { DRDY }
> | [  249.040802] ata1: hard resetting link
> | [  250.076059] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> | [  250.076258] ata1.00: Security Log not supported
> | [  250.076471] ata1.00: Security Log not supported
> | [  250.076478] ata1.00: configured for UDMA/133
> | [  250.076537] ata1: EH complete
> 
>> And you will likely trigger the issue, even with 345c5091ffec reverted.
>> The issue is likely caused by a FW bug handling large commands.
>> Please try.
> Done. It seems the firmware is not always dedicated to fulfill larger
> requests.

Yep, looks like it.
What is the driver used for that "PowerEdge R6525 which exposes a "DELLBOSS VD"
device with firmware MV.R00-0" ? Is it the regular ahci driver ?
If yes, we can quirk it to limit the max command size, but we would need to
know what the limit is. That means repeating that test with varying max command
sise (max_sectors_kb) to try to figure out the threshold.

And maybe contact Dell support too if this is still a supported device.
(I have zero experience with this, no idea what that DELLBOSS VD is...)


-- 
Damien Le Moal
Western Digital Research
