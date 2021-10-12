Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FA2C433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 15:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6959660E54
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 15:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbhJLPT5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237248AbhJLPT4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 11:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634051874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cI6wSNt3VFHTO0Dz206mUxF9fpkASifNApOqsUeK/gQ=;
        b=AxHk4TxyXwZXuDeQX2A6ckmUEokVrt0ZEsHmnK81nHe1lC4Vh1WthxoA0noWjDTEziE5LK
        DTeWavcWCUtdPp5NnZSA9dAucWjaDS+AUDhQCZ4CFbFj2HqlA7YU5PpPpJAaU7Lm/e+WIP
        gM3uVnmlhU1MfbBHL1OLo5Nw5OOZrkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-TZYveaiiOAmueDKcVEuUiw-1; Tue, 12 Oct 2021 11:17:51 -0400
X-MC-Unique: TZYveaiiOAmueDKcVEuUiw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B81EE1926DA2;
        Tue, 12 Oct 2021 15:17:49 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BB3A10023B8;
        Tue, 12 Oct 2021 15:17:43 +0000 (UTC)
Date:   Tue, 12 Oct 2021 23:17:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 4/6] nvme: paring quiesce/unquiesce
Message-ID: <YWWnEvX2uT4mUDpE@T590>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
 <20211009034713.1489183-5-ming.lei@redhat.com>
 <20211012103620.GB29640@lst.de>
 <YWWjXN3GEzypVFZ/@T590>
 <20211012150741.GA20571@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012150741.GA20571@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 12, 2021 at 05:07:41PM +0200, Christoph Hellwig wrote:
> On Tue, Oct 12, 2021 at 11:01:48PM +0800, Ming Lei wrote:
> > There are lots of unbalanced usage in nvme, such as
> > 
> > 1) nvme pci:
> > 
> > - nvme_dev_disable() can be called more than one times before starting
> > reset, so multiple nvme_stop_queues() vs. single nvme_start_queues().
> > 
> > 2) Forcibly unquiesce queues in nvme_kill_queues() even though queues
> > are never quiesced, and similar usage can be seen in tcp/fc/rdma too
> > 
> > Once the quiesce and unquiesce are run from difference context, it becomes
> > not easy to audit if the two is done in pair.
> 
> Yes, but I'm not sure a magic flag is really the solution here.
> I think we need to work on our state machine here so that this is less
> of a mess.

Frankly speaking, I am not sure you can clean the whole mess in short time.

At least the approach of using the flag is clean and correct, and it can
be reverted quite easily if you finally cleaned it.

Thanks,
Ming

