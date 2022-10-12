Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A6CC4332F
	for <linux-block@archiver.kernel.org>; Wed, 12 Oct 2022 06:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJLGVF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Oct 2022 02:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJLGVF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 02:21:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4BF89AC2
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 23:20:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6D59D1F381;
        Wed, 12 Oct 2022 06:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665555656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRw286FCeo/z7YPKAjzl9PWu46h36NwIgHxI8T3tlXI=;
        b=YvyfKT1v4CjxamnrK3HzxZDwnHwUgtnl418i6u0fgDDMO4pReRvWpVRJS8KU0IjaDAuUxG
        eMqZvXn6E6q6o0nHUMdXDf0bEeYC1QsDCUBdQ+vtd5m8YLD88c1ZNUlKaCUGYx/WdrYVHS
        xquanNiDi5Ftwq9VDxOL1xtG7DyzJRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665555656;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRw286FCeo/z7YPKAjzl9PWu46h36NwIgHxI8T3tlXI=;
        b=1ixFZ2oa40iqgStLDLruyxczBPimPSowXMjlJ6JoDCy7U+SXf7d6w76wTWyRZBQZ7nFerX
        eaYlGhIt6ECt8XBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12CEB13ACD;
        Wed, 12 Oct 2022 06:20:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q/qIAMhcRmPjIwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 12 Oct 2022 06:20:56 +0000
Message-ID: <0d869239-73bb-b61a-6a33-2219f3d635ef@suse.de>
Date:   Wed, 12 Oct 2022 08:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] block: fix leaking minors of hidden disks
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
References: <20221010131857.748129-1-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221010131857.748129-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/10/22 15:18, Christoph Hellwig wrote:
> The major/minor of a hidden gendisk is not propagated to the block
> device because it is never registered using bdev_add.  But the lack of
> bd_dev also causes the dynamic major minor number not to be freed.
> Assign bd_dev manually to ensure the dynamic major minor gets freed.
> 
> Based on a patch by Keith Busch.
> 
> Fixes:  8ddcd653257c ("block: introduce GENHD_FL_HIDDEN")
> Reported-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Daniel Wagner <dwagner@suse.de>
> ---
>   block/genhd.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 514395361d7c5..17b33c62423df 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -507,6 +507,13 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>   		 */
>   		dev_set_uevent_suppress(ddev, 0);
>   		disk_uevent(disk, KOBJ_ADD);
> +	} else {
> +		/*
> +		 * Even if the block_device for a hidden gendisk is not
> +		 * registered, it needs to have a valid bd_dev so that the
> +		 * freeing of the dynamic major works.
> +		 */
> +		disk->part0->bd_dev = MKDEV(disk->major, disk->first_minor);
>   	}
>   
>   	disk_update_readahead(disk);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

