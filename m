Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDE0C54EBE
	for <linux-block@archiver.kernel.org>; Sun,  8 Jan 2023 18:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjAHSGS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Jan 2023 13:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjAHSGR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Jan 2023 13:06:17 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AA418B;
        Sun,  8 Jan 2023 10:06:15 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E33EA68AA6; Sun,  8 Jan 2023 19:06:11 +0100 (CET)
Date:   Sun, 8 Jan 2023 19:06:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, john.garry@huawei.com,
        jack@suse.cz
Subject: Re: [PATCH v2 08/13] blk-mq: simplify flush check in
 blk_mq_dispatch_rq_list
Message-ID: <20230108180611.GG23466@lst.de>
References: <20230104142259.2673013-1-shikemeng@huaweicloud.com> <20230104142259.2673013-9-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104142259.2673013-9-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I think we need to come up with a clear rule on when commit_rqs
needs to be called, and follow that.  In this case I'd be confused
if there was any case where we need to call it if list was empty.
