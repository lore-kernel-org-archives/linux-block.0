Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E09C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 15:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiBPPcf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:32:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiBPPce (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 10:32:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B26DB866
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 07:32:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 013DB21114;
        Wed, 16 Feb 2022 15:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645025541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGsVUd4Tvft1mgackRQ5FZ0xdPjACeQFfBX1pwcwAyo=;
        b=XLJqRF/L15YCRQPUQbZrAd2YzYWliOp9HpvS0VzI2nnQKGoGoXmeBX2EYntnp1Vawokns5
        RFrVImk4XKOmvhdb/62PziOZsVzux+XcOZ3CIAH6aqFvHeY1UaSeuRDSIPYg0jHahKFtpY
        Sv/mNKJd0xI9rDngPxuThD4dgrJLAxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645025541;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGsVUd4Tvft1mgackRQ5FZ0xdPjACeQFfBX1pwcwAyo=;
        b=yuIzoPz6ECxxM3mSnBr0X60Chtsjqvu1QQE+qZI05uTjsxpGoQrRKHkMMlCVGmdRAOCT4e
        iMJc2WbTQyaUalCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFE7D13B15;
        Wed, 16 Feb 2022 15:32:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ehlvNgQZDWKsMwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 16 Feb 2022 15:32:20 +0000
Message-ID: <f7620445-6954-dd53-9481-8c3502840a78@suse.de>
Date:   Wed, 16 Feb 2022 16:32:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] block: fix surprise removal for drivers calling
 blk_set_queue_dying
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     kbusch@kernel.org, markus.bloechl@ipetronik.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20220216150901.4166235-1-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220216150901.4166235-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/16/22 16:09, Christoph Hellwig wrote:
> Various block drivers call blk_set_queue_dying to mark a disk as dead due
> to surprise removal events, but since commit 8e141f9eb803 that doesn't
> work given that the GD_DEAD flag needs to be set to stop I/O.
> 
> Replace the driver calls to blk_set_queue_dying with a new (and properly
> documented) blk_mark_disk_dead API, and fold blk_set_queue_dying into the
> only remaining caller.
> 
> Fixes: 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
> Reported-by: Markus Blöchl <markus.bloechl@ipetronik.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c                  | 18 +++++++++++++-----
>   drivers/block/mtip32xx/mtip32xx.c |  2 +-
>   drivers/block/rbd.c               |  2 +-
>   drivers/block/xen-blkfront.c      |  2 +-
>   drivers/md/dm.c                   |  2 +-
>   drivers/nvme/host/core.c          |  2 +-
>   drivers/nvme/host/multipath.c     |  2 +-
>   include/linux/blkdev.h            |  3 ++-
>   8 files changed, 21 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
