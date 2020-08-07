Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB807C433E0
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 09:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F55221E5
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 09:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PN8z7gRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHGJZU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:25:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54552 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727030AbgHGJZU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 05:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596792317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5zNghwZyDwNMJFv9scQbFvX4Q5eB7i0ZQE3vtTwERyw=;
        b=PN8z7gRDuqdOiIjzSoe+nG8IgWJUo5PFsylc0B+hYVFhJSo7/B/q90w/GE/TTXTekx/Z4I
        xmpzLUTSlk3RMQGdmKYsHEtswrYhLLLwvcJf60VND+y/hkc9DeVyvkulP4m0FuBUbzA/Ox
        7YBK55iM2IqMtwq96Ypb7Yd71oLS1CQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-6DgKfVeOMj2xYj1wbWQ_LA-1; Fri, 07 Aug 2020 05:25:13 -0400
X-MC-Unique: 6DgKfVeOMj2xYj1wbWQ_LA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 858C379EC0;
        Fri,  7 Aug 2020 09:25:11 +0000 (UTC)
Received: from T590 (ovpn-13-53.pek2.redhat.com [10.72.13.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 193A887A6D;
        Fri,  7 Aug 2020 09:25:01 +0000 (UTC)
Date:   Fri, 7 Aug 2020 17:24:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        paulmck@kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200807092457.GA2112310@T590>
References: <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
 <20200728135436.GP9247@paulmck-ThinkPad-P72>
 <d1ba2009-130a-d423-1389-c7af72e25a6a@grimberg.me>
 <20200729003124.GT9247@paulmck-ThinkPad-P72>
 <07c90cf1-bb6f-a343-b0bf-4c91b9acb431@grimberg.me>
 <20200729005942.GA2729664@dhcp-10-100-145-180.wdl.wdc.com>
 <2f17c8ed-99f6-c71c-edd1-fd96481f432c@grimberg.me>
 <31a9ba72-1322-4b7c-fb73-db0cb52989da@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31a9ba72-1322-4b7c-fb73-db0cb52989da@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 07, 2020 at 05:04:38PM +0800, Chao Leng wrote:
> 
> 
> On 2020/7/29 12:39, Sagi Grimberg wrote:
> > 
> > > > > > Dynamically allocating each one is possible but not very scalable.
> > > > > > 
> > > > > > The question is if there is some way, we can do this with on-stack
> > > > > > or a single on-heap rcu_head or equivalent that can achieve the same
> > > > > > effect.
> > > > > 
> > > > > If the hctx structures are guaranteed to stay put, you could count
> > > > > them and then do a single allocation of an array of rcu_head structures
> > > > > (or some larger structure containing an rcu_head structure, if needed).
> > > > > You could then sequence through this array, consuming one rcu_head per
> > > > > hctx as you processed it.  Once all the callbacks had been invoked,
> > > > > it would be safe to free the array.
> > > > > 
> > > > > Sounds too simple, though.  So what am I missing?
> > > > 
> > > > We don't want higher-order allocations...
> > > 
> > > So:
> > > 
> > >    (1) We don't want to embed the struct in the hctx because we allocate
> > >    so many of them that this is non-negligable to add for something we
> > >    typically never use.
> > > 
> > >    (2) We don't want to allocate dynamically because it's potentially
> > >    huge.
> > > 
> > > As long as we're using srcu for blocking hctx's, I think it's "pick your
> > > poison".
> > > 
> > > Alternatively, Ming's percpu_ref patch(*) may be worth a look.
> > > 
> > >   * https://www.spinics.net/lists/linux-block/msg56976.html1
> > I'm not opposed to having this. Will require some more testing
> > as this affects pretty much every driver out there..
> > 
> > If we are going with a lightweight percpu_ref, can we just do
> > it also for non-blocking hctx and have a single code-path?
> > .
> I tried to optimize the patch，support for non blocking queue and
> blocking queue.
> See next email.

Please see the following thread:

https://lore.kernel.org/linux-block/05f75e89-b6f7-de49-eb9f-a08aa4e0ba4f@kernel.dk/

Both Keith and Jens didn't think it is a good idea.



Thanks,
Ming

