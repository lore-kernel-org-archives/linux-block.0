Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CA5C3F2D2
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 10:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509B72467B
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 10:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="gCBpS1Km"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCBKvy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:51:54 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:53838 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727027AbgCBKvy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Mar 2020 05:51:54 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 1AEC12E09C5;
        Mon,  2 Mar 2020 13:51:51 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id xzrWdUQQnx-pox8C8xr;
        Mon, 02 Mar 2020 13:51:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1583146311; bh=c8nRtiIQTy0hYZDBROc/llu6uiBzaMtKduryGQp4LBA=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=gCBpS1KmIO8HmVRphH0wt2/ehafdwEXHTQvpI1t/jpszIVkKnQ4W8mDmJfxzFGbTD
         nvs85msRPN7O6gHUcZeh3uWlwzUE6B10eiF2RgrFmSrxpVSSeSm7rjNGIi9gbHQR8J
         bUuXSS0nTTxOeYwPM2hhd4BPO88uD7rmLcAssvsI=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:7cd4:25a8:c7e3:39e2])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 1HkcgWlnvl-poWebbTs;
        Mon, 02 Mar 2020 13:51:50 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] block: keep bdi->io_pages in sync with max_sectors_kb for
 stacked devices
To:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc:     linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <158290150891.4423.13566449569964563258.stgit@buzz>
 <35ef813c-d5a4-8eb8-073d-9c5814266299@molgen.mpg.de>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <4ce1ccf2-6a7c-818d-bfe3-b9bf29e8be3e@yandex-team.ru>
Date:   Mon, 2 Mar 2020 13:51:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <35ef813c-d5a4-8eb8-073d-9c5814266299@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/03/2020 13.41, Paul Menzel wrote:
> Dear Konstantin,
> 
> 
> Thank you for the patch.
> 
> 
> On 2020-02-28 15:51, Konstantin Khlebnikov wrote:
>> Field bdi->io_pages added in commit 9491ae4aade6 ("mm: don't cap request
>> size based on read-ahead setting") removes unneeded split of read requests.
>>
>> Stacked drivers do not call blk_queue_max_hw_sectors(). Instead they setup
> 
> The verb is spelled with a space *set up*.
> 
>> limits of their devices by blk_set_stacking_limits() + disk_stack_limits().
>> Field bio->io_pages stays zero until user set max_sectors_kb via sysfs.
>>
>> This patch updates io_pages after merging limits in disk_stack_limits().
>>
>> Commit c6d6e9b0f6b4 ("dm: do not allow readahead to limit IO size") fixed
>> the same problem for device-mapper devices, this one fixes MD RAIDs.
> 
> Add a Fixes: tag?
> 
> Fixes: 9491ae4aade6 ("mm: don't cap request size based on read-ahead setting")

Maybe, but this isn't fatal bug. Just incomplete fix.

Same problem exists for non-disk BDIs. I.e. network filesystem must
set io_pages manually if doesn't want split read requests.

> 
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
>>   block/blk-settings.c |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index c8eda2e7b91e..66c45fd79545 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -664,6 +664,8 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
>>   		printk(KERN_NOTICE "%s: Warning: Device %s is misaligned\n",
>>   		       top, bottom);
>>   	}
>> +
>> +	t->backing_dev_info->io_pages = t->limits.max_sectors >> (PAGE_SHIFT-9);
>>   }
>>   EXPORT_SYMBOL(disk_stack_limits);
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul
> 
