Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB8E33A00E
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284172; cv=none; b=N+hZtd8+tAJ/FkaRIPLpkgkaof1XmLgUYOMaiMSyNB5nva8KrzD3doKgExNWlDAQLIkfvRZzqLbhnPlw52CFJ4FwXG4NO+2lqklfT5rNEYUS0xFog5l8R0cM30DA0o/yVCjQNTcBSvHwzHbG6TCjEGCb8wgwOLah5Pgi+ZeP328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284172; c=relaxed/simple;
	bh=zlsk2zOzk9KYHzhk1LzeST1WauthAbkauFvG8nbX8+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNn27YIsLI4MOavk/by2fg5O7x4i7Fhr3Kty9c4Ajts0vXSxxMrvCdTpnkBYfRPvfbjW1YTal2tu9BYv2+m+FGJp/jMXuXbK77aVitPxpJVW7jr3DCKDPvXYUrqA5dMJCfs/Xb4vbJc6N+tJf3baijnF6DydgXQFMheiD808Ng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1YHAn1bC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gQ2z1j8d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1YHAn1bC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gQ2z1j8d"
Date: Wed, 27 Aug 2025 10:42:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756284169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9697rRianlWm8lAUBcz/4h03JjfH94JM+MdYN8KdjfY=;
	b=1YHAn1bCbACW6M/bZCPtl339hv58HFfAZN22pECKgD17mUstQzUP1XVvmjVu5BYtpiRNhs
	TelnoIrppyNVvwz+rdqN9V6KjhzNiZUfpi+PWQt0aC1l1XNG+Gt9F+DDp/N2QhAzrVNuIi
	lXqKoDCArHU1ZBAfqHGmPi1Kn3bkK+rc7DTFhEeOGf1rmFGjDcqM5mmW1mIwRYolIFoVl5
	ZT91DQk8SUseJ2orE4Z+eKl0Y7RfFEBo/EaLYPW+w7buCqnuEPPt7LhYGAfAYZfeh1nmsN
	KFhoUCcZXy3EnSJBpRper0utMo5ZkTKFWV11Es4Z1/Atk67GKQrh7zkHLSuMww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756284169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9697rRianlWm8lAUBcz/4h03JjfH94JM+MdYN8KdjfY=;
	b=gQ2z1j8dBQVxUucj4+QgR51RO5Qf339i+9k+JnQyAYVWgYgxrwYic00oKqvPE16/OMTjC9
	DT2aJtOgTi0DeoAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
Message-ID: <20250827084248.tLS5-C5i@linutronix.de>
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <175078375641.82625.9467584315092336312.b4-ty@kernel.dk>
 <20250827070705.4iWhHGPE@linutronix.de>
 <20250827073836.GA25169@lst.de>
 <20250827075221.6hTi-i7m@linutronix.de>
 <39ac5089-794c-4e50-a090-6dabf4a60575@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39ac5089-794c-4e50-a090-6dabf4a60575@kernel.org>

On 2025-08-27 17:01:49 [+0900], Damien Le Moal wrote:
> Don't read a file. Read the disk directly. So please use "if=/dev/sdX".
> Also, there is no way that a 1GiB I/O will be done as a single large command.
> That is not going to happen.
> 
> With 345c5091ffec reverted, what does:
> 
> cat /sys/block/sdX/queue/max_sectors_kb
> cat /sys/block/sdX/queue/max_hw_sectors_kb
> 
> say ?

| # cat /sys/block/sda/queue/max_sectors_kb
| 1280
| # cat /sys/block/sda/queue/max_hw_sectors_kb
| 32767

> Likely, the first one is "1280". So before running dd, you need to do:
> 
> echo 4096 > /sys/block/sdX/queue/max_sectors_kb
> 
> and then
> 
> dd if=/dev/sdX of=/dev/null bs=4M count=1 iflag=direct

| # echo 4096 > /sys/block/sda/queue/max_sectors_kb
| # cat /sys/block/sda/queue/max_sectors_kb 
| 4096
| # dd if=/dev/sda of=/dev/null bs=4M count=1 iflag=direct
| 1+0 records in
| 1+0 records out
| 4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.00966543 s, 434 MB/s

It passed.
After a reboot I issued the same dd command five times and all came
back. Then I increased the sector size and issued it again. The first
two came back and then

| root@zen3:~# dd if=/dev/sda of=/dev/null bs=4M count=1 iflag=direct
| 1+0 records in
| 1+0 records out
| 4194304 bytes (4.2 MB, 4.0 MiB) copied, 33.1699 s, 126 kB/s
| root@zen3:~# dd if=/dev/sda of=/dev/null bs=4M count=1 iflag=direct
| 1+0 records in
| 1+0 records out
| 4194304 bytes (4.2 MB, 4.0 MiB) copied, 57.3711 s, 73.1 kB/s
| root@zen3:~# dd if=/dev/sda of=/dev/null bs=4M count=1 iflag=direct
| 1+0 records in
| 1+0 records out
| 4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.0264171 s, 159 MB/s

They all came back but as you see on the speed side, it took while. And
I see
| [  191.641315] ata1.00: exception Emask 0x0 SAct 0x800000 SErr 0x0 action 0x6 frozen
| [  191.648839] ata1.00: failed command: READ FPDMA QUEUED
| [  191.653995] ata1.00: cmd 60/00:b8:00:00:00/20:00:00:00:00/40 tag 23 ncq dma 4194304 in
|                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
| [  191.669306] ata1.00: status: { DRDY }
| [  191.672981] ata1: hard resetting link
| [  192.702763] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
| [  192.702964] ata1.00: Security Log not supported
| [  192.703207] ata1.00: Security Log not supported
| [  192.703215] ata1.00: configured for UDMA/133
| [  192.703282] ata1: EH complete
| [  248.985303] ata1.00: exception Emask 0x0 SAct 0x10001 SErr 0x0 action 0x6 frozen
| [  248.992733] ata1.00: failed command: READ FPDMA QUEUED
| [  248.997889] ata1.00: cmd 60/00:00:00:00:00/20:00:00:00:00/40 tag 0 ncq dma 4194304 in
|                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
| [  249.013107] ata1.00: status: { DRDY }
| [  249.016775] ata1.00: failed command: WRITE FPDMA QUEUED
| [  249.022011] ata1.00: cmd 61/08:80:40:d1:18/00:00:00:00:00/40 tag 16 ncq dma 4096 out
|                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
| [  249.037135] ata1.00: status: { DRDY }
| [  249.040802] ata1: hard resetting link
| [  250.076059] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
| [  250.076258] ata1.00: Security Log not supported
| [  250.076471] ata1.00: Security Log not supported
| [  250.076478] ata1.00: configured for UDMA/133
| [  250.076537] ata1: EH complete

> And you will likely trigger the issue, even with 345c5091ffec reverted.
> The issue is likely caused by a FW bug handling large commands.
> Please try.
Done. It seems the firmware is not always dedicated to fulfill larger
requests.

Sebastian
