Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176B1DB546
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 07:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756278430; cv=none; b=u4mRQV+MuKlfn2X1uvScGcTU5RIJqO0KZvZ43KBbk13FE6NVt6jdnf1fMDkq17tM7G4CWQoVBTS1g3MTBBFWh3VzX/qa6EXi+3hYcNrPt/zNUxyASUyD5206l2ivnRTaffc6EHwxtGSRbmsj0hMPmygNWn/ynhiVGsQbuMyv85k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756278430; c=relaxed/simple;
	bh=a/li323hwMtjrLSnOHVCSzgA/1eJWrV9QJMXatOWIyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inoCM3EBsXwfPEy7JsYKDnAYsXF0gf6UozxD6nyGbfTAWkEMCeT+sShFyN/0gaiHWlMYUVHK0dhWg7P/CSLMcN+tB77KTBVcFw2mKvNjq7SBTsOO6nPydeHtG1fJWfLpbCwDgyj8AY6v/Gg9W2+1z9hQPBSbsvtcYucMbNOfvLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cyP5V4rB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qF0Zqyg5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cyP5V4rB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qF0Zqyg5"
Date: Wed, 27 Aug 2025 09:07:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756278426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYN1cPca32DtGQfgP7TwGlOVM9EA7JGBpRuhCBM21Mc=;
	b=cyP5V4rBk7JxlTqQYQ9DJYB3pKg3faclSKuTw73r+2aMlXnr6wf5cVPeT8I2w2q3EpeY6W
	Zw2Vna1vJA/a8fPohnem6ZcGUvoEWKb+MxL+B5tvmZ3n02O9wtyt9XdMda2JNKuBFTZ3Gc
	iGFchkW06krZftzJpAkOENVNCbUp8chTv7ASEHJLYva6y/PuIWxxarMjE1OIzgA/YtJ8WY
	pSm98dq7z4N5IsK3WHVbdt60bFIdK590p0zfqh96s6eG4IK45Sa6bbMRJjD1oL1I5w30Pd
	72DI5XQTsDJNl0BrKgldhm30tTtrVsH92jhOsUgRo5m/ouf++SCnXucLUg3mUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756278426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYN1cPca32DtGQfgP7TwGlOVM9EA7JGBpRuhCBM21Mc=;
	b=qF0Zqyg5lrn3EeGBM84bQBiWbvcf9/gshPnfP8cOUMZeYppBRKt/Q3pm5T7mWY5YBNvtuv
	mu0V2dAfBULOo+AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
Message-ID: <20250827070705.4iWhHGPE@linutronix.de>
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <175078375641.82625.9467584315092336312.b4-ty@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <175078375641.82625.9467584315092336312.b4-ty@kernel.dk>

On 2025-06-24 10:49:16 [-0600], Jens Axboe wrote:
> Applied, thanks!
>=20
> [1/1] block: Increase BLK_DEF_MAX_SECTORS_CAP
>       commit: 345c5091ffec5d4d53d7fe572fef3bcc3805824b

I have here a PowerEdge R6525 which exposes a "DELLBOSS VD" device with
firmware MV.R00-0. I updated firmware left and right of the components I
could find but started with this commit I get:
|[   10.894688] ata1: SATA max UDMA/133 abar m2048@0xa6300000 port 0xa63001=
00 irq 97 lpm-pol 1
|[   11.233656] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
|[   11.267540] ata1.00: ATA-8: DELLBOSS VD, MV.R00-0, max UDMA7
|[   11.279106] ata1.00: 468731008 sectors, multi 0: LBA48 NCQ (depth 32)
|[   11.309332] ata1.00: Invalid log directory version 0x0000
|[   11.324380] ata1.00: Security Log not supported
|[   11.336514] ata1.00: Security Log not supported
|[   11.350523] ata1.00: configured for UDMA/133
|[   11.351026] scsi 0:0:0:0: Direct-Access     ATA      DELLBOSS VD      0=
0-0 PQ: 0 ANSI: 5
|[   11.361416] scsi 0:0:0:0: Attached scsi generic sg0 type 0
|[   11.361928] sd 0:0:0:0: [sda] 468731008 512-byte logical blocks: (240 G=
B/224 GiB)
|[   11.361932] sd 0:0:0:0: [sda] 4096-byte physical blocks
|[   11.361942] sd 0:0:0:0: [sda] Write Protect is off
|[   11.361944] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
|[   11.361957] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled=
, doesn't support DPO or FUA
|[   11.361979] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
|[   12.654692] EXT4-fs (sda2): mounted filesystem abc6d95d-c676-442b-b22a-=
ce59dbdc47d3 ro with ordered data mode. Quota mode: none.
|[   14.497319] EXT4-fs (sda2): re-mounted abc6d95d-c676-442b-b22a-ce59dbdc=
47d3 r/w.
|[   67.619838] ata1: illegal qc_active transition (100000000->180005576)
|[   67.627051] ata1.00: Read log 0x10 page 0x00 failed, Emask 0x100
|[   67.633773] ata1: failed to read log page 10h (errno=3D-5)
|[   67.639802] ata1.00: exception Emask 0x1 SAct 0x80005576 SErr 0x0 actio=
n 0x6 frozen
|[   67.648156] ata1.00: irq_stat 0x40000008
|[   67.652785] ata1.00: failed command: WRITE FPDMA QUEUED
|[   67.658707] ata1.00: cmd 61/08:08:d0:85:12/00:00:00:00:00/40 tag 1 ncq =
dma 4096 out
|                         res 00/00:00:00:00:00/00:00:00:00:00/00 Emask 0x3=
 (HSM violation)=20
=E2=80=A6
|[   67.881878] ata1: hard resetting link
|[   68.194853] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
|[   68.201931] ata1.00: Security Log not supported
|[   68.207468] ata1.00: Security Log not supported
|[   68.212723] ata1.00: configured for UDMA/133
|[   68.527427] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
|[   68.534478] ata1.00: Security Log not supported
|[   68.539924] ata1.00: Security Log not supported
|[   68.545218] ata1.00: configured for UDMA/133
|[   68.550246] sd 0:0:0:0: [sda] tag#7 FAILED Result: hostbyte=3DDID_TIME_=
OUT driverbyte=3DDRIVER_OK cmd_age=3D50s
|[   68.560502] sd 0:0:0:0: [sda] tag#7 CDB: Read(10) 28 00 00 50 08 00 00 =
00 10 00
|[   68.568502] I/O error, dev sda, sector 5244928 op 0x0:(READ) flags 0x83=
700 phys_seg 2 prio class 2

and this never recovers. After reverting 9b8b84879d4ad ("block: Increase
BLK_DEF_MAX_SECTORS_CAP") on top of v6.17-rc3 things are back to normal.

Did I forget to update firmware somewhere or is this "normal" and this
device requires a quirk?

> Best regards,

Sebastian
