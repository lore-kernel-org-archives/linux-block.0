Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5A6C7EE22
	for <linux-block@archiver.kernel.org>; Thu, 11 May 2023 14:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbjEKO3W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 10:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238526AbjEKO2y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 10:28:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDF62711
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 07:27:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 527DE1FF1B;
        Thu, 11 May 2023 14:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683815242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svB6XG/iJfvKnmgn0AFHWzp41AFmGZq01kVHd7lYh3c=;
        b=xnh8taAgJv4CWhXHUvxGjgNC+4Ft5q8z4qF1SqThRcP4BQnAE5tF0UW+JCa272NgP1rU5A
        fRkd29QneefEwg3KW/Fy9vkTPRVYb/y/tEZjZelrgLz3qL8nCVwyomuLff6liEdjrpq+dS
        1EB8kpneoL2hV/z9HQ1g3YhZWe5NnWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683815242;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svB6XG/iJfvKnmgn0AFHWzp41AFmGZq01kVHd7lYh3c=;
        b=hkhBgM+xtqTafXGpYGHNhSDp/BE6UkrrmXUpr12h8cT2WbE8i/aRWHYs7mkJySdi2SxpFl
        ssvAE+SvUhkIlZAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EFC94134B2;
        Thu, 11 May 2023 14:27:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vpyUMUj7XGQDSgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 11 May 2023 14:27:20 +0000
Message-ID: <a66c9620-2da9-99f4-5041-6be31bac1aab@suse.de>
Date:   Thu, 11 May 2023 16:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] brd: use XArray instead of radix-tree to index backing
 pages
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc:     gost.dev@samsung.com, linux-block@vger.kernel.org, hch@lst.de,
        willy@infradead.org
References: <CGME20230511121547eucas1p17acca480b5e1d0e04c6595b70c1c92a1@eucas1p1.samsung.com>
 <20230511121544.111648-1-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230511121544.111648-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/11/23 14:15, Pankaj Raghav wrote:
> XArray was introduced to hold large array of pointers with a simple API.
> XArray API also provides array semantics which simplifies the way we store
> and access the backing pages, and the code becomes significantly easier
> to understand.
> 
> No performance difference was noticed between the two implementation
> using fio with direct=1 [1].
> 
> [1] Performance in KIOPS:
> 
>            |  radix-tree |    XArray  |   Diff
>            |             |            |
> write     |    315      |     313    |   -0.6%
> randwrite |    286      |     290    |   +1.3%
> read      |    330      |     335    |   +1.5%
> randread  |    309      |     312    |   +0.9%
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> @willy: I noticed later that you sent a similar patch in 2019[1]. Let me
> know if you need your signoff in the patch as well.
>                                                                                                                                                                                                                                                                                         
> [1] https://lore.kernel.org/linux-block/20190318194821.3470-9-willy@infradead.org/
> 
>   drivers/block/brd.c | 93 ++++++++++++---------------------------------
>   1 file changed, 24 insertions(+), 69 deletions(-)
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

