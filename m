Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982B1C43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 08:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7962089F
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 08:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfFXIqa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:46:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20027 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfFXIq3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 04:46:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62A0F59474;
        Mon, 24 Jun 2019 08:46:29 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30B315D9C5;
        Mon, 24 Jun 2019 08:46:19 +0000 (UTC)
Date:   Mon, 24 Jun 2019 16:46:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/9] blk-mq: allow hw queues to share hostwide tags
Message-ID: <20190624084614.GC10941@ming.t460p>
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-2-ming.lei@redhat.com>
 <0f1773af-170a-a6b5-54ce-274dacb2b63a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f1773af-170a-a6b5-54ce-274dacb2b63a@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 24 Jun 2019 08:46:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 05, 2019 at 03:10:51PM +0100, John Garry wrote:
> On 31/05/2019 03:27, Ming Lei wrote:
> > index 32b8ad3d341b..49d73d979cb3 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2433,6 +2433,11 @@ static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
> >  {
> >  	int ret = 0;
> > 
> 
> Hi Ming,
> 
> > +	if ((set->flags & BLK_MQ_F_HOST_TAGS) && hctx_idx) {
> > +		set->tags[hctx_idx] = set->tags[0];
> 
> Here we set all tags same as that of hctx index 0.
> 
> > +		return true;
> 
> 
> As such, I think that the error handling in __blk_mq_alloc_rq_maps() is made
> a little fragile:
> 
> __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
> {
> 	int i;
> 
> 	for (i = 0; i < set->nr_hw_queues; i++)
> 		if (!__blk_mq_alloc_rq_map(set, i))
> 			goto out_unwind;
> 
> 	return 0;
> 
> out_unwind:
> 	while (--i >= 0)
> 		blk_mq_free_rq_map(set->tags[i]);
> 
> 	return -ENOMEM;
> }
> 
> If __blk_mq_alloc_rq_map(, i > 1) fails for when BLK_MQ_F_HOST_TAGS FLAG is
> set (even though today it can't), then we would try to free set->tags[0]
> multiple times.

Good catch, and the issue can be addressed easily by setting set->hctx[i] as
NULL, then check 'tags' in blk_mq_free_rq_map().

Thanks,
Ming
