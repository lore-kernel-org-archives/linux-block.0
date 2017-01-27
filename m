Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0056.outbound.protection.outlook.com ([104.47.40.56]:35101
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751387AbdA0WBS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 17:01:18 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 03/10] blk-mq: move hctx->dispatch and ctx->rq_list
 from sysfs to debugfs
Date: Fri, 27 Jan 2017 22:00:19 +0000
Message-ID: <1485554400.13218.5.camel@sandisk.com>
References: <cover.1485360145.git.osandov@fb.com>
         <4a761343fab2fc3d74689fa64e397a6aa2704819.1485360145.git.osandov@fb.com>
In-Reply-To: <4a761343fab2fc3d74689fa64e397a6aa2704819.1485360145.git.osandov@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-25 at 08:06 -0800, Omar Sandoval wrote:
> +static void *hctx_dispatch_start(struct seq_file *m, loff_t *pos)
> +{
> +	struct blk_mq_hw_ctx *hctx =3D m->private;
> +
> +	spin_lock(&hctx->lock);
> +	return seq_list_start(&hctx->dispatch, *pos);
> +}
> [ ... ]
> +static void hctx_dispatch_stop(struct seq_file *m, void *v)
> +{
> +	struct blk_mq_hw_ctx *hctx =3D m->private;
> +
> +	spin_unlock(&hctx->lock);
> +}
> [ ... ]
> +static void *ctx_rq_list_start(struct seq_file *m, loff_t *pos)
> +{
> +	struct blk_mq_ctx *ctx =3D m->private;
> +
> +	spin_lock(&ctx->lock);
> +	return seq_list_start(&ctx->rq_list, *pos);
> +}
> [ ... ]
> +static void ctx_rq_list_stop(struct seq_file *m, void *v)
> +{
> +	struct blk_mq_ctx *ctx =3D m->private;
> +
> +	spin_unlock(&ctx->lock);
> +}

Please add __acquires() / __releases() annotations to these functions as
appropriate to keep sparse happy.

Thanks,

Bart.=
