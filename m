Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Wed, 22 Jun 2016 14:52:40 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: John David Anglin <dave.anglin@bell.net>
cc: Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: parisc late boot crash in 4.4-rc, scsi-related
In-Reply-To: <9d1ae51e-69c3-c3f6-60aa-e5238dd18241@bell.net>
Message-ID: <alpine.LRH.2.20.1606221451310.11869@math.ut.ee>
References: <alpine.LRH.2.20.1601082329270.23187@math.ut.ee> <56902D77.1020200@gmx.de> <alpine.LRH.2.20.1605162336050.12607@math.ut.ee> <9d1ae51e-69c3-c3f6-60aa-e5238dd18241@bell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

> > > > I noticed on RP3440 and A500 that recent 4.4-rc* crashes on boot.
> > > >
> > > >I've not seen it with 4.4-rc yet, but I've seen it on debian kernel
> > > >4.3.3:
> > This is still present in 4.6, just tested. All my pariscs are broken
> > - A500, RP3410, RP3440. 4.3 is the latest working release for me. If
> > 4.3.3 is broken, it might be possible to bisect more easily.
> 
> I believe this is fixed in current gcc versions (4.9 and latter). It was
> exposed by a blk-merge
> change.  It was fixed by this change:

Out of interest, how do other parisc users get the new compiler?

What distro are you using?

My pariscs are gentoo and still only the old versions are available on 
hppa.

-- 
Meelis Roos (mroos@linux.ee)
