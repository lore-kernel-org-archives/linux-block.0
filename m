Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D263AC433DF
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 11:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37DC2072D
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 11:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjFT5Ok5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHQLHF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:07:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25765 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726341AbgHQLHD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 07:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597662422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vaeJYlqz4i43h2jN+zYN6KdI8iVkdCIzTxfaFW4qgUs=;
        b=SjFT5Ok5A+ubsWNdhVc2bfzj8RoK+7aDXZoqzFyRrqacGSPgK/O+Vcc79qJwJYqeiC42TA
        g/DS9Xg9xMfpSChPLVwVy4MVjqlnb/p1GJ87D7YZUUhGajWaDPMSYYOnJ5NOiTAFGacUl6
        c162TQTgKOppV4Y+WJR3sHTiK/+24Ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-xoXRQM56NEiUy0GdfqN1jw-1; Mon, 17 Aug 2020 07:06:56 -0400
X-MC-Unique: xoXRQM56NEiUy0GdfqN1jw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08E1E1014DEE;
        Mon, 17 Aug 2020 11:06:55 +0000 (UTC)
Received: from T590 (ovpn-13-146.pek2.redhat.com [10.72.13.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56ADD7DFC0;
        Mon, 17 Aug 2020 11:06:48 +0000 (UTC)
Date:   Mon, 17 Aug 2020 19:06:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        David Jeffery <djeffery@redhat.com>,
        kernel test robot <rong.a.chen@intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND] blk-mq: order adding requests to hctx->dispatch
 and checking SCHED_RESTART
Message-ID: <20200817110643.GA2486425@T590>
References: <20200817100115.2495988-1-ming.lei@redhat.com>
 <20200817101539.GB25336@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817101539.GB25336@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 17, 2020 at 12:15:39PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 17, 2020 at 06:01:15PM +0800, Ming Lei wrote:
> > SCHED_RESTART code path is relied to re-run queue for dispatch requests
> > in hctx->dispatch. Meantime the SCHED_RSTART flag is checked when adding
> > requests to hctx->dispatch.
> > 
> > memory barriers have to be used for ordering the following two pair of OPs:
> > 
> > 1) adding requests to hctx->dispatch and checking SCHED_RESTART in
> > blk_mq_dispatch_rq_list()
> > 
> > 2) clearing SCHED_RESTART and checking if there is request in hctx->dispatch
> > in blk_mq_sched_restart().
> > 
> > Without the added memory barrier, either:
> > 
> > 1) blk_mq_sched_restart() may miss requests added to hctx->dispatch meantime
> > blk_mq_dispatch_rq_list() observes SCHED_RESTART, and not run queue in
> > dispatch side
> > 
> > or
> > 
> > 2) blk_mq_dispatch_rq_list still sees SCHED_RESTART, and not run queue
> > in dispatch side, meantime checking if there is request in
> > hctx->dispatch from blk_mq_sched_restart() is missed.
> > 
> > IO hang in ltp/fs_fill test is reported by kernel test robot:
> > 
> > 	https://lkml.org/lkml/2020/7/26/77
> > 
> > Turns out it is caused by the above out-of-order OPs. And the IO hang
> > can't be observed any more after applying this patch.
> > 
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: David Jeffery <djeffery@redhat.com>
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Can you add a Fixes: tag so that the commit gets backported?

Fixes: bd166ef183c2 ("blk-mq-sched: add framework for MQ capable IO schedulers")


Thanks, 
Ming

