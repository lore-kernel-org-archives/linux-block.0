Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECB6C2B9F7
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 06:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F865613C9
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 06:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhEZGli (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 02:41:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:36696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhEZGli (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 02:41:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622011206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=luqMSXgB8eZm/L0s7EDeJK5BGlD5HxVqyowJH5yTODI=;
        b=h2v38Zrgg0d6k3awg2WYRfSGhaRZzLmlduzFQ2sCYBKSVJlyoaNLJXMP0RjW9Zk6Dv9UH5
        che8XeD5HOt2/ASqxCGB6sofekXIsbH2HyoXm29dIUy1o0JubdbLd2ufk0mAWj4vPBHqP7
        OHeq6hAQTJK7dfAFE/abCkk63A37yJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622011206;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=luqMSXgB8eZm/L0s7EDeJK5BGlD5HxVqyowJH5yTODI=;
        b=nSiWlnJHmz0k2KoKk5T6Y65BjRF5gU1dYnFq20bZTFO8+nRbZKJ/F+al3YU1XGayXRgHXt
        OtV9eRrA6/+69hAQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F375B2A1;
        Wed, 26 May 2021 06:40:06 +0000 (UTC)
Subject: Re: [PATCH v5 10/11] dm: introduce zone append emulation
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
 <20210525212501.226888-11-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <308fa8bd-83a7-0c08-a26e-91fe03d12afd@suse.de>
Date:   Wed, 26 May 2021 08:40:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210525212501.226888-11-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/25/21 11:25 PM, Damien Le Moal wrote:
> For zoned targets that cannot support zone append operations, implement
> an emulation using regular write operations. If the original BIO
> submitted by the user is a zone append operation, change its clone into
> a regular write operation directed at the target zone write pointer
> position.
> 
> To do so, an array of write pointer offsets (write pointer position
> relative to the start of a zone) is added to struct mapped_device. All
> operations that modify a sequential zone write pointer (writes, zone
> reset, zone finish and zone append) are intersepted in __map_bio() and
> processed using the new functions dm_zone_map_bio().
> 
> Detection of the target ability to natively support zone append
> operations is done from dm_table_set_restrictions() by calling the
> function dm_set_zones_restrictions(). A target that does not support
> zone append operation, either by explicitly declaring it using the new
> struct dm_target field zone_append_not_supported, or because the device
> table contains a non-zoned device, has its mapped device marked with the
> new flag DMF_ZONE_APPEND_EMULATED. The helper function
> dm_emulate_zone_append() is introduced to test a mapped device for this
> new flag.
> 
> Atomicity of the zones write pointer tracking and updates is done using
> a zone write locking mechanism based on a bitmap. This is similar to
> the block layer method but based on BIOs rather than struct request.
> A zone write lock is taken in dm_zone_map_bio() for any clone BIO with
> an operation type that changes the BIO target zone write pointer
> position. The zone write lock is released if the clone BIO is failed
> before submission or when dm_zone_endio() is called when the clone BIO
> completes.
> 
> The zone write lock bitmap of the mapped device, together with a bitmap
> indicating zone types (conv_zones_bitmap) and the write pointer offset
> array (zwp_offset) are allocated and initialized with a full device zone
> report in dm_set_zones_restrictions() using the function
> dm_revalidate_zones().
> 
> For failed operations that may have modified a zone write pointer, the
> zone write pointer offset is marked as invalid in dm_zone_endio().
> Zones with an invalid write pointer offset are checked and the write
> pointer updated using an internal report zone operation when the
> faulty zone is accessed again by the user.
> 
> All functions added for this emulation have a minimal overhead for
> zoned targets natively supporting zone append operations. Regular
> device targets are also not affected. The added code also does not
> impact builds with CONFIG_BLK_DEV_ZONED disabled by stubbing out all
> dm zone related functions.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> ---
>   drivers/md/dm-core.h          |  13 +
>   drivers/md/dm-table.c         |  19 +-
>   drivers/md/dm-zone.c          | 580 ++++++++++++++++++++++++++++++++--
>   drivers/md/dm.c               |  38 ++-
>   drivers/md/dm.h               |  16 +-
>   include/linux/device-mapper.h |   6 +
>   6 files changed, 618 insertions(+), 54 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
