Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46681 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbeH2TDx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 15:03:53 -0400
Received: by mail-ua1-f66.google.com with SMTP id u11-v6so3428263uan.13
        for <linux-block@vger.kernel.org>; Wed, 29 Aug 2018 08:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1535545414-550-5-git-send-email-hans.ml.holmberg@owltronix.com> <92a2b562-c485-47ff-7aa9-5aa82b992e40@lightnvm.io>
In-Reply-To: <92a2b562-c485-47ff-7aa9-5aa82b992e40@lightnvm.io>
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date: Wed, 29 Aug 2018 17:06:18 +0200
Message-ID: <CANr-nt1yygevsNUELoaN6tC1N+emiuz+QtqmynKha18_AZP2Rg@mail.gmail.com>
Subject: Re: [PATCH 4/7] lightnvm: pblk: move global caches to module init/exit
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Gonzalez <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 29, 2018 at 3:29 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wrote=
:
>
> On 08/29/2018 02:23 PM, Hans Holmberg wrote:
> > From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> >
> > Pblk's global caches should not be initialized every time
> > a pblk instance is created, so move the creation and destruction
> > of the caches to module init/exit.
> >
> > Also remove the global pblk lock as it is no longer needed after
> > the move.
> >
>
> The original goal was to not allocate memory for the caches unless a
> pblk instance was initialized. This instead uses up memory without pblk
> being used, which I don't think is a good idea.

You're right, i'll rework the patch with reference counting of pblk instanc=
es.
The global caches only need to exist when there is at least one pblk instan=
ce.

Thanks,
Hans

