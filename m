Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [rfc] weirdness in bio_map_user_iov()
To: Al Viro <viro@ZenIV.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
References: <20160921215226.GU2356@ZenIV.linux.org.uk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3bef44d1-1968-804e-87d9-458b32d83a7e@grimberg.me>
Date: Fri, 23 Sep 2016 14:47:55 -0700
MIME-Version: 1.0
In-Reply-To: <20160921215226.GU2356@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hey Al,

> What happens if we feed it a 3-element iovec array, one page in each?
> AFAICS, bio_add_pc_page() is called for each of those pages, even if
> the previous calls have failed - break is only out of the inner loop.
>
> Sure, failure due to exceeded request size means that everything after
> that one will fail, but what of e.g.
>                 /*
>                  * If the queue doesn't support SG gaps and adding this
>                  * offset would create a gap, disallow it.
>                  */
>                 if (bvec_gap_to_prev(q, prev, offset))
>                         return 0;
> in there?  Won't we risk having the first and the third pages added, with
> the second one quietly skipped?  Jens, looks like it had come from you
> (by way of jejb).  Am I missing something subtle here?

So AFAICT, 'gappy' iovecs will never reach bio_map_user_iov() because it
is checked before in blk_rq_map_user_iov():

         if (map_data)
                 copy = true;
         else if (iov_iter_alignment(iter) & align)
                 copy = true;
         else if (queue_virt_boundary(q))
                 copy = queue_virt_boundary(q) & 
iov_iter_gap_alignment(iter);

if iov_iter_gap_alignment(iter) detects gaps it will use
a nice aligned bounce via bio_copy_user_iov().
