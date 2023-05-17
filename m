Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BB2C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 07:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjEQHlZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 03:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjEQHlS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 03:41:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E22B1999
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 00:41:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3026B2020D;
        Wed, 17 May 2023 07:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684309275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CG9JXcnAkRpRasCMMccY8LUKb5sJeH8TjKysa6zydlQ=;
        b=kv6ZI7WPIHrUry22kYATSj3Y11zZUE5I7LwcAumyAqgssCHiA1yJTo2ptEakYfDf13fXK7
        HwOJ+utAzSUz452l0L3HwzFPUBDQJQPoOWYGhmSaQZwEmsqgckcKH3zo/Wyb8fRSVmwwEe
        2wbMn5WD4PHmIOCODzL7IkjOlPGpoQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684309275;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CG9JXcnAkRpRasCMMccY8LUKb5sJeH8TjKysa6zydlQ=;
        b=7UXD4RSDKzbhcgTbqwFIBKLxa6AxuqdIFiF+xnS/n+6PMRmuiLZhsSvl3aDtttS8+yk4fD
        c/K2C0RISzbmoDCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 980DB13358;
        Wed, 17 May 2023 07:41:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pLyPIxqFZGTnEwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 17 May 2023 07:41:14 +0000
Message-ID: <2471f31c-763f-1935-ec32-c32447c9379e@suse.de>
Date:   Wed, 17 May 2023 09:41:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 07/11] block: mq-deadline: Improve
 deadline_skip_seq_writes()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-8-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230516223323.1383342-8-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 00:33, Bart Van Assche wrote:
> Make deadline_skip_seq_writes() do what its name suggests, namely to
> skip sequential writes.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 6276afede9cd..dbc0feca963e 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -308,7 +308,7 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
>   	do {
>   		pos += blk_rq_sectors(rq);
>   		rq = deadline_latter_request(rq);
> -	} while (rq && blk_rq_pos(rq) == pos);
> +	} while (rq && blk_rq_pos(rq) == pos && blk_rq_is_seq_zoned_write(rq));
>   
>   	return rq;
>   }

Please merge it with the previous patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

