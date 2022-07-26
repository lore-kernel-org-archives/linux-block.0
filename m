Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D27C43334
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 11:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiGZLFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 07:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiGZLFP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 07:05:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72916367
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 04:05:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A709668AA6; Tue, 26 Jul 2022 13:05:11 +0200 (CEST)
Date:   Tue, 26 Jul 2022 13:05:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: bio splitting cleanups v2
Message-ID: <20220726110511.GB30558@lst.de>
References: <20220723062816.2210784-1-hch@lst.de> <155c447e-9e4d-8e07-0810-c58973d65bae@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155c447e-9e4d-8e07-0810-c58973d65bae@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 25, 2022 at 05:06:19PM -0600, Jens Axboe wrote:
> Since this clashes with opf changes from Bart, would you mind spinning
> them against the for-5.20/drivers-post branch?

Actually.  The conflict seems to be that for-5.20/drivers-post still
has the blkcg_bio_issue_init in __blk_queue_split that went away
in for-5.20/block.  So while I can resend against drivers-post, that
seems somewhat counterproductive.
