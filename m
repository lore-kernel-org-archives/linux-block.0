Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0922C05027
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 15:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjBFPuy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 10:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjBFPux (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 10:50:53 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACC759F6
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 07:50:52 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1F16668BFE; Mon,  6 Feb 2023 16:50:49 +0100 (CET)
Date:   Mon, 6 Feb 2023 16:50:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, mcgrof@kernel.org,
        gost.dev@samsung.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] brd: improve performance with blk-mq
Message-ID: <20230206155048.GA13392@lst.de>
References: <20230203103005.31290-1-p.raghav@samsung.com> <CGME20230203103127eucas1p293a9fa97366fc89c62f18053be6aca1f@eucas1p2.samsung.com> <20230203103005.31290-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203103005.31290-2-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 03, 2023 at 04:00:06PM +0530, Pankaj Raghav wrote:
> move to blk-mq based request processing as brd is one of the few drivers
> that still uses submit_bio interface. The changes are pretty trivial
> to start using blk-mq. The performance increases up to 125% for direct IO
> read workloads. There is a slight dip in performance for direct IO write
> workload but considering the general performance gain with blk-mq
> support, it is not a lot.

Can you find out why writes regress, and what improves for reads?

In general blk-mq is doing a lot more work for better batching, but much
of that batching should not matter for a simple ramdisk.  So the results
look a little odd to me, and extra numbers and explanations would
really help.
