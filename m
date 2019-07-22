Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB8BC76194
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 23:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CD8219BE
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 23:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0kI8lG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfGVXWq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:22:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36022 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfGVXWq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 19:22:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so41167956wrs.3
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 16:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w8RmrKCLNV6A0HgHZ+FerLtUh99eSc8LM/7Qtq8LAJo=;
        b=u0kI8lG+YC0TmWykIx8xQEGsoI+nGMJ/i3uHiGKfD5w7rR1bJKBeN9YhhoU5JtdZ8c
         WaHQbZckfqd6y+R4tWVCnlj/Xzo42nMktJqCLnAfOp6gz/mL9IAFsyTBfl4XQE3OOvA1
         Hg+MEa4vo4YJibO6ezdJY4091FMcOmHRd23IAGnx+annB2AZb87UQjZzdDmuATaZccym
         59AecHUOdFhbZi7G77EKZyM0Fw+EI+R9mVz4v7cUz5QE8DVkNSoWkZ+r43uV/5W6menk
         Y/gJwPsn5tN9Tg3DpmV9EuIxgDl3z7c1m4fjpmUak7RpVx5ZdVg68HPo9dPbKB3ky3tr
         JWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8RmrKCLNV6A0HgHZ+FerLtUh99eSc8LM/7Qtq8LAJo=;
        b=QFh3tGZQkPav+wmEWxgDfXqgvRb+QhNITPXMLpIYTMEmd3vhg778+7m6+VZ2n37wyr
         sdnPKqbG4QRR57msmNVnUTlUotKz5SQW2oqOSia8/qOWSjDEzO8M/cyZo9izjKlB4oNM
         kvw5tSqiLG2ADxlhEtfDbtB2QND355O/PY//NHRJXSz9qJTjRfNKsyy2By2e7hXkAFw2
         2F/aDYnyfDZNIHQsEbOxKG7p+1eWTj7J8OmB9s5hUBQENRW04yu/KSEQ5YT9tbm0yjO6
         ZCFA7Lo76BTbvA+afdlaHC7gcGPn4RAj2l96yDr1ISJUnnCY6dXTUn/un2mEU9JtLTW5
         pRhw==
X-Gm-Message-State: APjAAAWVpNeDYkhBgUInLjVxMnMqrmiJ/8jxVJc+jsHOlZat0Kc6Z0b9
        GE+Fpsaunm+gQPIqHBMq/VfWdcsjoPItJBbDBsU=
X-Google-Smtp-Source: APXvYqzhZz7CnaC0oTLchBJevUk/xHJs7yT2V0xsuTZrWkdrGh4pYTmo6wXaIICBDEdvD1m0kMEXHiC9ZzOuoQal53Q=
X-Received: by 2002:a5d:630c:: with SMTP id i12mr71823262wru.312.1563837764191;
 Mon, 22 Jul 2019 16:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190722053954.25423-1-ming.lei@redhat.com> <20190722053954.25423-4-ming.lei@redhat.com>
 <d82ead02-c893-4d14-307e-70a6d4596439@acm.org>
In-Reply-To: <d82ead02-c893-4d14-307e-70a6d4596439@acm.org>
From:   Keith Busch <keith.busch@gmail.com>
Date:   Mon, 22 Jul 2019 17:22:33 -0600
Message-ID: <CAOSXXT5TkrfH0AFZCV0c+YtbFCQ4MnShKM-gkZrj8Qex+Z7Png@mail.gmail.com>
Subject: Re: [PATCH 3/5] nvme: don't abort completed request in nvme_cancel_request
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 22, 2019 at 9:27 AM Bart Van Assche <bvanassche@acm.org> wrote:
> On 7/21/19 10:39 PM, Ming Lei wrote:
> > Before aborting in-flight requests, all IO queues have been shutdown.
> > However, request's completion fn may not be done yet because it may
> > be scheduled to run via IPI.
> >
> > So don't abort one request if it is marked as completed, otherwise
> > we may abort one normal completed request.
> >
> > Cc: Max Gurtovoy <maxg@mellanox.com>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/nvme/host/core.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index cc09b81fc7f4..cb8007cce4d1 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -285,6 +285,10 @@ EXPORT_SYMBOL_GPL(nvme_complete_rq);
> >
> >   bool nvme_cancel_request(struct request *req, void *data, bool reserved)
> >   {
> > +     /* don't abort one completed request */
> > +     if (blk_mq_request_completed(req))
> > +             return;
> > +
> >       dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
> >                               "Cancelling I/O %d", req->tag);
>
> Something I probably already asked before: what prevents that
> nvme_cancel_request() is executed concurrently with the completion
> handler of the same request?

At least for pci, we've shutdown the queues and their interrupts prior
to tagset iteration, so we can't concurrently execute a natural
completion for in-flight requests while cancelling them.
