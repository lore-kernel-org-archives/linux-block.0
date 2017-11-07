Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: put driver tag if dispatch budget can't be got
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>
References: <20171107095957.1426-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <49ff5756-e488-5a68-b7a7-b4ededd541b2@kernel.dk>
Date: Tue, 7 Nov 2017 09:23:19 -0700
MIME-Version: 1.0
In-Reply-To: <20171107095957.1426-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/07/2017 02:59 AM, Ming Lei wrote:
> We have to put the driver tag if dispatch budget can't be got, otherwise
> it might cause IO deadlock, especially in case that size of tags is very
> small.

Fix looks correct to me, but it's missing a Fixes: line. I tried to
go back a little bit, but it looks like this failure case was
introduced just recently:

commit 88022d7201e96b43f1754b0358fc6bcd8dbdcde1
Author: Ming Lei <ming.lei@redhat.com>
Date:   Sun Nov 5 02:21:12 2017 +0800

    blk-mq: don't handle failure in .get_budget


-- 
Jens Axboe
