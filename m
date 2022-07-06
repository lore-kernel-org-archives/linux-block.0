Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E14CCA47F
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 15:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiGFPau (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 11:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbiGFPas (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 11:30:48 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2641237E3
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 08:30:46 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id r14so16801624wrg.1
        for <linux-block@vger.kernel.org>; Wed, 06 Jul 2022 08:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XvMk995wzgnDDJsq9K/qXkIeP50uy/sMjQBxeoI5vHk=;
        b=NmLWPv6cZi3OQRugb2BHz1FgXTQE0fj+sYiYqmA62aahb5JGE2HS6mcPqy3WdCiuPe
         nPrw4WfXoSsc8K4YO+6Vot5dUSa6L3cT+Sd7rzJUcCTsqN7zBt+BQF8Vc8pZGZnummGk
         oxEpGTdVhZee50zltQluxXwnxDjA9/T+kIvbcw/2p2ShcU2RnEqXViwghlK/iqZbumw4
         siGZ38G0j6jUuQTzcWfhBqImSaVOi6EBqMv7hbfWTFERMUwqQUvTo21IB8XshcdKSHp5
         F8BfwXeI8rjL+REkBrv/Isnx6okDGbpR+AgGdYL/gjy0rqDYoIaGnLFQ2ss+jqeABlQ4
         qNLQ==
X-Gm-Message-State: AJIora86x7KnzYfLG0BPr4jFYK3+8pgGK4yG9LVxVOwbE/M036VHk7hX
        HW9u/jF/AD0i/b+MT9JougNEsLV7p1Y=
X-Google-Smtp-Source: AGRyM1vcVnSxSH3WsC7XW58OYK6cjX6DhrmMF3Sf0/0iIGolBMboRP/Fm0D47hTciu30fK/aNaVDgw==
X-Received: by 2002:adf:ffc1:0:b0:21d:66a1:c3ee with SMTP id x1-20020adfffc1000000b0021d66a1c3eemr17797653wrs.364.1657121445291;
        Wed, 06 Jul 2022 08:30:45 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b0021d7ae38ca2sm2733195wrp.55.2022.07.06.08.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 08:30:44 -0700 (PDT)
Message-ID: <0a8099e6-6e28-da1f-7b4b-0ea04fa8f9d6@grimberg.me>
Date:   Wed, 6 Jul 2022 18:30:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] nvme/rdma: nvme connect failed after offline one cpu
 on host side
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <CAHj4cs9+F5F-v_2m=MYd8B=dXVgTBrtGikTTzfBU8_cX8fb0=g@mail.gmail.com>
 <CAHj4cs_RUuiOw4pzSD+fv70p6izVMZ8z7mc+E0Kv0Rh8zriWCQ@mail.gmail.com>
 <2c42c70a-8eb4-a095-1d2b-139614ebd903@grimberg.me> <YsOKnb7MWLCeJxBE@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YsOKnb7MWLCeJxBE@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> update the subject to better describe the issue:
>>>
>>> So I tried this issue on one nvme/rdma environment, and it was also
>>> reproducible, here are the steps:
>>>
>>> # echo 0 >/sys/devices/system/cpu/cpu0/online
>>> # dmesg | tail -10
>>> [  781.577235] smpboot: CPU 0 is now offline
>>> # nvme connect -t rdma -a 172.31.45.202 -s 4420 -n testnqn
>>> Failed to write to /dev/nvme-fabrics: Invalid cross-device link
>>> no controller found: failed to write to nvme-fabrics device
>>>
>>> # dmesg
>>> [  781.577235] smpboot: CPU 0 is now offline
>>> [  799.471627] nvme nvme0: creating 39 I/O queues.
>>> [  801.053782] nvme nvme0: mapped 39/0/0 default/read/poll queues.
>>> [  801.064149] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
>>> [  801.073059] nvme nvme0: failed to connect queue: 1 ret=-18
>>
>> This is because of blk_mq_alloc_request_hctx() and was raised before.
>>
>> IIRC there was reluctance to make it allocate a request for an hctx even
>> if its associated mapped cpu is offline.
>>
>> The latest attempt was from Ming:
>> [PATCH V7 0/3] blk-mq: fix blk_mq_alloc_request_hctx
>>
>> Don't know where that went tho...
> 
> The attempt relies on that the queue for connecting io queue uses
> non-admined irq, unfortunately that can't be true for all drivers,
> so that way can't go.

The only consumer is nvme-fabrics, so others don't matter.
Maybe we need a different interface that allows this relaxation.

> So far, I'd suggest to fix nvme_*_connect_io_queues() to ignore failed
> io queue, then the nvme host still can be setup with less io queues.

What happens when the CPU comes back? Not sure we can simply ignore it.

> Otherwise nvme_*_connect_io_queues() could fail easily, especially for
> 1:1 mapping.
