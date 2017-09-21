Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] block: consider merge of segments when merge bio into rq
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1505517709-2478-1-git-send-email-jianchao.w.wang@oracle.com>
 <20170921012949.GA29873@infradead.org>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <a85abdc2-ca46-f943-061c-41743a6a9230@oracle.com>
Date: Thu, 21 Sep 2017 10:46:23 +0800
MIME-Version: 1.0
In-Reply-To: <20170921012949.GA29873@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 09/21/2017 09:29 AM, Christoph Hellwig wrote:
> So the check change here looks good to me.
> 
> I don't like like the duplicate code, can you look into sharing
> the new segment checks between the two functions and the existing
> instance in ll_merge_requests_fn by passing say two struct bio *bio1
> and struct bio *bio2 pointer instead of using req->bio and req->biotail?
> 
> Also please include the information that you posted in the reply to
> the other patch in the description for this one.
> 
I have looked into the ll_back/front_merge_fn() and ll_merge_requests_fn().
It seems that segments check code fragment looks similar but not unified.
We could unify the part of calculation of variable of seg_size and contig,
but not the positions where use these two.
Especially the calculation of total_phys_segments and judgment of 
'nr_phys_segments == 1', rq variable cannot be avoided there. And the update
of bi_seg_front/back_size is also very tricky. If force to merge these code 
fragments together, the code may become hard to read.

So please refer to the V2 patch which contain more comment about the issue
and result.

Thanks
Jianchao
