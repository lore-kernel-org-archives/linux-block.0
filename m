Subject: Re: [PATCHSET] Add support for simplified async direct-io
To: Christoph Hellwig <hch@infradead.org>
References: <1479144519-15738-1-git-send-email-axboe@fb.com>
 <20161114173728.GA22167@infradead.org>
 <71ce9ae3-214d-b248-3507-cc96bea41a9b@fb.com>
 <20161114180052.GA24476@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <4f30a528-9996-4c6a-9513-8aa2054e4d4b@fb.com>
Date: Mon, 14 Nov 2016 11:02:47 -0700
MIME-Version: 1.0
In-Reply-To: <20161114180052.GA24476@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/14/2016 11:00 AM, Christoph Hellwig wrote:
> On Mon, Nov 14, 2016 at 10:47:46AM -0700, Jens Axboe wrote:
>> This seems less clean in basically all ways, not sure I agree with you.
>> We already have 4 vecs inlined in a generic bio, and we might as well
>> use the fs bioset instead of creating our own. You also add a smallish
>> dio to track things, I don't think we need that.
>
> We need it unless we want unbounded allocations for the biovec.  With a
> 1GB I/O we're at a page size allocation, and with 64MB I/Os that aren't
> unheard of we'd be up to a 64 pages or an order 6 allocation which will
> take down the VM.  We also need to pin down all the user memory while
> doing the I/O instead of having throttling on the bio mempool before
> doing the get_user_pages.

Just add the iterator and loop for every X pages? We can even put a plug
around it, if we have to.

-- 
Jens Axboe
