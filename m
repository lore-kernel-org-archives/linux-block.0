Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05855C433ED
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 09:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20956140E
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 09:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhENJZT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 05:25:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:44902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhENJZT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 05:25:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69A30AD1B;
        Fri, 14 May 2021 09:24:07 +0000 (UTC)
Subject: Re: [PATCH] block: add protection for divide by zero in
 blk_mq_map_queues
To:     Yiyuan GUO <yguoaz@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Yiyuan GUO <yguoaz@cse.ust.hk>
References: <21cb65d1-b91a-2627-3824-292de3a7553a@suse.de>
 <20210514091609.66252-1-yguoaz@cse.ust.hk>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <274501fd-3115-3015-3577-3ed64e4038a0@suse.de>
Date:   Fri, 14 May 2021 11:24:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514091609.66252-1-yguoaz@cse.ust.hk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/14/21 11:16 AM, Yiyuan GUO wrote:
> In function blk_mq_map_queues, qmap->nr_queues may equal zero
> and thus it needs to be checked before we pass it to function
> queue_index.
> 
> Signed-off-by: Yiyuan GUO <yguoaz@cse.ust.hk>
> ---
>  block/blk-mq-cpumap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 3db84d319..dc440870e 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -65,7 +65,8 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
>  		} else {
>  			first_sibling = get_first_sibling(cpu);
>  			if (first_sibling == cpu)
> -				map[cpu] = queue_index(qmap, nr_queues, q++);
> +				if (nr_queues)
> +					map[cpu] = queue_index(qmap, nr_queues, q++);
>  			else
>  				map[cpu] = map[first_sibling];
>  		}
> 
Err ... and what is the value of 'map[cpu]' if 'nr_queues' equals zero?
Please move the 'if (nr_queues)' condition into the first if-clause:

if ((first_sibling == cpu) && nr_queues)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
