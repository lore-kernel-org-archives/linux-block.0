Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C039326D4A
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137551; cv=none; b=K1G8iv/0e45w/0Au1xuWAAthXAppmJ9H1DbjBbZSfHm6I50u0pVIRm1hlcjhNOGPM5mCLXdu1s0zv1p5vMgBLOdsmiglpJpCZjgMtE6Z89ncTSgOMEnNabnBlMBO5RDUP9Qa74Pwx24oGgELe/mVHh8ijo/B7RAgCqSAZcjRqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137551; c=relaxed/simple;
	bh=jMHyNvFyRKuUidjHCOqNTKAd8sdKWYzRNRNIsxVz34s=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O2N/zpOdQfa+7tIZkUJFWDF6iZwK2jbNpqhAN17n6zf32oSThLm1dTXhjV2etDgikms6RmuvEpOeOej4fLD2Y5FL+/8A2CIeue5Oiw9I7Le/gzIvQB9HfiThTXaXSnDQOAjobHZIctZ7xnuRgEHht44EtZyLp2WjArCHD1n0JGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=eOtCkp/s; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="eOtCkp/s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DFNMHJkohAfPYyu2h0uo7l5kVioM6jyih0lJ/buNhQg=; b=eOtCkp/s6KnVkPmlAVVNgbZpIc
	o42Y/bwRHvYUBdmh2MnNPXNZP8oSkUU5LzGfQW+ztj82pzxg8Ih1WBuuT3KAN6W8yk7PMysw9pktc
	m1a6yJWI1h1tsFdTSjpGv7QBKGNNMRxsGrGHBwZJuPJ5iFuJJM+M54KvBjzaTkQmq51xoWzjhzScx
	uH3cW0V2/SfE+FFB9M2poJ0AU+pbUIxAfW9fW2g6L4FGwnakUywgmR57JFlzCu3v8GkksNNhmTxff
	GGyta/zuMuH1ZA1RRcCs3lPl9l55ZQKVuS+FNb3cS+JzPr9BJ/r1Br+O3se9wPeq26n59gsm7f9nu
	NaTbaPzQ==;
Date: Fri, 14 Nov 2025 17:25:43 +0100 (CET)
Message-Id: <20251114.172543.20704181754788128.rene@exactco.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, efremov@linux.com
Subject: Re: [PATCH] fix floppy for PAGE_SIZE != 4KB
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
In-Reply-To: <b1e17016-3d4d-4fac-b5b0-97db357d0749@kernel.dk>
References: <20251114.144127.170518024415947073.rene@exactco.de>
	<b1e17016-3d4d-4fac-b5b0-97db357d0749@kernel.dk>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

> On 11/14/25 6:41 AM, Rene Rebe wrote:
> > For years I wondered why the floppy driver does not just work on
> > sparc64, e.g:
> > 
> > root@SUNW_375_0066:# disktype /dev/fd0
> > --- /dev/fd0
> > disktype: Can't open /dev/fd0: No such device or address
> > 
> > [  525.341906] disktype: attempt to access beyond end of device
> >                fd0: rw=0, sector=0, nr_sectors = 16 limit=8
> > [  525.341991] floppy: error 10 while reading block 0
> > 
> > Turns out floppy.c __floppy_read_block_0 tries to read one page for
> > the first test read to determine the disk size and thus fails if that
> > is greater than 4k. Adjust minimum MAX_DISK_SIZE to PAGE_SIZE to fix
> > floppy on sparc64 and likely all other PAGE_SIZE != 4KB configs.
> 
> 16k seem like a lot to read from a floppy, no? Why isn't it just
> reading a single 512b sector? Or just cap it at 4k rather than do
> a full page, at least?

Well, on my sparc64.config it is just 8k and I did not feel like
changing this vintage code more than was necessiary to write a floppy
for a Firmware update of another systems while my Ultra10 was the only
system with a floppy drive in my office. But even 16k or 64k is not
that much of a 1.44mb disk.

But if someone wants to refactor this code some more, ... I'm happy to
test it, too ;-)

    René

-- 
  René Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
  https://exactco.de | https://t2linux.com | https://rene.rebe.de
