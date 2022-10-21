Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BF9C433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 06:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJUGuH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Oct 2022 02:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiJUGuB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 02:50:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F31B64E4
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 23:49:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98B0F218B1;
        Fri, 21 Oct 2022 06:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666334995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pwT2KXY/wGwZ1s/hzF2oWy6XQ1PJfg+yHoJqPEx0UAE=;
        b=KUOlbHpaITkk99sZiNtKYnzl3bIR9zWYrI2gwtWNzAcqRRwpu+e90/RNQZG6Xtnxsgn+MP
        Y6IFuV9gYoX8pVM7rIIGxQf2gOTM8fdufNbJjQtVBLQTs1khdYwEQw9nA8pzx5NxetivOy
        jd4AuoMAVlwmTcubmfeOe5EpaONbRso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666334995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pwT2KXY/wGwZ1s/hzF2oWy6XQ1PJfg+yHoJqPEx0UAE=;
        b=fDDPyhMlXGc8UUhPwIhYQKuSg7SSxtrbHSN+upF+ufu01EdVR6EayEBnLfPMuM6OaT0ZmV
        +tf4yGSkvHl9TNCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E05E1331A;
        Fri, 21 Oct 2022 06:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pZ8tFhNBUmM5HgAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 21 Oct 2022 06:49:55 +0000
Message-ID: <3298d857-f30b-6dbe-33b2-177a8ff104b0@suse.de>
Date:   Fri, 21 Oct 2022 08:49:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/8] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221020105608.1581940-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/22 12:56, Christoph Hellwig wrote:
> For submit_bio based queues there is no (S)RCU critical section during
> I/O submission and thus nothing to wait for in blk_mq_wait_quiesce_done,
> so skip doing any synchronization.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 33292c01875d5..df967c8af9fee 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -280,7 +280,9 @@ EXPORT_SYMBOL_GPL(blk_mq_wait_quiesce_done);
>   void blk_mq_quiesce_queue(struct request_queue *q)
>   {
>   	blk_mq_quiesce_queue_nowait(q);
> -	blk_mq_wait_quiesce_done(q);
> +	/* nothing to wait for non-mq queues */
> +	if (queue_is_mq(q))
> +		blk_mq_wait_quiesce_done(q);
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
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

