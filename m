Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <149266672835.27388.5719138070560521601.stgit@noble>
References: <149266645258.27388.14083229348123176454.stgit@noble> <149266672835.27388.5719138070560521601.stgit@noble>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 21 Apr 2017 23:14:58 +0800
Message-ID: <CACVXFVPfC3JZMHoLwJXyfTxGkGKcQV1MZQ3+mSgXkBLMmbiCcQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] blk: remove bio_set arg from blk_queue_split()
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 20, 2017 at 1:38 PM, NeilBrown <neilb@suse.com> wrote:
> blk_queue_split() is always called with the last arg being q->bio_split,
> where 'q' is the first arg.
>
> Also blk_queue_split() sometimes uses the passed-in 'bs' and sometimes uses
> q->bio_split.
>
> This is inconsistent and unnecessary.  Remove the last arg and always use
> q->bio_split inside blk_queue_split()
>
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
