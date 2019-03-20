Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D587C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 03:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C04217F4
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 03:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfCTDa7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 23:30:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbfCTDa7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 23:30:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 965A158E35;
        Wed, 20 Mar 2019 03:30:58 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BD0C62489;
        Wed, 20 Mar 2019 03:30:50 +0000 (UTC)
Date:   Wed, 20 Mar 2019 11:30:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>, Yi Zhang <yi.zhang@redhat.com>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2] sbitmap: order READ/WRITE freed instance and setting
 clear bit
Message-ID: <20190320033044.GA5745@ming.t460p>
References: <20190319083842.30059-1-ming.lei@redhat.com>
 <1553008008.152266.42.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553008008.152266.42.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 20 Mar 2019 03:30:58 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 19, 2019 at 08:06:48AM -0700, Bart Van Assche wrote:
> On Tue, 2019-03-19 at 16:38 +0800, Ming Lei wrote:
> > Inside sbitmap_queue_clear(), once the clear bit is set, it will be
> > visiable to allocation path immediately. Meantime READ/WRITE on old
> > associated instance(such as request in case of blk-mq) may be
> > out-of-order with the setting clear bit, so race with re-allocation
> > may be triggered.
> > 
> > Adds one memory barrier for ordering READ/WRITE of the freed associated
> > instance with setting clear bit for avoiding race with re-allocation.
> > 
> > The following kernel oops triggerd by block/006 on aarch64 may be fixed:
>                                                              ^^^
> 
> Does that mean that it has not been verified whether this patch fixes the
> NULL pointer issue mentioned in the patch description?

V1 has been verified by Zhang Yi, but V2 isn't done yet.

> 
> > diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> > index 5b382c1244ed..941a46495e12 100644
> > --- a/lib/sbitmap.c
> > +++ b/lib/sbitmap.c
> > @@ -591,6 +591,17 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
> >  void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
> >                          unsigned int cpu)
> >  {
> > +       /*
> > +        * Once the clear bit is set, the bit may be allocated out.
>              ^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This comment is confusing. Did you perhaps mean "Once the bit is cleared"?

No, please take at look at sbitmap_deferred_clear_bit().

> 
> > +        *
> > +        * Orders READ/WRITE on the asssociated instance(such as request
> > +        * of blk_mq) by this bit for avoiding race with re-allocation,
> > +        * and its pair is the memory barrier implied in __sbitmap_get_word.
> > +        *
> > +        * One invarient is that the clear bit has to be zero when the bit
>                  ^^^^^^^^^             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                  invariant?            I cant' make sense of this.

It is really 'clear bit', again please look at
sbitmap_deferred_clear_bit().

Thanks,
Ming
