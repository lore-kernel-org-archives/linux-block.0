Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77D522F17B;
	Wed, 15 Jan 2025 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736923582; cv=none; b=N66qtsa9pEYKGQ+1EjHolqcZwc5bVDBC4y6E4ZafRsxH279VVC6yv35T1uOY865cnZc0x9L9Xv5iGNzY7lc2teC3GLPwgE1UPnTIuG4SCtEUj6HLZhOP+yeZxEUs/5jt311hh//gZSsPJik2yfoX490+Ay1rg5mB8u40bEaW9Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736923582; c=relaxed/simple;
	bh=fhG31OPe/KKOTQfBi44O56xCbrj+iKtHHD/B08Qi6JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Why5qguW3eyzE4+A6b8/tcjGm9rUOx4cYNibFAeiScFLTfBaUzjIjkk+zTWtmfGg/w53tAFoXFBW7AQO963PVVwUtKJHtpxvAAiDhsurQNole+EfnCc9qem4E/+R5W+HmNYFPsO3Ku/fN4hZPrtag4wVsMj3mpciFmZWp267Kz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fiyUi28R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fiyUi28R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7U4mEDcmKoY5aftWhHjmmyqEuXuOj20HXGe+y6DDHxc=; b=fiyUi28R/SWzaVsCAM4/Sd76Qq
	fA75PTLKhVysegHE5Yc7iXSFI5YdcdTxBiKW5D9b/7SryAKjtt10SmlYn5XgIQA6dTipuo/KhpcNP
	veS7pObakQOXj32rI9s9cCrD/uS2KlyxaDAYIPUs16BLsw2mljYclsoIj80mwIfXuDOR0A7UJhr/C
	5VJksDvx7idS7lh4lCdrxnl2Yi9MH2MPOncll9+GSR1BGA72gHOjf7uA9Tge/yV6HEdX7Btiw+Mev
	AtYReJ2KKZ0ETU5Yb1+obTs08bjNpFCFwrmsZSzzicxw+lhrYw9FKVrbZVIgGTKDu9+g8iWBqvkzr
	cLqFXUZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXxAS-0000000AqVW-0NjF;
	Wed, 15 Jan 2025 06:46:20 +0000
Date: Tue, 14 Jan 2025 22:46:20 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Edward Adam Davis <eadavis@qq.com>, hare@suse.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] block: no show partitions if partno corrupted
Message-ID: <Z4dZvH5WuOeNTgXg@infradead.org>
References: <abd5921f-a37f-4736-b1b4-920a5c108f71@suse.de>
 <tencent_9E78266DF82CB96C549658EA5AED66CD240A@qq.com>
 <d384b565-0be8-461d-ba8c-0185842c9d9c@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d384b565-0be8-461d-ba8c-0185842c9d9c@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 14, 2025 at 07:16:31AM -0700, Jens Axboe wrote:
> On 1/14/25 1:51 AM, Edward Adam Davis wrote:
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 9130e163e191..8d539a4a3b37 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -890,7 +890,9 @@ static int show_partition(struct seq_file *seqf, void *v)
> >  
> >  	rcu_read_lock();
> >  	xa_for_each(&sgp->part_tbl, idx, part) {
> > -		if (!bdev_nr_sectors(part))
> > +		int partno = bdev_partno(part);
> > +
> > +		if (!bdev_nr_sectors(part) || WARN_ON(partno >= DISK_MAX_PARTS))
> >  			continue;
> >  		seq_printf(seqf, "%4d  %7d %10llu %pg\n",
> >  			   MAJOR(part->bd_dev), MINOR(part->bd_dev),
> 
> This should be a WARN_ON_ONCE(), and please put warn-on's on a separate
> line.

Ummm...

DISK_MAX_PARTS is 256.

bdev_partno reads form bdev->__bd_flags and masks out BD_PARTNO,
which is 255.

In other words we should never be able to get a value bigger than 255
from bdev_partno, so something is really fishy here that a WARN_ON in
the show function won't help with.

Also the fact that the low-level printf code trips over a 8-bit integer
sounds wrong, and if it does for something not caused by say a use
after free higher up we've got another deep problem there.

All of that has nothing to do with show_partition, though.
