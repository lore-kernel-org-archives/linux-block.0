Return-Path: <ming.lei@redhat.com>
Date: Wed, 18 Jul 2018 10:48:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Martin Wilck <mwilck@suse.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	jack@suse.com, kent.overstreet@gmail.com
Subject: Re: Silent data corruption in blkdev_direct_IO()
Message-ID: <20180718024758.GB11151@ming.t460p>
References: <e36f28d8-0eb8-1600-f327-8b066eeaf45c@suse.de>
 <CACVXFVPVb_8pUkGXPt5joDE4JRu0b4kgTQy7Pd0sL+kXDwys+A@mail.gmail.com>
 <c5073ab4-6b06-16bd-f358-d4c18e18b3e0@kernel.dk>
 <f6f3f16b66622a9b16acd0d8be7ef311e4da807a.camel@suse.com>
 <CACVXFVPV1ckFvvh3m61QSPCtEY19ussRsMtKoptUbY3LLHKz8A@mail.gmail.com>
 <ff0fc8c44f205453a203e88676942507339f6829.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ff0fc8c44f205453a203e88676942507339f6829.camel@suse.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 18, 2018 at 02:07:28AM +0200, Martin Wilck wrote:
> On Mon, 2018-07-16 at 19:45 +0800, Ming Lei wrote:
> > On Sat, Jul 14, 2018 at 6:29 AM, Martin Wilck <mwilck@suse.com>
> > wrote:
> > > Hi Ming & Jens,
> > > 
> > > On Fri, 2018-07-13 at 12:54 -0600, Jens Axboe wrote:
> > > > On 7/12/18 5:29 PM, Ming Lei wrote:
> > > > > 
> > > > > Maybe you can try the following patch from Christoph to see if
> > > > > it
> > > > > makes a
> > > > > difference:
> > > > > 
> > > > > https://marc.info/?l=linux-kernel&m=153013977816825&w=2
> > > > 
> > > > That's not a bad idea.
> > > 
> > > Are you saying that the previous "nasty hack"  in
> > > bio_iov_iter_get_pages() was broken, and the new one is not?
> > > I've scratched my head over that (old) code lately, but I couldn't
> > > spot
> > > an actual error in it.
> > 
> > Yeah, I think the new patch in above link is better, and looks its
> > correctness
> > is easy to prove.
> > 
> >    https://marc.info/?t=152812081400001&r=1&w=2
> > 
> > So please test the patch if possible.
> 
> I haven't tested yet, but upon further inspection, I can tell that the
> current code (without Christoph's patch) is actually broken if the
> function is called with bio->bi_vcnt > 0. The following patch explains
> the problem. AFAICS, Christoph's new code is correct.
> 
> From b75adc856119346e02126cf8975755300f2d9b7f Mon Sep 17 00:00:00 2001
> From: Martin Wilck <mwilck@suse.com>
> Date: Wed, 18 Jul 2018 01:56:37 +0200
> Subject: [PATCH] block: bio_iov_iter_get_pages: fix size of last iovec
> 
> If the last page of the bio is not "full", the length of the last
> vector bin needs to be corrected. This bin has the index
> (bio->bi_vcnt - 1), but in bio->bi_io_vec, not in the "bv" helper array which
> is shifted by the value of bio->bi_vcnt at function invocation.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>  block/bio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 53e0f0a..c22e76f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -913,7 +913,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	bv[0].bv_offset += offset;
>  	bv[0].bv_len -= offset;
>  	if (diff)
> -		bv[bio->bi_vcnt - 1].bv_len -= diff;
> +		bio->bi_io_vec[bio->bi_vcnt - 1].bv_len -= diff;
>  
>  	iov_iter_advance(iter, size);
>  	return 0;

Right, that is the issue, we need this fix for -stable, but maybe the
following fix is more readable:

diff --git a/block/bio.c b/block/bio.c
index f3536bfc8298..6e37b803755b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -914,16 +914,16 @@ EXPORT_SYMBOL(bio_add_page);
  */
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
-	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
+	unsigned short idx, nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
-	size_t offset, diff;
+	size_t offset;
 	ssize_t size;
 
 	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
-	nr_pages = (size + offset + PAGE_SIZE - 1) / PAGE_SIZE;
+	idx = nr_pages = (size + offset + PAGE_SIZE - 1) / PAGE_SIZE;
 
 	/*
 	 * Deep magic below:  We need to walk the pinned pages backwards
@@ -936,17 +936,15 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	bio->bi_iter.bi_size += size;
 	bio->bi_vcnt += nr_pages;
 
-	diff = (nr_pages * PAGE_SIZE - offset) - size;
-	while (nr_pages--) {
-		bv[nr_pages].bv_page = pages[nr_pages];
-		bv[nr_pages].bv_len = PAGE_SIZE;
-		bv[nr_pages].bv_offset = 0;
+	while (idx--) {
+		bv[idx].bv_page = pages[idx];
+		bv[idx].bv_len = PAGE_SIZE;
+		bv[idx].bv_offset = 0;
 	}
 
 	bv[0].bv_offset += offset;
 	bv[0].bv_len -= offset;
-	if (diff)
-		bv[bio->bi_vcnt - 1].bv_len -= diff;
+	bv[nr_pages - 1].bv_len -= (nr_pages * PAGE_SIZE - offset) - size;
 
 	iov_iter_advance(iter, size);
 	return 0;

And for mainline, I suggest to make Christoph's new code in, that is
easy to prove its correctness, and seems simpler.

Thanks,
Ming
