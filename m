Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8FAC433ED
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C057611BD
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 05:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhETGBB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 02:01:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:49292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhETGBB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 02:01:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2D2FAD71;
        Thu, 20 May 2021 05:59:39 +0000 (UTC)
Subject: Re: [PATCH v2 09/11] dm: rearrange core declarations
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210520042228.974083-1-damien.lemoal@wdc.com>
 <20210520042228.974083-10-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5d5447dc-6e07-63af-9cc6-c7bf68c99e52@suse.de>
Date:   Thu, 20 May 2021 07:59:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210520042228.974083-10-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/21 6:22 AM, Damien Le Moal wrote:
> Move the definitions of struct dm_target_io, struct dm_io and of the
> bits of the flags field of struct mapped_device from dm.c to dm-core.h
> to make them usable from dm-zone.c.
> For the same reason, declare dec_pending() in dm-core.h after renaming
> it to dm_io_dec_pending(). And for symmetry of the function names,
> introduce the inline helper dm_io_inc_pending() instead of directly
> using atomic_inc() calls.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   drivers/md/dm-core.h | 52 ++++++++++++++++++++++++++++++++++++++
>   drivers/md/dm.c      | 59 ++++++--------------------------------------
>   2 files changed, 59 insertions(+), 52 deletions(-)
> I've never been a fan of private structures.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
