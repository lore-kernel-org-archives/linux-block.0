Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38652C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 13:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbiGNNPD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239692AbiGNNO5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 09:14:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC2F4A829
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 06:14:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w185so1820523pfb.4
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WuVjgSu19AxeIq7zXdfNT4Js6AYDBoMQtJ/IbUxVIjw=;
        b=5asObrFz85YO5EShuHHnWf4gxYRgQotZnabKx2XXp7wVsMP1kV72lbX7lIhwXN8FlY
         sXopxPKXAfrABPJEcbRh4QVElqUhg7rxV34UjBguO9L3Hv6Rlz6Aybbn7cRzlAMr/lyQ
         8qJZuC54pYhwi0BrKk4CNycSBiMrGN2YwKrVkyThYmG+j5SjMJKRo+39/6TkZk1kgX/K
         obYDGKdTWcuwi1UCfPGXfaBd/Lq2wS/RzydlRHaDNLQ2O8SzswBlUaZQ+c6CJ7sL5N2T
         GkWWeEbUGoH7QYkWhOnGhHMzBpVQ29CGSNHDmvbsmsu9UG7EgH64Z/Fks4mrcIDvBxIZ
         PG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WuVjgSu19AxeIq7zXdfNT4Js6AYDBoMQtJ/IbUxVIjw=;
        b=ZIFNWmylhyQVJB86LWJu0DOcKLysKLuU0EJhaB61myJ5uIJjCAYMDg4Mc+7+kBMlGw
         KovA12fxE1mSfKKcULugWeHlw9E6aKIvJbpN1YO+UPu8ros/L4f8/YstwUAOFaD+uV7T
         oyI65wpce8bL7//nD8mkukhFxZpzxEnAp4MkNbWaMi30N5EFzpFf97OgGprwgyZEQEXy
         +reItbkQoWfSAAq76CbKiEdxuDjwM41EGsnX2qzI7D35BrXcXiZ5SMF4Dd//xk0UEzQb
         58YQwdvtV4M2dBF1aH+9DR0hI0OVFC0pFoJ/yBn/YrBPejUl8T39+/Mvm2zGme2GwZrK
         dVVQ==
X-Gm-Message-State: AJIora9MzhIlvGJtE063E+n5Bs6hyxBnUWdmGt+xqSddgl97z5VJIhyF
        Z7VeKTmhAYWjYR4mdwcp91v4gbT77ZgMIw==
X-Google-Smtp-Source: AGRyM1ucfHkwxxHHH8B99gHcKx29Dp0WpeiP2XtpNMYd4Ta+Z9av/hzw7t+c0Uoh0dYNKakG7cgdpg==
X-Received: by 2002:a63:fc55:0:b0:412:a6e8:b974 with SMTP id r21-20020a63fc55000000b00412a6e8b974mr7739020pgk.279.1657804493999;
        Thu, 14 Jul 2022 06:14:53 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d75-20020a621d4e000000b0052896629f66sm1618353pfd.208.2022.07.14.06.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 06:14:53 -0700 (PDT)
Message-ID: <8afcfc87-966e-4e19-8b09-a9f25cd8e442@kernel.dk>
Date:   Thu, 14 Jul 2022 07:14:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ublk_drv: fix request queue leak
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20220714103201.131648-1-ming.lei@redhat.com>
 <47f6931d-5bb3-bc7e-51db-ef2e9d54d01b@kernel.dk> <YtAVraMgY9XsJ8JU@T590>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YtAVraMgY9XsJ8JU@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/14/22 7:10 AM, Ming Lei wrote:
