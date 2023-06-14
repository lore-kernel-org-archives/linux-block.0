Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7249DEB64D8
	for <linux-block@archiver.kernel.org>; Wed, 14 Jun 2023 13:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244315AbjFNNgn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 09:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243483AbjFNNgm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 09:36:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3C31FC4
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 06:36:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 110381FDEE;
        Wed, 14 Jun 2023 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686749800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U9GJ8ya9z2XHoqQWq2/v69J4A8CBYF1KNjX4WfuSRHs=;
        b=UKv9WOObHh6bzDsP9n6a/JplKi+SvHMv2Hez+JddLpXdiZWIchDg4bdXq26vofR8bW+ehf
        vsVMUWppKcxOS26joVuitCTTjDCVxXrpBeep3NCgA0URtFPASZpLyvLsBZ3Lzv630gM+h9
        UZPBs8Sg4KmECjGcMv1dFEJflW9Fvko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686749800;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U9GJ8ya9z2XHoqQWq2/v69J4A8CBYF1KNjX4WfuSRHs=;
        b=a/BZb/OgnNYx44ELR7qPqZ0SqOP4xkbr47dhJLOYIDrtlAoLX7SNtxI/IgOiZxhfoOxr+6
        1gsvEraJAnNIcVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0014E1357F;
        Wed, 14 Jun 2023 13:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +DtCO2fCiWTyYAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 14 Jun 2023 13:36:39 +0000
Message-ID: <b7700f44-97b2-84a7-aafa-07887c90e5a4@suse.de>
Date:   Wed, 14 Jun 2023 15:36:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next] brd: use cond_resched instead of
 cond_resched_rcu
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc:     mcgrof@kernel.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, Matthew Wilcox <willy@infradead.org>
References: <CGME20230614133540eucas1p1a761c184d7d571cfcd893ab5f8b759fd@eucas1p1.samsung.com>
 <20230614133538.1279369-1-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230614133538.1279369-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/23 15:35, Pankaj Raghav wrote:
> The body of the loop is run without RCU lock held. Use the regular
> cond_resched() instead of cond_resched_rcu().
> 
> Fixes: 786bb0245881 ("brd: use XArray instead of radix-tree to index backing pages")
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   drivers/block/brd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 2f71376afc71..970bd6ff38c4 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -111,7 +111,7 @@ static void brd_free_pages(struct brd_device *brd)
>   
>   	xa_for_each(&brd->brd_pages, idx, page) {
>   		__free_page(page);
> -		cond_resched_rcu();
> +		cond_resched();
>   	}
>   
>   	xa_destroy(&brd->brd_pages);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

