Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14621C433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 00:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E145A61353
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 00:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhESAXX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 20:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233756AbhESAXX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 20:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621383724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bfJ3M7RnbPtNH2FUWu2oZP6hfkEcT5WfiT7nzkh6yVE=;
        b=O4fuIhPlZMaqLHT9T9cCRb/iqThkSnz2T70Azzv+Baps956XBem8FrIZd/ZQm8FPqrSrMK
        gHLuy5XHRV5WR/lK3kL+7VwSDF0lmOrppS+crPs9gPQZQ9Dq5yzMD51GbAaiv+UGnBQQUu
        m2XI3/PGmbBbmho1m+aB1+11FIrg8KA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-PNyYYzozMJiBrke-Q9NOaw-1; Tue, 18 May 2021 20:22:02 -0400
X-MC-Unique: PNyYYzozMJiBrke-Q9NOaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DDBC801107;
        Wed, 19 May 2021 00:22:01 +0000 (UTC)
Received: from T590 (ovpn-12-62.pek2.redhat.com [10.72.12.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50D1D1A868;
        Wed, 19 May 2021 00:21:50 +0000 (UTC)
Date:   Wed, 19 May 2021 08:21:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Yanhui Ma <yama@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] blk-mq: plug request for shared sbitmap
Message-ID: <YKRaGT5PjCvH+12p@T590>
References: <20210514022052.1047665-1-ming.lei@redhat.com>
 <b38d671a-530b-244a-bc0f-0b926c796243@huawei.com>
 <YKOiClSTyHl5lbXV@T590>
 <185d1d58-f4e3-2024-e5e4-0831af151e3d@huawei.com>
 <YKOsQ4StDThlbMko@T590>
 <12a651a2-5a0e-15dc-ec40-fc3c57265cd2@huawei.com>
 <676e9667-3022-7fde-4518-e82eb0503ec8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <676e9667-3022-7fde-4518-e82eb0503ec8@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 18, 2021 at 05:01:16PM +0100, John Garry wrote:
> On 18/05/2021 13:51, John Garry wrote:
> > n 18/05/2021 13:00, Ming Lei wrote:
> > > > > 'Before 620K' could be caused by busy queue when batching
> > > > > submission isn't
> > > > > applied, so merge chance is increased. This patch applies batching
> > > > > submission, so queue becomes not busy enough.
> > > > > 
> > > > > BTW, what is the queue depth of sdev and can_queue of shost
> > > > > for your hisilision SAS?
> > > > sdev queue depth is 64 (see hisi_sas_slave_configure()) and host
> > > > depth is
> > > > 4096 - 96 (for reserved tags) = 4000
> > > OK, so queue depth should get IO merged if there are too many requests
> > > queued.
> > > 
> > > What is the same read test result without shared tags? still 430K?
> > 
> > I never left a driver switch in place to disable it.
> > 
> > I can forward-port "reply-map" support, which is not too difficult and I
> > will let you know the result.
> 
> The 'after' results are similar to without shared sbitmap, i.e using
> reply-map:
> 
> reply-map:
> 450K (read), 430K IOPs (randread)

OK, that is expected result. After shared sbitmap, IO merge gets improved
when batching submission is bypassed, meantime IOPS of random IO drops
because cpu utilization is increased.

So that isn't a regression, let's live with this awkward situation, :-(


Thanks,
Ming

