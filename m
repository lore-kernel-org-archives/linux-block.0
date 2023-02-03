Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D748C61DA4
	for <linux-block@archiver.kernel.org>; Fri,  3 Feb 2023 08:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjBCIGv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Feb 2023 03:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjBCIGB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Feb 2023 03:06:01 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851B226CC5;
        Fri,  3 Feb 2023 00:04:21 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B995D68C4E; Fri,  3 Feb 2023 09:04:17 +0100 (CET)
Date:   Fri, 3 Feb 2023 09:04:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 03/19] blk-cgroup: improve error unwinding in blkg_alloc
Message-ID: <20230203080417.GA28639@lst.de>
References: <20230201134123.2656505-1-hch@lst.de> <20230201134123.2656505-4-hch@lst.de> <Y9xQ33MtLhoxtPNv@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xQ33MtLhoxtPNv@slm.duckdns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 02, 2023 at 02:10:07PM -1000, Tejun Heo wrote:
> This is fine but is this necessarily better? If it's needed for future
> changes, maybe that should be mentioned?

It avoids dealing with partially constructed blkgs outside of blkg_alloc,
which is mostly useful for code clarity.  It also micro-optimized the
free fast path a bit by avoiding two pointless (but mostly confusing)
branches.

I've updated the commit log a bit.
