Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] block: consider merge of segments when merge bio into rq
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1505517709-2478-1-git-send-email-jianchao.w.wang@oracle.com>
 <20170921012949.GA29873@infradead.org>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <a2a1f63c-89fe-b9a0-58a3-8ced81b587c7@oracle.com>
Date: Thu, 21 Sep 2017 09:34:55 +0800
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

I have just sent a new version which contains more comment before I see
this mail. I will send out another new version that apply your advice later.
Thanks for your kind and fair comment.

Jianchao
