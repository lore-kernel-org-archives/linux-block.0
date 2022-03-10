Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D79AC433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 12:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiCJMEu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 07:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiCJMEu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 07:04:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9835813F9B;
        Thu, 10 Mar 2022 04:03:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3653861709;
        Thu, 10 Mar 2022 12:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49828C340E8;
        Thu, 10 Mar 2022 12:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646913827;
        bh=NfICtKlhZL/pMZsaGdp5C1Kw7skOJL1B0NVOs+Q11Wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGvOLeGtrSZGReY8A+RY7A8L8uExwew5D50e8BJ6R8bcAf4KfsSwC6EqING9AC+Uo
         v8G5Sl5eHvZlqWP6Td4u0yBkrBCZGFE3H93RfQPd0OdPZoW4U0PMV2qOskbHyrJN0i
         5FQ0pUkXfzBOoSxrLt/sVDSE3LrbOS5aLK48UL+U=
Date:   Thu, 10 Mar 2022 13:03:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin Kleibel <valentin@vrvis.at>
Cc:     stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Justin Sanders <justin@coraid.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: aoe: fix page fault in freedev()
Message-ID: <YinpIKY0HVlJ+TLR@kroah.com>
References: <c274db07-9c7d-d857-33ad-4a762819bcdd@vrvis.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c274db07-9c7d-d857-33ad-4a762819bcdd@vrvis.at>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 10, 2022 at 12:53:01PM +0100, Valentin Kleibel wrote:
> There is a bug in the aoe driver module where every forcible removal of an
> aoe device (eg. "rmmod aoe" with aoe devices available or "aoe-flush ex.x")
> leads to a page fault.
> The code in freedev() calls blk_mq_free_tag_set() before running
> blk_cleanup_queue() which leads to this issue (drivers/block/aoe/aoedev.c
> L281ff).
> This issue was fixed upstream in commit 6560ec9 (aoe: use blk_mq_alloc_disk
> and blk_cleanup_disk) with the introduction and use of the function
> blk_cleanup_disk().
> 
> This patch applies to kernels 5.4 and 5.10.

We need a fix for Linus's tree first before we can backport anything to
older kernels.  Does this also work there?

> 
> The function calls are reordered to match the behavior of blk_cleanup_disk()
> to mitigate this issue.
> 
> Fixes: 3582dd2 (aoe: convert aoeblk to blk-mq)

A few more digits in the sha1 here would be good, otherwise our tools
will complain.  It should look like:
Fixes: 3582dd291788 ("aoe: convert aoeblk to blk-mq")

thanks,

greg k-h
