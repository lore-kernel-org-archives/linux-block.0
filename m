Return-Path: <lars.ellenberg@linbit.com>
Return-Path: <lars.ellenberg@linbit.com>
Date: Fri, 3 Aug 2018 15:44:09 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Kees Cook <keescook@chromium.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-crypto <linux-crypto@vger.kernel.org>,
	drbd-dev@lists.linbit.com,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 12/18] drbd: Convert from ahash to shash
Message-ID: <20180803134357.GB28982@soda.linbit>
References: <20180724164936.37477-1-keescook@chromium.org>
 <20180724164936.37477-13-keescook@chromium.org>
 <CAGXu5jJB6V0r8LXOGL6+sO0NVZ0HK3VCthML=T3gLEwMABhSDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXu5jJB6V0r8LXOGL6+sO0NVZ0HK3VCthML=T3gLEwMABhSDQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 02, 2018 at 04:43:19PM -0700, Kees Cook wrote:
> On Tue, Jul 24, 2018 at 9:49 AM, Kees Cook <keescook@chromium.org> wrote:
> > In preparing to remove all stack VLA usage from the kernel[1], this
> > removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
> > the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
> > to direct shash. By removing a layer of indirection this both improves
> > performance and reduces stack usage. The stack allocation will be made
> > a fixed size in a later patch to the crypto subsystem.
> 
> Philipp or Lars, what do you think of this? Can this go via your tree
> or maybe via Jens?
> 
> I'd love an Ack or Review.

I'm sorry, summer time and all, limited online time ;-)

I'm happy for this to go in via Jens, or any other way.

Being not that fluent in the crypto stuff,
I will just "believe" most of it.

I still think I found something, comments below:

> > diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
> > index 1476cb3439f4..62dd3700dd84 100644
> > --- a/drivers/block/drbd/drbd_worker.c
> > +++ b/drivers/block/drbd/drbd_worker.c
> > @@ -295,60 +295,54 @@ void drbd_request_endio(struct bio *bio)
> >                 complete_master_bio(device, &m);
> >  }
> >
> > -void drbd_csum_ee(struct crypto_ahash *tfm, struct drbd_peer_request *peer_req, void *digest)
> > +void drbd_csum_ee(struct crypto_shash *tfm, struct drbd_peer_request *peer_req, void *digest)
> >  {
> > -       AHASH_REQUEST_ON_STACK(req, tfm);
> > -       struct scatterlist sg;
> > +       SHASH_DESC_ON_STACK(desc, tfm);
> >         struct page *page = peer_req->pages;
> >         struct page *tmp;
> >         unsigned len;
> >
> > -       ahash_request_set_tfm(req, tfm);
> > -       ahash_request_set_callback(req, 0, NULL, NULL);
> > +       desc->tfm = tfm;
> > +       desc->flags = 0;
> >
> > -       sg_init_table(&sg, 1);
> > -       crypto_ahash_init(req);
> > +       crypto_shash_init(desc);
> >
> >         while ((tmp = page_chain_next(page))) {
> >                 /* all but the last page will be fully used */
> > -               sg_set_page(&sg, page, PAGE_SIZE, 0);
> > -               ahash_request_set_crypt(req, &sg, NULL, sg.length);
> > -               crypto_ahash_update(req);
> > +               crypto_shash_update(desc, page_to_virt(page), PAGE_SIZE);

These pages may be "highmem", so page_to_virt() seem not appropriate.
I think the crypto_ahash_update() thingy did an implicit kmap() for us
in the crypto_hash_walk()?
Maybe it is good enough to add a kmap() here,
and a kunmap() on the next line?


> >                 page = tmp;
> >         }
> >         /* and now the last, possibly only partially used page */
> >         len = peer_req->i.size & (PAGE_SIZE - 1);
> > -       sg_set_page(&sg, page, len ?: PAGE_SIZE, 0);
> > -       ahash_request_set_crypt(req, &sg, digest, sg.length);
> > -       crypto_ahash_finup(req);
> > -       ahash_request_zero(req);
> > +       crypto_shash_update(desc, page_to_virt(page), len ?: PAGE_SIZE);

Same here ...

> > +
> > +       crypto_shash_final(desc, digest);
> > +       shash_desc_zero(desc);
> >  }
> >
> > -void drbd_csum_bio(struct crypto_ahash *tfm, struct bio *bio, void *digest)
> > +void drbd_csum_bio(struct crypto_shash *tfm, struct bio *bio, void *digest)
> >  {
> > -       AHASH_REQUEST_ON_STACK(req, tfm);
> > -       struct scatterlist sg;
> > +       SHASH_DESC_ON_STACK(desc, tfm);
> >         struct bio_vec bvec;
> >         struct bvec_iter iter;
> >
> > -       ahash_request_set_tfm(req, tfm);
> > -       ahash_request_set_callback(req, 0, NULL, NULL);
> > +       desc->tfm = tfm;
> > +       desc->flags = 0;
> >
> > -       sg_init_table(&sg, 1);
> > -       crypto_ahash_init(req);
> > +       crypto_shash_init(desc);
> >
> >         bio_for_each_segment(bvec, bio, iter) {
> > -               sg_set_page(&sg, bvec.bv_page, bvec.bv_len, bvec.bv_offset);
> > -               ahash_request_set_crypt(req, &sg, NULL, sg.length);
> > -               crypto_ahash_update(req);
> > +               crypto_shash_update(desc, (u8 *)page_to_virt(bvec.bv_page) +
> > +                                         bvec.bv_offset,
> > +                                   bvec.bv_len);


... and here.


> > +
> >                 /* REQ_OP_WRITE_SAME has only one segment,
> >                  * checksum the payload only once. */
> >                 if (bio_op(bio) == REQ_OP_WRITE_SAME)
> >                         break;
> >         }
> > -       ahash_request_set_crypt(req, NULL, digest, 0);
> > -       crypto_ahash_final(req);
> > -       ahash_request_zero(req);
> > +       crypto_shash_final(desc, digest);
> > +       shash_desc_zero(desc);
> >  }
> >
> >  /* MAYBE merge common code with w_e_end_ov_req */

Thanks,

    Lars
