Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670B7C433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 10:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387306139C
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 10:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350769AbhDGKPf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 06:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235774AbhDGKP3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Apr 2021 06:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617790469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tpWdJceqZi+vDccG7bvsZkCK5+mYmOOPU4eTEgJFV74=;
        b=BMdrLvVYUDU0dMx67/w98q396S14UhVdaX7EPv/ebwO5T0nTk9A5D5X/9urnQ+LgC5AZWh
        GT5rgmisUGvKXvwDrxSQdB57RUMUOvssenJ1qhHEJxSbI4HoEwAj/aH5F8ji9rnm8U/VJz
        jJqRzRfXwO8hG7N4DcGA9ZbfHbWgwoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-wLL_GZhYOHi1VCsLdZKw8A-1; Wed, 07 Apr 2021 06:14:26 -0400
X-MC-Unique: wLL_GZhYOHi1VCsLdZKw8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35F1B1856A60;
        Wed,  7 Apr 2021 10:14:25 +0000 (UTC)
Received: from T590 (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9864E610A8;
        Wed,  7 Apr 2021 10:14:18 +0000 (UTC)
Date:   Wed, 7 Apr 2021 18:14:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yanhui Ma <yama@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH] blk-mq: set default elevator as deadline in case of hctx
 shared tagset
Message-ID: <YG2F9ed33XbY6vZe@T590>
References: <20210406031933.767228-1-ming.lei@redhat.com>
 <d081eb6a-ace7-c9b2-7374-7f05a31551a0@huawei.com>
 <YG0BTVsCNKZHD3/T@T590>
 <6c346805-a7b1-f66d-af16-b1da03d77fc0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c346805-a7b1-f66d-af16-b1da03d77fc0@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 07, 2021 at 09:04:30AM +0100, John Garry wrote:
> Reviewed-by: John Garry <john.garry@huawei.com>
> 
> 
> > On Tue, Apr 06, 2021 at 11:25:08PM +0100, John Garry wrote:
> > > On 06/04/2021 04:19, Ming Lei wrote:
> > > 
> > > Hi Ming,
> > > 
> > > > Yanhui found that write performance is degraded a lot after applying
> > > > hctx shared tagset on one test machine with megaraid_sas. And turns out
> > > > it is caused by none scheduler which becomes default elevator caused by
> > > > hctx shared tagset patchset.
> > > > 
> > > > Given more scsi HBAs will apply hctx shared tagset, and the similar
> > > > performance exists for them too.
> > > > 
> > > > So keep previous behavior by still using default mq-deadline for queues
> > > > which apply hctx shared tagset, just like before.
> > > I think that there a some SCSI HBAs which have nr_hw_queues > 1 and don't
> > > use shared sbitmap - do you think that they want want this as well (without
> > > knowing it)?
> > I don't know but none has been used for them since the beginning, so not
> > an regression of shared tagset, but this one is really.
> 
> It seems fine to revert to previous behavior when host_tagset is set. I
> didn't check the results for this recently, but for the original shared
> tagset patchset [0] I had:
> 
> none sched:		2132K IOPS					
> mq-deadline sched:	2145K IOPS			

BTW, Yanhui reported that sequential write on virtio-scsi drops by
40~70% in VM, and the virito-scsi is backed by file image on XFS over
megaraid_sas. And the disk is actually SSD, instead of HDD. It could
be worse in case of megaraid_sas HDD.

Same drop is observed on virtio-blk too.

I didn't figure out one simple reproducer in host side yet, but the
performance data is pretty stable in the VM IO workload.


Thanks, 
Ming

