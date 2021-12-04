Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DFEC433EF
	for <linux-block@archiver.kernel.org>; Sat,  4 Dec 2021 10:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348193AbhLDKu3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Dec 2021 05:50:29 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54904 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351571AbhLDKu3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Dec 2021 05:50:29 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 38F071FD37;
        Sat,  4 Dec 2021 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638614823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZbuQWGj4Exo/bQg6uaDn4SOsmn6tCdLllErpnT9Jz4=;
        b=Hk3+FSCVc2srXagY2Dql1bp2YHldkHPhiYKAW/EYREv1Tq3T2ZBcnbzZXOS2tV3P4ylzYb
        htWjjjF+JbLwr8E6s7EKIk7AsimkZuxKHwVAxrST9J7LmTYYFPnpeQokfY6Zn3DwvrinQT
        ZD5ePkqGksczQuKBNPmYelaPrGRhjYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638614823;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZbuQWGj4Exo/bQg6uaDn4SOsmn6tCdLllErpnT9Jz4=;
        b=XGjtagYaImYIXunxL0oiE4DSS3DHzlDcepJYfJgp/fD5bnOg8yA3qkSZ94rL/p/yGqWbR1
        Qn4Aet9xhvireADQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2438313BF8;
        Sat,  4 Dec 2021 10:47:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wb4JCCdHq2HIawAAMHmgww
        (envelope-from <hare@suse.de>); Sat, 04 Dec 2021 10:47:03 +0000
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-5-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <63cf5e47-bc05-03eb-bc67-581eeee0ba37@suse.de>
Date:   Sat, 4 Dec 2021 11:47:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211203214544.343460-5-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/21 10:45 PM, Jens Axboe wrote:
> This enables the block layer to send us a full plug list of requests
> that need submitting. The block layer guarantees that they all belong
> to the same queue, but we do have to check the hardware queue mapping
> for each request.
> 
> If errors are encountered, leave them in the passed in list. Then the
> block layer will handle them individually.
> 
> This is good for about a 4% improvement in peak performance, taking us
> from 9.6M to 10M IOPS/core.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/host/pci.c | 61 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
