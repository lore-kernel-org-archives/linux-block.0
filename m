Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C39C433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 13:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B66560FF1
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 13:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbhESND0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 09:03:26 -0400
Received: from verein.lst.de ([213.95.11.211]:38252 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240957AbhESND0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 09:03:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DA76167373; Wed, 19 May 2021 15:02:01 +0200 (CEST)
Date:   Wed, 19 May 2021 15:02:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 08/15] io_uring: don't sleep when polling for I/O
Message-ID: <20210519130201.GA9474@lst.de>
References: <20210512131545.495160-1-hch@lst.de> <20210512131545.495160-9-hch@lst.de> <22a8e5a0-b292-a2c5-148d-287c1a50e2b9@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a8e5a0-b292-a2c5-148d-287c1a50e2b9@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 12, 2021 at 02:55:59PM -0700, Sagi Grimberg wrote:
> I think that the combination of oneshot and nosleep flags to replace
> a boolen spin is a little hard to follow (especially that spin doesn't
> mean spinning without sleeping).
>
> Maybe we should break it to:
> 1. replace spin to flags with ONESHOT passed from io_uring (direct
>    replacement)
> 2. add NOSLEEP passed from io_uring as there is no need for it.
>
> Just a suggestion though that would help (me at least) to follow
> this more easily.

I've split it up for the next version.
