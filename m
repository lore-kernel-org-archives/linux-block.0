Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFADEB64D9
	for <linux-block@archiver.kernel.org>; Tue, 27 Jun 2023 04:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjF0E7a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jun 2023 00:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjF0E7a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2023 00:59:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F001729;
        Mon, 26 Jun 2023 21:59:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F126A6732D; Tue, 27 Jun 2023 06:59:24 +0200 (CEST)
Date:   Tue, 27 Jun 2023 06:59:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Min Li <min15.li@samsung.com>, axboe@kernel.dk,
        willy@infradead.org, hch@lst.de, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: add check that partition length needs to be
 aligned with block size
Message-ID: <20230627045924.GA16913@lst.de>
References: <CGME20230627031105epcas5p3010432ebd447ad865c3ddd986b3ffee0@epcas5p3.samsung.com> <20230627110918.7608-1-min15.li@samsung.com> <8ea3bdfb-f2d9-ee5e-f623-02b2b134490d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ea3bdfb-f2d9-ee5e-f623-02b2b134490d@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 27, 2023 at 01:39:26PM +0900, Damien Le Moal wrote:
> See Greg's comment: this likely need a "Fixes:" tag. And I think that the tag
> is: fa9156ae597c ("block: refactor blkpg_ioctl"). But please double check.

No, the lack of checks goes back all the way to when this code was
added long before git was a thing.  So I don't think a Fixes tag makes
all that much sense here.
