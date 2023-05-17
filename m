Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05B7C77B75
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 07:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjEQHiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 03:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjEQHh6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 03:37:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0CCE67
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 00:37:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C66A228D8;
        Wed, 17 May 2023 07:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684309070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3knXjnp/oCJLXwglMQ9KOHwVVO10JfceHNOcamTibQ=;
        b=kZYA0xhzx2bWxtjZSRdOgdM1eJNsDxTGQq3TiOQvmC062+pvnzqWYfNILei1lUByUne1l0
        ApFOs7hO63HT8Clvxm03yGzQmrNtYU7vHVCCophPaPabEJTqXgSD1DatoiRhPKp1yxncg8
        u486fY4FNjvnq/wGlks3U7KCAEj4MYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684309070;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3knXjnp/oCJLXwglMQ9KOHwVVO10JfceHNOcamTibQ=;
        b=t/xC0Rar1llvkR/Xwh0SPEUS/fgdaYvXDDyf6XJ6Hn4Va9GcdRpsxC8DWEO3MKLWNq/Mgf
        1jPYWFnyqTtBb3Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0412113358;
        Wed, 17 May 2023 07:37:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5ssYOk2EZGQTEgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 17 May 2023 07:37:49 +0000
Message-ID: <d281c975-9169-0f04-d411-43836fd53299@suse.de>
Date:   Wed, 17 May 2023 09:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 03/11] block: Introduce op_is_zoned_write()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-4-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230516223323.1383342-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 00:33, Bart Van Assche wrote:
> Introduce a helper function for checking whether write serialization is
> required if the operation will be sent to a zoned device. A second caller
> for op_is_zoned_write() will be introduced in the next patch in this
> series.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   include/linux/blkdev.h | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index db24cf98ccfb..a4f85781060c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1281,13 +1281,16 @@ static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
>   	return disk_zone_no(bdev->bd_disk, sec);
>   }
>   
> +/* Whether write serialization is required for @op on zoned devices. */
> +static inline bool op_is_zoned_write(enum req_op op)
> +{
> +	return op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES;
> +}
> +
>   static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
>   					  enum req_op op)
>   {
> -	if (!bdev_is_zoned(bdev))
> -		return false;
> -
> -	return op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES;
> +	return bdev_is_zoned(bdev) && op_is_zoned_write(op);
>   }
>   
>   static inline sector_t bdev_zone_sectors(struct block_device *bdev)

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

