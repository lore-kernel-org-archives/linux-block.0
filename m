Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B11EC77B75
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 04:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjEPED4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 00:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEPED4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 00:03:56 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCA7E2
        for <linux-block@vger.kernel.org>; Mon, 15 May 2023 21:03:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3B61667373; Tue, 16 May 2023 06:03:51 +0200 (CEST)
Date:   Tue, 16 May 2023 06:03:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: RFC: less special casing for flush requests
Message-ID: <20230516040351.GB5624@lst.de>
References: <20230416200930.29542-1-hch@lst.de> <2dca2b99-612e-97f7-32de-9713ac1891f4@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dca2b99-612e-97f7-32de-9713ac1891f4@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 15, 2023 at 05:08:27PM -0700, Bart Van Assche wrote:
> Do you have the time to continue the work on this patch series? Please let 
> me know in case you would prefer that I continue the work on this patch 
> series. I just found and fixed a bug in my patch "block: Send FUA requests 
> to the I/O scheduler" (not included in this series).

I did another pass last weekend and was planning to finish it off today.
