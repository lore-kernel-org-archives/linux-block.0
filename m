Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14257C04A6A
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 06:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjHIGJl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Aug 2023 02:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjHIGJk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 02:09:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774701BE1
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 23:09:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 393562187F;
        Wed,  9 Aug 2023 06:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691561379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1T6JTXsp5m8e96LIgJmRhQETiUHcyBLDbI/ZfwD+Qt0=;
        b=t4ZOUADbYtZKU9GvpylKJLLg2KhzgTOoNY4O/4wppuSYyjF6PyWdig7rhomatFgtpF3a1q
        33qs1kwzTN/mALfvcfGMR8O/ptyTlm5FfvGLYqFPSV7qzf3ikJm3Tj5DAgC//BEayVU9Zk
        ACvywuaBbORqRup3RPvRV6fOewuHckM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691561379;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1T6JTXsp5m8e96LIgJmRhQETiUHcyBLDbI/ZfwD+Qt0=;
        b=zoZIOWKe/6UaUq3nibc9J5Fb4BE2HS0hu4Y93NTu/cSURO0U0YK6f7VafRIytj+/qiWO/w
        cS8TQn6fqxc3rgAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B74913251;
        Wed,  9 Aug 2023 06:09:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DcvCBaMt02TQMgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 09 Aug 2023 06:09:39 +0000
Message-ID: <78c1b65c-7fdc-7c35-9eb2-5033535f0b87@suse.de>
Date:   Wed, 9 Aug 2023 08:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/5] block: Improve efi partition debug messages
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-5-dlemoal@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230808135702.628588-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/23 15:57, Damien Le Moal wrote:
> Add the missing definition of pr_fmt to prefix the debug messages from
> partitions/efi.c with "partition: efi: ".
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/partitions/efi.c | 3 +++
>   1 file changed, 3 insertions(+)
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

