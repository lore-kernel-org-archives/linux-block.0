Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E732DC77B73
	for <linux-block@archiver.kernel.org>; Mon,  1 May 2023 04:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjEAEhq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 May 2023 00:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjEAEhp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 00:37:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4CC10C4
        for <linux-block@vger.kernel.org>; Sun, 30 Apr 2023 21:37:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8B61268B05; Mon,  1 May 2023 06:37:40 +0200 (CEST)
Date:   Mon, 1 May 2023 06:37:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 8/9] block: mq-deadline: Handle requeued requests
 correctly
Message-ID: <20230501043740.GC19847@lst.de>
References: <20230424203329.2369688-1-bvanassche@acm.org> <20230424203329.2369688-9-bvanassche@acm.org> <20230428055443.GI8549@lst.de> <05a7d0cb-44c9-cb2f-12c2-957123e031d5@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a7d0cb-44c9-cb2f-12c2-957123e031d5@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 28, 2023 at 10:03:45AM -0700, Bart Van Assche wrote:
> Because the blk_rq_zone_no() definition is surrounded with #ifdef 
> CONFIG_BLK_DEV_ZONED / #endif. Without the #ifdef the above code would 
> trigger a compilation error with CONFIG_BLK_DEV_ZONED=n. I have considered 
> to add a definition of blk_rq_zone_no() for CONFIG_BLK_DEV_ZONED=n. I 
> prefer not to do this because I think it's better to cause a compiler error 
> if blk_rq_zone_no() is used in code that is also used for the 
> CONFIG_BLK_DEV_ZONED=n case.

Ok.
