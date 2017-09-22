Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:23722 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751847AbdIVJmQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 05:42:16 -0400
Date: Fri, 22 Sep 2017 12:42:14 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
CC: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] lightnvm: pblk: reuse pblk_gc_should_kick
Message-ID: <20170922094213.GA31904@dhcp-216.srv.tuxera.com>
References: <20170921112539.GA28510@dhcp-216.srv.tuxera.com>
 <BBF0A7B6-682D-45C7-A087-4072F5B101CE@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <BBF0A7B6-682D-45C7-A087-4072F5B101CE@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Sep 22, 2017 at 10:40:57AM +0200, Javier Gonz�lez wrote:
> > On 21 Sep 2017, at 13.25, Rakesh Pandit wrote:
> > 
> > This is a trivial change which reuses pblk_gc_should_kick instead of
> > repeating it again in pblk_rl_free_lines_inc.
> > 
> > Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> > ---
> > drivers/lightnvm/pblk-core.c | 1 +
> > drivers/lightnvm/pblk-rl.c   | 9 ---------
> > 2 files changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> > index 64a6a25..a230125 100644
> > --- a/drivers/lightnvm/pblk-core.c
> > +++ b/drivers/lightnvm/pblk-core.c
> > @@ -1478,6 +1478,7 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
> > 	spin_unlock(&l_mg->free_lock);
> > 
> > 	pblk_rl_free_lines_inc(&pblk->rl, line);
> > +	pblk_gc_should_kick(pblk);
> > }
> > 
> > static void pblk_line_put_ws(struct work_struct *work)
> > diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
> > index 596bdec..e7c162a 100644
> > --- a/drivers/lightnvm/pblk-rl.c
> > +++ b/drivers/lightnvm/pblk-rl.c
> > @@ -129,18 +129,9 @@ static int pblk_rl_update_rates(struct pblk_rl *rl, unsigned long max)
> > 
> > void pblk_rl_free_lines_inc(struct pblk_rl *rl, struct pblk_line *line)
> > {
> > -	struct pblk *pblk = container_of(rl, struct pblk, rl);
> > 	int blk_in_line = atomic_read(&line->blk_in_line);
> > -	int ret;
> > 
> > 	atomic_add(blk_in_line, &rl->free_blocks);
> > -	/* Rates will not change that often - no need to lock update */
> > -	ret = pblk_rl_update_rates(rl, rl->rb_budget);
> > -
> > -	if (ret == (PBLK_RL_MID | PBLK_RL_LOW))
> > -		pblk_gc_should_start(pblk);
> > -	else
> > -		pblk_gc_should_stop(pblk);
> > }
> > 
> > void pblk_rl_free_lines_dec(struct pblk_rl *rl, struct pblk_line *line)
> > --
> > 2.5.0
> 
> Looking at the patch, I can see that a more general cleanup can be done.
> What do you think about this? We can merge it in this patch if you are OK
> with it.

Makes more sense. Feel free to merge. You have my Signed-off-by tag.

> 
> From 944936663c7eef7bc32243b89cc554e40ec436c5 Mon Sep 17 00:00:00 2001
> From: Rakesh Pandit <rakesh@tuxera.com>
> Date: Thu, 21 Sep 2017 14:25:40 +0300
> Subject: [PATCH] lightnvm: pblk: reuse pblk_gc_should_kick
> 
> This is a trivial change which reuses pblk_gc_should_kick instead of
> repeating it again in pblk_rl_free_lines_inc.
> 
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
>  drivers/lightnvm/pblk-core.c |  2 --
>  drivers/lightnvm/pblk-rl.c   | 33 +++++++++------------------------
>  drivers/lightnvm/pblk.h      |  1 -
>  3 files changed, 9 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 64a6a255514e..c92113b0a2e7 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1633,8 +1633,6 @@ void pblk_line_close(struct pblk *pblk, struct pblk_line *line)
> 
>  	spin_unlock(&line->lock);
>  	spin_unlock(&l_mg->gc_lock);
> -
> -	pblk_gc_should_kick(pblk);
>  }
> 
>  void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
> index 596bdec433c3..0896439a91b0 100644
> --- a/drivers/lightnvm/pblk-rl.c
> +++ b/drivers/lightnvm/pblk-rl.c
> @@ -96,9 +96,11 @@ unsigned long pblk_rl_nr_free_blks(struct pblk_rl *rl)
>   *
>   * Only the total number of free blocks is used to configure the rate limiter.
>   */
> -static int pblk_rl_update_rates(struct pblk_rl *rl, unsigned long max)
> +static void pblk_rl_update_rates(struct pblk_rl *rl)
>  {
> +	struct pblk *pblk = container_of(rl, struct pblk, rl);
>  	unsigned long free_blocks = pblk_rl_nr_free_blks(rl);
> +	int max = rl->rb_budget;
> 
>  	if (free_blocks >= rl->high) {
>  		rl->rb_user_max = max;
> @@ -124,23 +126,18 @@ static int pblk_rl_update_rates(struct pblk_rl *rl, unsigned long max)
>  		rl->rb_state = PBLK_RL_LOW;
>  	}
> 
> -	return rl->rb_state;
> +	if (rl->rb_state == (PBLK_RL_MID | PBLK_RL_LOW))
> +		pblk_gc_should_start(pblk);
> +	else
> +		pblk_gc_should_stop(pblk);
>  }
> 
>  void pblk_rl_free_lines_inc(struct pblk_rl *rl, struct pblk_line *line)
>  {
> -	struct pblk *pblk = container_of(rl, struct pblk, rl);
>  	int blk_in_line = atomic_read(&line->blk_in_line);
> -	int ret;
> 
>  	atomic_add(blk_in_line, &rl->free_blocks);
> -	/* Rates will not change that often - no need to lock update */
> -	ret = pblk_rl_update_rates(rl, rl->rb_budget);
> -
> -	if (ret == (PBLK_RL_MID | PBLK_RL_LOW))
> -		pblk_gc_should_start(pblk);
> -	else
> -		pblk_gc_should_stop(pblk);
> +	pblk_rl_update_rates(rl);
>  }
> 
>  void pblk_rl_free_lines_dec(struct pblk_rl *rl, struct pblk_line *line)
> @@ -148,19 +145,7 @@ void pblk_rl_free_lines_dec(struct pblk_rl *rl, struct pblk_line *line)
>  	int blk_in_line = atomic_read(&line->blk_in_line);
> 
>  	atomic_sub(blk_in_line, &rl->free_blocks);
> -}
> -
> -void pblk_gc_should_kick(struct pblk *pblk)
> -{
> -	struct pblk_rl *rl = &pblk->rl;
> -	int ret;
> -
> -	/* Rates will not change that often - no need to lock update */
> -	ret = pblk_rl_update_rates(rl, rl->rb_budget);
> -	if (ret == (PBLK_RL_MID | PBLK_RL_LOW))
> -		pblk_gc_should_start(pblk);
> -	else
> -		pblk_gc_should_stop(pblk);
> +	pblk_rl_update_rates(rl);
>  }
> 
>  int pblk_rl_high_thrs(struct pblk_rl *rl)
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index eaf539715d71..d4b7dee0ef50 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -829,7 +829,6 @@ int pblk_gc_init(struct pblk *pblk);
>  void pblk_gc_exit(struct pblk *pblk);
>  void pblk_gc_should_start(struct pblk *pblk);
>  void pblk_gc_should_stop(struct pblk *pblk);
> -void pblk_gc_should_kick(struct pblk *pblk);
>  void pblk_gc_kick(struct pblk *pblk);
>  void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
>  			      int *gc_active);
> --
> 2.7.4
> 
