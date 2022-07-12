Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46649C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 01:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiGLBvO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jul 2022 21:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiGLBvO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jul 2022 21:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55B382AC5D
        for <linux-block@vger.kernel.org>; Mon, 11 Jul 2022 18:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657590672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KIjzl7edHnX8DzaOiYgsgS3/Vle3xDsIdNJSVd1oDco=;
        b=HlRaojecxme0o9pogmSzoiNETtrG6QNSv90VwyS0TDixhZmHxob2rYVdphl6XGV+Tj0yiT
        qw04Fdzmqd/T+Ttr0ApumyMYxRkO31pABcpqWywCpJ/DP+NpzhU9c0K+eJ0BZS6QH9CStW
        UsglzOuQDXuey/SsdmCUwRRvaEWaqv8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-uJKlGyDbO_WtIs_1AII_ZA-1; Mon, 11 Jul 2022 21:51:09 -0400
X-MC-Unique: uJKlGyDbO_WtIs_1AII_ZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5A4985A585;
        Tue, 12 Jul 2022 01:51:08 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F31AF40D2827;
        Tue, 12 Jul 2022 01:51:04 +0000 (UTC)
Date:   Tue, 12 Jul 2022 09:50:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] blk-mq: don't create hctx debugfs dir until
 q->debugfs_dir is created
Message-ID: <YszTg0GAQrOa96UX@T590>
References: <20220711090808.259682-1-ming.lei@redhat.com>
 <4c5f332f-ccd4-5d0e-14d4-bccf57bcd7cc@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c5f332f-ccd4-5d0e-14d4-bccf57bcd7cc@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 11, 2022 at 10:20:39AM -0700, Bart Van Assche wrote:
> On 7/11/22 02:08, Ming Lei wrote:
> > blk_mq_debugfs_register_hctx() can be called by blk_mq_update_nr_hw_queues
> > when gendisk isn't added yet, such as nvme tcp.
> > 
> > Fixes the warning of 'debugfs: Directory 'hctx0' with parent '/' already present!'
> > which can be observed reliably when running blktests nvme/005.
> > 
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-mq-debugfs.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > index b80fae7ab1d9..28adb01f6441 100644
> > --- a/block/blk-mq-debugfs.c
> > +++ b/block/blk-mq-debugfs.c
> > @@ -728,6 +728,9 @@ void blk_mq_debugfs_register_hctx(struct request_queue *q,
> >   	char name[20];
> >   	int i;
> > +	if (!q->debugfs_dir)
> > +		return;
> > +
> >   	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
> >   	hctx->debugfs_dir = debugfs_create_dir(name, q->debugfs_dir);
> 
> Does this patch need a Fixes: tag?

Yeah,

Fixes: 6cfc0081b046 ("blk-mq: no need to check return value of debugfs_create functions")

> 
> Additionally, as one can see here, I reported this bug before Yi:
> https://bugzilla.kernel.org/show_bug.cgi?id=216191

Sorry for missing your report, and I am fine to add your reported-by.


Thanks,
Ming

