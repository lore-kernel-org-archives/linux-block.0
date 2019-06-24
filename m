Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9D2C43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 08:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B79208CA
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 08:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfFXIo7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:44:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfFXIo7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 04:44:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52803A00F9;
        Mon, 24 Jun 2019 08:44:56 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FDC45C21F;
        Mon, 24 Jun 2019 08:44:46 +0000 (UTC)
Date:   Mon, 24 Jun 2019 16:44:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/9] blk-mq: allow hw queues to share hostwide tags
Message-ID: <20190624084441.GB10941@ming.t460p>
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-2-ming.lei@redhat.com>
 <90d85b99-3bc0-fb3b-8537-aeac03414eae@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90d85b99-3bc0-fb3b-8537-aeac03414eae@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 24 Jun 2019 08:44:59 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 31, 2019 at 08:37:39AM -0700, Bart Van Assche wrote:
> On 5/30/19 7:27 PM, Ming Lei wrote:
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index 6aea0ebc3a73..3d6780504dcb 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -237,6 +237,7 @@ static const char *const alloc_policy_name[] = {
> >   static const char *const hctx_flag_name[] = {
> >   	HCTX_FLAG_NAME(SHOULD_MERGE),
> >   	HCTX_FLAG_NAME(TAG_SHARED),
> > +	HCTX_FLAG_NAME(HOST_TAGS),
> >   	HCTX_FLAG_NAME(BLOCKING),
> >   	HCTX_FLAG_NAME(NO_SCHED),
> >   };
> 
> The name BLK_MQ_F_HOST_TAGS suggests that tags are shared across a SCSI
> host. That is misleading since this flag means that tags are shared across
> hardware queues. Additionally, the "host" term is a term that comes from the
> SCSI world and this patch is a block layer patch. That makes me wonder
> whether another name should be used to reflect that all hardware queues
> share the same tag set? How about renaming BLK_MQ_F_TAG_SHARED into
> BLK_MQ_F_TAG_QUEUE_SHARED and renaming BLK_MQ_F_HOST_TAGS into
> BLK_MQ_F_TAG_HCTX_SHARED?

Looks fine, will do it in V2.

Thanks,
Ming
