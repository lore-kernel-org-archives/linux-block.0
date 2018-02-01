Return-Path: <jglisse@redhat.com>
Date: Thu, 1 Feb 2018 10:57:49 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, lsf-pc@lists.linux-foundation.org,
	linux-block@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Killing reliance on struct page->mapping
Message-ID: <20180201155748.GA3085@redhat.com>
References: <20180130004347.GD4526@redhat.com>
 <20180131165646.GI29051@ZenIV.linux.org.uk>
 <20180131174245.GE2912@redhat.com>
 <20180131175558.GA30522@ZenIV.linux.org.uk>
 <20180131181356.GG2912@redhat.com>
 <35c2908e-b6ba-fc29-0a3c-15cb8cf00256@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <35c2908e-b6ba-fc29-0a3c-15cb8cf00256@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Feb 01, 2018 at 08:34:58AM -0700, Jens Axboe wrote:
> On 1/31/18 11:13 AM, Jerome Glisse wrote:
> > That's one solution, another one is to have struct bio_vec store
> > buffer_head pointer and not page pointer, from buffer_head you can
> > find struct page and using buffer_head and struct page pointer you
> > can walk the KSM rmap_item chain to find back the mapping. This
> > would be needed on I/O error for pending writeback of a newly write
> > protected page, so one can argue that the overhead of the chain lookup
> > to find back the mapping against which to report IO error, is an
> > acceptable cost.
> 
> Ehm nope. bio_vec is a generic container for pages, requiring
> buffer_heads to be able to do IO would be insanity.

The extra pointer dereference would be killing performance ? Note that
i am not saying have one vec entry per buffer_head but keep thing as
they are and run the following semantic patch:

@@
struct bio_vec *bvec;
expression E;
@@
-bvec->bv_page = E;
+bvec_set_page(bvec, E);

@@
struct bio_vec *bvec;
@@
-bvec->bv_page
+bvec_get_page(bvec);

Then inside struct bio_vec:
s/struct page *bv_head;/struct buffer_head *bv_bh;/

Finally add:
struct page *bvec_get_page(const struct bio_vec *bvec)
{
    return bvec->bv_bh->page;
}

void bvec_set_page(struct bio_vec *bvec, struct page *page)
{
    bvec->bv_bh = first_buffer_head(page);
}

Well you get the idea. Point is that it just add one more pointer
dereference so one more memory lookup. But if it is an issue they
are other way to achieve what i want. For instance i can have a
flags in the address store (1 bit) and make the extra dereference
only needed for write protected page. Or the other solution in
previous email, or something i haven't thought of yet :)

Like i said i don't think i will change the block subsystem, for
block i would only need to change if i ever want to allow write
protection to happen before pending writeback completion. Which
as of now feels to me like a micro-optimization that i might never
need.

In any case i am happy to discuss my ideas and try to find one
that people likes :)

Cheers,
J�r�me
