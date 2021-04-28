Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717EEC433B4
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 02:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46FBE61400
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 02:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbhD1CXa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 22:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235814AbhD1CXa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 22:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619576565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T5Wibpbux5z7k0o6MD3/ry3v5KFwFF9ftRFvRaDekbk=;
        b=KFMgSgi3sipXFUvDNLBTIhnnwSRYPlkEzkntE/0iNPGrdCPVekxaaZ7Xfqn1pvReVOXM8C
        SpxZ00gtGRUAu9GlpDx8wg9xsNGmj9bM0Byw1DPup1e/RTwPjcVFKYwoyvj1oGQyeHQkWp
        9O7v+ShNVWDFggkHci9UAwqLiIRLj8o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-sslCbqnUMse9xiHr8WBPrQ-1; Tue, 27 Apr 2021 22:22:43 -0400
X-MC-Unique: sslCbqnUMse9xiHr8WBPrQ-1
Received: by mail-ed1-f72.google.com with SMTP id f1-20020a0564021941b02903850806bb32so20043737edz.9
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 19:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T5Wibpbux5z7k0o6MD3/ry3v5KFwFF9ftRFvRaDekbk=;
        b=U8P/LSkuPVlYqrvp9RsKuOG8P4lVLvVfK49SFYhvwvxIszWjplKFrTetGdQvr8o5jo
         TOIUWz5lgdQOfJrNf8wYSWdQ6yjJMMyfylgxNqJwlhnG9/z1qTg58Ch4oZKGp0C46UAB
         84ER9GMjZR+/GzowZNlSU+IRgycm4DZw5LE/jCt1rGnPctq/KiiN+VzOju4XN5SDHq1T
         Tm46Fwsej32fgDkq59c8Y1OEEFmiITKYkdx9Xk5HM1GA85D+GMyfUgbzNTnbVxPCG7Z4
         IHsCjchMoR/W4MpjCBE1oX/iEPTVRIw5XWLWJKIp8zdp/GYPzLlO6vo5mX0cv0+LteP5
         2Iuw==
X-Gm-Message-State: AOAM5322TIobIacbnVjXlVdUB1t+wI39s0Z2z9TyPGKGjjgG6PM0vlV5
        rFqZ19KIMBqTZuh0OaS/WJ9+3xsFTIV7Kvsngwq77w60iGbSChjnJmjGNdTscngK93suY4sJ/RP
        i+KtfrRy5Dwfhi05fUkLg3/PwlJ1YSuwOJEeIShQ=
X-Received: by 2002:a17:907:100e:: with SMTP id ox14mr10723634ejb.484.1619576561989;
        Tue, 27 Apr 2021 19:22:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9ZpjZ2gv4fc7fFpT7xNyf8kC1lajHgrZWho/ysEr9Dj2SHpyUbdrRfNDVhEL1EBwLcXOuw4Cfqjv7xxmyv00=
X-Received: by 2002:a17:907:100e:: with SMTP id ox14mr10723615ejb.484.1619576561812;
 Tue, 27 Apr 2021 19:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210427151058.2833168-1-ming.lei@redhat.com> <20210427151058.2833168-3-ming.lei@redhat.com>
 <ce2f315d-ffa8-8327-0633-01c06a2c23fe@acm.org> <YIinU8pb2RzzNxLi@T590> <0151a8f4-37d2-69c2-cc3f-ff05e0c2b8d5@acm.org>
In-Reply-To: <0151a8f4-37d2-69c2-cc3f-ff05e0c2b8d5@acm.org>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Wed, 28 Apr 2021 10:22:42 +0800
Message-ID: <CAFj5m9+hc04qma9HuZeigq+mMZG-vcLGKYUG-NQgjyLMExxRvA@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] blk-mq: grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Khazhy Kumykov <khazhy@google.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 28, 2021 at 9:37 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/27/21 5:07 PM, Ming Lei wrote:
> > On Tue, Apr 27, 2021 at 01:17:06PM -0700, Bart Van Assche wrote:
> >> On 4/27/21 8:10 AM, Ming Lei wrote:
> >>> +void blk_mq_put_rq_ref(struct request *rq)
> >>> +{
> >>> +   if (is_flush_rq(rq, rq->mq_hctx))
> >>> +           rq->end_io(rq, 0);
> >>> +   else if (refcount_dec_and_test(&rq->ref))
> >>> +           __blk_mq_free_request(rq);
> >>> +}
> >>
> >> The above function needs more work. blk_mq_put_rq_ref() may be called from
> >> multiple CPUs concurrently and hence must handle concurrent calls safely.
> >> The flush .end_io callbacks have not been designed to handle concurrent
> >> calls.
> >
> > static void flush_end_io(struct request *flush_rq, blk_status_t error)
> > {
> >         struct request_queue *q = flush_rq->q;
> >         struct list_head *running;
> >         struct request *rq, *n;
> >         unsigned long flags = 0;
> >         struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
> >
> >         /* release the tag's ownership to the req cloned from */
> >         spin_lock_irqsave(&fq->mq_flush_lock, flags);
> >
> >         if (!refcount_dec_and_test(&flush_rq->ref)) {
> >                 fq->rq_status = error;
> >                 spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
> >                 return;
> >         }
> >               ...
> >               spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
> > }
> >
> > Both spin lock and refcount_dec_and_test() are called at the beginning of
> > flush_end_io(), so it is absolutely reliable in case of concurrent
> > calls.
> >
> > Otherwise, it is simply one issue between normal completion and timeout
> > since the pattern in this patch is same with timeout.
> >
> > Or do I miss something?
>
> The following code from blk_flush_restore_request() modifies the end_io
> pointer:
>
>         rq->end_io = rq->flush.saved_end_io;

blk_flush_restore_request() is only done for request passed to
blk_insert_flush(),
here we only call ->end_io() for flush_rq which is one flush internal
request instance, please see is_flush_rq() definition.  Also
flush_rq->end_io always
points to flush_end_io().

So there isn't such issue you mentioned.

Thanks,
Ming

