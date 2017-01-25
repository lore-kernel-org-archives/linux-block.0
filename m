Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35499 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdAYQAP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 11:00:15 -0500
Received: by mail-pg0-f51.google.com with SMTP id 194so65531380pgd.2
        for <linux-block@vger.kernel.org>; Wed, 25 Jan 2017 08:00:15 -0800 (PST)
Date: Wed, 25 Jan 2017 07:59:48 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 02/10] blk-mq: add hctx->{state,flags} to debugfs
Message-ID: <20170125155948.GA19470@vader>
References: <cover.1485197480.git.osandov@fb.com>
 <ab6a91d92e1832116be1fdd8c47dca471badd727.1485197480.git.osandov@fb.com>
 <d08e8c98-4ada-6f1c-2a62-86a9295b6d88@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d08e8c98-4ada-6f1c-2a62-86a9295b6d88@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 24, 2017 at 02:25:39PM +0100, Hannes Reinecke wrote:
> On 01/23/2017 07:59 PM, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > hctx->state could come in handy for bugs where the hardware queue gets
> > stuck in the stopped state, and hctx->flags is just useful to know.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  block/blk-mq-debugfs.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> > 
> Hehe. I've found myself adding exactly the same attributes when
> debugging mq-deadline :-)
> 
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index 01711bbf5ade..0c14511fa9e0 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -29,7 +29,49 @@ struct blk_mq_debugfs_attr {
> >  
> >  static struct dentry *block_debugfs_root;
> >  
> > +static int hctx_state_show(struct seq_file *m, void *v)
> > +{
> > +	struct blk_mq_hw_ctx *hctx = m->private;
> > +
> > +	seq_printf(m, "0x%lx\n", hctx->state);
> > +	return 0;
> > +}
> > +
> What about decoding it?
> Would make life so much easier, and one doesn't have to have a kernel
> source tree available when looking things up...

I thought of this, too, but doing that would require setting up a
mapping from flag values to strings and keeping those in sync with the
actual flags, which I don't think is worth the trouble, since I imagine
that most of the time you're going to be consulting the source to debug
this kind of issue, anyways.

Thanks for the review!