>
> > Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> > ---
> >   drivers/lightnvm/pblk-init.c | 42 ++++++++++++++++++++---------------=
-------
> >   1 file changed, 20 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.=
c
> > index 76a4a271b9cf..0be64220b5d8 100644
> > --- a/drivers/lightnvm/pblk-init.c
> > +++ b/drivers/lightnvm/pblk-init.c
> > @@ -27,7 +27,6 @@ MODULE_PARM_DESC(write_buffer_size, "number of entrie=
s in a write buffer");
> >
> >   static struct kmem_cache *pblk_ws_cache, *pblk_rec_cache, *pblk_g_rq_=
cache,
> >                               *pblk_w_rq_cache;
> > -static DECLARE_RWSEM(pblk_lock);
> >   struct bio_set pblk_bio_set;
> >
> >   static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
> > @@ -306,21 +305,17 @@ static int pblk_set_addrf(struct pblk *pblk)
> >       return 0;
> >   }
> >
> > -static int pblk_init_global_caches(struct pblk *pblk)
> > +static int pblk_init_global_caches(void)
> >   {
> > -     down_write(&pblk_lock);
> >       pblk_ws_cache =3D kmem_cache_create("pblk_blk_ws",
> >                               sizeof(struct pblk_line_ws), 0, 0, NULL);
> > -     if (!pblk_ws_cache) {
> > -             up_write(&pblk_lock);
> > +     if (!pblk_ws_cache)
> >               return -ENOMEM;
> > -     }
> >
> >       pblk_rec_cache =3D kmem_cache_create("pblk_rec",
> >                               sizeof(struct pblk_rec_ctx), 0, 0, NULL);
> >       if (!pblk_rec_cache) {
> >               kmem_cache_destroy(pblk_ws_cache);
> > -             up_write(&pblk_lock);
> >               return -ENOMEM;
> >       }
> >
> > @@ -329,7 +324,6 @@ static int pblk_init_global_caches(struct pblk *pbl=
k)
> >       if (!pblk_g_rq_cache) {
> >               kmem_cache_destroy(pblk_ws_cache);
> >               kmem_cache_destroy(pblk_rec_cache);
> > -             up_write(&pblk_lock);
> >               return -ENOMEM;
> >       }
> >
> > @@ -339,15 +333,13 @@ static int pblk_init_global_caches(struct pblk *p=
blk)
> >               kmem_cache_destroy(pblk_ws_cache);
> >               kmem_cache_destroy(pblk_rec_cache);
> >               kmem_cache_destroy(pblk_g_rq_cache);
> > -             up_write(&pblk_lock);
> >               return -ENOMEM;
> >       }
> > -     up_write(&pblk_lock);
> >
> >       return 0;
> >   }
> >
> > -static void pblk_free_global_caches(struct pblk *pblk)
> > +static void pblk_free_global_caches(void)
> >   {
> >       kmem_cache_destroy(pblk_ws_cache);
> >       kmem_cache_destroy(pblk_rec_cache);
> > @@ -381,13 +373,10 @@ static int pblk_core_init(struct pblk *pblk)
> >       if (!pblk->pad_dist)
> >               return -ENOMEM;
> >
> > -     if (pblk_init_global_caches(pblk))
> > -             goto fail_free_pad_dist;
> > -
> >       /* Internal bios can be at most the sectors signaled by the devic=
e. */
> >       ret =3D mempool_init_page_pool(&pblk->page_bio_pool, NVM_MAX_VLBA=
, 0);
> >       if (ret)
> > -             goto free_global_caches;
> > +             goto free_pad_dist;
> >
> >       ret =3D mempool_init_slab_pool(&pblk->gen_ws_pool, PBLK_GEN_WS_PO=
OL_SIZE,
> >                                    pblk_ws_cache);
> > @@ -455,9 +444,7 @@ static int pblk_core_init(struct pblk *pblk)
> >       mempool_exit(&pblk->gen_ws_pool);
> >   free_page_bio_pool:
> >       mempool_exit(&pblk->page_bio_pool);
> > -free_global_caches:
> > -     pblk_free_global_caches(pblk);
> > -fail_free_pad_dist:
> > +free_pad_dist:
> >       kfree(pblk->pad_dist);
> >       return -ENOMEM;
> >   }
> > @@ -480,7 +467,6 @@ static void pblk_core_free(struct pblk *pblk)
> >       mempool_exit(&pblk->e_rq_pool);
> >       mempool_exit(&pblk->w_rq_pool);
> >
> > -     pblk_free_global_caches(pblk);
> >       kfree(pblk->pad_dist);
> >   }
> >
> > @@ -1067,7 +1053,6 @@ static void pblk_exit(void *private, bool gracefu=
l)
> >   {
> >       struct pblk *pblk =3D private;
> >
> > -     down_write(&pblk_lock);
> >       pblk_gc_exit(pblk, graceful);
> >       pblk_tear_down(pblk, graceful);
> >
> > @@ -1076,7 +1061,6 @@ static void pblk_exit(void *private, bool gracefu=
l)
> >   #endif
> >
> >       pblk_free(pblk);
> > -     up_write(&pblk_lock);
> >   }
> >
> >   static sector_t pblk_capacity(void *private)
> > @@ -1237,9 +1221,22 @@ static int __init pblk_module_init(void)
> >       ret =3D bioset_init(&pblk_bio_set, BIO_POOL_SIZE, 0, 0);
> >       if (ret)
> >               return ret;
> > +
> >       ret =3D nvm_register_tgt_type(&tt_pblk);
> >       if (ret)
> > -             bioset_exit(&pblk_bio_set);
> > +             goto fail_exit_bioset;
> > +
> > +     ret =3D pblk_init_global_caches();
> > +     if (ret)
> > +             goto fail_unregister_tgt_type;
> > +
> > +     return 0;
> > +
> > +fail_unregister_tgt_type:
> > +     nvm_unregister_tgt_type(&tt_pblk);
> > +fail_exit_bioset:
> > +     bioset_exit(&pblk_bio_set);
> > +
> >       return ret;
> >   }
> >
> > @@ -1247,6 +1244,7 @@ static void pblk_module_exit(void)
> >   {
> >       bioset_exit(&pblk_bio_set);
> >       nvm_unregister_tgt_type(&tt_pblk);
> > +     pblk_free_global_caches();
> >   }
> >
> >   module_init(pblk_module_init);
> >
>
