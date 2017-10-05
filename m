Return-Path: <msnitzer@redhat.com>
Date: Thu, 5 Oct 2017 17:21:53 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH, resend] block: remove QUEUE_FLAG_STACKABLE
Message-ID: <20171005212153.GA6949@redhat.com>
References: <20171005192252.21090-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171005192252.21090-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 05 2017 at  3:22pm -0400,
Christoph Hellwig <hch@lst.de> wrote:

> We already have a queue_is_rq_based helper to check if a request_queue
> is request based, so we can remove the flag for it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>
