Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170930070143.GA14515@localhost.didichuxing.com>
References: <20170930070143.GA14515@localhost.didichuxing.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 30 Sep 2017 15:53:23 +0800
Message-ID: <CACVXFVO_knG2NV-ND1tOsOG6iun_SzWST_bDWVgiAjo9QyHsXw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: remove unused function hctx_allow_merges
To: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sat, Sep 30, 2017 at 3:01 PM, weiping zhang
<zhangweiping@didichuxing.com> wrote:
> since 9bddeb2a5b981 "blk-mq: make per-sw-queue bio merge as default .bio_merge"
> there is no caller for this function.
>
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>



-- 
Ming Lei
