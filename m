Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039CAC433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDCB610CC
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhETF7Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 01:59:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:48948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229676AbhETF7O (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 01:59:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 34AEFAD71;
        Thu, 20 May 2021 05:57:53 +0000 (UTC)
Subject: Re: [PATCH v2 08/11] dm: Forbid requeue of writes to zones
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
 <20210520042228.974083-9-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <275d8cc1-495f-54fd-276a-ec1adbca5b04@suse.de>
Date:   Thu, 20 May 2021 07:57:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210520042228.974083-9-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/21 6:22 AM, Damien Le Moal wrote:
> A target map method requesting the requeue of a bio with
> DM_MAPIO_REQUEUE or completing it with DM_ENDIO_REQUEUE can cause
> unaligned write errors if the bio is a write operation targeting a
> sequential zone. If a zoned target request such a requeue, warn about
> it and kill the IO.
> 
> The function dm_is_zone_write() is introduced to detect write operations
> to zoned targets.
> 
> This change does not affect the target drivers supporting zoned devices
> and exposing a zoned device, namely dm-crypt, dm-linear and dm-flakey as
> none of these targets ever request a requeue.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   drivers/md/dm-zone.c | 17 +++++++++++++++++
>   drivers/md/dm.c      | 18 +++++++++++++++---
>   drivers/md/dm.h      |  5 +++++
>   3 files changed, 37 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
