Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCD6C433F5
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 15:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiI2PDm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 11:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiI2PDb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 11:03:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412BA142E09
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 08:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A1420CE21C4
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 15:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADC3C433B5;
        Thu, 29 Sep 2022 15:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664463807;
        bh=oe5t3MO6suf++0Q4/eQSbeDMVNrpcAiy/4s2fqFhZP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDoTBl9s+q259YmmTDewsSNixuD2NqzHD3dTnP6Dx8Px1CYTMGo3ow9rNQO4ouGAn
         S3skrM+wSmSeXU1WqFSQtrIK3NY9kTWbtHkEKmIg4aqDvoRkg2ivHtohtyq8W89QB0
         ZTsfGawiHVgbEa8oyENgZn77nSs7MKRoQiav/kDhzLCABXYjZOhFrMsD7ZwrmxNvNB
         sVTl9+PmPyIR9ymw4RyOh4F5LCyh49P/fcf3wxtqcrdJWccqjDr0OLMKgMBIag9nQT
         RkSMybalq0bwu/zqfRQJuj42ZplnPo3ckakRNT9hm8tAO794PCQFH5p/CoafoqcH2x
         tiO3X54PUXFQg==
Date:   Thu, 29 Sep 2022 09:03:24 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Message-ID: <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 29, 2022 at 12:59:46PM +0300, Sagi Grimberg wrote:
> > 3. Do you have some performance numbers (we're touching the fast path
> > here) ?
> 
> This is pretty light-weight, accounting is per-cpu and only wrapped by
> preemption disable. This is a very small price to pay for what we gain.

It does add up, though, and some environments disable stats to skip the
overhead. At a minimum, you need to add a check for blk_queue_io_stat() before
assuming you need to account for stats.

Instead of duplicating the accounting, could you just have the stats file report
the sum of its hidden devices?
