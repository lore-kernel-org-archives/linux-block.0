Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E453BC433EF
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 09:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiCHJGz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 04:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiCHJGy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 04:06:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBD53FBE0
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 01:05:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 462431F397;
        Tue,  8 Mar 2022 09:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646730357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9AWxDwdbmd7z31NrIod0AE3Fko0MByOxLhNSedgRjxE=;
        b=RmJIe+L8DtxezJzeLr7kM7p6cZ0O8wYglACx1B7LNv/WhKLlOsIC6WLnLdx6fsAq8gBSB1
        pJU1HhOs6485Y/yO/w5fS18VmLUhAWBTu/KhR9JUSCZ2/4084jQOkH4kuwm31EeBxo6v/3
        +c9b9HQd2LlOR9yP+Ie7+CAil+pp1mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646730357;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9AWxDwdbmd7z31NrIod0AE3Fko0MByOxLhNSedgRjxE=;
        b=Qbl3CvFd0nYIy/h/tyEO92g1sZYyLkqGFaIPDwVm+/XWwTjCJod34Q3lDxlxDYWPauVQbP
        u4UcwUBDU7XiSxCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D8A713C2F;
        Tue,  8 Mar 2022 09:05:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +OTxB3UcJ2JgHQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 08 Mar 2022 09:05:57 +0000
Message-ID: <f15e3d3c-a934-632b-2657-d8aaf5fdd057@suse.de>
Date:   Tue, 8 Mar 2022 10:05:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V4 6/6] blk-mq: manage hctx map via xarray
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220308073219.91173-1-ming.lei@redhat.com>
 <20220308073219.91173-7-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220308073219.91173-7-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/8/22 08:32, Ming Lei wrote:
> First code becomes more clean by switching to xarray from plain array.
> 
> Second use-after-free on q->queue_hw_ctx can be fixed because
> queue_for_each_hw_ctx() may be run when updating nr_hw_queues is
> in-progress. With this patch, q->hctx_table is defined as xarray, and
> this structure will share same lifetime with request queue, so
> queue_for_each_hw_ctx() can use q->hctx_table to lookup hctx reliably.
> 
> Reported-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-tag.c     |  2 +-
>   block/blk-mq.c         | 62 ++++++++++++++++--------------------------
>   block/blk-mq.h         |  2 +-
>   include/linux/blk-mq.h |  3 +-
>   include/linux/blkdev.h |  2 +-
>   5 files changed, 28 insertions(+), 43 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
