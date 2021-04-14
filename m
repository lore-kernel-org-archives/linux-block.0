Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3299C433B4
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 10:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9823961249
	for <linux-block@archiver.kernel.org>; Wed, 14 Apr 2021 10:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhDNKtK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Apr 2021 06:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233860AbhDNKtC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 06:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618397321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2W3mrszVTjoSmNICo//rzMQbCG7yBbBkXKactbhG/E=;
        b=WxgsNPzco60QbqXrI4U3WaRFKAyYfqb3zi/KLirrTmQN+C71E9s5F1O2/t8wY1IilD31WO
        GfaVUIVWVtHouhhNYIm4Z5mLF6KXBGilDAX5IOGB2Gk0j+AMLTE1aad0eyog78TJNdJQZ2
        vNN1norZhSkzeDPZYYKm15Opc7O+/7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-t_8OIcR7Pw6tK3zxJwldMw-1; Wed, 14 Apr 2021 06:48:37 -0400
X-MC-Unique: t_8OIcR7Pw6tK3zxJwldMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F1851856A63;
        Wed, 14 Apr 2021 10:48:36 +0000 (UTC)
Received: from T590 (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59A095C26D;
        Wed, 14 Apr 2021 10:48:32 +0000 (UTC)
Date:   Wed, 14 Apr 2021 18:48:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Yanhui Ma <yama@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] blk-mq: set default elevator as deadline in case of hctx
 shared tagset
Message-ID: <YHbIfNKGXq6V6KUF@T590>
References: <20210406031933.767228-1-ming.lei@redhat.com>
 <d081eb6a-ace7-c9b2-7374-7f05a31551a0@huawei.com>
 <YG0BTVsCNKZHD3/T@T590>
 <6c346805-a7b1-f66d-af16-b1da03d77fc0@huawei.com>
 <YG2F9ed33XbY6vZe@T590>
 <49bb403dc1ecf8ea25eb40c0fb921c65@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49bb403dc1ecf8ea25eb40c0fb921c65@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 14, 2021 at 01:51:01PM +0530, Kashyap Desai wrote:
> >
> > On Wed, Apr 07, 2021 at 09:04:30AM +0100, John Garry wrote:
> > > Reviewed-by: John Garry <john.garry@huawei.com>
> > >
> > >
> > > > On Tue, Apr 06, 2021 at 11:25:08PM +0100, John Garry wrote:
> > > > > On 06/04/2021 04:19, Ming Lei wrote:
> > > > >
> > > > > Hi Ming,
> > > > >
> > > > > > Yanhui found that write performance is degraded a lot after
> > > > > > applying hctx shared tagset on one test machine with
> > > > > > megaraid_sas. And turns out it is caused by none scheduler which
> > > > > > becomes default elevator caused by hctx shared tagset patchset.
> > > > > >
> > > > > > Given more scsi HBAs will apply hctx shared tagset, and the
> > > > > > similar performance exists for them too.
> > > > > >
> > > > > > So keep previous behavior by still using default mq-deadline for
> > > > > > queues which apply hctx shared tagset, just like before.
> > > > > I think that there a some SCSI HBAs which have nr_hw_queues > 1
> > > > > and don't use shared sbitmap - do you think that they want want
> > > > > this as well (without knowing it)?
> 
> John - I have noted this and discussing internally.
> This patch fixing shared host tag behavior is good (and required to intact
> earlier behavior) but for <mpi3mr> which is true multi hardware queue
> interface, I will update later.
> In general most of the OS vendor recommend <mq-deadline> for rotational
> media and <none> for non-rotational media. We would like to go with this
> method in <mpi3mr> driver.
> 
> 
> > > > I don't know but none has been used for them since the beginning, so
> > > > not an regression of shared tagset, but this one is really.
> > >
> > > It seems fine to revert to previous behavior when host_tagset is set.
> > > I didn't check the results for this recently, but for the original
> > > shared tagset patchset [0] I had:
> > >
> > > none sched:		2132K IOPS
> > > mq-deadline sched:	2145K IOPS
> 
> On my local setup also I did not see much difference.
> 
> >
> > BTW, Yanhui reported that sequential write on virtio-scsi drops by
> 40~70% in
> > VM, and the virito-scsi is backed by file image on XFS over
> megaraid_sas. And
> > the disk is actually SSD, instead of HDD. It could be worse in case of
> > megaraid_sas HDD.
> 
> Ming -  If we have old megaraid_sas driver (without host tag set patch),
> and just toggling io-scheduler from <none> to <mq-deadline> (through
> sysfs) also gives similar performance drop.  ?

The default io sched for old megraid_sas is mq-deadline, which
performs very well in Yanhui's virt workloads. And with none, IO
performance drops much with new driver(shared tags).

The disk is INTEL SSDSC2CT06.

> 
> I think performance drop using <none> io scheduler, might be due to bio
> merge is missing compare to mq-deadline. It may not be linked to shared
> host tag IO path.
> Usually bio merge does not help for sequential work load if back-end is
> enterprise SSDs/NVME, but it is not always true. It is difficult to have
> all setup and workload to get benefit from one io-scheduler.

BTW, with mq-deadline & shared tags, CPU utilization is increased by ~20%
in some VM fio test




Thanks, 
Ming

