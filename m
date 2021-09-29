Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B948C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 15:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25ED361465
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 15:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245150AbhI2PqK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 11:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245313AbhI2PqD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 11:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632930261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LR3ObdM1X37e6OfSRn8U+lGYCyvoYCCHleB0Zqxpw04=;
        b=O/eUtapqKfbqehB7fi/dvG72VhljGbHO3GxNeaNVhLS0KK2ci6F93bH3/RUW0I4dIjBK6q
        OUkljPlrrtmiyU4HfwhT+cNdlfiAWgjaJa5paA9QktVlGZRcQcHSE0AY85fXOm7Gd/09RM
        k4xKdgwh9cwykZF5h9UMEDwZII/PCtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-ooXitBhVPKK49Q_IGM_U2A-1; Wed, 29 Sep 2021 11:44:20 -0400
X-MC-Unique: ooXitBhVPKK49Q_IGM_U2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F388801B3D;
        Wed, 29 Sep 2021 15:44:19 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 512855C1B4;
        Wed, 29 Sep 2021 15:44:14 +0000 (UTC)
Date:   Wed, 29 Sep 2021 23:44:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5/5] blk-mq: support nested blk_mq_quiesce_queue()
Message-ID: <YVSJyIxfFQ+KSNi4@T590>
References: <20210929041559.701102-1-ming.lei@redhat.com>
 <20210929041559.701102-6-ming.lei@redhat.com>
 <54b636d5-ede6-a700-4d02-4712db679234@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54b636d5-ede6-a700-4d02-4712db679234@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 29, 2021 at 02:53:27PM +0300, Sagi Grimberg wrote:
> 
> 
> On 9/29/21 7:15 AM, Ming Lei wrote:
> > Turns out that blk_mq_freeze_queue() isn't stronger[1] than
> > blk_mq_quiesce_queue() because dispatch may still be in-progress after
> > queue is frozen, and in several cases, such as switching io scheduler,
> > updating nr_requests & wbt latency, we still need to quiesce queue as a
> > supplement of freezing queue.
> > 
> > As we need to extend uses of blk_mq_quiesce_queue(), it is inevitable
> > for us to need support nested quiesce, especailly we can't let
> > unquiesce happen when there is quiesce originated from other contexts.
> 
> The serialization need is clear, but why is the nesting required?

I guess the serialization is what my nesting meant:

1) code path1:

- quiesce
- do something
- unquiesce

2) code path2:
- quiesce
- do something
- unquiesce

What the patch tries to implement is that the actual unquiesce action has
to be done in the last or outermost unquiesce of the two code paths.

Not sure if serialization is a good term here, maybe I should use words of
concurrent quiesce, or other better one? Nesting is really supported
by this patch, such as code path2 may be part of 'do something' in code
path1. Meantime serialization among quiesce and unquiesce is supported
too.

> In other words what is the harm is running the hw queue every time
> we unquiesce?

running hw queue in each unquiesce doesn't matter, what matters is that
the QUIESCE flag has to be cleared in the outermost or the last unquiesce.
But if QUIESCE isn't set, it isn't useless to run hw queue in unquiesce.

 

Thanks,
Ming

