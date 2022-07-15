Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE0BC433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 09:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiGOJjv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 05:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiGOJju (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 05:39:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2339B491DC
        for <linux-block@vger.kernel.org>; Fri, 15 Jul 2022 02:39:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3563A34305;
        Fri, 15 Jul 2022 09:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657877987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q2QiUb7I9eQPDspNjvCZBP0NklIhtjmPamqc2ASCF6Q=;
        b=w36bwmyRqhYkLQ7jC3k4RelqyEZDDYroNk6XUNJuhniaYVGgsP7+jiiTHvQspYwSNrWsu5
        oKU41TswTkQZJUe+AkTGffKCjqo781ODW4TlK21hHCOeFQERjIbz+vKwodp6K8bht45kwZ
        yx3S/jQF0Iuy75bcOuMsspdzDE9br7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657877987;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q2QiUb7I9eQPDspNjvCZBP0NklIhtjmPamqc2ASCF6Q=;
        b=//3tGYLsJMKTogGuUueAfy80L8ScTnauOEVmD6pHSC1mcHaDn5OGvqCJc1UfGq6ZLutx4e
        xWO70FLs1LNIacBQ==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 18D452C146;
        Fri, 15 Jul 2022 09:39:47 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BF6EEA0657; Fri, 15 Jul 2022 11:39:46 +0200 (CEST)
Date:   Fri, 15 Jul 2022 11:39:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Stefan Roesch <shr@fb.com>,
        NeilBrown <neilb@suse.de>
Subject: Re: [PATCH v3 45/63] mm: Use the new blk_opf_t type
Message-ID: <20220715093946.yxn57vdmrrmsbwvt@quack3>
References: <20220714180729.1065367-1-bvanassche@acm.org>
 <20220714180729.1065367-46-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714180729.1065367-46-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 14-07-22 11:07:11, Bart Van Assche wrote:
> Improve static type checking by using the new blk_opf_t type for block
> layer request flags.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Stefan Roesch <shr@fb.com>
> Cc: NeilBrown <neilb@suse.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/writeback.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index da21d63f70e2..e91bea371b18 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -101,9 +101,9 @@ struct writeback_control {
>  #endif
>  };
>  
> -static inline int wbc_to_write_flags(struct writeback_control *wbc)
> +static inline blk_opf_t wbc_to_write_flags(struct writeback_control *wbc)
>  {
> -	int flags = 0;
> +	blk_opf_t flags = 0;
>  
>  	if (wbc->punt_to_cgroup)
>  		flags = REQ_CGROUP_PUNT;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
