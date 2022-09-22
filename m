Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D89C6FA82
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 13:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiIVNAg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiIVNAf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 09:00:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD3282856
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 06:00:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1362F1F8A4;
        Thu, 22 Sep 2022 13:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663851632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=miLCrBcrINct/aPXfS458YnHtv7le+AZFlll2tqwd3M=;
        b=olNYCta/7+NGfxRg4nHNBeDTf1WPZhVW8DCJ9zkZ/PHmtW/jJ8yryJ/mtl584xrBnTw8nM
        V3AZs3IlvGU5+1+LUf0SOBZpKYaL0ZurTFkdwLM9YKF+DruG5LfioYS6n4H6SJy8xp3ZxM
        gxBYsF75QKj4iSzIs4ZRuUND+q6QcT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663851632;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=miLCrBcrINct/aPXfS458YnHtv7le+AZFlll2tqwd3M=;
        b=tAFaajoB0vFd8LZsnVaTXUKierZJW1T8yb01GKyPXRgn+RlhzJnZN0KB362t/1pjP+WiBI
        GVtwPPq9H4gdDvDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1A9F1346B;
        Thu, 22 Sep 2022 13:00:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gFS8NW9cLGMpaQAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 22 Sep 2022 13:00:31 +0000
Date:   Thu, 22 Sep 2022 15:00:30 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 01/17] blk-cgroup: fix error unwinding in blkcg_init_queue
Message-ID: <YyxcbpJqKeQfDo9O@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:45PM +0200, Christoph Hellwig wrote:
> When blk_throtl_init fails, we need to call blk_ioprio_exit.  Switch to
> proper goto based unwinding to fix this.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 869af9d72bcf8..3a88f8c011d27 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1297,17 +1297,18 @@ int blkcg_init_queue(struct request_queue *q)
>  
>  	ret = blk_throtl_init(q);
>  	if (ret)
> -		goto err_destroy_all;
> +		goto err_ioprio_exit;
>  
>  	ret = blk_iolatency_init(q);
> -	if (ret) {
> -		blk_throtl_exit(q);
> -		blk_ioprio_exit(q);
> -		goto err_destroy_all;
> -	}
> +	if (ret)
> +		goto err_throtl_exit;
>  
>  	return 0;
>  
> +err_throtl_exit:
> +	blk_throtl_exit(q);
> +err_ioprio_exit:
> +	blk_ioprio_exit(q);
>  err_destroy_all:
>  	blkg_destroy_all(q);
>  	return ret;
> -- 
> 2.30.2
> 

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
