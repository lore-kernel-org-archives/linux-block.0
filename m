Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D9AC48BE5
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 15:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E5960FF1
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 15:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhFPPu7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 11:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbhFPPuk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 11:50:40 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549F8C08E79C
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 08:43:08 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id z1so2790022ils.0
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wAO8ZYobK2OXjZEEGgDhUWu+oZCUKjx9jOB5Y2qM7Xw=;
        b=O/S4Suz7kqdsCYAYPOfD089VNWcNOcmlOD/BAbBA+vhuXkum+WdiXkbSjdzJQpX7vC
         rsLs11zlAQ5AZHAHoX63f8px2UVpPz1MCHLYoNbDADJAJ6dmu/h8Sen46hn8Sz7VVE7G
         3cgzBYDWlvBx4oLSpGklcI/Z7U9DSMXhI67uZevNlLwppMv0SxfCj9U1WlcalMzYSJCD
         m1h1ephRoz95E/uufVkxitMXDY+52G90IWu+FZeYJQmONg7njZLdrRmCKZq+3tvC/m6w
         HTY4mkL3ln6Nl52FEPPqkEmKtAhfEnm4B9majVegvdONfmxYTsSFVSO7Lz8ekFqJIRb+
         shGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wAO8ZYobK2OXjZEEGgDhUWu+oZCUKjx9jOB5Y2qM7Xw=;
        b=ppid8NQO8mwou+OAyPFopQeRgwxh+EXI37qx1OvtSTfbOjB6YMi/dFjE2O/cybNV1d
         rNNBi3z0kIKKtanHli4SWUkYQXSr0rZfh7LfCiI9T5H5WoDBhNq6iCTZzLB6JNQSItjb
         uyn/tFlF5A8zrekiPTrX+nXHlDIdteAQ+Wuovj5u8VmjQxoRvbu7YbPhZ5WygBwZ3AK3
         pcvP/MAHf2u7Au+7tRMlCGDHhtpvuZlnOxiGxyacDPLL7TYldZAH0q1IV3EpXq/oPz+p
         ZUSlc043bie4dc78nQqyIFawcXS5WhBMW/z1xggov7FkZ28hr47NcriaYB+r31q92oUk
         1zPQ==
X-Gm-Message-State: AOAM533POZaKb7OfyQ7Vsj50OXIcSHwTYsz2RNEaSUXJbiz9yjyuX0Cp
        qzUIvicYx1yns69saVCd2/2ZXZ1C5a+QOceb
X-Google-Smtp-Source: ABdhPJw4EVxymZe9nbaXu2c1Z1VB5/3dLcWfP7dd3/BLZuNtGSzI6pgoNLK8sp/K8HeKGMHu+aGnTg==
X-Received: by 2002:a92:8708:: with SMTP id m8mr191585ild.295.1623858187647;
        Wed, 16 Jun 2021 08:43:07 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x2sm1333365iox.15.2021.06.16.08.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 08:43:07 -0700 (PDT)
Subject: Re: [PATCH v2] block: Do not pull requests from the scheduler when we
 cannot dispatch them
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>
References: <20210603104721.6309-1-jack@suse.cz>
 <20210616154038.GA18520@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d61be138-7fc2-76d6-d01f-6ec555e46f29@kernel.dk>
Date:   Wed, 16 Jun 2021 09:43:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210616154038.GA18520@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/21 9:40 AM, Jan Kara wrote:
> On Thu 03-06-21 12:47:21, Jan Kara wrote:
>> Provided the device driver does not implement dispatch budget accounting
>> (which only SCSI does) the loop in __blk_mq_do_dispatch_sched() pulls
>> requests from the IO scheduler as long as it is willing to give out any.
>> That defeats scheduling heuristics inside the scheduler by creating
>> false impression that the device can take more IO when it in fact
>> cannot.
>>
>> For example with BFQ IO scheduler on top of virtio-blk device setting
>> blkio cgroup weight has barely any impact on observed throughput of
>> async IO because __blk_mq_do_dispatch_sched() always sucks out all the
>> IO queued in BFQ. BFQ first submits IO from higher weight cgroups but
>> when that is all dispatched, it will give out IO of lower weight cgroups
>> as well. And then we have to wait for all this IO to be dispatched to
>> the disk (which means lot of it actually has to complete) before the
>> IO scheduler is queried again for dispatching more requests. This
>> completely destroys any service differentiation.
>>
>> So grab request tag for a request pulled out of the IO scheduler already
>> in __blk_mq_do_dispatch_sched() and do not pull any more requests if we
>> cannot get it because we are unlikely to be able to dispatch it. That
>> way only single request is going to wait in the dispatch list for some
>> tag to free.
>>
>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>> Signed-off-by: Jan Kara <jack@suse.cz>
>> ---
>>  block/blk-mq-sched.c | 12 +++++++++++-
>>  block/blk-mq.c       |  2 +-
>>  block/blk-mq.h       |  2 ++
>>  3 files changed, 14 insertions(+), 2 deletions(-)
>>
>> Jens, can you please merge the patch? Thanks!
> 
> Ping Jens?

Didn't I reply? It's merged for a while:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.14/block&id=613471549f366cdf4170b81ce0f99f3867ec4d16

-- 
Jens Axboe

