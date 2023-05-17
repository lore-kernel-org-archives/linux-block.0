Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3905C7EE2A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 07:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjEQHhX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 03:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjEQHgs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 03:36:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEDC10EC
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 00:36:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CBFF320474;
        Wed, 17 May 2023 07:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684309004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FzfOM1qUWbzC0KrrALHQS8WLOOIn2ZW2iRP7eqIxJ3I=;
        b=gzG7f5ONK+OWH30coMueRY95WLVzHvudTrgLRhXdvPkSo6j3BcF5R2fs3f+D4vU4Q/x1Xj
        aqYkIs/5cUbCK852pUMZKbyU2EMZc7Qpm4foSly+CBriKuXJXny1KzwFNZOG7VKwVKlnXv
        g8kECj5rpyQ9xkh7K6kkpKdphNjsqvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684309004;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FzfOM1qUWbzC0KrrALHQS8WLOOIn2ZW2iRP7eqIxJ3I=;
        b=IC8YIPMw/hsbJLXnrnKyjSiirAlu7sarAtXQmZfNsicL/Hd8roL29DOBubSIaioYDFtCRQ
        DmzuBGujWLf5KqAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EE9A13358;
        Wed, 17 May 2023 07:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ecQjGQyEZGSGEQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 17 May 2023 07:36:44 +0000
Message-ID: <bbe559b6-f993-ba3e-cf91-b0cfd1aad514@suse.de>
Date:   Wed, 17 May 2023 09:36:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 01/11] block: Simplify blk_req_needs_zone_write_lock()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-2-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230516223323.1383342-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 00:33, Bart Van Assche wrote:
> Remove the blk_rq_is_passthrough() check because it is redundant:
> blk_req_needs_zone_write_lock() also calls bdev_op_is_zoned_write()
> and the latter function returns false for pass-through requests.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-zoned.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index fce9082384d6..835d9e937d4d 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -57,9 +57,6 @@ EXPORT_SYMBOL_GPL(blk_zone_cond_str);
>    */
>   bool blk_req_needs_zone_write_lock(struct request *rq)
>   {
> -	if (blk_rq_is_passthrough(rq))
> -		return false;
> -
>   	if (!rq->q->disk->seq_zones_wlock)
>   		return false;
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

