Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] block: fix two regressiones on bounce
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neilb@suse.com>,
 Michele Ballabio <barra_cuda@katamail.com>, Vincent Batts <vbatts@redhat.com>
References: <20171218074044.1369-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8d1baf35-3f94-a6d7-7e05-0f90acbefde0@kernel.dk>
Date: Mon, 18 Dec 2017 13:22:10 -0700
MIME-Version: 1.0
In-Reply-To: <20171218074044.1369-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/18/2017 12:40 AM, Ming Lei wrote:
> Hi Jens,
> 
> The 1st patch makes sure that passthrough IO won't enter .make_request_fn.
> 
> The 2nd one fixes blk_rq_append_bio(), which is from your post with
> small change on failure handling.

Thanks Ming, queued up.

-- 
Jens Axboe
