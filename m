Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769E4C4167B
	for <linux-block@archiver.kernel.org>; Tue, 27 Dec 2022 16:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiL0QyP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Dec 2022 11:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiL0Qxp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2022 11:53:45 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB576B03
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 08:53:43 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 19E7F6732D; Tue, 27 Dec 2022 17:53:40 +0100 (CET)
Date:   Tue, 27 Dec 2022 17:53:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com
Subject: Re: [PATCH] block: save user max_sectors limit
Message-ID: <20221227165339.GA7682@lst.de>
References: <20221222175204.1782061-1-kbusch@meta.com> <20221223060009.GA3088@lst.de> <Y6siCw6JFqTpsObx@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6siCw6JFqTpsObx@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 27, 2022 at 09:49:15AM -0700, Keith Busch wrote:
> > and drop the min_t here.  Instead of working around type mismatches
> > just avoid them from the beginning..
> 
> Let me just make sure I understand: you don't want BLK_DEF_MAX_SECTORS
> defined in an enum, and instead want it a 'const unsigned int'? Or
> #define?

Just make sure it's marked as unsigned, either and enum or define
works, just make sure it has the u suffix.  Note that for enums recent
gccs enforce the same type over different embers, so you might have
to split it from an existing catchall enum into a separate one.
