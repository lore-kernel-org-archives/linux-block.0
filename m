Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9817AC43219
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80CE6610A2
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 18:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhJLS62 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbhJLS6Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 14:58:24 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42F5C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:56:22 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r134so15939iod.11
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 11:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sjHMxprO6yk65cpDD0EYudGzOPnaRVtiZ+7ihmXOJnc=;
        b=WcafrDj+wnD4+Dz9Wyau5G8vy6zjW4HWSI92CbjnQmpA+wqVQH7iOYKgF7/KBdVQ7n
         4t4uXCfXnBL+HjPiM8cYCm5K78dyoS56CdJAIHKe31BSpzDXXp3ZUw0CAUn1yU7DOKGF
         Ajbb71PN/0SxaYzoEasah1iGDb+r50ZwPgdZXdn0qS+83L85doHEakfCB04WhWa1ro4H
         uY8smPUQyawCP7c0h/bno+QIZslfxwIa4FYLH9o4HtVy+gMC/wTadDs2QZyp4GabuDA2
         Hh/069AVHuTobeIUU6dpX/NzA77Hf3pQdCIca0Nhn6XG4huVmGjjulw2pbGe+2DNyOAM
         UdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sjHMxprO6yk65cpDD0EYudGzOPnaRVtiZ+7ihmXOJnc=;
        b=xRIejNY/SioIvyFBEqFTnILHo5SZM18119hzR0c8CPhylLjn14aL3xM1Zg4CGHRqRz
         ToJVJi5+i8qFxLKvflvX/zwDa+sOniTm0xs4vDdP2Nuxv8E16tXGw479mtw2Zs2unQY9
         YkLOStmlMILdLa/p29ab0TXvnqcba5QSYaTKAvL47P554BrLaQWfTlA1GhpjQE9HiQKw
         7ask0yTXToufnOVuPzS0gIR0Xkm+v4myZ8NV1sXXt5jTMs/JTRYgjNUQ/Ov0AywvP8o3
         E4CUPlAQRVWCIxlkGs3wxgtMNeVW2anrdbH0pU0qSDIhlnBgKhpZhMckjWgbwC0LNNE/
         ClVw==
X-Gm-Message-State: AOAM533sE/9ROaUU3JzObxrZLVwUElrvaw9aBLNqJgf/vvakWGKwO05a
        Wl9OezEEVVsUxIqgK0s0jTgXTTRHh1ZgeQ==
X-Google-Smtp-Source: ABdhPJwXl3BqxDSlVgSu5RpyRquGMBkY6tGHCbu7INLGsqSd5rmXb/tjoaJL4A9C6pP0lHZ9nphfdg==
X-Received: by 2002:a02:c6ca:: with SMTP id r10mr9910047jan.111.1634064982321;
        Tue, 12 Oct 2021 11:56:22 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b7sm5338256ilq.65.2021.10.12.11.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 11:56:21 -0700 (PDT)
Subject: Re: [PATCH] nvme: don't memset() the normal read/write command
To:     Keith Busch <kbusch@kernel.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <b38d0d5c-191a-68cd-f6fb-5662706dc366@kernel.dk>
 <20211012183107.GA636540@dhcp-10-100-145-180.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <186c4aed-23eb-05f4-b310-0b0d091e2223@kernel.dk>
Date:   Tue, 12 Oct 2021 12:56:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211012183107.GA636540@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/21 12:31 PM, Keith Busch wrote:
> On Tue, Oct 12, 2021 at 12:13:52PM -0600, Jens Axboe wrote:
>> This memset in the fast path costs a lot of cycles on my setup. Here's a
>> top-of-profile of doing ~6.7M IOPS:
>>
>> +    5.90%  io_uring  [nvme]            [k] nvme_queue_rq
>> +    5.32%  io_uring  [nvme_core]       [k] nvme_setup_cmd
>> +    5.17%  io_uring  [kernel.vmlinux]  [k] io_submit_sqes
>> +    4.97%  io_uring  [kernel.vmlinux]  [k] blkdev_direct_IO
>>
>> and a perf diff with this patch:
>>
>>      0.92%     +4.40%  [nvme_core]       [k] nvme_setup_cmd
>>
>> reducing it from 5.3% to only 0.9%. This takes it from the 2nd most
>> cycle consumer to something that's mostly irrelevant.
>>
>> Retain the full clear for the other commands to avoid doing any audits
>> there, and just clear the fields in the rw command manually that we
>> don't already fill.
> 
> Oo, we knew about this optimization *years* ago, yet didn't do anything
> about it! Better late than never.
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2014-May/000837.html

Dang, 2014! Better late than never...

> Acked-by: Keith Busch <kbusch@kernel.org>

Added, thanks.

-- 
Jens Axboe

