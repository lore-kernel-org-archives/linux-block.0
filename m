Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB34CC433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 01:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F81611AD
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 01:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhETBZR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 21:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhETBZR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 21:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621473836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bilSsvR+MBv+YsXPw447CV9ksYbBHkM2TMAGPVrj4BY=;
        b=IMLonclV+Itl6eq9M3L8HDd60XMoPtXYYPsDbNANaE8uQmYw/m7f8Bq2DXRrA9I0k54nPa
        8Yj6t+gn5umamtYrxfYJ6AS9z2tOFsqbliQTHKKaBP2qV+Doiy4cLpS5AmViYO3eTDXYAL
        46dyznB366S16SZwXF+2l08NrNFBYyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-PL8gCMOrNayLLLkXG9MgHg-1; Wed, 19 May 2021 21:23:54 -0400
X-MC-Unique: PL8gCMOrNayLLLkXG9MgHg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 627916D585;
        Thu, 20 May 2021 01:23:53 +0000 (UTC)
Received: from T590 (ovpn-12-84.pek2.redhat.com [10.72.12.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 905395C224;
        Thu, 20 May 2021 01:23:43 +0000 (UTC)
Date:   Thu, 20 May 2021 09:23:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Yanhui Ma <yama@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] blk-mq: plug request for shared sbitmap
Message-ID: <YKW6G1flax9vkfIR@T590>
References: <20210514022052.1047665-1-ming.lei@redhat.com>
 <b38d671a-530b-244a-bc0f-0b926c796243@huawei.com>
 <YKOiClSTyHl5lbXV@T590>
 <185d1d58-f4e3-2024-e5e4-0831af151e3d@huawei.com>
 <YKOsQ4StDThlbMko@T590>
 <12a651a2-5a0e-15dc-ec40-fc3c57265cd2@huawei.com>
 <676e9667-3022-7fde-4518-e82eb0503ec8@huawei.com>
 <YKRaGT5PjCvH+12p@T590>
 <aa667e0d-0b42-08c2-35e1-387e2e92dc43@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa667e0d-0b42-08c2-35e1-387e2e92dc43@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 19, 2021 at 09:41:01AM +0100, John Garry wrote:
> On 19/05/2021 01:21, Ming Lei wrote:
> > > The 'after' results are similar to without shared sbitmap, i.e using
> > > reply-map:
> > > 
> > > reply-map:
> > > 450K (read), 430K IOPs (randread)
> > OK, that is expected result. After shared sbitmap, IO merge gets improved
> > when batching submission is bypassed, meantime IOPS of random IO drops
> > because cpu utilization is increased.
> > 
> > So that isn't a regression, let's live with this awkward situation,:-(
> 
> Well at least we have ~ parity with non-shared sbitmap now. And also know
> higher performance is possible for "read" (vs "randread") scenario, FWIW.

NVMe too, but never see it becomes true, :-)

> 
> BTW, recently we have seen 2x optimisation/improvement for shared sbitmap
> which were under/related to nr_hw_queues == 1 check - this patch and the
> changing of the default IO sched.

You mean you saw 2X improvement in your hisilicon SAS compared with
non-shared sbitmap? In Yanhui's virt test, we just bring back the perf
to non-shared sbitmap's level.

> 
> I am wondering how you detected/analyzed this issue, and whether we need to
> audit other nr_hw_queues == 1 checks? I did a quick scan, and the only
> possible thing I see is the other q->nr_hw_queues > 1 check for direct issue
> in blk_mq_subit_bio() - I suspect you know more about that topic.

IMO, the direct issue code path is fine.

For slow devices, we won't use none, so the code path can't be reached.

For fast device, direct issue is often a win.

Also looks your test on non has shown that perf is fine.

Thanks,
Ming

