Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8248C282DA
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 12:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F85E21841
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 12:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDIM2o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:28:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34658 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIM2n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 08:28:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id k2so19476959qtm.1
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2019 05:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hC5Ru/QY1tmBjG26dnKAwq2FofQs90W+dJuN5exhNtc=;
        b=aVPSYVGJ+Ba9VScYtiXFWnLseWeB0vJGEcbyGQks/bydpYrWHFL0R+LZ/515VHnkRw
         fH2peV6YVtIN1guT3KR26v4beFjD2VXg75uAzUKwHHjL8UR7C6RFFpLBm1HgT6DozB9N
         IMfcZRLnWaWz0iIT5e0Sz26bKM+Qt3r3B615zHjz86q2XUFLCZq/Jrfp3RIBd3p7NF0d
         HPBPMpsT+h9K2gr6VeQqo5bNuUtof4ZWLCsQaTfnLShwe0RYcH/gM9hx9RESFAGzN9Lr
         WKlQUDB6NYO1whxxHoZm6mGiMYwQsLPfTsLtVKFLuxymhKHMnGg46SnXe4csGrKKXmCp
         sXqw==
X-Gm-Message-State: APjAAAUYHaflv8Jtb7/MgseTDN3Prh/7XMVWAWbpt8Z2iDHcloSUN6uU
        Rns8cOGTVxhTzRzyr9xcXg/jiQ==
X-Google-Smtp-Source: APXvYqw0zUhSmg7IwbJpT231GuQgzlXP1MeDu+A7i770nexKvGUPYc9z4Q5vb4IGxlrSYzqgQya0HA==
X-Received: by 2002:ac8:2a2e:: with SMTP id k43mr30340515qtk.353.1554812922421;
        Tue, 09 Apr 2019 05:28:42 -0700 (PDT)
Received: from 2600-6c64-4e80-00f1-4f34-e35d-3415-c460.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-4f34-e35d-3415-c460.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:4f34:e35d:3415:c460])
        by smtp.gmail.com with ESMTPSA id w13sm20794717qtc.26.2019.04.09.05.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 05:28:41 -0700 (PDT)
Message-ID: <f2703a1e76262820cbe0e40ed7110771606ec2f6.camel@redhat.com>
Subject: Re: [PATCH] block: Fix blk_mq_try_issue_directly()
From:   Laurence Oberman <loberman@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
Date:   Tue, 09 Apr 2019 08:28:40 -0400
In-Reply-To: <328a5660-8355-ddad-be0e-32cbaa76cc84@oracle.com>
References: <20190403201126.22819-1-bvanassche@acm.org>
         <2c3dbaa5-dad9-12a4-b535-5e1e614c43e1@oracle.com>
         <2254e259-107f-38d4-1692-e542271db654@oracle.com>
         <328a5660-8355-ddad-be0e-32cbaa76cc84@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-09 at 09:31 +0800, jianchao.wang wrote:
