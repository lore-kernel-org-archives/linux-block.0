Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524DCC4742C
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 09:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F4E221F9
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 09:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVZkjDs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgKPIlj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 03:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727779AbgKPIli (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 03:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605516097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efmyc1CuOVg4ojQNr6kjjyi068x2OkeNRQvY6Ycc68k=;
        b=dVZkjDs6Qyp4Q/jvS6xe4/EOQ0YD+1LeJ/lq8F6Q9Xu40j/eXyPNyeYmuXnYC6n4gNphlI
        5Gz5G3ldRGLRe7nY/weXaB1lFJAqNBoSiGxNN208v7SnZDBnV1J8Lftt1PZrcfMsYxthSZ
        HT4+2u7P/Hl7D+6LYwDHFoXgJ4X3K1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-ZVE8-tV0M4Shj7XumfnGwA-1; Mon, 16 Nov 2020 03:41:33 -0500
X-MC-Unique: ZVE8-tV0M4Shj7XumfnGwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44DD0809DD3;
        Mon, 16 Nov 2020 08:41:30 +0000 (UTC)
Received: from T590 (ovpn-13-166.pek2.redhat.com [10.72.13.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 158BE5C5AF;
        Mon, 16 Nov 2020 08:41:18 +0000 (UTC)
Date:   Mon, 16 Nov 2020 16:41:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Rachit Agarwal <rach4x0r@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
        Qizhe Cai <qc228@cornell.edu>,
        Midhul Vuppalapati <mvv25@cornell.edu>,
        Rachit Agarwal <ragarwal@cs.cornell.edu>,
        Sagi Grimberg <sagi@lightbitslabs.com>,
        Rachit Agarwal <ragarwal@cornell.edu>
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
Message-ID: <20201116084113.GA40246@T590>
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
 <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
 <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me>
 <c4cb66f6-8a66-7973-dc03-0f4f61d0a1e4@kernel.dk>
 <cbe18a3d-8a6b-e775-81bb-3b3f11045183@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbe18a3d-8a6b-e775-81bb-3b3f11045183@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 13, 2020 at 01:36:16PM -0800, Sagi Grimberg wrote:
> 
> > > But if you think this has a better home, I'm assuming that the guys
> > > will be open to that.
> > 
> > Also see the reply from Ming. It's a balancing act - don't want to add
> > extra overhead to the core, but also don't want to carry an extra
> > scheduler if the main change is really just variable dispatch batching.
> > And since we already have a notion of that, seems worthwhile to explore
> > that venue.
> 
> I agree,
> 
> The main difference is that this balancing is not driven from device
> resource pressure, but rather from an assumption of device specific
> optimization (and also with a specific optimization target), hence a
> scheduler a user would need to opt-in seemed like a good compromise.
> 
> But maybe Ming has some good ideas on a different way to add it..

Not yet, :-(

It is one very good work to show that IO is improved with batching. 

One big question I am still not clear is that how NVMe-TCP performance(
should be throughput according to 'Introduction' part of paper[1]) is
improved much when batching IO is applied. Is it because network stack
performs much well for transporting big chunk data? Or context switch overhead is
reduced because 'Ringing the doorbell' implies worker queue scheduling,
according to '2.4 Delayed Doorbells' of [1]. Or both? Or others? Do we
have data wrt. how much improvement from each factor?

Another question is that 'Introduction' of [1] part mentions that i10 is
more for 'throughput-bound applications'. And 'at low loads, latencies
may be high(within 1.7× of NVMe-over-RDMA latency over storage devices))',
so i10 scheduler is primarily for throughput-bound applications? If yes,
I'd suggest to add the words to commit log for helping people to review.
Then we can avoid to consider IO latency sensitive usages(such as iopoll).

[1] https://www.usenix.org/conference/nsdi20/presentation/hwang

Thanks,
Ming

