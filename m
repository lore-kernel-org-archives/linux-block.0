Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DBFFA373D
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 09:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJ3JRo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 05:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJ3JRn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 05:17:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24294B497
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 02:17:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C24C68AA6; Sun, 30 Oct 2022 10:17:39 +0100 (CET)
Date:   Sun, 30 Oct 2022 10:17:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 02/17] nvme-pci: refactor the tagset handling in
 nvme_reset_work
Message-ID: <20221030091739.GA5643@lst.de>
References: <20221025144020.260458-1-hch@lst.de> <20221025144020.260458-3-hch@lst.de> <cafdc008-9d07-758a-bb66-1ca62b0baa50@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cafdc008-9d07-758a-bb66-1ca62b0baa50@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 26, 2022 at 03:46:09PM +0300, Sagi Grimberg wrote:
> This is clearer, but what I think would be even cleaner, is if we simply
> move the whole first time to a different probe_work and treat it like it
> is instead of relying on resources existence as a state indicators
> (tagset/admin_q). The shared portion can move to helpers.

I started playing with that a bit on my flight home this week.
I think the right thing is to do away with the scheduled work for probe
entirely and set the PROBE_PREFER_ASYNCHRONOUS flag in the driver, and
that should also really help with probe error handling.  But that's
another fairly big set of changes over this already quite big series
so I'd prefer to do it separately.
