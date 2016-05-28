Return-Path: <linux-block-owner@vger.kernel.org>
Received: from silver.sucs.swan.ac.uk ([137.44.10.1]:40250 "EHLO
	silver.sucs.swan.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbcE1KEi (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Sat, 28 May 2016 06:04:38 -0400
Date: Sat, 28 May 2016 10:27:55 +0100
From: Sitsofe Wheeler <sitsofe@gmail.com>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@redhat.com, axboe@fb.com, martin.petersen@oracle.com,
	Kernel-team@fb.com
Subject: Re: [PATCH] block: correctly fallback for zeroout
Message-ID: <20160528092755.GB938@sucs.org>
References: <20160527054918.GA9521@sucs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, May 28, 2016 at 08:55:43AM +0000, Sitsofe Wheeler wrote:
> On Thu, May 26, 2016 at 11:08:14AM -0700, Shaohua Li wrote:
> > blkdev_issue_zeroout try discard/writesame first, if they fail, zeroout
> > fallback to regular write. The problem is discard/writesame doesn't
> > return error for -EOPNOTSUPP, then zeroout can't do fallback and leave
> > disk data not changed. zeroout should have guaranteed zero-fill
> > behavior.
> 
> It sounds like at least this patch should go in so BLKZEROOUT can always
> fall back (since those zeros are essential) but it would still be nice
> to see the disabling of write same being copied up to md device's
> write_same_max_bytes so everyone knows not to try using it in the future
> but perhaps someone will say "what if I re-enable it on the device
> below?" etc.

I've tested Shaohua's original patch on top of Linus' tree and even
without the suggested changes (above and below) it at least resolves the
success being returned but data not being zeroed (with both PVSCSI and
scsi_debug underlying devices) issue so:

Tested-by: Sitsofe Wheeler <sitsofe@yahoo.com>

> > BTW, I saw several callers of blkdev_issue_discard can handle
> > -EOPNOTSUPP, not sure why blkdev_issue_discard not returns -EOPNOTSUPP.
> > The same story for blkdev_issue_write_same.
> 
> Most of the time there's no harm if discard fails for any reason -
> there's no guarantee what state the data is in even if it succeeds so
> not doing anything is always legal. I guess there's an argument for why
> try harder. Further, perhaps not every caller is prepared to handle the
> case where an advertised feature suddenly becomes not supported and this
> papers over the problem.
> 
> The original SCSI WRITE SAME has overloaded semantics - not only does it
> mean "write this data multiple times" but it can also be used to mean
> "discard this range" too. If the kernel's command was modelled on the
> SCSI original perhaps this conflation clouded things?
> 
> My fear is that there is another user of blkdev_issue_write_same other
> than blkdev_issue_zeroout (e.g. if this call is somehow wrapped so user
> space can issue it) who doesn't know about the secret "don't hold back!"
> version and winds up ignoring (permanent) errors.
> 
> > https://bugzilla.kernel.org/show_bug.cgi?id=118581
> > 
> > Cc: Sitsofe Wheeler <sitsofe@yahoo.com>
> > Cc: Mike Snitzer <snitzer@redhat.com>
> > Cc: Jens Axboe <axboe@fb.com>
> > Cc: Martin K. Petersen <martin.petersen@oracle.com>
> > Signed-off-by: Shaohua Li <shli@fb.com>
> > ---
> >� block/blk-lib.c | 35 ++++++++++++++++++++++++++---------
> >� 1 file changed, 26 insertions(+), 9 deletions(-)
> > 
> > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > index 23d7f30..232f9ea 100644
> > --- a/block/blk-lib.c
> > +++ b/block/blk-lib.c
> > @@ -95,8 +95,9 @@ EXPORT_SYMBOL(__blkdev_issue_discard);
> >� * Description:
> >� *� � Issue a discard request for the sectors in question.
> >� */
> > -int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> > -��� ��� sector_t nr_sects, gfp_t gfp_mask, unsigned long flags)
> > +static int do_blkdev_issue_discard(struct block_device *bdev, sector_t sector,
> > +��� sector_t nr_sects, gfp_t gfp_mask, unsigned long flags,
> > +��� bool ignore_nosupport)
> 
> I'm not sure about "ignore" and "no" being in the same variable name -
> it's almost like double negation.

-- 
Sitsofe | http://sucs.org/~sits/
