Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D80C05027
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 05:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjBIFEH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 00:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBIFEH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 00:04:07 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54201BAE1
        for <linux-block@vger.kernel.org>; Wed,  8 Feb 2023 21:04:04 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7749667373; Thu,  9 Feb 2023 06:04:01 +0100 (CET)
Date:   Thu, 9 Feb 2023 06:04:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: delay calling blkcg_exit_disk until
 disk_release
Message-ID: <20230209050401.GA8235@lst.de>
References: <20230208063514.171485-1-hch@lst.de> <Y+NRgI+99Gz33BvQ@T590> <20230208151231.GA16018@lst.de> <Y+Q0mp1cV3Ca6bAf@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Q0mp1cV3Ca6bAf@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 09, 2023 at 07:47:38AM +0800, Ming Lei wrote:
> Another thing is that blkcg_init_disk() and blkcg_exit_disk() becomes
> asymmetrical with this patch. So alloc_disk() & add_disk(), del_disk() & put_disk()
> have to be done together. If it may be documented, this patch looks
> fine.

As in no add_disk is allowed after del_gendisk on the same disk?
It's been like that since basically forever.  I agree that documenting
it probably doesn't hurt though - but that's separate from this fix.
