Date: Thu, 4 May 2017 08:11:38 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Hannes Reinecke <hare@suse.de>
Cc: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: Re: [PATCH v2 05/12] blk-mq-debugfs: rename hw queue directories
 from <n> to hctx<n>
Message-ID: <20170504141138.GB9292@kernel.dk>
References: <cover.1493882751.git.osandov@fb.com>
 <d93cf237ca97fa3fa7213689ebdaffaf12a32146.1493882751.git.osandov@fb.com>
 <3ce428ae-8356-a6e3-e4c8-229837be9a76@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ce428ae-8356-a6e3-e4c8-229837be9a76@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 04 2017, Hannes Reinecke wrote:
> On 05/04/2017 09:31 AM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > It's not clear what these numbered directories represent unless you
> > consult the code. We're about to get rid of the intermediate "mq"
> > directory, so these would be even more confusing without that context.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  block/blk-mq-debugfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index 109ae9f3d400..2eae3238fb35 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -936,7 +936,7 @@ static int blk_mq_debugfs_register_hctx(struct request_queue *q,
> >  	char name[20];
> >  	int i;
> >  
> > -	snprintf(name, sizeof(name), "%u", hctx->queue_num);
> > +	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
> >  	hctx_dir = debugfs_create_dir(name, q->mq_debugfs_dir);
> >  	if (!hctx_dir)
> >  		return -ENOMEM;
> > 
> Hmm. The number actually corresponds to /sys/block/XX/mq/<num>
> With this patch we would break this mapping, no?
> 
> I'd rather keep it in sync with /sys/block ...

It's still the same number, it's just clearer what it is. I like this
change.

-- 
Jens Axboe
