Return-Path: <SRS0=FZnh=BK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B349CC433E0
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 00:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DEDC21D95
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 00:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVyDnS3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbgGaAeC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:34:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29526 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728086AbgGaAeB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 20:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596155639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vJQromNPIvFXeePNHdGd0slAvSopRlWUu3iA2FCc2UY=;
        b=WVyDnS3c9PkYtxXdUF/l1GYrOC4DgLKcQ59UClN7KQuvY+ivXQWM/TUG/knUUid7+megcC
        5U8tmZW8o+uPAHwS9ymW3F9Zl3LtBiYQJ+LeuYWs3asFq9Qr+VN/Ap/8MQ4ZbgHxUKHOMj
        KtnjbjEGZdAh+MtUFHeZ7k6Tgs1b+70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-m2-BATurPBymLxD7y13WPQ-1; Thu, 30 Jul 2020 20:33:55 -0400
X-MC-Unique: m2-BATurPBymLxD7y13WPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7315980183C;
        Fri, 31 Jul 2020 00:33:54 +0000 (UTC)
Received: from T590 (ovpn-12-75.pek2.redhat.com [10.72.12.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B6481C921;
        Fri, 31 Jul 2020 00:33:46 +0000 (UTC)
Date:   Fri, 31 Jul 2020 08:33:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Message-ID: <20200731003341.GC1717993@T590>
References: <b80fa58d-34f0-cff5-c3f9-7b3d05a8a1ca@grimberg.me>
 <20200729154957.GD1698748@T590>
 <f3ead535-070d-40ec-08b8-56e2c1cd7ba4@grimberg.me>
 <20200730145325.GA1710335@T590>
 <57689a6d-9e6f-bb28-dd5f-f575988e7cb6@grimberg.me>
 <20200730181857.GA147247@dhcp-10-100-145-180.wdl.wdc.com>
 <761aa0f7-2e3f-d083-a32f-7c26ef2cd858@grimberg.me>
 <20200730192701.GC147247@dhcp-10-100-145-180.wdl.wdc.com>
 <05f75e89-b6f7-de49-eb9f-a08aa4e0ba4f@kernel.dk>
 <d8b3c882-098c-eb7a-06b9-46d3f05f72fb@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8b3c882-098c-eb7a-06b9-46d3f05f72fb@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 30, 2020 at 02:03:02PM -0700, Sagi Grimberg wrote:
> 
> > > > > > > > I think it will be a significant improvement to have a single code path.
> > > > > > > > The code will be more robust and we won't need to face issues that are
> > > > > > > > specific for blocking.
> > > > > > > > 
> > > > > > > > If the cost is negligible, I think the upside is worth it.
> > > > > > > > 
> > > > > > > 
> > > > > > > rcu_read_lock and rcu_read_unlock has been proved as efficient enough,
> > > > > > > and I don't think percpu_refcount is better than it, so I'd suggest to
> > > > > > > not switch non-blocking into this way.
> > > > > > 
> > > > > > It's not a matter of which is better, its a matter of making the code
> > > > > > more robust because it has a single code-path. If moving to percpu_ref
> > > > > > is negligible, I would suggest to move both, I don't want to have two
> > > > > > completely different mechanism for blocking vs. non-blocking.
> > > > > 
> > > > > FWIW, I proposed an hctx percpu_ref over a year ago (but for a
> > > > > completely different reason), and it was measured as too costly.
> > > > > 
> > > > >     https://lore.kernel.org/linux-block/d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk/
> > > > 
> > > > If this is the case, we shouldn't consider this as an alternative at all,
> > > > and move forward with either the original proposal or what
> > > > ming proposed to move a counter to the tagset.
> > > 
> > > Well, the point I was trying to make is that we shouldn't bother making
> > > blocking and non-blocking dispatchers use the same synchronization since
> > > non-blocking has a very cheap solution that blocking can't use.
> > 
> > I fully agree with that point.
> 
> I also agree, just said we should use the same mechanisms, IFF its not
> expensive. But I'm concerned that if we use completely different mechanisms
> we are likely to get wrong assumptions and break one at some
> point.
> 
> Hence my suggestion to move back to srcu and place the rcu_head in the hctx.

SRCU has been different enough compared with RCU, either implementation or API interface.

Then I'd still suggest to replace SRCU with percpu refcount. Then we can
have a simpler quiesce implementation.


Thanks,
Ming

