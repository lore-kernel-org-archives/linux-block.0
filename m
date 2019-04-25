Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6270C43218
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 15:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D48205ED
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 15:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfDYPgm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:36:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbfDYPgl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 11:36:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62E0A8E5BB;
        Thu, 25 Apr 2019 15:36:41 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ADC0600C1;
        Thu, 25 Apr 2019 15:36:32 +0000 (UTC)
Date:   Thu, 25 Apr 2019 23:36:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.com>,
        Bart van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@gmail.com>, neilb@suse.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH] block: use static bio_set for bio_split() calls
Message-ID: <20190425153627.GA9825@ming.t460p>
References: <20190418140632.60606-1-hare@suse.de>
 <20190418143429.GA19175@ming.t460p>
 <98d8549a-2663-b404-e38a-6f55dfb575bf@grimberg.me>
 <20190424221422.GA21351@ming.t460p>
 <20190425004106.GA22683@ming.t460p>
 <c6a54cea-f2ce-3344-efb1-ba8f20bf9509@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6a54cea-f2ce-3344-efb1-ba8f20bf9509@suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 25 Apr 2019 15:36:41 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 25, 2019 at 04:32:42PM +0200, Hannes Reinecke wrote:
> On 4/25/19 2:41 AM, Ming Lei wrote:
> > On Thu, Apr 25, 2019 at 06:14:22AM +0800, Ming Lei wrote:
> > > On Wed, Apr 24, 2019 at 10:20:46AM -0700, Sagi Grimberg wrote:
> > > > 
> > > > > per-queue bioset is used originally for avoiding deadlock, are you
> > > > > sure the static bioset is safe?
> > > > 
> > > > Can you explain this? I didn't find any indication of that in the change
> > > > log history...
> > > > 
> > > > Originally introduced by Kent:
> > > 
> > > bio split can be run from stacking drivers, for example, MD over NVMe,
> > > if the global reserved mempool is consumed by MD bio splitting, then
> > > no any progress can be made when splitting on bio submitted to NVMe.
> > > 
> > > Kent may have more details...
> > 
> > I guess it might be fine to use one shared global bio_set for all
> > lowest underlying queues, could be all queues except for loop, dm, md
> > , drbd, bcache, ...
> > 
> But wasn't the overall idea of stacking drivers that we propagate the queue
> limits up to the uppermost drivers, so that we have to do a split only at
> the upper layers?

For example, LVM over RAID, the limits of LVM queue is figured out and fixed
during creating LVM. However, new device may be added to the RAID. Then the
underlying queue's limit may not be propagated to LVM's queue's limit.

And we did discuss the topic of 'block: dm: restack queue_limits'
before, looks not see any progress made.

Also loop doesn't consider stack limits at all.

> Furthermore, it's not every bio which needs to be split, only those which
> straddle some device limitations.
> The only ones not being able to propagate the queue limits is MD, and that
> is already using a private bio_set here.

If DM and the lowest queue share one same bio_set(mem_pool), it isn't
enough for MD to use private bio_set.

> 
> I've worked on a patchset to provide a separate bio set for each of the
> stacking drivers, but the interface I've been able to come up with is not
> very nice, and I really doubt it's worth it.
> 
> So I'd advocate to test with this patch first, and only provide individual
> biosets once we find it's an issue.

The above issue of LVM over RAID was a real one reported inside Red Hat.


Thanks,
Ming
