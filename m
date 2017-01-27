Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35158 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbdA0WDw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 17:03:52 -0500
Received: by mail-pg0-f51.google.com with SMTP id 194so84266774pgd.2
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2017 14:03:44 -0800 (PST)
Date: Fri, 27 Jan 2017 14:03:15 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 03/10] blk-mq: move hctx->dispatch and ctx->rq_list
 from sysfs to debugfs
Message-ID: <20170127220315.GB21371@vader.DHCP.thefacebook.com>
References: <cover.1485360145.git.osandov@fb.com>
 <4a761343fab2fc3d74689fa64e397a6aa2704819.1485360145.git.osandov@fb.com>
 <1485554400.13218.5.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485554400.13218.5.camel@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 27, 2017 at 10:00:19PM +0000, Bart Van Assche wrote:
> On Wed, 2017-01-25 at 08:06 -0800, Omar Sandoval wrote:
> > +static void *hctx_dispatch_start(struct seq_file *m, loff_t *pos)
> > +{
> > +	struct blk_mq_hw_ctx *hctx = m->private;
> > +
> > +	spin_lock(&hctx->lock);
> > +	return seq_list_start(&hctx->dispatch, *pos);
> > +}
> > [ ... ]
> > +static void hctx_dispatch_stop(struct seq_file *m, void *v)
> > +{
> > +	struct blk_mq_hw_ctx *hctx = m->private;
> > +
> > +	spin_unlock(&hctx->lock);
> > +}
> > [ ... ]
> > +static void *ctx_rq_list_start(struct seq_file *m, loff_t *pos)
> > +{
> > +	struct blk_mq_ctx *ctx = m->private;
> > +
> > +	spin_lock(&ctx->lock);
> > +	return seq_list_start(&ctx->rq_list, *pos);
> > +}
> > [ ... ]
> > +static void ctx_rq_list_stop(struct seq_file *m, void *v)
> > +{
> > +	struct blk_mq_ctx *ctx = m->private;
> > +
> > +	spin_unlock(&ctx->lock);
> > +}
> 
> Please add __acquires() / __releases() annotations to these functions as
> appropriate to keep sparse happy.
> 
> Thanks,
> 
> Bart.

Hey, Bart,

Jens pulled these in to his for-4.11/block branch already, could you
send these comments as incremental patches?

Thanks for taking a look!
Omar
