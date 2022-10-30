Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828EDFA373D
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 07:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJ3HpT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 03:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3HpS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 03:45:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718FDCD5
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 00:45:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7236968AA6; Sun, 30 Oct 2022 08:45:15 +0100 (CET)
Date:   Sun, 30 Oct 2022 08:45:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [bug?] blk_queue_may_bounce() has the comparison max_low_pfn
 and max_pfn wrong way
Message-ID: <20221030074514.GA4214@lst.de>
References: <Y1wZTtENDq3fvs6n@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wZTtENDq3fvs6n@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 28, 2022 at 07:02:54PM +0100, Al Viro wrote:
> Now, the last term in expression in blk_queue_may_bounce() is
> true only on the boxen where max_pfn is no greater than max_low_pfn.
> 
> Unless I'm very confused, that's the boxen where we don't *have*
> any highmem pages.

Yes, this go mixed up.
