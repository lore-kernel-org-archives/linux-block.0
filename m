Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C82C4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 20:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A1E206C0
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 20:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUq1Ko15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfDDUzP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:55:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35389 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbfDDUzP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 16:55:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so4993374wmd.0;
        Thu, 04 Apr 2019 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoIJTueLk0iYF0MqX7y0ytWOG5pG46WMqj1TDV/bZCc=;
        b=PUq1Ko15s8Pbv+XHUaFfOVmVOwYLJCwcLudWZ+kBwXWvTblMNHmNbWgIiNdW66eDY3
         VqyOrdUGpnRhzvouSchbck+4ULgBESx3tnm1gy+lfSd4JYZe1cjc53F9uPxMNfuNtcbP
         dIhjLVY2vkr84tFi6B+Z5S0wagrF9eczEV+Oh5d95+rgWkSDTWEPQrl2f9Qh8ZmxXXRC
         IZgmGi7P1Bs7szVktWg4oJWVO/x8/3kv2dkgHNV0mP9RZ4+DdwLJYKwV5Z+ypwYMKqUF
         OkhAaa8ZcaFLjOWEDG8owlvNGTXSkJwmng7EY/3mH54sIap32se8tTWZ/okBHnBCe5Ow
         807Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoIJTueLk0iYF0MqX7y0ytWOG5pG46WMqj1TDV/bZCc=;
        b=Pq4dNZh9enCGLBAkhefGGZkD54xdOY2S73r2agHOnEg+Jln1ZdyKLmWfa4CX14VhxO
         N8hFvi2lao1rpfguJ1lf4YkJa1Q9RZOV3JkfPP5R47CpF0XBImMWzgScJSOOrzIgpq2v
         ykP2fGfl2HywO2TLlIlWoS4pxGoBejsA8ijhOnrGAtpdGIJ0clMnGw34uQpmh91Fn5w0
         Q3L9bhHa0Mrf/nXosxPV3DE3BZVRe363ZB8nvXxVuS1vUb0ZJJjr9GgiIwTnqUPbgYkg
         Y+ogfSesIRzbSxAHw0DAxJtiZfYsyHckOKNwVlJR0xBOcGDbHTi0JDesTxEMbEpRd/Uj
         j16g==
X-Gm-Message-State: APjAAAXvw1VaUxY1ExOtLshX3xdsu0exno5NbH3LpglIJyq1ae2+jeFj
        sX7sJdZ3LURCfOqSTEp/29xWq6FzNUJE9RlS6fw=
X-Google-Smtp-Source: APXvYqxcxxmI/WFAZPVm1ZgcbhW+LWuIAxF0XdMyr5eSvq2zCooCAGEXsxKCFd5ZLHToHw/dXfkZ6RMdwUSbaBS+owI=
X-Received: by 2002:a7b:c408:: with SMTP id k8mr5569358wmi.69.1554411312978;
 Thu, 04 Apr 2019 13:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190404084320.24681-1-ming.lei@redhat.com> <20190404084320.24681-4-ming.lei@redhat.com>
 <1554393431.118779.249.camel@acm.org>
In-Reply-To: <1554393431.118779.249.camel@acm.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 5 Apr 2019 04:55:01 +0800
Message-ID: <CACVXFVO0K5-sJT0eO=AUQh4GWMSzk90y80seagA7hib58YkGnA@mail.gmail.com>
Subject: Re: [PATCH V4 3/7] blk-mq: quiesce queue before updating nr_hw_queues
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 4, 2019 at 11:57 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Thu, 2019-04-04 at 16:43 +0800, Ming Lei wrote:
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index b512ba0cb359..41c12d9008b7 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -3224,8 +3224,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> >         if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
> >                 return;
> >
> > -       list_for_each_entry(q, &set->tag_list, tag_set_list)
> > +       list_for_each_entry(q, &set->tag_list, tag_set_list) {
> >                 blk_mq_freeze_queue(q);
> > +               blk_mq_quiesce_queue(q);
> > +               blk_sync_queue(q);
> > +       }
> >         /*
> >          * Sync with blk_mq_queue_tag_busy_iter.
> >          */
> > @@ -3269,8 +3272,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> >         list_for_each_entry(q, &set->tag_list, tag_set_list)
> >                 blk_mq_elv_switch_back(&head, q);
> >
> > -       list_for_each_entry(q, &set->tag_list, tag_set_list)
> > +       list_for_each_entry(q, &set->tag_list, tag_set_list) {
> > +               blk_mq_unquiesce_queue(q);
> >                 blk_mq_unfreeze_queue(q);
> > +       }
> >  }
> >
> >  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
>
> Are you sure this patch is sufficient? What prevents that blk_mq_run_hw_queues()
> gets called after the blk_mq_quiesce() and blk_sync_queue() calls have finished
> and before the queue is unfrozen?

blk_queue_quiesced(hctx->queue) is supposed to prevents blk_mq_run_hw_queues()
from being called after the queue is quiesced.

But there is another bug in blk_mq_quiesce() which shouldn't depend on
hctx_lock(hctx, &srcu_idx)
for this check, will fix blk_mq_quiesce() in V5.

Thanks,
Ming Lei
