Return-Path: <BATV+a95b4574ae9f7e2979a4+5142+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 20 Sep 2017 18:29:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: consider merge of segments when merge bio into rq
Message-ID: <20170921012949.GA29873@infradead.org>
References: <1505517709-2478-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505517709-2478-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

So the check change here looks good to me.

I don't like like the duplicate code, can you look into sharing
the new segment checks between the two functions and the existing
instance in ll_merge_requests_fn by passing say two struct bio *bio1
and struct bio *bio2 pointer instead of using req->bio and req->biotail?

Also please include the information that you posted in the reply to
the other patch in the description for this one.
