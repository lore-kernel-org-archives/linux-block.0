Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C49EC4338F
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 10:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7961461151
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 10:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbhHSKmc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Aug 2021 06:42:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41070 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbhHSKmc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 06:42:32 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C973220A0;
        Thu, 19 Aug 2021 10:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629369715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OP307IowN6ZHFMyYF7A9NGL9fFMwxVD/FHcKNg7u/74=;
        b=mie67qIK+o54tOpmBrKvHyB4FttGKWzfS/o5utRGzj3GhWGUBSXOypssAUof1+28/3o1+E
        9XNzaXCxwtcBNcR1VYXMykmsFAspRP034j8CT68hw01fCABHfaDpF0PI30B1J79fHXgqXU
        QM/HYjBDBkAn9v4w67XbwM792megRWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629369715;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OP307IowN6ZHFMyYF7A9NGL9fFMwxVD/FHcKNg7u/74=;
        b=Pvhez0A6l9Xjd83Fv0u/mRAjoHkAShB0nH8NBko9ioUy2D1vBVDX84bQ0OJP5baJ7draBx
        DqktOBpKLqd1U9Dg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1F606139BA;
        Thu, 19 Aug 2021 10:41:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id bB6LBHM1HmF9QwAAGKfGzw
        (envelope-from <hare@suse.de>); Thu, 19 Aug 2021 10:41:55 +0000
Subject: Re: [PATCH 01/11] block: add a sanity check for a live disk in
 del_gendisk
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
References: <20210818144542.19305-1-hch@lst.de>
 <20210818144542.19305-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3192ce13-cc67-c849-3a47-5a73759bfc66@suse.de>
Date:   Thu, 19 Aug 2021 12:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210818144542.19305-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/21 4:45 PM, Christoph Hellwig wrote:
> Add a sanity check to del_gendisk to do nothing when the disk wasn't
> successfully added.  This papers over the complete lack of add_disk
> error handling, which is about to get fixed gradually.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/genhd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 02cd9ec93e52..935f74c652f1 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -579,7 +579,7 @@ void del_gendisk(struct gendisk *disk)
>   {
>   	might_sleep();
>   
> -	if (WARN_ON_ONCE(!disk->queue))
> +	if (WARN_ON_ONCE(!disk_live(disk)))
>   		return;
>   
>   	blk_integrity_del(disk);
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
