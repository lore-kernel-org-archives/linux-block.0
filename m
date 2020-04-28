Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9503BC83007
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 08:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 727B5206B9
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 08:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIRU+1u8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgD1ICr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgD1ICq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 04:02:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E8EC03C1A9;
        Tue, 28 Apr 2020 01:02:46 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u15so20457439ljd.3;
        Tue, 28 Apr 2020 01:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qBq8MNvK8Nt/D5QT2/1GNIA89VYusPV5jUqjHtTptYc=;
        b=HIRU+1u8K7IFC9dUiid10MpRqqgDfPiiEtdQn/F1C71TCCLM97SePIKpq/EHxpTTZL
         aGij20mzHyxRZQDIcuu5OZl1n29WX6Z1WxlJmejBnQ/SouUBwehIHAMklCPffYHATqzA
         +YiLUYoRlTvZVCkjGC8PhkhJDq4H2M72pr6qUAAxyUg7GONzh0/ZnNKeTbKeUUv43voW
         OfZ0gWC/JooWIdAvUi0bi7ScveloLkpBgSktzyO/J5WIzssynK5TVVpPEm8wYciJBmxi
         QDbYYiHB+dXDlwTe1aADpBT3NSwBVL5/UPqR1DEe7poZupXBcFgno4zj25nlz0GQwV6z
         UFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBq8MNvK8Nt/D5QT2/1GNIA89VYusPV5jUqjHtTptYc=;
        b=V1f9pDGr2t9IILDGVRruXcZzN1fj96OWtIGlRBT50yfFejgDXdi/u9K8n7lRFNy89n
         xP/o+4UIXlSB96hhL60pGNxj5O5Da1qlYJXaB3MQK99KNAKH2VimXV0FAmMz02ANrrbb
         FQmN14K+/rt0GHYqyxg8brrFCK15B4VjEPvQ8EV0vT0QmgkMSmKYEfrz15s2Ps95wy2+
         tX70p1WrmTQYZsyA/dQfSXWv9v+TeSNn3Cg6EtJGA5yMjTd7B2SjTzmd6URPovIWEWnG
         OO3Oxa4EWoLJThl+i3NH2DsZak4AAW6qDtwbBHluJXA5FDpvGxKejgTf6nSh1C9gKWO6
         7MHA==
X-Gm-Message-State: AGi0PuY63nb4DrUnpxov/iRMf+7DdwPc+TwtJVjufZVGzoUlcgOlfkxd
        vkTqL5bG8GgUPgqQLCZ0mJTWh/rl0SiqkCXOj38=
X-Google-Smtp-Source: APiQypKIDA7sLbwgIsOl28DhVoAQyjhVKdOdVrx7ZbmXpXqulpkql5QUkf/hSTUfwACFToV4UqilQZOJ0bPp2alcXFM=
X-Received: by 2002:a2e:5746:: with SMTP id r6mr16464643ljd.15.1588060964488;
 Tue, 28 Apr 2020 01:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587888520.git.baolin.wang7@gmail.com> <c8bd9e5ba815a3f1bc9dac0a4bc2fbadadbc0a43.1587888520.git.baolin.wang7@gmail.com>
 <20200427154645.GA1201@infradead.org>
In-Reply-To: <20200427154645.GA1201@infradead.org>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 28 Apr 2020 16:02:33 +0800
Message-ID: <CADBw62qrM2pjDXVGumTDsjvbNwN9S3kexxZemqkCf2JBynDOmQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] block: Extand commit_rqs() to do batch processing
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <ming.lei@redhat.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 27, 2020 at 11:46 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> extand in the subject really shpuld be 'extend'

Sorry for typo, and will fix in next version.

>
> On Sun, Apr 26, 2020 at 05:38:54PM +0800, Baolin Wang wrote:
> > From: Ming Lei <ming.lei@redhat.com>
> >
> > Now some SD/MMC host controllers can support packed command or packed request,
> > that means we can package several requests to host controller at one time
> > to improve performence.
> >
> > But the blk-mq always takes one request from the scheduler and dispatch it to
> > the device, regardless of the driver or the scheduler, so there should only
> > ever be one request in the local list in blk_mq_dispatch_rq_list(), that means
> > the bd.last is always true and the driver can not use bd.last to decide if
> > there are requests are pending now in hardware queue to help to package
> > requests.
> >
> > Thus this patch introduces a new 'BLK_MQ_F_FORCE_COMMIT_RQS' flag to call
> > .commit_rqs() to do batch processing if necessary.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > Tested-by: Baolin Wang <baolin.wang7@gmail.com>
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
> >  block/blk-mq-sched.c   | 29 ++++++++++++++++++++---------
> >  block/blk-mq.c         | 15 ++++++++++-----
> >  include/linux/blk-mq.h |  1 +
> >  3 files changed, 31 insertions(+), 14 deletions(-)
> >
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index 74cedea56034..3429a71a7364 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -85,11 +85,12 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
> >   * its queue by itself in its completion handler, so we don't need to
> >   * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
> >   */
> > -static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > +static bool blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
>
> This function already returns an int in the current for-5.8/block tree.

Thanks for pointing this out, and seems I should re-modify the return
values of the functions.

>
> > +             if (!(hctx->flags & BLK_MQ_F_FORCE_COMMIT_RQS)) {
> > +                     if (list_empty(list)) {
> > +                             bd.last = true;
> > +                     } else {
> > +                             nxt = list_first_entry(list, struct request,
> > +                                                    queuelist);
> > +                             bd.last = !blk_mq_get_driver_tag(nxt);
> > +                     }
> > +             } else {
> > +                     bd.last = false;
> >               }
>
> This seems a little odd in terms of code flow.  Why not:
>
>                 if (hctx->flags & BLK_MQ_F_FORCE_COMMIT_RQS) {
>                         bd.last = false;
>                 } else if (list_empty(list)) {
>                         bd.last = true;
>                 } else {
>                         nxt = list_first_entry(list, struct request, queuelist);
>                         bd.last = !blk_mq_get_driver_tag(nxt);
>                 }

Yes, looks better.

> > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > index f389d7c724bd..6a20f8e8eb85 100644
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -391,6 +391,7 @@ struct blk_mq_ops {
> >  enum {
> >       BLK_MQ_F_SHOULD_MERGE   = 1 << 0,
> >       BLK_MQ_F_TAG_SHARED     = 1 << 1,
> > +     BLK_MQ_F_FORCE_COMMIT_RQS = 1 << 3,
>
> Maybe BLK_MQ_F_ALWAYS_COMMIT might be a better name?  Also this

Looks reasonable to me, and will do.

> flag (just like the existing ones..) could really use a comment
> explaining it.

OK, will add some comments. Thanks for your comments.

-- 
Baolin Wang
