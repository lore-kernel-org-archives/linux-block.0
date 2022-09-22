Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BACBC54EE9
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 12:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiIVMKp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 08:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIVMKk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 08:10:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A3C9A9E3
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 05:10:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 24FAB219FE;
        Thu, 22 Sep 2022 12:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663848638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJxACNSw1ZRXgzqAyqDIOqjNjtXxGbCyLrKX6NKj90g=;
        b=Sl4WumscCuxCY+ixrIOZE4lZjgcpnJqcbYSo3MpeGRaUoyymfLlsAzLV0EDwXY2oPNWlhV
        AyqZr5hi41PSlINU+pW/dy5oRdVcxMhinlHCli5CCo7lNsbAycdh5hu97p7WGdNtuZP9QO
        9WGUNkPDT5CMv2bMztPQ9kWjftbpLdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663848638;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJxACNSw1ZRXgzqAyqDIOqjNjtXxGbCyLrKX6NKj90g=;
        b=GuLiPbkN+EuK2qq5seFQznyKyyZ9lMQSvopwWpIT7KgewxHQMTq9OsP66kLLRYcOgFFGCu
        g9/hYtqTEX+Rd4Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F257E13AA5;
        Thu, 22 Sep 2022 12:10:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rH3HOb1QLGMtUAAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 22 Sep 2022 12:10:37 +0000
Date:   Thu, 22 Sep 2022 14:10:36 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 09/17] blk-iocost: simplify ioc_name
Message-ID: <YyxQvLwyg84tCFvm@suselix>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220921180501.1539876-10-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:53PM +0200, Christoph Hellwig wrote:
> Just directly dereference the disk name instead of going through multiple
> hoops to find the same value.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-iocost.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 7936e5f5821c7..cba9d3ad58e16 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -664,17 +664,13 @@ static struct ioc *q_to_ioc(struct request_queue *q)
>  	return rqos_to_ioc(rq_qos_id(q, RQ_QOS_COST));
>  }
>  
> -static const char *q_name(struct request_queue *q)
> -{
> -	if (blk_queue_registered(q))
> -		return kobject_name(q->kobj.parent);
> -	else
> -		return "<unknown>";
> -}
> -
>  static const char __maybe_unused *ioc_name(struct ioc *ioc)
>  {
> -	return q_name(ioc->rqos.q);
> +	struct gendisk *disk = ioc->rqos.q->disk;
> +
> +	if (!disk)
> +		return "<unknown>";
> +	return disk->disk_name;
>  }
>  
>  static struct ioc_gq *pd_to_iocg(struct blkg_policy_data *pd)
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
