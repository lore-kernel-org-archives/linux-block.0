Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE1CC19F28
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 15:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiG0PwJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 11:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiG0PwJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 11:52:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6342610E
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 08:52:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D405668AA6; Wed, 27 Jul 2022 17:52:02 +0200 (CEST)
Date:   Wed, 27 Jul 2022 17:52:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/6] block: change the blk_queue_split calling
 convention
Message-ID: <20220727155202.GA18260@lst.de>
References: <20220726183029.2950008-1-hch@lst.de> <20220726183029.2950008-2-hch@lst.de> <219efcde-fbdb-d379-5c14-874490f8c886@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <219efcde-fbdb-d379-5c14-874490f8c886@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 27, 2022 at 08:26:13AM +0900, Damien Le Moal wrote:
> >  		/* there isn't chance to merge the splitted bio */
> >  		split->bi_opf |= REQ_NOMERGE;
> >  
> > -		blkcg_bio_issue_init(split);
> 
> Is removing this init call intentional ? If yes, isn't that a problem ?

No.  This was actually added back in the drivers-post tree by
"block: fix missing blkcg_bio_issue_init" and I messed up the rebase.

Jens, do you want me to send a fixup, or are you going to do it locally?
