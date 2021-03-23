Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82C3C433C1
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FCB619B8
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhCWQTs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:19:48 -0400
Received: from verein.lst.de ([213.95.11.211]:33140 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233085AbhCWQTm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 12:19:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E7E768B02; Tue, 23 Mar 2021 17:19:40 +0100 (CET)
Date:   Tue, 23 Mar 2021 17:19:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of
 the underlying device
Message-ID: <20210323161939.GC13402@lst.de>
References: <20210322073726.788347-1-hch@lst.de> <20210322073726.788347-3-hch@lst.de> <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me> <c064b296-c25c-3731-cbbd-f99ab93e6bd2@suse.de> <608f8198-8c0d-b59c-180b-51666840382d@grimberg.me> <250dc97d-8781-1655-02ca-5171b0bd6e24@suse.de> <20210323145330.GB21687@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323145330.GB21687@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 23, 2021 at 11:53:30PM +0900, Keith Busch wrote:
> Failover might be overkill. We can run out of tags in a perfectly normal
> situation, and simply waiting may be the best option, or even scheduling
> on a different CPU may be sufficient to get a viable tag  rather than
> selecting a different path.

Indeed.  Then again IFF there are multiple optimized paths picking one
could also be a way to make progress.

> Does it make sense to just abort all allocated tags during a reset and
> let the original bio requeue for multipath IO?

Well, this would again hard code multipath information into the lower
levels.  But then again we could at least do it so that we check for
the REQ_NVME_MPATH to make it clear what is going on.
