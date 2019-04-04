Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAE6C4360F
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 06:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757A8206DF
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 06:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfDDGrn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:47:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfDDGrm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Apr 2019 02:47:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A07323078AAF;
        Thu,  4 Apr 2019 06:47:42 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BCA6B19C67;
        Thu,  4 Apr 2019 06:47:31 +0000 (UTC)
Date:   Thu, 4 Apr 2019 14:47:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V3 6/6] SCSI: don't hold device refcount in IO path
Message-ID: <20190404064723.GB5004@ming.t460p>
References: <20190403102609.18707-1-ming.lei@redhat.com>
 <20190403102609.18707-7-ming.lei@redhat.com>
 <1554308694.118779.219.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554308694.118779.219.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 04 Apr 2019 06:47:42 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 03, 2019 at 09:24:54AM -0700, Bart Van Assche wrote:
> On Wed, 2019-04-03 at 18:26 +0800, Ming Lei wrote:
> >         /*
> > -        * Before a SCSI command is dispatched,
> > -        * get_device(&sdev->sdev_gendev) is called and the host,
> > -        * target and device busy counters are increased. Since
> > -        * requeuing a request causes these actions to be repeated and
> > -        * since scsi_device_unbusy() has already been called,
> > -        * put_device(&device->sdev_gendev) must still be called. Call
> > -        * put_device() after blk_mq_requeue_request() to avoid that
> > -        * removal of the SCSI device can start before requeueing has
> > -        * happened.
> > +        * Before a SCSI command is dispatched, the host, target and
> > +        * device busy counters are increased. Since requeuing a request
> > +        * causes these actions to be repeated and since scsi_device_unbusy()
> > +        * has already been called.
> >          */
> 
> The last sentence of the new comment looks incomplete to me ("Since ...").

Given most of the previous comment is about get/put device, I'd suggest
to remove the whole block given we are clean that get/put device isn't
required in IO path.

Will do that in V4 if no objections.

Thanks,
Ming
