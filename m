Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE06C433EF
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 05:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242657AbiCYFgs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 01:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbiCYFgr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 01:36:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF06C55AF
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 22:35:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6795168B05; Fri, 25 Mar 2022 06:35:10 +0100 (CET)
Date:   Fri, 25 Mar 2022 06:35:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 2/3] block: allow use of per-cpu bio alloc cache by
 block drivers
Message-ID: <20220325053510.GA5327@lst.de>
References: <20220324203526.62306-1-snitzer@kernel.org> <20220324203526.62306-3-snitzer@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324203526.62306-3-snitzer@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 24, 2022 at 04:35:25PM -0400, Mike Snitzer wrote:
> Refine per-cpu bio alloc cache interfaces so that DM and other block
> drivers can properly create and use the cache:
> 
> DM uses bioset_init_from_src() to do its final bioset initialization,
> so must update bioset_init_from_src() to set BIOSET_PERCPU_CACHE if
> %src bioset has a cache.
> 
> Also move bio_clear_polled() to include/linux/bio.h to allow users
> outside of block core.
> 
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
