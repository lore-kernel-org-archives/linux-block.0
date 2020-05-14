Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62C3C433DF
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 08:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9341206F1
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 08:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEP5HxZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgENI2Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 04:28:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45138 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgENI2Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 04:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589444903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i65sotCGYn3tFRtLJaW3vOmrtm9FIOmuDRn/aGxvAYM=;
        b=SEP5HxZi8UcOPE8PUCjfMiCTe9d08zfT8daf2xMvc1OhHV7kDCJukDNS3CIr4TRdReT9Mr
        kSzvaOdzPWodPVc/6gBRleVpjxHZ8S5pip60NvFaWOCr83cd82P7+XhzeE9MJLGxEV/go7
        W72YHnd3NCddisWKeFMJXmFL0mrv1Y0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-pLwJDGbjN3izxxMe1pYE0g-1; Thu, 14 May 2020 04:28:22 -0400
X-MC-Unique: pLwJDGbjN3izxxMe1pYE0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAA06800053;
        Thu, 14 May 2020 08:28:20 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A968960FB9;
        Thu, 14 May 2020 08:28:14 +0000 (UTC)
Date:   Thu, 14 May 2020 16:28:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH 3/9] blk-mq: don't predicate last flag in
 blk_mq_dispatch_rq_list
Message-ID: <20200514082810.GL2073570@T590>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-4-ming.lei@redhat.com>
 <20200513122753.GC23958@infradead.org>
 <20200514020955.GH2073570@T590>
 <20200514032143.GA1833@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514032143.GA1833@redsun51.ssa.fujisawa.hgst.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 14, 2020 at 12:21:43PM +0900, Keith Busch wrote:
> On Thu, May 14, 2020 at 10:09:55AM +0800, Ming Lei wrote:
> > However, why is .commit_rqs() required? Why doesn't .queue_rq() handle the batching
> > submission before non-STS_OK is returned?
> 
> Wouldn't the driver need to know that the request is !first in that case
> so that it doesn't commit nothing if the first request fails?

Yeah, I have replied on this question, :-)

In short, I plan to make the interface explicit and more efficient:

1) .commit_rqs() is used for notifying driver that one batching requests
are done, which is usually caused by lacking of resource for queuing more
requests to driver

2) one request with .last flag marks end of one batching submission, so
.commit_rq() will not be called if no new request with !.last is queued

3) it is driver's responsibility for handling batching submission if non
STS_OK is returned from .queue_rq() to block layer.

Then we can minimize .commit_rqs() uses.

Thanks,
Ming

