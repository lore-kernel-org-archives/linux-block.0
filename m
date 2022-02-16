Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12B4C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 15:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiBPPS6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:18:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiBPPS5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 10:18:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C25C10EC5A
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 07:18:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 173B4218B0;
        Wed, 16 Feb 2022 15:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645024724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dWqOeDtMZ42yPNgafj4ZRZZXwfvzlF+Q15WMudELbXA=;
        b=HHZFm/xZP8HNIiIsBlQ0l3pNHmdhD7lUm/m/5vtusuDB3qE4BZmZkMXd5UmaZHUUHqK0pp
        gxeHOru4iGU4uBOiW00gzcyDob6Mfiog3C9z38rBJLWg8zYv5HgWVpgA/xwzcL8fICarnR
        oR2Qm4chQPVzBDQqI9K8s48Al+LfIs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645024724;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dWqOeDtMZ42yPNgafj4ZRZZXwfvzlF+Q15WMudELbXA=;
        b=AkufuLkXmz9hTmQshpjkVbRwhvFTlHSgyiUN1DvoC6SFhIglXua6SR2+DHeE/rhDcwX/2K
        OUveqbSVCb7kQDDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0096C13B15;
        Wed, 16 Feb 2022 15:18:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sc7qOtMVDWLoLAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 16 Feb 2022 15:18:43 +0000
Message-ID: <4f29d9a3-021c-f2f0-b452-e682fa1db459@suse.de>
Date:   Wed, 16 Feb 2022 16:18:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] block: skip the fsync_bdev call in del_gendisk for
 surprise removals
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     kbusch@kernel.org, markus.bloechl@ipetronik.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20220216150901.4166235-1-hch@lst.de>
 <20220216150901.4166235-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220216150901.4166235-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/16/22 16:09, Christoph Hellwig wrote:
> For surprise removals that have already marked the disk dead, there is
> no point in calling fsync_bdev as all I/O will fail anyway, so skip it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/genhd.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 626c8406f21a6..f68bdfe4f883b 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -584,7 +584,14 @@ void del_gendisk(struct gendisk *disk)
>   	blk_drop_partitions(disk);
>   	mutex_unlock(&disk->open_mutex);
>   
> -	fsync_bdev(disk->part0);
> +	/*
> +	 * If this is not a surprise removal see if there is a file system
> +	 * mounted on this device and sync it (although this won't work for
> +	 * partitions).  For surprise removals that have already marked the
> +	 * disk dead skip this call as no I/O is possible anyway.
> +	 */
> +	if (!test_bit(GD_DEAD, &disk->state))
> +		fsync_bdev(disk->part0);
>   	__invalidate_device(disk->part0, true);
>   
>   	/*
My turn to be picky:
In the previous patch you use 'set_bit()' for GD_DEAD, which to my 
knowledge doesn't imply a memory barrier.
Yet here you rely on that for the 'test_bit()' to return the 
correct/most recent value.
Don't we need a memory barrier here somewhere?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
