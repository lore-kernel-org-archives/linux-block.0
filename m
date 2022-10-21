Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E949C4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 06:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJUGvq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 02:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJUGvp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 02:51:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11E5244C63
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 23:51:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6FA21218B1;
        Fri, 21 Oct 2022 06:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666335103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YqFclqQe5x0FsQfI9ufAAsm0QC6l9etWKDbU9Cr6SiY=;
        b=c2dMd3vot/LtZQLbO0P2VloAx+yzDzryZuZp/K/fy2DnzRg7RHOnV/5ZreMhNY9NHvgbBL
        uBJ0TBT1U8j9XPmu3BTabkebU5S3z2AvPcjvgZ7g4/NV8+KadfOzzEtCyFRtluRLSmllN5
        FOcRxMAZPzeLjdRDP88bkScJQnYSyxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666335103;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YqFclqQe5x0FsQfI9ufAAsm0QC6l9etWKDbU9Cr6SiY=;
        b=1UD8Y3ORUVmgg3QIAiD6CaFgV/7/V/xVjsmVIHyyGlSRhoGWZnWk7tyfzs1knnXScVdEgT
        xzeGiDeo9lqlRpBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D8D51331A;
        Fri, 21 Oct 2022 06:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v2HNDX9BUmNiHwAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 21 Oct 2022 06:51:43 +0000
Message-ID: <86aede18-183d-5c9e-2710-2ad33b62d21b@suse.de>
Date:   Fri, 21 Oct 2022 08:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 6/8] nvme: move the NS_DEAD flag to the controller
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-7-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221020105608.1581940-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/22 12:56, Christoph Hellwig wrote:
> The NVME_NS_DEAD flag is only set in nvme_set_queue_dying, which is
> called in a loop over all namespaces in nvme_kill_queues.  Switch it
> to a controller flag checked and set outside said loop.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 16 +++++++---------
>   drivers/nvme/host/nvme.h |  2 +-
>   2 files changed, 8 insertions(+), 10 deletions(-)
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

