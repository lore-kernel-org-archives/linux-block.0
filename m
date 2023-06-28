Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914A7EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 09:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjF1JYL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 05:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232964AbjF1IH4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 04:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687939626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kGytBMT/4D8N3PdlUpmb4evMLlTEamUTcj7Gwbg+z3A=;
        b=DV4qkl9CDHfP0WcjAxB1PodsH5lg/BpoX66pw5UYJbJB3qRRKplubXb7yT1lhbg44KlMma
        X6JYXvp62w/Bt5rInG+ULPAVnqFgwoEYhF7WR0/wufnYLh4ba6ngAWlni8dYR7Ap/C1Tb5
        LWFa+N8nOZlE00dXlP3xMdKPSf12Fpk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-hCjEIBPSMzWGqhs1ltmbFw-1; Wed, 28 Jun 2023 03:06:38 -0400
X-MC-Unique: hCjEIBPSMzWGqhs1ltmbFw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D60D185A793;
        Wed, 28 Jun 2023 07:06:38 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D858E40BB4D;
        Wed, 28 Jun 2023 07:06:32 +0000 (UTC)
Date:   Wed, 28 Jun 2023 15:06:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>, ming.lei@redhat.com
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJvb85ovMrZEbilc@ovpn-8-21.pek2.redhat.com>
References: <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
 <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
 <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
 <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 27, 2023 at 11:21:36AM -0600, Keith Busch wrote:
> On Sun, Jun 25, 2023 at 08:26:48AM +0800, Ming Lei wrote:
> > Yeah, but you can't remove the gap at all with start_freeze, that said
> > the current code has to live with the situation of new mapping change
> > and old request with old mapping.
> > 
> > Actually I considered to handle this kind of situation before, one approach
> > is to reuse the bio steal logic taken in nvme mpath:
> > 
> > 1) for FS IO, re-submit bios, meantime free request
> > 
> > 2) for PT request, simply fail it
> > 
> > It could be a bit violent for 2) even though REQ_FAILFAST_DRIVER is
> > always set for PT request, but not see any better approach for handling
> > PT request.
> 
> I think that's acceptable for PT requests, or any request that doesn't
> have a bio. I tried something similiar a while back that was almost
> working, but I neither never posted it, or it's in that window when
> infradead lost all the emails. :(

If you are fine to fail PT request, I'd suggest to handle the
problem in the following way:

1) moving freeze into reset

2) during resetting

- freeze NS queues
- unquiesce NS queues
- nvme_wait_freeze()
- update_nr_hw_queues
- unfreeze NS queues

3) meantime changes driver's ->queue_rq() in case that ctrl state is NVME_CTRL_CONNECTING,

- if the request is FS IO with data, re-submit all bios of this request,
  and free the request

- otherwise, fail the request  

With this way, not only freeze is paired with unfreeze. More
importantly, it becomes not possible to trigger new timeout during
handling NVME_CTRL_CONNECTING, then fallback to ctrl removal can
be avoided.

Any comment on this approach?

Thanks,
Ming

