Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:14872 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751967AbdDKSAv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2017 14:00:51 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH 1/3] blk-mq: unify hctx delayed_run_work and run_work
Date: Tue, 11 Apr 2017 18:00:40 +0000
Message-ID: <1491933638.2654.12.camel@sandisk.com>
References: <1491839696-24783-1-git-send-email-axboe@fb.com>
         <1491839696-24783-2-git-send-email-axboe@fb.com>
In-Reply-To: <1491839696-24783-2-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-04-10 at 09:54 -0600, Jens Axboe wrote:
>  void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
>  {
> -	cancel_work(&hctx->run_work);
> +	cancel_delayed_work(&hctx->run_work);
>  	cancel_delayed_work(&hctx->delay_work);
>  	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
>  }

Hello Jens,

I would like to change the above cancel_*work() calls into cancel_*work_syn=
c()
calls because this code is used when e.g. switching between I/O schedulers =
and
no .queue_rq() calls must be ongoing while switching between schedulers. Do=
 you
want to integrate that change into this patch or do you want me to post a
separate patch? In the latter case, should I start from your for-next branc=
h
to develop that patch or from your for-next branch + this patch series?

Thanks,

Bart.=
