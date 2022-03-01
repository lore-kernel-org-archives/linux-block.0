Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716DFC433EF
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 11:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiCAL0N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 06:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiCAL0M (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 06:26:12 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84B591371
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 03:25:31 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 652BA68AFE; Tue,  1 Mar 2022 12:25:27 +0100 (CET)
Date:   Tue, 1 Mar 2022 12:25:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        damien.lemoal@wdc.com, axboe@kernel.dk, hch@lst.de,
        sagi@grimberg.me
Subject: Re: [PATCH 1/1] block: move sector bio member into blk_next_bio()
Message-ID: <20220301112527.GA2567@lst.de>
References: <20220301022310.8579-1-kch@nvidia.com> <20220301022310.8579-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301022310.8579-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It would be nice to just calculate the sector from the previous
bio using bio_end_sector, but that doesn't really work with the
current blk_next_bio pattern.  It might make sense to just take the
initial allocation case out of blk_next_bio and do that manually now
that the bio_alloc interface makes a lot more sense.
