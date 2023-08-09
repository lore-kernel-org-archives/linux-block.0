Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDBFC001B0
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 06:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjHIGHm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Aug 2023 02:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHIGHm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 02:07:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9D912D
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 23:07:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3C6431F388;
        Wed,  9 Aug 2023 06:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691561260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6UXQ0i4tg7g8JoHktOSNbXYhH0Tmp0UBByZq/Tq2ic=;
        b=oJ5U73nifOm0Uy0jMOl52oRjJCCTy0fxBs3t38Db9vycCbKij2W5QjQ3wh49QQgKrYG4kd
        pj6eiZbm+Ub4YK2W6BZKBuUc8/D7SXhReBoukg5WFdaBrSlJJuKmyilnX/3FfFgA/162Cv
        SEW+x2UZ4TDBF5vV/kUAE1R1eIc+dHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691561260;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6UXQ0i4tg7g8JoHktOSNbXYhH0Tmp0UBByZq/Tq2ic=;
        b=JsCjOG6Q3cFz406EFfMhTwneLjh7ROwZojDNPeWiSRb5tRghb3cNH+60xbtkPVbCtVuAU/
        qGW1kyjXgZomWGCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2540713251;
        Wed,  9 Aug 2023 06:07:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vy0eCCwt02S1MQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 09 Aug 2023 06:07:40 +0000
Message-ID: <926edf15-389d-d6f5-9ac9-337cc77cc561@suse.de>
Date:   Wed, 9 Aug 2023 08:07:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/5] block: use PAGE_SECTORS_SHIFT to set limits
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-2-dlemoal@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230808135702.628588-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/23 15:56, Damien Le Moal wrote:
> Replace occurences of "PAGE_SHIFT - 9" in blk-settings.c with the
> cleaner PAGE_SECTORS_SHIFT macro.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-settings.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

