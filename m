Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AA2C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 07:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjEQHh0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 03:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjEQHhW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 03:37:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45374DA
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 00:37:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E62CC228D8;
        Wed, 17 May 2023 07:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684309039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bbhE9GJQOzE0iI7LlAW6X4OB68+t/GJc1UuKThaOF/k=;
        b=haTTee2TRcJNEVBT4jnyRY3zNK9aUmXzkXdCdIyQQKQvJ14nwOFhT4k9uNi/P5RuBGVfJh
        NdAGi+Z3cryGl6R0e3EmJyyAXxydacCXLJwwY0odcgIBwKK7jQhVUx9Aah7b7eIvtfQTce
        jcMaAdSOBK1+IqomGzHfgp16Xj1so08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684309039;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bbhE9GJQOzE0iI7LlAW6X4OB68+t/GJc1UuKThaOF/k=;
        b=8St2MdQK0Jh2sM6RZ/in2Kq0PmLF3U+M6w70g9gGklTlJZ9PJRusdJOGWrjrWJao4XcO5o
        dQ0EUaWWTFZeReAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A98413358;
        Wed, 17 May 2023 07:37:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XGQiHy+EZGTYEQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 17 May 2023 07:37:19 +0000
Message-ID: <3f2ea039-ef84-098e-fdcd-72d11f6ccdd4@suse.de>
Date:   Wed, 17 May 2023 09:37:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 02/11] block: Fix the type of the second
 bdev_op_is_zoned_write() argument
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-3-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230516223323.1383342-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 00:33, Bart Van Assche wrote:
> Change the type of the second argument of bdev_op_is_zoned_write() from
> blk_opf_t into enum req_op because this function expects an operation
> without flags as second argument.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Fixes: 8cafdb5ab94c ("block: adapt blk_mq_plug() to not plug for writes that require a zone lock")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   include/linux/blkdev.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b441e633f4dd..db24cf98ccfb 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1282,7 +1282,7 @@ static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
>   }
>   
>   static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
> -					  blk_opf_t op)
> +					  enum req_op op)
>   {
>   	if (!bdev_is_zoned(bdev))
>   		return false;

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

