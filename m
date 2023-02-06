Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A63C05027
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 16:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjBFQGR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 11:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjBFQGQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 11:06:16 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5EF1CF70;
        Mon,  6 Feb 2023 08:06:13 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 09FF768C7B; Mon,  6 Feb 2023 17:06:07 +0100 (CET)
Date:   Mon, 6 Feb 2023 17:06:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     ming.lei@redhat.com, Christoph Hellwig <hch@lst.de>,
        axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, jack@suse.cz
Subject: Re: [PATCH v4 12/14] blk-mq: remove set of bd->last when get
 driver tag for next request fails
Message-ID: <20230206160607.GA15025@lst.de>
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com> <20230118093726.3939160-12-shikemeng@huaweicloud.com> <20230118174208.GH12399@lst.de> <1f116b9b-8194-54c8-eedb-7f2c9cd493c6@huaweicloud.com> <0526b518-0894-10f6-e428-c03644d39c02@huaweicloud.com> <119aeade-151b-e375-f89b-20956bd9f3fb@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <119aeade-151b-e375-f89b-20956bd9f3fb@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 06, 2023 at 09:05:25AM +0800, Kemeng Shi wrote:
> Could anyone please help review the last two patches without reviewed-by.

I'm still not really convinved of this one patch.

The rest of the series looks like great small cleanups, but this one
isn't quite as trivial.   Maybe you can split it from the series and
resend it with a more detailed and better explanation for the next
merge window?
