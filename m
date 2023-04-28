Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35021C77B60
	for <linux-block@archiver.kernel.org>; Fri, 28 Apr 2023 05:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345142AbjD1F60 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Apr 2023 01:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345220AbjD1F6Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2023 01:58:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C53B3C3D
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 22:58:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CB7A68D0A; Fri, 28 Apr 2023 07:58:18 +0200 (CEST)
Date:   Fri, 28 Apr 2023 07:58:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 9/9] block: mq-deadline: Fix handling of at-head
 zoned writes
Message-ID: <20230428055818.GJ8549@lst.de>
References: <20230424203329.2369688-1-bvanassche@acm.org> <20230424203329.2369688-10-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424203329.2369688-10-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  	/*
>  	 * Look for a write request that can be dispatched, that is one with
> +	 * an unlocked target zone. For each write request from the FIFO list,
> +	 * check whether an earlier write request exists in the RB tree.

I can see that you are checking the RB tree, so the comment is a bit
useless.  It should explain why.  And preferably right next to the code
instead of hidden in this long and fairly hard to read above the loop
comment.
