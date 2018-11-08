Return-Path: <msnitzer@redhat.com>
Date: Thu, 8 Nov 2018 10:48:33 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq-tag: change busy_iter_fn to return whether to
 continue or not
Message-ID: <20181108154832.GA28795@redhat.com>
References: <20181108154216.23853-1-axboe@kernel.dk>
 <20181108154216.23853-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181108154216.23853-2-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Nov 08 2018 at 10:42am -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> We have this functionality in sbitmap, but we don't export it in
> blk-mq for users of the tags busy iteration. This can be useful
> for stopping the iteration, if the caller doesn't need to find
> more requests.
> 
> Cc: Mike Snitzer <snitzer@redhat.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

(could add Tested-by too but probably overkill?)

Thanks,
Mike
