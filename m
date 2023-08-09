Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F72FC001B0
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 06:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjHIGKV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Aug 2023 02:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjHIGKU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 02:10:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C926E61
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 23:10:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 28CA12187F;
        Wed,  9 Aug 2023 06:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691561419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k1/G+m+X9ywGhb2hU+T+4TLygwamzJc/ghnzyiERZ1k=;
        b=SAV3W09AZcKZwvWZdq8aTPhQZrrkDyjVnyruVBI8Xpl3GxZdpVgbA3lhfo3dyWPITCmzJa
        0sslcACgRQLrV5IIgGwaUjhA8yGGvFjOTl/UStYLgX/5Or87ffBnhxFLZouGl4p7VVAXcU
        2FGuaUIl7b+EJUBpxfBNxGi6e0mpnJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691561419;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k1/G+m+X9ywGhb2hU+T+4TLygwamzJc/ghnzyiERZ1k=;
        b=ClPEL9AK9Hmphzy8x+IaCkmjjho7ZXvUqXXOLqcoVNOtrthirt27Oxy0Z5J1M/L24fCue7
        ON116gtM2QUu3pAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11B0F13251;
        Wed,  9 Aug 2023 06:10:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5Ng1A8st02RgMwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 09 Aug 2023 06:10:19 +0000
Message-ID: <21c5b436-7979-8c3a-c0e4-9c73967c0699@suse.de>
Date:   Wed, 9 Aug 2023 08:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/5] block: switch ldm partition code to use pr_xxx()
 functions
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-6-dlemoal@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230808135702.628588-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/23 15:57, Damien Le Moal wrote:
> Modify the ldm partition code to use the regular pr_info(), pr_err() etc
> functions instead of using printk(). With this change, the function
> _ldm_printk() is not necessary and removed. The special LDM_DEBUG
> configuration option is also removed as regular dynamic debug control
> can be used to turn on or off the debug messages. References to this
> configuration option is removed from the documentation and from the m68k
> defconfig.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   Documentation/admin-guide/ldm.rst |  7 +++----
>   arch/m68k/configs/virt_defconfig  |  1 -
>   block/partitions/Kconfig          | 10 ---------
>   block/partitions/ldm.c            | 35 +++++++------------------------
>   4 files changed, 10 insertions(+), 43 deletions(-)
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

