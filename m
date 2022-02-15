Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7069EC433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 20:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiBOURx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 15:17:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiBOURx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 15:17:53 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBB8EB144;
        Tue, 15 Feb 2022 12:17:42 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A045F68AA6; Tue, 15 Feb 2022 21:17:38 +0100 (CET)
Date:   Tue, 15 Feb 2022 21:17:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Markus =?iso-8859-1?Q?Bl=F6chl?= <markus.bloechl@ipetronik.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>
Subject: Re: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
Message-ID: <20220215201738.GA26945@lst.de>
References: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So, I think in th short run setting GD_DEAD is the right thing as a
non-invasive fix, but I'd rather do it in blk_set_queue_dying to also
cover the other drivers with a similar pattern.  blk_set_queue_dying
is never used for cases where q->disk isn't valid so that should be
fine.

In the long run I think we just need to remove the fsync_bdev in
del_gendisk or at least make it conditional.
