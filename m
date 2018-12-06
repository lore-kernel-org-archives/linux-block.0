Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BCAC04EB9
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 00:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFFB2081B
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 00:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFFB2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeLFAdk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:33:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeLFAdj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Dec 2018 19:33:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F9B0307CDC2;
        Thu,  6 Dec 2018 00:33:39 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0D13747BC;
        Thu,  6 Dec 2018 00:33:28 +0000 (UTC)
Date:   Thu, 6 Dec 2018 08:33:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Subject: Re: +AFs-PATCH+AF0- blk-mq: Set request mapping to NULL in
 blk+AF8-mq+AF8-put+AF8-driver+AF8-tag
Message-ID: <20181206003323.GB3015@ming.t460p>
References: <1543943674.185366.194.camel@acm.org>
 <ce2cdcee7e8d8e21cc8398a882b9d6e3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce2cdcee7e8d8e21cc8398a882b9d6e3@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 06 Dec 2018 00:33:39 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 04, 2018 at 11:48:48PM +0530, Kashyap Desai wrote:
> > -----Original Message-----
> > From: Bart Van Assche [mailto:bvanassche@acm.org]
> > Sent: Tuesday, December 4, 2018 10:45 PM
> > To: Kashyap Desai; linux-block; Jens Axboe; Ming Lei; linux-scsi
> > Cc: Suganath Prabu Subramani; Sreekanth Reddy; Sathya Prakash Veerichetty
> > Subject: Re: [PATCH] blk-mq: Set request mapping to NULL in
> > blk_mq_put_driver_tag
> >
> > On Tue, 2018-12-04 at 22:17 +0530, Kashyap Desai wrote:
> > > + Linux-scsi
> > >
> > > > > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > > > > index 9497b47..57432be 100644
> > > > > --- a/block/blk-mq.h
> > > > > +++ b/block/blk-mq.h
> > > > > @@ -175,6 +175,7 @@ static inline bool
> > > > > blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx *hctx)
> > > > >   static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx
> > *hctx,
> > > > >                          struct request *rq)
> > > > >   {
> > > > > +    hctx->tags->rqs[rq->tag] = NULL;
> > > > >       blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
> > > > >       rq->tag = -1;
> > > >
> > > > No SCSI driver should call scsi_host_find_tag() after a request has
> > > > finished. The above patch introduces yet another race and hence can't
> > > > be
> > > > a proper fix.
> > >
> > > Bart, many scsi drivers use scsi_host_find_tag() to traverse max tag_id
> > > to
> > > find out pending IO in firmware.
> > > One of the use case is -  HBA firmware recovery.  In case of firmware
> > > recovery, driver may require to traverse the list and return back
> > > pending
> > > scsi command to SML for retry.
> > > I quickly grep the scsi code and found that snic_scsi, qla4xxx, fnic,
> > > mpt3sas are using API scsi_host_find_tag for the same purpose.
> > >
> > > Without this patch, we hit very basic kernel panic due to page fault.
> > > This
> > > is not an issue in non-mq code path. Non-mq path use
> > > blk_map_queue_find_tag() and that particular API does not provide stale
> > > requests.
> >
> > As I wrote before, your patch doesn't fix the race you described but only
> > makes the race window smaller.
> Hi Bart,
> 
> Let me explain the issue. It is not a race, but very straight issue.  Let's
> say we have one scsi_device /dev/sda and total IO submitted + completed are
> some number 100.
> All the 100 IO is *completed*.   Now, As part of Firmware recovery, driver
> tries to find our outstanding IOs using scsi_host_find_tag().

If the 'tag' passed to scsi_host_find_tag() is valid, I think there
shouldn't have such issue.

If you want to find outstanding IOs, maybe you can try blk_mq_queue_tag_busy_iter()
or blk_mq_tagset_busy_iter(), because you may not know if the passed 'tag' to
scsi_host_find_tag() is valid or not.


Thanks,
Ming
