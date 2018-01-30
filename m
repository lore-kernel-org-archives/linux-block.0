Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:45511 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeA3Mxm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jan 2018 07:53:42 -0500
Received: by mail-wr0-f175.google.com with SMTP id 16so10998238wry.12
        for <linux-block@vger.kernel.org>; Tue, 30 Jan 2018 04:53:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87o9lcp1aq.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
References: <20171218074044.1369-3-ming.lei@redhat.com> <87o9lcp1aq.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 30 Jan 2018 20:53:40 +0800
Message-ID: <CACVXFVMoXR9pobeCK9j-8ZL0VJB6xC7J6EYCN5YZarcVccPuvQ@mail.gmail.com>
Subject: Re: [PATCH] Use bio_endio instead of bio_put in error path of blk_rq_append_bio
To: =?UTF-8?B?SmnFmcOtIFBhbGXEjWVr?= <jpalecek@web.de>
Cc: linux-block <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 25, 2018 at 9:58 PM, Ji=C5=99=C3=AD Pale=C4=8Dek <jpalecek@web.=
de> wrote:
>  Avoids page leak from bounced requests
> ---
>  block/blk-map.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-map.c b/block/blk-map.c
> index d3a94719f03f..702d68166689 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -26,7 +26,8 @@ int blk_rq_append_bio(struct request *rq, struct bio **=
bio)
>         } else {
>                 if (!ll_back_merge_fn(rq->q, rq, *bio)) {
>                         if (orig_bio !=3D *bio) {
> -                               bio_put(*bio);
> +                               bio_inc_remaining(orig_bio);
> +                               bio_endio(*bio);

'bio_inc_remaining(orig_bio);' shouldn't be needed since we don't chain bou=
nced
bio, otherwise this patch is fine.

Thanks,
Ming Lei
