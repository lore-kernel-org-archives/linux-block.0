Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1053C47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D950F613C0
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhFJGEp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 02:04:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35038 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhFJGEp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 02:04:45 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B94B4219A1;
        Thu, 10 Jun 2021 06:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623304968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhNzuzrvujH0/gm9UZV4mJxsb2Bn32QWlfxZT3yLBJU=;
        b=VErtgLN/xqY/Tjx6uRH2WC0DC1pjoM4XJeFFwgyJkMRwSQW+kUTso7cG7x22noE0zqpnqp
        jlUYwX/FA+ay+NWTSs2GumZBqDG1BT4iqMWgVPtyHQpUzVxb6vcRo2jmqH6kN/RVKvwCmc
        BJ8K+tVc5KSCwyJyft3Y70VUyg4BdzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623304968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhNzuzrvujH0/gm9UZV4mJxsb2Bn32QWlfxZT3yLBJU=;
        b=sDl4MZ91Z0TKyeSa5CTLYFXDU3qkXcciciWUQV43i+5Ub80Ewjk626sjs1Zonnj2579dMV
        HZeAWb+tqo2L4XDw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 6AD4E118DD;
        Thu, 10 Jun 2021 06:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623304968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhNzuzrvujH0/gm9UZV4mJxsb2Bn32QWlfxZT3yLBJU=;
        b=VErtgLN/xqY/Tjx6uRH2WC0DC1pjoM4XJeFFwgyJkMRwSQW+kUTso7cG7x22noE0zqpnqp
        jlUYwX/FA+ay+NWTSs2GumZBqDG1BT4iqMWgVPtyHQpUzVxb6vcRo2jmqH6kN/RVKvwCmc
        BJ8K+tVc5KSCwyJyft3Y70VUyg4BdzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623304968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhNzuzrvujH0/gm9UZV4mJxsb2Bn32QWlfxZT3yLBJU=;
        b=sDl4MZ91Z0TKyeSa5CTLYFXDU3qkXcciciWUQV43i+5Ub80Ewjk626sjs1Zonnj2579dMV
        HZeAWb+tqo2L4XDw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id N5a/GAirwWDLUgAALh3uQQ
        (envelope-from <hare@suse.de>); Thu, 10 Jun 2021 06:02:48 +0000
Subject: Re: [PATCH 02/14] block/blk-cgroup: Swap the blk_throtl_init() and
 blk_iolatency_init() calls
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Tejun Heo <tj@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-3-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <243d19ca-ead5-1728-bc19-2ed69ce5ce43@suse.de>
Date:   Thu, 10 Jun 2021 08:02:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608230703.19510-3-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 1:06 AM, Bart Van Assche wrote:
> Before adding more calls in this function, simplify the error path.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-cgroup.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index d169e2055158..3b0f6efaa2b6 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1183,15 +1183,14 @@ int blkcg_init_queue(struct request_queue *q)
>  	if (preloaded)
>  		radix_tree_preload_end();
>  
> -	ret = blk_throtl_init(q);
> +	ret = blk_iolatency_init(q);
>  	if (ret)
>  		goto err_destroy_all;
>  
> -	ret = blk_iolatency_init(q);
> -	if (ret) {
> -		blk_throtl_exit(q);
> +	ret = blk_throtl_init(q);
> +	if (ret)
>  		goto err_destroy_all;
> -	}
> +
>  	return 0;
>  
>  err_destroy_all:
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
