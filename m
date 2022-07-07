Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B204C43334
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 05:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiGGFYc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 01:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGGFYb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 01:24:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF682F3AB
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 22:24:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6693368AA6; Thu,  7 Jul 2022 07:24:26 +0200 (CEST)
Date:   Thu, 7 Jul 2022 07:24:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 7/8] dm: delay registering the gendisk
Message-ID: <20220707052425.GA13016@lst.de>
References: <20210804094147.459763-1-hch@lst.de> <20210804094147.459763-8-hch@lst.de> <ad2c7878-dabb-cb41-1bba-60ef48fa1a9f@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2c7878-dabb-cb41-1bba-60ef48fa1a9f@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 07, 2022 at 11:29:26AM +0800, Yu Kuai wrote:
> We found that this patch fix a nullptr crash in our test:

> Do you think it's ok to backport this patch(and all realted patches) to
> lts, or it's better to fix that bio can be submitted with queue
> uninitialized from block layer?

Given how long ago this was I do not remember offhand how much prep
work this would require.  The patch itself is of course tiny and
backportable, but someone will need to do the work and figure out how
much else would have to be backported.
