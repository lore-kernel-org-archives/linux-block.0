Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB534A334
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289779; cv=none; b=jvpLhf64vN3vdEMIv0CKwYbO8vmLln7epA717S6ZpXN/8FATmo5xWrmiDu1WgUm49+mdG4MAY5JXQAcVdvTX1hyeu/6cDwNVO0cU6aFj1A4AD8jp/43BaRer5bUl1rrIIgTcBCPgsFBLzzt7aLs38U3yt04kz+24rPLuZm+Slq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289779; c=relaxed/simple;
	bh=CZqe5rzTDS5ajZjIcC88VV1OoN4rTkwjNr3LOMmJSW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDOik4XkQIo1z9CVdd4mle6waRLEIz69frD2zJjjc1fLoxwh5IhcRPu2rO1o5VCagpuZeRpAJj3gjT8Sg0KwOrqGhF4wnJ3EWw50uctxLpUaYy74L4wAJwi/HZRjmXV39lk2fgH2pg0z0T44eqFewaznl76/KjmyVfUhSikQmeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lSlEYh2D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G5IgJnA2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lSlEYh2D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G5IgJnA2"
Date: Wed, 27 Aug 2025 12:16:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756289776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7z4kOkb9hJ5KDJ7AViQ8ws/d+x00zbISk9ncb+f0SBk=;
	b=lSlEYh2DN9jgZYMsEqm8iUPctwZCanA05KGl62AiwDceD49ZYGCyfg/BRjtdVuCvzJGTWR
	ckcA4Qcc2x+BTr2/PkeBdEdG2eBX6ZpAc0VCrYKp1JwtK6XWH2k/xgjOTLGfUIBkMhIVl7
	7ftU3vwc2WngKYOEyUHI8cFAqRJePrWUByJWM6BpFskEYNJklQjAmNUB8OB5voPPbYwGNa
	SWNiYW2DzEx7jzfruVDTQekht+jzQROqG1N/whAk47BuS/6vnyCVKwXAJywSmY8hBnDFRm
	8SwYBDD88W1Rlukmg5vIikvM+fajAax8k2bk6BoRZOYA2XyJSFT2D/WeopFXZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756289776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7z4kOkb9hJ5KDJ7AViQ8ws/d+x00zbISk9ncb+f0SBk=;
	b=G5IgJnA2BvwMrCwiHFriaLI2ml1hac0nZXXi99JSUtpruyXSPXQjcSZzAKG6Tha1gUKRjX
	fbNMACPMH0NJTYAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
Message-ID: <20250827101614.K6_74JSa@linutronix.de>
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <175078375641.82625.9467584315092336312.b4-ty@kernel.dk>
 <20250827070705.4iWhHGPE@linutronix.de>
 <20250827073836.GA25169@lst.de>
 <20250827075221.6hTi-i7m@linutronix.de>
 <39ac5089-794c-4e50-a090-6dabf4a60575@kernel.org>
 <20250827084248.tLS5-C5i@linutronix.de>
 <ebd83628-162c-4f5e-9563-8713cbf5854e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebd83628-162c-4f5e-9563-8713cbf5854e@kernel.org>

On 2025-08-27 18:01:58 [+0900], Damien Le Moal wrote:
> Yep, looks like it.
> What is the driver used for that "PowerEdge R6525 which exposes a "DELLBOSS VD"
> device with firmware MV.R00-0" ? Is it the regular ahci driver ?
> If yes, we can quirk it to limit the max command size, but we would need to
> know what the limit is. That means repeating that test with varying max command
> sise (max_sectors_kb) to try to figure out the threshold.

issued 'dd if=/dev/sda of=/dev/null bs=4M count=1 iflag=direct'

| echo 3584 > /sys/block/sda/queue/max_sectors_kb

survives

| echo 4096 > /sys/block/sda/queue/max_sectors_kb
dies after a few attempts.

| lrwxrwxrwx 1 root root 0 Aug 27 11:01 0:0:0:0 -> ../../../devices/pci0000:a0/0000:a0:03.1/0000:a1:00.0/ata1/host0/target0:0:0/0:0:0:0
| a1:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9230 PCIe 2.0 x2 4-port SATA 6 Gb/s RAID Controller (rev 11)
|         Subsystem: Dell BOSS-S1 Adapter
|         Kernel driver in use: ahci
|         Kernel modules: ahci

so a Marvell one. Interesting.

> And maybe contact Dell support too if this is still a supported device.
> (I have zero experience with this, no idea what that DELLBOSS VD is...)

There are two physical disks which are behind this controller and
exposed as one virtual device after applying some raid magic. I have no
idea if this limitation is due to the physical device or the controller.

Now, how do I put this. The disk behind it is an INTEL SSDSCKKB240G8R.
The firmware XC31DL6P exposed this problem. After an update to XC31DL6R
the problem is gone.

Sebastian
