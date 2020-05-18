Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5084BC433DF
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 04:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E438207F9
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 04:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3lI9Bmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgEREHb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 00:07:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35126 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgEREHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 00:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589774849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t6RY7iLJPhArb3KrYiOZuhyUNPcsaIYuZP3UDTmH94c=;
        b=F3lI9BmhP1UHTOhm/IgYY9E7xbrxnUAmFdesfzLm1x9739cRdKxhJN43kb4jovEfxGddyn
        bFymoEUr9WY/F12bFps9eu8RsvKWXchRqwU9TIgDZi/hS2PTpkcLTUcXPzbKthCkZFfWIp
        sHCBUSHb2gEfTl1tO9kO9O2giHpd79w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300--fMtilqiP7OUUfkP4RC99A-1; Mon, 18 May 2020 00:07:19 -0400
X-MC-Unique: -fMtilqiP7OUUfkP4RC99A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D9D6474;
        Mon, 18 May 2020 04:07:17 +0000 (UTC)
Received: from T590 (ovpn-13-68.pek2.redhat.com [10.72.13.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F83F5D9DC;
        Mon, 18 May 2020 04:07:10 +0000 (UTC)
Date:   Mon, 18 May 2020 12:07:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/6] blk-mq: improvement CPU hotplug(simplified version)
Message-ID: <20200518040705.GC20647@T590>
References: <20200515014153.2403464-1-ming.lei@redhat.com>
 <20200516123555.GA13448@lst.de>
 <CACVXFVNou_dMjzxYs-4KvbKmBnrqaBk2sG2pqWuJeLeh_tZoug@mail.gmail.com>
 <20200517070853.GA30271@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200517070853.GA30271@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 17, 2020 at 09:08:53AM +0200, Christoph Hellwig wrote:
> On Sun, May 17, 2020 at 12:08:40PM +0800, Ming Lei wrote:
> > On Sat, May 16, 2020 at 8:37 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > I took at stab at the series this morning, and fixed the fabrics
> > > crash (blk_mq_alloc_request_hctx passed the cpumask of a NULL hctx),
> > > and pre-loaded a bunch of cļeanups to let your changes fit in better.
> > >
> > > Let me know what you think, the git branch is here:
> > >
> > >     git://git.infradead.org/users/hch/block.git blk-mq-hotplug
> > >
> > > Gitweb:
> > >
> > >     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug
> > >
> > 
> > I think the approach is fine, especially the driver tag related
> > change, that was in my mind too, :-)
> > 
> > I guess you will post them all soon, and I will take a close look
> > after they are out.
> 
> Let me know what you prefer - either I can send it out or you can
> pick the series up.
> 

I prefer you send it out because they depend on your another 5 posted
cleanup patches.

thanks,
Ming

