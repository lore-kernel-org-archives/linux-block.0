Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EF1C77B7A
	for <linux-block@archiver.kernel.org>; Wed,  7 Jun 2023 05:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjFGFdP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jun 2023 01:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjFGFdO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 01:33:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4798F1989
        for <linux-block@vger.kernel.org>; Tue,  6 Jun 2023 22:33:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E78C368AA6; Wed,  7 Jun 2023 07:33:08 +0200 (CEST)
Date:   Wed, 7 Jun 2023 07:33:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: enforce read-only state at the block layer
Message-ID: <20230607053308.GA20390@lst.de>
References: <20230601072829.1258286-1-hch@lst.de> <ZH9alEbuNxHNwYYe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH9alEbuNxHNwYYe@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Not sure of a crafty hack to workaround. Hopefully 5 year old lvm2
> remains tightly coupled to kernels of the same vintage and we get
> lucky moving forward.
> 
> So I agree with Linus, worth trying this simple change again and
> seeing if there is fallout. Revert/worry about it again as needed.

I'm actually looking into implementing Linus' suggestion now and
track in the block_device if it has ever been opened for writing.
