Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EFEC77B7A
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 06:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjEXGOB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 02:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjEXGOA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 02:14:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32294132
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 23:13:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9E94F68CFE; Wed, 24 May 2023 08:13:56 +0200 (CEST)
Date:   Wed, 24 May 2023 08:13:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 4/7] block: Make it easier to debug zoned write
 reordering
Message-ID: <20230524061356.GE19611@lst.de>
References: <20230522183845.354920-1-bvanassche@acm.org> <20230522183845.354920-5-bvanassche@acm.org> <20230523071957.GD8758@lst.de> <41dd1a93-2491-a094-dc61-f424b51af6cb@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41dd1a93-2491-a094-dc61-f424b51af6cb@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 12:34:38PM -0700, Bart Van Assche wrote:
>> What makes sequential writes here special vs other requests that are
>> supposed to be using the scheduler and not a bypass?
>
> Hi Christoph,
>
> If some REQ_OP_WRITE or REQ_OP_WRITE_ZEROES requests are submitted to the 
> I/O scheduler and others bypass the I/O scheduler this may lead to 
> reordering. Hence this patch that triggers a kernel warning if any 
> REQ_OP_WRITE or REQ_OP_WRITE_ZEROES requests bypass the I/O scheduler.

But why would we ever do a direct insert when using a scheduler for
write (an read for that matter) commands when not on a zoned device?
