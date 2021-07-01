Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E09C11F64
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 09:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A3B461585
	for <linux-block@archiver.kernel.org>; Thu,  1 Jul 2021 09:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbhGAJQp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jul 2021 05:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235088AbhGAJQp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Jul 2021 05:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625130854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NWsQfkJsHozHt689Ycc7QAhEWD6ZJjZVr7BQ4llvQfI=;
        b=aTrvpZFLwmec0QAiO4NLmcw+rXLRgWyjtcyEm6WoYgf/YbnpEqvvPq1WIq9Sd0FV4AEWCk
        HWYfhVqdN/McfbSIDFXjj7bMKUiVp0xn1d7Q35Bh0sY5fSIg3njQfQXHpboD72jfkwTFh9
        OW6E1Ft1/8f5l1uXbxjicnCQpkLFH0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-vol2z-XON_SF3zKUgPjlww-1; Thu, 01 Jul 2021 05:14:08 -0400
X-MC-Unique: vol2z-XON_SF3zKUgPjlww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3255100C66B;
        Thu,  1 Jul 2021 09:14:05 +0000 (UTC)
Received: from T590 (ovpn-13-92.pek2.redhat.com [10.72.13.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9661160C17;
        Thu,  1 Jul 2021 09:13:53 +0000 (UTC)
Date:   Thu, 1 Jul 2021 17:13:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
Message-ID: <YN2HTZaygkVemw4y@T590>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de>
 <YNwug8n7qGL5uXfo@T590>
 <c1de513a-5477-9d1d-0ddc-24e9166cc717@suse.de>
 <YNw/DcxIIMeg/2VK@T590>
 <e106f9c4-35c3-b2da-cdd8-3c4dff8234d6@grimberg.me>
 <89081624-fedd-aa94-1ba2-9a137708a1f1@suse.de>
 <YN0FXrcwXfAwGU6w@T590>
 <c3a3a25b-a36b-e20d-6f7f-828f22650a30@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3a3a25b-a36b-e20d-6f7f-828f22650a30@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 01, 2021 at 10:00:27AM +0200, Hannes Reinecke wrote:
> On 7/1/21 1:59 AM, Ming Lei wrote:
> > On Wed, Jun 30, 2021 at 09:46:35PM +0200, Hannes Reinecke wrote:
> > > On 6/30/21 8:59 PM, Sagi Grimberg wrote:
> > > > 
> > > > > > > > Shouldn't we rather modify the tagset to only refer to
> > > > > > > > the current online
> > > > > > > > CPUs _only_, thereby never submit a connect request for hctx with only
> > > > > > > > offline CPUs?
> > > > > > > 
> > > > > > > Then you may setup very less io queues, and performance may suffer even
> > > > > > > though lots of CPUs become online later.
> > > > > > > ;
> > > > > > Only if we stay with the reduced number of I/O queues. Which is
> > > > > > not what I'm
> > > > > > proposing; I'd rather prefer to connect and disconnect queues
> > > > > > from the cpu
> > > > > > hotplug handler. For starters we could even trigger a reset once
> > > > > > the first
> > > > > > cpu within a hctx is onlined.
> > > > > 
> > > > > Yeah, that need one big/complicated patchset, but not see any advantages
> > > > > over this simple approach.
> > > > 
> > > > I tend to agree with Ming here.
> > > 
> > > Actually, Daniel and me came to a slightly different idea: use cpu hotplug
> > > notifier.
> > > Thing is, blk-mq already has cpu hotplug notifier, which should ensure that
> > > no I/O is pending during cpu hotplug.
> > 
> > Why should we ensure that for non-managed irq?
> > 
> 
> While not strictly necessary, it does align the hctx layout with the current
> CPU topology.
> As such we won't have any 'stale' CPUs or queues in the hctx layout, and
> with that avoid any issues we'll be having due to inactive CPUs in the
> cpumask.

We know the exact theory for non-managed interrupt, can you share us
any issue you want to avoid?

> 
> > > If we now add a nvme cpu hotplug notifier which essentially kicks off a
> > > reset once all cpu in a hctx are offline the reset logic will rearrange the
> > > queues to match the current cpu layout.
> > > And when the cpus are getting onlined we'll do another reset.
> > > 
> > > Daniel is currently preparing a patch; let's see how it goes.
> > 
> > What is the advantage of that big change over this simple way?
> > 
> 
> With the simple way we might (and, as the results show, do) run the
> nvme_ctrl_reset() in parallel to CPU hotplug.
> This leads to quite some complexity, and as we've seen is triggering quite
> some race conditions.

CPU hotplug isn't related with nvme reset at all, which is just for
recovering nvme controller to make it working again. How can cpu offline
affect nvme controller?

For NVMe PCI, blk-mq have drained any inflight requests before the hctx
is becoming inactive.

For other NVMe controller which doesn't use managed irq, the inflight
requests can still be completed via the original interrupt, or polling
task, both can been migrated to new online cpu.

I don't know what exact race conditions you are talking about. Please
explain it in details, otherwise it just wastes our time.

> 
> Hence I do think we need to synchronize nvme_ctrl_reset() with CPU hotplug,
> to ensure that the reset handler is completed before the cpu is completely
> torn down.

No, you didn't provide any proof about the necessity of adding the sync. 



Thanks, 
Ming

