Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5C5C4332F
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 10:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiKGKXm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 05:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiKGKXl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 05:23:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0241C12762;
        Mon,  7 Nov 2022 02:23:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 891401F383;
        Mon,  7 Nov 2022 10:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667816619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfBjNBctYzVN9tZP9O8xyLWUf7vriScs1MgfEs65OUc=;
        b=jPefW1e3ntgr9FVHp175t7pF7FlbHP8Jl29gmN7II/TXEVUF1sjeOz/FycJvaTiBu8VWzx
        XqY4+3uzzulb3PL8CcG1dJQGqnuglVtVwVFJ6tu34qoAMjHDza1TwcvtVpOeWWxcGoaT2u
        PRwD0FMO4qw5HJsYXszXfXucvvmB3nY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667816619;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AfBjNBctYzVN9tZP9O8xyLWUf7vriScs1MgfEs65OUc=;
        b=8tmRnLU0Rw5EP61Mf4jocyKQkvbvbCjj2Ijo8snTjCI7Bw3Awm72Wu2mSfkVJiSB2BvnHE
        BiPfSu1YPLEhFqAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77DF113AC7;
        Mon,  7 Nov 2022 10:23:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UpH6HKvcaGO/bQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 07 Nov 2022 10:23:39 +0000
Message-ID: <d4b38972-05db-2705-d39d-d3a0e90b2694@suse.de>
Date:   Mon, 7 Nov 2022 11:23:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 1/7] block: add a sanity check for non-write flush/fua
 bios
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
 <20221107005021.1327692-2-damien.lemoal@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221107005021.1327692-2-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/7/22 01:50, Damien Le Moal wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Check that the PREFUSH and FUA flags are only set on write bios,
> given that the flush state machine expects that.
> 
> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   block/blk-core.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

