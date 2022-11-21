Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A84DC4332F
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 13:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKUNTI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 08:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiKUNTH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 08:19:07 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA35575D86
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 05:19:06 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5853B68CFE; Mon, 21 Nov 2022 14:19:03 +0100 (CET)
Date:   Mon, 21 Nov 2022 14:19:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kch@nvidia.com" <kch@nvidia.com>
Subject: Re: [PATCH 2/2] blk-mq: simplify blk_mq_realloc_tag_set_tags
Message-ID: <20221121131903.GA15981@lst.de>
References: <20221109100811.2413423-1-hch@lst.de> <20221109100811.2413423-2-hch@lst.de> <20221118140640.featvt3fxktfquwh@shindev> <20221121075857.GA24878@lst.de> <20221121111442.qxyqtsac2bhzhyjd@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121111442.qxyqtsac2bhzhyjd@shindev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 21, 2022 at 11:14:44AM +0000, Shinichiro Kawasaki wrote:
> Thanks, this fix is the better. And I reconfirmed it avoids the block/029 and
> block/030 failures.
> 
> I guess it is too late for Jens to fold-in this fix in the for-next branch.
> Christoph, would you prepare a formal fix patch? Or if it helps, I can send out
> the patch with your authorship and SoB tag (with Co-developed-by tag of mine).

I can send the patch.  But I'd also be perfectly happy with you
sending it as the auther, as my version is just a tiny incremental
cleanup.
