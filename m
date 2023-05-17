Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEE6C77B7F
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 07:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjEQHkz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 03:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjEQHkx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 03:40:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170632D4D
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 00:40:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BFC5E20508;
        Wed, 17 May 2023 07:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684309240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D3zl4ZBa9gynw9Gj0QHzusYDzIRww4g7tO6q0e6b3LQ=;
        b=nPYhJjReILu5AQF/npObJAIIVci5vJUr5290qSraDzl7lfQogJ501Aw1fQAshmZH6/v33s
        b3cyICKM0eo82wibP2wqmBAnDpgAXJwjcBgm5MLLw3VfFv1IIs+HlUX+XebbaEuveW5BGC
        jTdo1zagrP8Qvnj1Ly/upq3hksQ0Fw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684309240;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D3zl4ZBa9gynw9Gj0QHzusYDzIRww4g7tO6q0e6b3LQ=;
        b=A6ELdS2170XzPgIaLOoW9fGKTkBMzkLtsD62nqiqaTTCE8W9kHx6mDlyu5RuyUJEZwgscw
        MNT/59YQ+3SuOnCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9489C13358;
        Wed, 17 May 2023 07:40:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aew9I/iEZGR7EwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 17 May 2023 07:40:40 +0000
Message-ID: <323c6717-12d0-d081-62ca-47eeab565658@suse.de>
Date:   Wed, 17 May 2023 09:40:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 06/11] block: mq-deadline: Simplify
 deadline_skip_seq_writes()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-7-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230516223323.1383342-7-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 00:33, Bart Van Assche wrote:
> Make the deadline_skip_seq_writes() code shorter without changing its
> functionality.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index a016cafa54b3..6276afede9cd 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -304,14 +304,11 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
>   						struct request *rq)
>   {
>   	sector_t pos = blk_rq_pos(rq);
> -	sector_t skipped_sectors = 0;
>   
> -	while (rq) {
> -		if (blk_rq_pos(rq) != pos + skipped_sectors)
> -			break;
> -		skipped_sectors += blk_rq_sectors(rq);
> +	do {
> +		pos += blk_rq_sectors(rq);
>   		rq = deadline_latter_request(rq);
> -	}
> +	} while (rq && blk_rq_pos(rq) == pos);
>   
>   	return rq;
>   }

Description could be improved (you're not changing the functionality, 
you are changing the implementation), but anyway:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

