Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA25C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 19:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343531AbiA0T6i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:58:38 -0500
Received: from verein.lst.de ([213.95.11.211]:45638 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343516AbiA0T6i (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 14:58:38 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BC25D68AA6; Thu, 27 Jan 2022 20:58:34 +0100 (CET)
Date:   Thu, 27 Jan 2022 20:58:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com
Subject: Re: improve the bio cloning interface
Message-ID: <20220127195834.GA25235@lst.de>
References: <20220127063546.1314111-1-hch@lst.de> <YfLN4/2bYe4hebCy@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfLN4/2bYe4hebCy@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 27, 2022 at 11:52:51AM -0500, Mike Snitzer wrote:
> I'd like to take a closer look, do you happen to have this series
> available in a git branch?

git://git.infradead.org/users/hch/block.git bio_alloc-cleanup-part2

> 
> The changes generally look fine.  Any chance you could forecast what
> you're planning for follow-on changes?

Mostly cleaning up a bunch of submitter code that needs more work to
get at the bdev and op, and trying to figure out what to do about
bio_kmalloc.

> Or is it best to just wait for you to produce those follow-on changes?

There should be no follow ons required to make sense of this series.
