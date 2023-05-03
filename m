Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0278BC7EE22
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 05:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjECFEW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 01:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECFEU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 01:04:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EE3198C
        for <linux-block@vger.kernel.org>; Tue,  2 May 2023 22:04:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8D65168AA6; Wed,  3 May 2023 07:04:14 +0200 (CEST)
Date:   Wed, 3 May 2023 07:04:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        joshi.k@samsung.com, axboe@kernel.dk, hch@lst.de,
        xiaoguang.wang@linux.alibaba.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC 1/3] nvme: skip block cgroups for passthrough commands
Message-ID: <20230503050414.GA19301@lst.de>
References: <20230501153306.537124-1-kbusch@meta.com> <20230501153306.537124-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501153306.537124-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 01, 2023 at 08:33:04AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Passthrough requests don't go through the submit_bio() path, so all the
> overhead of setting up the bio's cgroup is wasted cycles. Provide a path
> to skip this setup.

These days we should not need to set bi_bdev at all for passthrough,
so I think we can just drop the assingment.

But instead of just optimizing for passthrough we really need to optimize
this assignment and get rid of the cost entirely.  What is so expensive
about the cgroup lookup?  Is this even for a device that uses cgroups
at all, or could we come up with a flag to bypass all the lookup unless
cgroup are anbled?
