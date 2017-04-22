Return-Path: <jg@lightnvm.io>
Return-Path: <jg@lightnvm.io>
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <F684F05A-679F-4704-A70E-7C1EE92B83E7@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C1EACF8F-6AB3-40C9-B8F5-CE1F7E35E785";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 01/11] blk: remove bio_set arg from blk_queue_split()
Date: Sat, 22 Apr 2017 11:16:23 +0200
In-Reply-To: <149266672835.27388.5719138070560521601.stgit@noble>
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: NeilBrown <neilb@suse.com>
References: <149266645258.27388.14083229348123176454.stgit@noble>
 <149266672835.27388.5719138070560521601.stgit@noble>
List-ID: <linux-block@vger.kernel.org>


--Apple-Mail=_C1EACF8F-6AB3-40C9-B8F5-CE1F7E35E785
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

> On 20 Apr 2017, at 07.38, NeilBrown <neilb@suse.com> wrote:
> 
> blk_queue_split() is always called with the last arg being q->bio_split,
> where 'q' is the first arg.
> 
> Also blk_queue_split() sometimes uses the passed-in 'bs' and sometimes uses
> q->bio_split.
> 
> This is inconsistent and unnecessary.  Remove the last arg and always use
> q->bio_split inside blk_queue_split()
> 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
> block/blk-core.c              |    2 +-
> block/blk-merge.c             |    9 ++++-----
> block/blk-mq.c                |    2 +-
> drivers/block/drbd/drbd_req.c |    2 +-
> drivers/block/pktcdvd.c       |    2 +-
> drivers/block/ps3vram.c       |    2 +-
> drivers/block/rsxx/dev.c      |    2 +-
> drivers/block/umem.c          |    2 +-
> drivers/block/zram/zram_drv.c |    2 +-
> drivers/lightnvm/rrpc.c       |    2 +-
> drivers/md/md.c               |    2 +-
> drivers/s390/block/dcssblk.c  |    2 +-
> drivers/s390/block/xpram.c    |    2 +-
> include/linux/blkdev.h        |    3 +--
> 14 files changed, 17 insertions(+), 19 deletions(-)
> 

It most probably made it to Jens' tree after you made these changes, but
in drivers/lightnvm/pblk-init.c we also use blk_queue_split() in a
couple of places inside pblk_rw_io().

Thanks,
Javier.

--Apple-Mail=_C1EACF8F-6AB3-40C9-B8F5-CE1F7E35E785
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJY+x9oAAoJEGMfBTt1mRjKLRoQAJFM15QVljb5HsoUuVTfyFce
fvvRcOWTyPmLFSSO1D1mZo0lHPMgn1PgtXNf+YN/uNh6uhj3Djgk1Q/ua0rHrWk7
Iw5TX66Lox5wlCIeeVrUnRbGzxUFCvqyeNmuDcH+7fHvtdg2oBkPUFntxgFHUTI5
tBTi4BZPtPR/qS/nsgqa/pXXYTsJXYBjWnXDzz9zMb8172yDyARdOcRM+W3ld2Es
YH5EbMX3nJuBYiTMShLpjh6fGHbWxYnp19Y6snBan4zqXImkDXoN7p2ZPTnXuWPZ
ZoJhx9+tHWa6Urraqzn76rZNgRXhZYY9ujDx3zrg7aT+6LJEd9OjxQlxWLrk/rUw
MrAcIpvx8lhmSo9ee8hVN7ApfNTa1UAa/fpOQkKbY78Dj0PTB1ISJt30PeAtyoDj
z+95wJ3FDOqjPHEiud9xzUURsM0gSmaq91DKoG7etugcTFZjo5yL9d51xFLoI9sM
bXkvIXIMu3ggFObRHdEOSGv47Yvqh8XU0bqyvCge8lVldyEp97SiLOOISswmq3AL
qPWlIOJcOoK9wv60UInNbm/j6524rUhy0dClKG4nOVmDryAX8gjdi71huCmWlf+g
oKVebh1mKsVveTeFZ2K9RregJSEr2ugmAWIcBuU9Jpsf2/exDUqDmtfEmJ86Qt5D
wgtlPDRlzA2PXqfSY2JZ
=aoaH
-----END PGP SIGNATURE-----

--Apple-Mail=_C1EACF8F-6AB3-40C9-B8F5-CE1F7E35E785--
