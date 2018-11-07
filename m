Return-Path: <keith.busch@intel.com>
Date: Wed, 7 Nov 2018 08:15:38 -0700
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Clear kernel memory before copying to user
Message-ID: <20181107151538.GA11941@localhost.localdomain>
References: <20181107143745.11845-1-keith.busch@intel.com>
 <CACVXFVO8pcZpK0MBud8oebdZWhKB0Gzr14MPbzMtoHBUkN4Rbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVO8pcZpK0MBud8oebdZWhKB0Gzr14MPbzMtoHBUkN4Rbg@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Nov 07, 2018 at 11:09:27PM +0800, Ming Lei wrote:
> On Wed, Nov 7, 2018 at 10:42 PM Keith Busch <keith.busch@intel.com> wrote:
> >
> > If the kernel allocates a bounce buffer for user read data, this memory
> > needs to be cleared before copying it to the user, otherwise it may leak
> > kernel memory to user space.
> >
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> >  block/bio.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index d5368a445561..a50d59236b19 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -1260,6 +1260,7 @@ struct bio *bio_copy_user_iov(struct request_queue *q,
> >                 if (ret)
> >                         goto cleanup;
> >         } else {
> > +               zero_fill_bio(bio);
> >                 iov_iter_advance(iter, bio->bi_iter.bi_size);
> >         }
> 
> This way looks inefficient because zero fill should only be required
> for short READ.

Sure, but how do you know that happened before copying the bounce buffer
to user space?

We could zero the pages on allocation if that's better (and doesn't zero
twice if __GFP_ZERO was already provided):

---
diff --git a/block/bio.c b/block/bio.c
index d5368a445561..a1b6383294f4 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1212,6 +1212,9 @@ struct bio *bio_copy_user_iov(struct request_queue *q,
 		nr_pages = 1 << map_data->page_order;
 		i = map_data->offset / PAGE_SIZE;
 	}
+
+	if (iov_iter_rw(iter) == READ)
+		gfp_mask |= __GFP_ZERO;
 	while (len) {
 		unsigned int bytes = PAGE_SIZE;
 
--
