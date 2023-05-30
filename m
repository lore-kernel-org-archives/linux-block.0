Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EC1C7EE23
	for <linux-block@archiver.kernel.org>; Tue, 30 May 2023 06:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjE3GQB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 May 2023 02:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjE3GQB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2023 02:16:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5680B0
        for <linux-block@vger.kernel.org>; Mon, 29 May 2023 23:15:59 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 77E001F889;
        Tue, 30 May 2023 06:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685427358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Trpzp5YNsnPBrD2WUadSL3WQehtnvEgj8Z2n4SMYbtk=;
        b=kLQ6FjXu9/AypTb4ufFKVjcLEBG5/R1Gf71ocusSlE9uSldMFiWsgsW6FTV02uBC2NUcKX
        wjMIgZgsxqEZ+8SxtXPcy0SomEHW2NecEJ+/8xPA7PUprIZ/cIyJO1ZKFWmULitiVkDN3S
        7BHWlvUFiMoyVDjVpQSCwSKgz2knbZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685427358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Trpzp5YNsnPBrD2WUadSL3WQehtnvEgj8Z2n4SMYbtk=;
        b=ruoIb8KtGnexCcP22ii1FlvekZ5Bhk9atC93hZ81N2hkinIbVTUKErnWMPSZW8VgQjqEQt
        R0XDS1SIixrdInDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 557E91342F;
        Tue, 30 May 2023 06:15:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id gbxRE56UdWT0ZQAAGKfGzw
        (envelope-from <hare@suse.de>); Tue, 30 May 2023 06:15:58 +0000
Message-ID: <0ad655ee-d658-0a98-846c-62fe581335a2@suse.de>
Date:   Tue, 30 May 2023 08:15:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] block: fix revalidate performance regression
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     Brian Bunker <brian@purestorage.com>
References: <20230529023836.1209558-1-dlemoal@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230529023836.1209558-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/29/23 04:38, Damien Le Moal wrote:
> The scsi driver function sd_read_block_characteristics() always calls
> disk_set_zoned() to a disk zoned model correctly, in case the device
> model changed. This is done even for regular disks to set the zoned
> model to BLK_ZONED_NONE and free any zone related resources if the drive
> previously was zoned.
> 
> This behavior significantly impact the time it takes to revalidate disks
> on a large system as the call to disk_clear_zone_settings() done from
> disk_set_zoned() for the BLK_ZONED_NONE case results in the device
> request queued to be quiesced, even if there is no zone resource to
> free.
> 
> Avoid this overhead for non zoned devices by not calling
> disk_clear_zone_settings() in disk_set_zoned() if the device model
> already was set to BLK_ZONED_NONE.
> 
> Reported by: Brian Bunker <brian@purestorage.com>
> Fixes: 508aebb80527 ("block: introduce blk_queue_clear_zone_settings()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-settings.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 896b4654ab00..4dd59059b788 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -915,6 +915,7 @@ static bool disk_has_partitions(struct gendisk *disk)
>   void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
>   {
>   	struct request_queue *q = disk->queue;
> +	unsigned int old_model = q->limits.zoned;
>   
>   	switch (model) {
>   	case BLK_ZONED_HM:
> @@ -952,7 +953,7 @@ void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
>   		 */
>   		blk_queue_zone_write_granularity(q,
>   						queue_logical_block_size(q));
> -	} else {
> +	} else if (old_model != BLK_ZONED_NONE) {
>   		disk_clear_zone_settings(disk);
>   	}
>   }
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

