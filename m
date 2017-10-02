Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:52748 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750978AbdJBLnq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Oct 2017 07:43:46 -0400
Date: Mon, 2 Oct 2017 14:43:44 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
CC: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: fix changing GC group list for a line
Message-ID: <20171002114344.GA3526@dhcp-216.srv.tuxera.com>
References: <20170928143828.GA7645@hercules.tuxera.com>
 <5656C93D-F3DF-4054-906C-C27542D265CA@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <5656C93D-F3DF-4054-906C-C27542D265CA@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 02, 2017 at 01:27:42PM +0200, Javier Gonz�lez wrote:
> > On 28 Sep 2017, at 16.40, Rakesh Pandit <rakesh@tuxera.com> wrote:
> > 
> > pblk_line_gc_list seems to had a bug since the introduction of pblk in
> > getting GC list for a line.  In b20ba1bc7 while redesigning GC
> > algorithm it was not fixed correctly.  The problem is that even if
> > valid sector count (vsc) is less that mid_thrs (threshold for GC mid
> > list) it would always satisfy 'vsc < high_thrs' as high_thrs >
> > mid_thrs always.
> > 
> > Fixes: a4bd217b4("lightnvm: physical block device (pblk) target")
> > Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> > ---
> > drivers/lightnvm/pblk-core.c | 10 +++++-----
> > 1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> > index 8150164..93a58ed 100644
> > --- a/drivers/lightnvm/pblk-core.c
> > +++ b/drivers/lightnvm/pblk-core.c
> > @@ -295,16 +295,16 @@ struct list_head *pblk_line_gc_list(struct pblk *pblk, struct pblk_line *line)
> > 			line->gc_group = PBLK_LINEGC_FULL;
> > 			move_list = &l_mg->gc_full_list;
> > 		}
> > -	} else if (vsc < lm->high_thrs) {
> > -		if (line->gc_group != PBLK_LINEGC_HIGH) {
> > -			line->gc_group = PBLK_LINEGC_HIGH;
> > -			move_list = &l_mg->gc_high_list;
> > -		}
> > 	} else if (vsc < lm->mid_thrs) {
> > 		if (line->gc_group != PBLK_LINEGC_MID) {
> > 			line->gc_group = PBLK_LINEGC_MID;
> > 			move_list = &l_mg->gc_mid_list;
> > 		}
> > +	} else if (vsc < lm->high_thrs) {
> > +		if (line->gc_group != PBLK_LINEGC_HIGH) {
> > +			line->gc_group = PBLK_LINEGC_HIGH;
> > +			move_list = &l_mg->gc_high_list;
> > +		}
> > 	} else if (vsc < line->sec_in_line) {
> > 		if (line->gc_group != PBLK_LINEGC_LOW) {
> > 			line->gc_group = PBLK_LINEGC_LOW;
> > --
> > 2.9.3
> 
> You're right that the naming for high/mid/low was not updated when
> aligning vsc with GC thresholds. But the fix should be making high,
> being high, instead of reordering when moving into the GC bucket.
> 
> Does it make sense to you?

Yes.

> 
> diff --git i/drivers/lightnvm/pblk-init.c w/drivers/lightnvm/pblk-init.c
> index 7cf4b536d899..bc5c6cc12ad5 100644
> --- i/drivers/lightnvm/pblk-init.c
> +++ w/drivers/lightnvm/pblk-init.c
> @@ -675,8 +675,8 @@ static int pblk_lines_init(struct pblk *pblk)
>         lm->blk_bitmap_len = BITS_TO_LONGS(geo->nr_luns) * sizeof(long);
>         lm->sec_bitmap_len = BITS_TO_LONGS(lm->sec_per_line) * sizeof(long);
>         lm->lun_bitmap_len = BITS_TO_LONGS(geo->nr_luns) * sizeof(long);
> -       lm->high_thrs = lm->sec_per_line / 2;
> -       lm->mid_thrs = lm->sec_per_line / 4;
> +       lm->high_thrs = lm->sec_per_line / 4;
> +       lm->mid_thrs = lm->sec_per_line / 2;
>         lm->meta_distance = (geo->nr_luns / 2) * pblk->min_write_pgs;
> 
>         /* Calculate necessary pages for smeta. See comment over struct

Regards,
