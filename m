Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B77C07E95
	for <linux-block@archiver.kernel.org>; Fri, 16 Jul 2021 05:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF42613E9
	for <linux-block@archiver.kernel.org>; Fri, 16 Jul 2021 05:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhGPFyd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jul 2021 01:54:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40114 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhGPFyd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jul 2021 01:54:33 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5FFDB22B37;
        Fri, 16 Jul 2021 05:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626414698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KiBwXgqCdJWsgi0jvaNaGUC1mbi2qoxditZNf66Lj2U=;
        b=qYAHL/XL6E5ao5gjKyM8hUcYLdxGbgdULtz8SV80StW8RI8CfaPq8fr8p6QErxuNCU9c5G
        A8H4Dj8nDS2H0kB8J3abVup9JbBBO47ZHsZS4kDrrS2j934BIi1YouxGSZ142+dnjdmRei
        25q2WJPACP5hB9B8K81V1dp4fkgkiGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626414698;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KiBwXgqCdJWsgi0jvaNaGUC1mbi2qoxditZNf66Lj2U=;
        b=rp4k5+5kRwnTtdrlRwdh0fobId24LoNjfjdk/Pzwrljt4eRjRbhwJnTpg9YQWVFIGevyaK
        hbgnVKr8aLxeyACw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1EF4A13357;
        Fri, 16 Jul 2021 05:51:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id fhdSBWoe8WDxNwAAGKfGzw
        (envelope-from <hare@suse.de>); Fri, 16 Jul 2021 05:51:38 +0000
Subject: Re: [RFC 4/6] mmc/core/block: replace GENHD_FL_UP with
 GENHD_FL_DISK_ADDED
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210715202341.2016612-1-mcgrof@kernel.org>
 <20210715202341.2016612-5-mcgrof@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <703f466e-e2eb-fc20-fff0-307f29eb6144@suse.de>
Date:   Fri, 16 Jul 2021 07:51:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715202341.2016612-5-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/15/21 10:23 PM, Luis Chamberlain wrote:
> The GENHD_FL_DISK_ADDED flag is what we really want, as the
> flag GENHD_FL_UP could be set on a semi-initialized device.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   drivers/mmc/core/block.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 9890a1532cb0..5bb3e604e618 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2637,7 +2637,7 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
>   		 * from being accepted.
>   		 */
>   		card = md->queue.card;
> -		if (md->disk->flags & GENHD_FL_UP) {
> +		if (md->disk->flags & GENHD_FL_DISK_ADDED) {
>   			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
>   			if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
>   					card->ext_csd.boot_ro_lockable)
> 
Same here: as you have provided a wrapper please use it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
