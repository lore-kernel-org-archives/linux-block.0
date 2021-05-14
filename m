Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FDEC433ED
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 08:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236C561451
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 08:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhENIfz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 04:35:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:37988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhENIfz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 04:35:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9408AE00;
        Fri, 14 May 2021 08:34:43 +0000 (UTC)
Subject: Re: A possible divide by zero bug in blk_mq_map_queues
To:     Yiyuan guo <yguoaz@gmail.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <CAM7=BFrvCdsW1xekOb9QAdVkhRAU6kdg1g98OUz6YYyXOuMZRg@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <21cb65d1-b91a-2627-3824-292de3a7553a@suse.de>
Date:   Fri, 14 May 2021 10:34:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAM7=BFrvCdsW1xekOb9QAdVkhRAU6kdg1g98OUz6YYyXOuMZRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/14/21 10:28 AM, Yiyuan guo wrote:
> In block/blk-mq-cpumap.c, blk_mq_map_queues has the following code:
> 
> int blk_mq_map_queues(struct blk_mq_queue_map *qmap) {
>     ...
>     unsigned int nr_queues = qmap->nr_queues;
>     unsigned q = 0;
>     ...
>     for_each_present_cpu(cpu) {
>         if (q >= nr_queues)
>             break;
>         ...
>     }
> 
>     for_each_possible_cpu(cpu) {
>         ...
>         if (q < nr_queues) {
>             map[cpu] = queue_index(qmap, nr_queues, q++);
>         } else {
>            ...
>             if (first_sibling == cpu)
>                 map[cpu] = queue_index(qmap, nr_queues, q++);
> 
>         }
>     }
> }
> 
> if qmap->nr_queues equals to zero when entering the function, then by
> passing zero to function queue_index we have a divide by zero bug:
> 
> static int queue_index(struct blk_mq_queue_map *qmap,
>                unsigned int nr_queues, const int q)
> {
>     return qmap->queue_offset + (q % nr_queues);
> }
> 
> It seems possible to me that qmap->nr_queues may equal zero because
> this field is explicitly checked in other functions.
> 
> For example, in the function blk_mq_map_swqueue (block/blk-mq.c),
> there is a check comparing nr_queues with 0:
> 
> for (j = 0; j < set->nr_maps; j++) {
>             if (!set->map[j].nr_queues) {
>                 ...
>                 continue;
>             }
>             ...
> }
> 
Theoretically, but yes, possible.
Care to send a patch?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