> 
> On 4/8/19 10:36 AM, jianchao.wang wrote:
> > 
> > 
> > On 4/8/19 10:07 AM, jianchao.wang wrote:
> > > Hi Bart
> > > 
> > > On 4/4/19 4:11 AM, Bart Van Assche wrote:
> > > > If blk_mq_try_issue_directly() returns BLK_STS*_RESOURCE that
> > > > means that
> > > > the request has not been queued and that the caller should
> > > > retry to submit
> > > > the request. Both blk_mq_request_bypass_insert() and
> > > > blk_mq_sched_insert_request() guarantee that a request will be
> > > > processed.
> > > > Hence return BLK_STS_OK if one of these functions is called.
> > > > This patch
> > > > avoids that blk_mq_dispatch_rq_list() crashes when using dm-
> > > > mpath.
> > > 
> > > Sorry, I seem to miss the original mail list that reported this
> > > issue.
> > > As your comment, it looks like that the request is handled again
> > > when
> > > the blk_mq_try_issue_directly return BLK_STS*_RESOURCE, right ?
> > > 
> > > The usage of this helper interface is,
> > > if care about the return value and want to handle the request
> > > yourself when
> > > return BLK_STS*_RESOURCE, pass 'byass' as true.
> > > otherwise, just pass 'bypass' as false, then
> > > blk_mq_try_issue_directly would
> > > take over all of the work including requeue or complete the
> > > request.
> > > 
> > > if dm-mpath case, the driver should only invoke
> > > dm_dispatch_clone_request,
> > > the 'bypass' parameter should only be true.
> > > as the blk_mq_try_issue_directly,
> > > it would return BLK_STS_OK when have to insert the request,
> > > otherwise,
> > > it would do nothing but return BLK_STS*_RESOURCE.
> > > 
> > > Would you please show the cause that the dm-mpath driver invoke
> > > blk_mq_try_issue_direclty
> > > with 'bypass == false' ?
> > > 
> > 
> > The issue seems to be here,
> > 
> > blk_mq_try_issue_directly
> > 
> > 
> >     if (unlikely(blk_mq_hctx_stopped(hctx) ||
> > blk_queue_quiesced(q))) {
> >         run_queue = false;
> >         bypass = false;          //------> HERE !!!
> >         goto out_unlock;
> >     }
> > 
> > 
> >     case BLK_STS_RESOURCE:
> >         if (force) {
> >             blk_mq_request_bypass_insert(rq, run_queue);
> >             ret = bypass ? BLK_STS_OK : ret;
> >         } else if (!bypass) {
> >             blk_mq_sched_insert_request(rq, false,
> >                             run_queue, false);
> >         }
> >         break;
> > 
> > Then the request will be inserted and blk_mq_try_issue_dreictly
> > returns BLK_STS_RESOURCE.
> > 
> > 
> > Could following patch fix the issue ?
> 
> Hi Laurence
> 
> Would you please test this patch to see whether the issue could be
> fixed ?
> 
> Thanks
> Jianchao
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index a9c1816..a3394f2 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1813,7 +1813,7 @@ blk_status_t blk_mq_try_issue_directly(struct
> > blk_mq_hw_ctx *hctx,
> >          */
> >         if (unlikely(blk_mq_hctx_stopped(hctx) ||
> > blk_queue_quiesced(q))) {
> >                 run_queue = false;
> > -               bypass = false;
> > +               force = true;
> >                 goto out_unlock;
> >         }
> > 
> > Thanks
> > Jianchao
> > 
> > > 
> > > > 
> > > > Cc: Christoph Hellwig <hch@infradead.org>
> > > > Cc: Hannes Reinecke <hare@suse.com>
> > > > Cc: James Smart <james.smart@broadcom.com>
> > > > Cc: Ming Lei <ming.lei@redhat.com>
> > > > Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
> > > > Cc: Keith Busch <keith.busch@intel.com>
> > > > Cc: Dongli Zhang <dongli.zhang@oracle.com>
> > > > Cc: Laurence Oberman <loberman@redhat.com>
> > > > Tested-by: Laurence Oberman <loberman@redhat.com>
> > > > Reviewed-by: Laurence Oberman <loberman@redhat.com>
> > > > Reported-by: Laurence Oberman <loberman@redhat.com>
> > > > Fixes: 7f556a44e61d ("blk-mq: refactor the code of issue
> > > > request directly") # v5.0.
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > > > ---
> > > >  block/blk-mq.c | 9 ++-------
> > > >  1 file changed, 2 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > index 652d0c6d5945..b2c20dce8a30 100644
> > > > --- a/block/blk-mq.c
> > > > +++ b/block/blk-mq.c
> > > > @@ -1859,16 +1859,11 @@ blk_status_t
> > > > blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> > > >  	case BLK_STS_RESOURCE:
> > > >  		if (force) {
> > > >  			blk_mq_request_bypass_insert(rq,
> > > > run_queue);
> > > > -			/*
> > > > -			 * We have to return BLK_STS_OK for the
> > > > DM
> > > > -			 * to avoid livelock. Otherwise, we
> > > > return
> > > > -			 * the real result to indicate whether
> > > > the
> > > > -			 * request is direct-issued
> > > > successfully.
> > > > -			 */
> > > > -			ret = bypass ? BLK_STS_OK : ret;
> > > > +			ret = BLK_STS_OK;
> > > >  		} else if (!bypass) {
> > > >  			blk_mq_sched_insert_request(rq, false,
> > > >  						    run_queue,
> > > > false);
> > > > +			ret = BLK_STS_OK;
> > > >  		}
> > > >  		break;
> > > >  	default:
> > > > 
Hello Sir
I think Jens already took the revert patch though.
I will try this when I gat a chance.
Need to wait until I can reboot the targetserver again.
Regards
Laurence