> On Thu, Jul 14, 2022 at 07:00:59AM -0600, Jens Axboe wrote:
>> On 7/14/22 4:32 AM, Ming Lei wrote:
>>> Call blk_cleanup_queue() in release code path for fixing request
>>> queue leak.
>>>
>>> Also for-5.20/block has cleaned up blk_cleanup_queue(), which is
>>> basically merged to del_gendisk() if blk_mq_alloc_disk() is used
>>> for allocating disk and queue.
>>>
>>> However, ublk may not add disk in case of starting device failure, then
>>> del_gendisk() won't be called when removing ublk device, so blk_mq_exit_queue
>>> will not be callsed, and it can be bit hard to deal with this kind of
>>> merge conflict.
>>>
>>> Turns out ublk's queue/disk use model is very similar with scsi, so switch
>>> to scsi's model by allocating disk and queue independently, then it can be
>>> quite easy to handle v5.20 merge conflict by replacing blk_cleanup_queue
>>> with blk_mq_destroy_queue.
>>
>> Tried this with the below incremental added to make it compile with
>> the core block changes too, and it still fails for me:
>>
>> [   22.488660] WARNING: CPU: 0 PID: 11 at block/blk-mq.c:3880 blk_mq_release+0xa4/0xf0
>> [   22.490797] Modules linked in:
>> [   22.491762] CPU: 0 PID: 11 Comm: kworker/0:1 Not tainted 5.19.0-rc6-00322-g42ed61fe42f3-dirty #1609
>> [   22.494659] Hardware name: linux,dummy-virt (DT)
>> [   22.496171] Workqueue: events blkg_free_workfn
>> [   22.497652] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   22.499965] pc : blk_mq_release+0xa4/0xf0
>> [   22.501386] lr : blk_mq_release+0x44/0xf0
>> [   22.502748] sp : ffff80000af73cb0
>> [   22.503880] x29: ffff80000af73cb0 x28: 0000000000000000 x27: 0000000000000000
>> [   22.506263] x26: 0000000000000000 x25: ffff00001fe47b05 x24: 0000000000000000
>> [   22.508655] x23: ffff0000052b6cb8 x22: ffff0000031e1c38 x21: 0000000000000000
>> [   22.511035] x20: ffff0000031e1cf0 x19: ffff0000031e1bf0 x18: 0000000000000000
>> [   22.513427] x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffa8000b80
>> [   22.515814] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000001
>> [   22.518209] x11: ffff80000945b7e8 x10: 0000000000006cb9 x9 : 00000000ffffffff
>> [   22.520600] x8 : ffff800008fb5000 x7 : ffff80000860cf28 x6 : 0000000000000000
>> [   22.522987] x5 : 0000000000000000 x4 : 0000000000000028 x3 : ffff80000af73c14
>> [   22.525363] x2 : ffff0000071ccaa8 x1 : ffff0000071ccaa8 x0 : ffff0000071cc800
>> [   22.527624] Call trace:
>> [   22.528473]  blk_mq_release+0xa4/0xf0
>> [   22.529724]  blk_release_queue+0x58/0xa0
>> [   22.530946]  kobject_put+0x84/0xe0
>> [   22.531821]  blk_put_queue+0x10/0x18
>> [   22.532716]  blkg_free_workfn+0x58/0x84
>> [   22.533681]  process_one_work+0x2ac/0x438
>> [   22.534872]  worker_thread+0x1cc/0x264
>> [   22.535829]  kthread+0xd0/0xe0
>> [   22.536598]  ret_from_fork+0x10/0x20
>>
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index eeeac43e1dc1..d818da818c00 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -1078,7 +1078,7 @@ static void ublk_cdev_rel(struct device *dev)
>>  {
>>  	struct ublk_device *ub = container_of(dev, struct ublk_device, cdev_dev);
>>  
>> -	blk_cleanup_queue(ub->ub_queue);
>> +	blk_put_queue(ub->ub_queue);
> 
> I guess you run test on for-next, and it should work by just replacing
> two blk_cleanup_queue with blk_mq_destroy_queue().

Ah yes, that does the trick. I think I'll migrate the driver to the core
branch instead to avoid these issues.

-- 
Jens Axboe

