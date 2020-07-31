Return-Path: <SRS0=FZnh=BK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8936C433E0
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 00:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947B6208E4
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 00:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAzxzB+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbgGaAZL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:25:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51179 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730781AbgGaAZL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 20:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596155109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/re8HGg3LSJE9qNv7jQdYcOdkBdmvrDeNlfw69vDt+w=;
        b=IAzxzB+mbD0ClWsPZDQN43lS6o0RIwfdUBS7qEX+BwuLslhIp/IFaIMPlolRiLvLtZDEee
        mSk6OfGY5pCQ5AfCsKd4tc6YzBzndBXlYtwK3gBHsLSWowqxHK+Jqiif+9JivjzN2fftbp
        lq3xD/7awRFeqeENPBfs1jnRaI6x9Z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-prmEPtRfNmGzOz3Vk0IHJQ-1; Thu, 30 Jul 2020 20:25:07 -0400
X-MC-Unique: prmEPtRfNmGzOz3Vk0IHJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B93018839C9;
        Fri, 31 Jul 2020 00:25:05 +0000 (UTC)
Received: from T590 (ovpn-12-75.pek2.redhat.com [10.72.12.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B74097C0E1;
        Fri, 31 Jul 2020 00:24:56 +0000 (UTC)
Date:   Fri, 31 Jul 2020 08:24:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Message-ID: <20200731002452.GA1717993@T590>
References: <20200728134938.1505467-1-ming.lei@redhat.com>
 <20200729102856.GA1563056@T590>
 <b80fa58d-34f0-cff5-c3f9-7b3d05a8a1ca@grimberg.me>
 <20200729154957.GD1698748@T590>
 <f3ead535-070d-40ec-08b8-56e2c1cd7ba4@grimberg.me>
 <20200730145325.GA1710335@T590>
 <57689a6d-9e6f-bb28-dd5f-f575988e7cb6@grimberg.me>
 <20200730181857.GA147247@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730181857.GA147247@dhcp-10-100-145-180.wdl.wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 30, 2020 at 11:18:57AM -0700, Keith Busch wrote:
> On Thu, Jul 30, 2020 at 09:10:48AM -0700, Sagi Grimberg wrote:
> > > > I think it will be a significant improvement to have a single code path.
> > > > The code will be more robust and we won't need to face issues that are
> > > > specific for blocking.
> > > > 
> > > > If the cost is negligible, I think the upside is worth it.
> > > > 
> > > 
> > > rcu_read_lock and rcu_read_unlock has been proved as efficient enough,
> > > and I don't think percpu_refcount is better than it, so I'd suggest to
> > > not switch non-blocking into this way.
> > 
> > It's not a matter of which is better, its a matter of making the code
> > more robust because it has a single code-path. If moving to percpu_ref
> > is negligible, I would suggest to move both, I don't want to have two
> > completely different mechanism for blocking vs. non-blocking.
> 
> FWIW, I proposed an hctx percpu_ref over a year ago (but for a
> completely different reason), and it was measured as too costly.
> 
>   https://lore.kernel.org/linux-block/d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk/

That is why I don't want to switch non-blocking to percpu-refcount.

However, cost of srcu read lock/unlock is basically similar with percpu
ref.


Thanks,
Ming

