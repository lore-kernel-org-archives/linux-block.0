Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971EBC43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 00:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A22822360
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 00:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A22822360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeKOKyb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:54:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbeKOKya (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 05:54:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C15130001E5;
        Thu, 15 Nov 2018 00:48:55 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7870460BF6;
        Thu, 15 Nov 2018 00:48:44 +0000 (UTC)
Date:   Thu, 15 Nov 2018 08:48:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Andrew Jones <drjones@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        "jianchao . wang" <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2] SCSI: fix queue cleanup race before queue
 initialization is done
Message-ID: <20181115004838.GB32603@ming.t460p>
References: <20181114082551.12141-1-ming.lei@redhat.com>
 <1542207748.192870.14.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542207748.192870.14.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 15 Nov 2018 00:48:55 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 07:02:28AM -0800, Bart Van Assche wrote:
> On Wed, 2018-11-14 at 16:25 +0800, Ming Lei wrote:
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -697,6 +697,12 @@ static bool scsi_end_request(struct request *req,
> > blk_status_t error,
> >  		 */
> >  		scsi_mq_uninit_cmd(cmd);
> >  
> > +		/*
> > +		 * queue is still alive, so grab the ref for preventing it
> > +		 * from being cleaned up during running queue.
> > +		 */
> > +		percpu_ref_get(&q->q_usage_counter);
> > +
> 
> I think the above comment is misleading. In the block layer a queue is called
> alive if the "dying" flag has not been set. When the above call to
> percpu_ref_get() occurs it is not guaranteed that that flag has not yet been
> set. But it is guaranteed that q->q_usage_counter is not zero. I would prefer
> if the comment would be modified.

I am fine with either way given we know the context, not mention the first thing
blk_cleanup_queue() does is to call blk_set_queue_dying().

> 
> What's not clear to me is why this patch only protects the blk-mq path but
> not the legacy path. Does the legacy path need similar protection? It also
> triggers a queue run after having finished a request.

The queue_lock is held for protecting everything, so such issue in
legacy path.


Thanks,
Ming
