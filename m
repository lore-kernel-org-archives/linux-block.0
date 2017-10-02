Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:46957 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751082AbdJBRVG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Oct 2017 13:21:06 -0400
Date: Mon, 2 Oct 2017 20:21:04 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
CC: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] lightnvm: pblk: fix releases of kmem cache in error
 path
Message-ID: <20171002172104.GB6008@hercules.tuxera.com>
References: <20171001132633.GA5783@hercules.tuxera.com>
 <13AC8182-29EB-4601-980E-FC8B59A83CFC@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <13AC8182-29EB-4601-980E-FC8B59A83CFC@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 02, 2017 at 02:44:23PM +0200, Javier Gonz�lez wrote:
> > On 1 Oct 2017, at 15.26, Rakesh Pandit <rakesh@tuxera.com> wrote:
> > 
> > If pblk_core_init fails lets destroy all global caches.
> > 
> > Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> > ---
> > drivers/lightnvm/pblk-init.c | 8 +++++++-
> > 1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> > index 519e5cf..9f39800 100644
> > --- a/drivers/lightnvm/pblk-init.c
> > +++ b/drivers/lightnvm/pblk-init.c
> > @@ -246,7 +246,7 @@ static int pblk_core_init(struct pblk *pblk)
> > 	pblk->page_bio_pool = mempool_create_page_pool(nvm_max_phys_sects(dev),
> > 									0);
> > 	if (!pblk->page_bio_pool)
> > -		return -ENOMEM;
> > +		goto free_global_caches;
> > 
> > 	pblk->gen_ws_pool = mempool_create_slab_pool(PBLK_GEN_WS_POOL_SIZE,
> > 							pblk_ws_cache);
> > @@ -314,6 +314,12 @@ static int pblk_core_init(struct pblk *pblk)
> > 	mempool_destroy(pblk->gen_ws_pool);
> > free_page_bio_pool:
> > 	mempool_destroy(pblk->page_bio_pool);
> > +free_global_caches:
> > +	kmem_cache_destroy(pblk_ws_cache);
> > +	kmem_cache_destroy(pblk_rec_cache);
> > +	kmem_cache_destroy(pblk_g_rq_cache);
> > +	kmem_cache_destroy(pblk_e_rq_cache);
> > +	kmem_cache_destroy(pblk_w_rq_cache);
> > 	return -ENOMEM;
> > }
> > 
> > --
> > 2.7.4
> 
> Looks good. I'll refactor it on a single function so that we can reuse
> it on tear down. It will also be simpler to add/remove caches in the
> future.
> 
> Since it depends on the last patch, I'll wait until you reply to it
> before making the changes.

Please go ahead.  Now that previous patch is can be ignored, you can
adjust accordingly.

Thank you.

> 
> Javier
