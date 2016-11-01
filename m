Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20161031154021.GM30919@infradead.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-47-git-send-email-tom.leiming@gmail.com> <20161031154021.GM30919@infradead.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 1 Nov 2016 08:19:06 +0800
Message-ID: <CACVXFVO62t=6y7Wg+E2mUpueErpTeQ9D+1QqO6J_nSwnBLrRLg@mail.gmail.com>
Subject: Re: [PATCH 46/60] block: deal with dirtying pages for multipage bvec
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 31, 2016 at 11:40 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Sat, Oct 29, 2016 at 04:08:45PM +0800, Ming Lei wrote:
>> In bio_check_pages_dirty(), bvec->bv_page is used as flag
>> for marking if the page has been dirtied & released, and if
>> no, it will be dirtied in deferred workqueue.
>>
>> With multipage bvec, we can't do that any more, so change
>> the logic into checking all pages in one mp bvec, and only
>> release all these pages if all are dirtied, otherwise dirty
>> them all in deferred wrokqueue.
>
> Just defer the whole bio to the workqueue if we need to redirty any,
> that avoids having all these complex iteratations.

For dio READ, it is always dirtied before submitting, so there should be
little possibity that pages in the bio becomes non-dirty after completion,
it should hurt performance if each direct-read bio is deferred to the block
wq.


thanks,
Ming Lei
