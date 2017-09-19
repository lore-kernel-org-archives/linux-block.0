Return-Path: <BATV+de86e71b538cb4077339+5140+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 19 Sep 2017 07:36:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: move sanity checking ahead of
 bi_front/back_seg_size updating
Message-ID: <20170919143644.GA15944@infradead.org>
References: <1505517030-29287-1-git-send-email-jianchao.w.wang@oracle.com>
 <20170918235110.GB8600@infradead.org>
 <043c8787-1056-c16d-a38d-a421920742de@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <043c8787-1056-c16d-a38d-a421920742de@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 19, 2017 at 08:55:59AM +0800, jianchao.wang wrote:
> > But can you elaborate a little more on how this found and if there
> > is a way to easily reproduce it, say for a blktests test case?
> > 
> It is found when I made the patch of 
> 'block: consider merge of segments when merge bio into rq' , not from an actual
> issue or test case.

Same question applies to that one, I just haven't finished understanding
all the changes in it yet.
