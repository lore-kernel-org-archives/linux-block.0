Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A83FC32793
	for <linux-block@archiver.kernel.org>; Wed, 18 Jan 2023 17:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjARRnJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Jan 2023 12:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjARRmg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2023 12:42:36 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F7048604;
        Wed, 18 Jan 2023 09:42:13 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 94DB467373; Wed, 18 Jan 2023 18:42:08 +0100 (CET)
Date:   Wed, 18 Jan 2023 18:42:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
Subject: Re: [PATCH v4 12/14] blk-mq: remove set of bd->last when get
 driver tag for next request fails
Message-ID: <20230118174208.GH12399@lst.de>
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com> <20230118093726.3939160-12-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118093726.3939160-12-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 18, 2023 at 05:37:24PM +0800, Kemeng Shi wrote:
> Commit 113285b473824 ("blk-mq: ensure that bd->last is always set
> correctly") will set last if we failed to get driver tag for next
> request to avoid flush miss as we break the list walk and will not
> send the last request in the list which will be sent with last set
> normally.
> This code seems stale now becase the flush introduced is always
> redundant as:
> For case tag is really out, we will send a extra flush if we find
> list is not empty after list walk.
> For case some tag is freed before retry in blk_mq_prep_dispatch_rq for
> next, then we can get a tag for next request in retry and flush notified
> already is not necessary.

I think Ming will know this code better than me, but aren't we
losing the blk_mq_get_driver_tag call entirely here now.  Where
is getting the driver tag covered now?
