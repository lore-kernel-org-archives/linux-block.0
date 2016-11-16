Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCHSET] Add support for simplified async direct-io
To: Christoph Hellwig <hch@infradead.org>
References: <1479144519-15738-1-git-send-email-axboe@fb.com>
 <20161114173728.GA22167@infradead.org>
 <71ce9ae3-214d-b248-3507-cc96bea41a9b@fb.com>
 <20161114180052.GA24476@infradead.org>
 <4f30a528-9996-4c6a-9513-8aa2054e4d4b@fb.com>
 <20161114180503.GA31126@infradead.org>
 <d9baad75-d105-2968-1b59-608a8598e3bb@fb.com>
 <20161114181119.GA9396@infradead.org>
 <f8c29e81-7323-7362-b507-1b7c61e8a19a@fb.com>
 <20161116163147.GA25038@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <72b1725a-0363-d33e-f890-251b1ac88998@kernel.dk>
Date: Wed, 16 Nov 2016 09:57:11 -0700
MIME-Version: 1.0
In-Reply-To: <20161116163147.GA25038@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/16/2016 09:31 AM, Christoph Hellwig wrote:
> On Wed, Nov 16, 2016 at 09:09:17AM -0700, Jens Axboe wrote:
>> Another idea - just limit the max we can support in the simplified
>> version as a single bio. If the user is requesting more, fall back to
>> the old slow path. Doesn't really matter, since the transfer size will
>> be large enough to hopefully overcome any deficiencies in the old path.
>
> I really want to kill off the old code :)  Maybe we could use my
> iomap-based code instead of another block version if we delegate it
> far enough away from the host path with a patch like yours, but I really
> wonder if avoiding the atomic inc/dec is that important once we are
> above a minimal threshold.  That being said I think we could avoid
> the atomic op for the the single-bio cases even with code that handles
> multiples bios.  Kent actually noted that on my full blown iomap
> version.

I'd love to kill it off too, but that might take a bit longer. At least
the bdev versions are nice and simple.

> But if we need another fast but not super fast case your patch below
> looks reasonable.  Although we really need to implement O_SYNC/O_DSYNC
> support for it to avoid losing data.

I can add the flush support.

>> +	/*
>> +	 * Overload bio size in error. If it gets set, we lose the
>> +	 * size, but we don't need the size for that case. IO is limited
>> +	 * to BIO_MAX_PAGES, so we can't overflow.
>> +	 */
>> +	ret = bio->bi_error = bio->bi_iter.bi_size;
>
> Oh, that's a neat trick.

It's a bit iffy, but should be safe. And with that, we don't need an
extra allocation outside of the bio.

>> +	if (nr_pages <= DIO_INLINE_BIO_VECS)
>> +		vecs = inline_vecs;
>> +	else {
>> +		vecs = kmalloc(nr_pages * sizeof(struct bio_vec), GFP_KERNEL);
>
> kmalloc_array?

Good point, I'll make that change.

-- 
Jens Axboe
