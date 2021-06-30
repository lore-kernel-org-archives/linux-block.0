Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31587C11F66
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 23:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0948561443
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 23:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbhGAACN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 20:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229864AbhGAACN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 20:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625097583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jw4lNKzQTa8WoEHtp9xHFeVAe2ctfiqLinrekfQ4TYU=;
        b=C9UJ5OAXlE0mg8L2lfICREjfn2pwX3yuGzZQ0S1VFMv/faEEKiZrBHVme53WKavd+2Z+Do
        1qziK9DIg50oEdnphiEaRAz2QzR/6ZVncE5IDir7U5mEKEX4aU+JYjQH+pP9HPk98fj3nW
        yIR+ebHhzBUOW1sTXJgNy2AA8WuJ0Sc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-ECrR0RMFNkKwyZnwI0pO2w-1; Wed, 30 Jun 2021 19:59:41 -0400
X-MC-Unique: ECrR0RMFNkKwyZnwI0pO2w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DF811084F40;
        Wed, 30 Jun 2021 23:59:40 +0000 (UTC)
Received: from T590 (ovpn-12-75.pek2.redhat.com [10.72.12.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15D215DA60;
        Wed, 30 Jun 2021 23:59:30 +0000 (UTC)
Date:   Thu, 1 Jul 2021 07:59:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
Message-ID: <YN0FXrcwXfAwGU6w@T590>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de>
 <YNwug8n7qGL5uXfo@T590>
 <c1de513a-5477-9d1d-0ddc-24e9166cc717@suse.de>
 <YNw/DcxIIMeg/2VK@T590>
 <e106f9c4-35c3-b2da-cdd8-3c4dff8234d6@grimberg.me>
 <89081624-fedd-aa94-1ba2-9a137708a1f1@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89081624-fedd-aa94-1ba2-9a137708a1f1@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 30, 2021 at 09:46:35PM +0200, Hannes Reinecke wrote:
> On 6/30/21 8:59 PM, Sagi Grimberg wrote:
> > 
> > > > > > Shouldn't we rather modify the tagset to only refer to
> > > > > > the current online
> > > > > > CPUs _only_, thereby never submit a connect request for hctx with only
> > > > > > offline CPUs?
> > > > > 
> > > > > Then you may setup very less io queues, and performance may suffer even
> > > > > though lots of CPUs become online later.
> > > > > ;
> > > > Only if we stay with the reduced number of I/O queues. Which is
> > > > not what I'm
> > > > proposing; I'd rather prefer to connect and disconnect queues
> > > > from the cpu
> > > > hotplug handler. For starters we could even trigger a reset once
> > > > the first
> > > > cpu within a hctx is onlined.
> > > 
> > > Yeah, that need one big/complicated patchset, but not see any advantages
> > > over this simple approach.
> > 
> > I tend to agree with Ming here.
> 
> Actually, Daniel and me came to a slightly different idea: use cpu hotplug
> notifier.
> Thing is, blk-mq already has cpu hotplug notifier, which should ensure that
> no I/O is pending during cpu hotplug.

Why should we ensure that for non-managed irq?

> If we now add a nvme cpu hotplug notifier which essentially kicks off a
> reset once all cpu in a hctx are offline the reset logic will rearrange the
> queues to match the current cpu layout.
> And when the cpus are getting onlined we'll do another reset.
> 
> Daniel is currently preparing a patch; let's see how it goes.

What is the advantage of that big change over this simple way?

Thanks, 
Ming

