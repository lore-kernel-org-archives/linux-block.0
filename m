Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FDCC2D0E4
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 07:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A259F2463C
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 07:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcVkuqb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgKQHk4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Nov 2020 02:40:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgKQHk4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Nov 2020 02:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605598855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SRKFcRcQy1lG4g+wmZjGy6as9tMFMpFFgkdUzIBrtM4=;
        b=hcVkuqb3UPMItc8+dPafwvZL4bHaO9c2ZO+Q2O/0FBe2GWd+Azuf2BOgvkHi3LjyVVr1Fm
        IqXO1MZ94phv3frl0etOsL0k2G4eiiGLaC/s7SMPYH1PMvjcr7VWMiUkTUg980wHd3Pmu3
        2zS/RrXjWhaevqFQLLopMf0NMCoErss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-jVS79DX5NJmlK2L5iyj5sg-1; Tue, 17 Nov 2020 02:40:53 -0500
X-MC-Unique: jVS79DX5NJmlK2L5iyj5sg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 491E4186DD2B;
        Tue, 17 Nov 2020 07:40:52 +0000 (UTC)
Received: from T590 (ovpn-13-195.pek2.redhat.com [10.72.13.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FEA519C78;
        Tue, 17 Nov 2020 07:40:43 +0000 (UTC)
Date:   Tue, 17 Nov 2020 15:40:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        mpatocka@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v5 0/2] fix inaccurate io_ticks
Message-ID: <20201117074039.GA74954@T590>
References: <20201027045411.GA39796@192.168.3.9>
 <CAA70yB7bepwNPAMtxth8qJCE6sQM9vxr1A5sU8miFn3tSOSYQQ@mail.gmail.com>
 <CAA70yB6caVcKjJOTkEZa9ZBzZAHPgYrsr9nZWDgm-tfPMLGXHQ@mail.gmail.com>
 <20201117032756.GE56247@T590>
 <CAA70yB4G_1jHYRyVsf_mhHQA-_mGXzaZ6n4Bgtq9n-x1_Yz4rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB4G_1jHYRyVsf_mhHQA-_mGXzaZ6n4Bgtq9n-x1_Yz4rg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 17, 2020 at 12:59:46PM +0800, Weiping Zhang wrote:
> On Tue, Nov 17, 2020 at 11:28 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Nov 17, 2020 at 11:01:49AM +0800, Weiping Zhang wrote:
> > > Hi Jens,
> > >
> > > Ping
> >
> > Hello Weiping,
> >
> > Not sure we have to fix this issue, and adding blk_mq_queue_inflight()
> > back to IO path brings cost which turns out to be visible, and I did
> > get soft lockup report on Azure NVMe because of this kind of cost.
> >
> Have you test v5, this patch is different from v1, the v1 gets
> inflight for each IO,
> v5 has changed to get inflight every jiffer.

I meant the issue can be reproduced on kernel before 5b18b5a73760("block:
delete part_round_stats and switch to less precise counting").

Also do we really need to fix this issue? I understand device
utilization becomes not accurate at very small load, is it really
worth of adding runtime load in fast path for fixing this issue?

> 
> If for v5, can we reproduce it on null_blk ?

No, I just saw report on Azure NVMe.

> 
> > BTW, suppose the io accounting issue needs to be fixed, just wondering
> > why not simply revert 5b18b5a73760 ("block: delete part_round_stats and
> > switch to less precise counting"), and the original way had been worked
> > for decades.
> >
> This patch is more better than before, it will break early when find there is
> inflight io on any cpu, for the worst case(the io in running on the last cpu),
> it iterates all cpus.

Please see the following case:

1) one device has 256 hw queues, and the system has 256 cpu cores, and
each hw queue's depth is 1k.

2) there isn't any io load on CPUs(0 ~ 254)

3) heavy io load is run on CPU 255

So with your trick the code still need to iterate hw queues from 0 to 254, and
the load isn't something which can be ignored. Especially it is just for
io accounting.


Thanks,
Ming

