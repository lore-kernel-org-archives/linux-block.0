Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC32C001B0
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 06:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjHIGJJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Aug 2023 02:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjHIGJJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 02:09:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5A81BFA
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 23:09:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9FB15218B0;
        Wed,  9 Aug 2023 06:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691561347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPxuXi8Hg1eCbSDEFOnKDwFthyp8K6OiFJHJEQbMAeQ=;
        b=ocKPCyKjCVAL6ur3nLn55FF013DvDrlCYLNOjmrUXpPIwRsnZGjYhe7KDVeD/bzfq1HtUD
        1tAnVAIe6kAmPFg4gWX1YrgvEFh0GUKC9BM78lKtzve5RZ/1s0dycpRriRFRufx8ECFh+G
        ivtvCiy3Y1H/ZoIuuBxUw9seRFr9wnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691561347;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPxuXi8Hg1eCbSDEFOnKDwFthyp8K6OiFJHJEQbMAeQ=;
        b=FuJjkKI7Ll2alv9j1rQsnQVXDVPzspdmMr2cq6qfoVLUbHq/aR6w/2Xls1dLGrtL1EElE8
        CJgtGfxdnYEu4aCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84F0C13251;
        Wed,  9 Aug 2023 06:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z5lMH4Mt02SFMgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 09 Aug 2023 06:09:07 +0000
Message-ID: <342c9d71-6c01-7dfd-3aaa-006e4c8470b7@suse.de>
Date:   Wed, 9 Aug 2023 08:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/5] block: use pr_xxx() instead of printk() in partition
 code
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-4-dlemoal@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230808135702.628588-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/23 15:57, Damien Le Moal wrote:
> Replace calls to printk() in the core, atari, efi and sun partition
> code with the equivalent pr_info(), pr_err() etc calls. For each
> partition type, the pr_fmt message prefix is defined as "partition: xxx:
> " where "xxx" is the partition type name.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/partitions/atari.c | 11 +++++++----
>   block/partitions/check.h |  1 +
>   block/partitions/core.c  | 33 ++++++++++++++++-----------------
>   block/partitions/sgi.c   |  7 +++++--
>   block/partitions/sun.c   |  5 ++++-
>   5 files changed, 33 insertions(+), 24 deletions(-)
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

