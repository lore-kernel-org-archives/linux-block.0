Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE8EC433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D377D61163
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhETF5f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 01:57:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:48646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhETF5f (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 01:57:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEDDBAF03;
        Thu, 20 May 2021 05:56:13 +0000 (UTC)
Subject: Re: [PATCH v2 07/11] dm: Introduce dm_report_zones()
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
 <20210520042228.974083-8-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ff07c069-694e-8a14-36d5-2fcda5ad5cd4@suse.de>
Date:   Thu, 20 May 2021 07:56:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210520042228.974083-8-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/21 6:22 AM, Damien Le Moal wrote:
> To simplify the implementation of the report_zones operation of a zoned
> target, introduce the function dm_report_zones() to set a target
> mapping start sector in struct dm_report_zones_args and call
> blkdev_report_zones(). This new function is exported and the report
> zones callback function dm_report_zones_cb() is not.
> 
> dm-linear, dm-flakey and dm-crypt are modified to use dm_report_zones().
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   drivers/md/dm-crypt.c         |  7 +++----
>   drivers/md/dm-flakey.c        |  7 +++----
>   drivers/md/dm-linear.c        |  7 +++----
>   drivers/md/dm-zone.c          | 23 ++++++++++++++++++++---
>   include/linux/device-mapper.h |  3 ++-
>   5 files changed, 31 insertions(+), 16 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
