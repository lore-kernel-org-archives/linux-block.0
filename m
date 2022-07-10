Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FE8C43334
	for <linux-block@archiver.kernel.org>; Sun, 10 Jul 2022 09:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiGJJlj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jul 2022 05:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJJlj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jul 2022 05:41:39 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875E212620
        for <linux-block@vger.kernel.org>; Sun, 10 Jul 2022 02:41:37 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id f2so3560034wrr.6
        for <linux-block@vger.kernel.org>; Sun, 10 Jul 2022 02:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xEuiyabvsQDb6WJ6qFrmFNq916brfyyk43k/L2CuaG0=;
        b=n7mm5erXKD+W37oxaFirbrAjN+mj2L+BDDdgcezh56AZokDYxDC1SaAPYR20J4OX4q
         Y8OvEJpMehbyF4VkMQ3DD6VqFJrtKT1C5T1H9wzy5NI2G+mrnOyVFSEVS0ko5LwHzVb1
         3evD+4NzewWjIt+gOlbEhnon18a1F9OD9Sey1A+aFZDIPgL7Vy1umMWbbAeDzuTgo8Uy
         NWZlYDPEu/KHN1ZpRa4Gxk6FC70MGgl92fbG2KAhHmLm9hles8cZgVoeJ862dYylN+7d
         k9WJA8+zGZ1qYyuH6O3K1a6rmD7jTPn1rui+e8RhmcmeD9sMdS6xpNWE7Y/tFvcuzbGK
         fQJQ==
X-Gm-Message-State: AJIora+56LXtjMCKa7013T4c1NnsSrfp9vsoW10pAftHrpirU/tPs6fT
        i5/9WfWne8Xf90iAczuvMCQVsTqpIhQ=
X-Google-Smtp-Source: AGRyM1tnYHU2kuKbNjQiVLMiKob0GgudW3LLlovKxZOzecsGCXewdaZdgCiaGIy0Ixz+wQEbAeoUhQ==
X-Received: by 2002:adf:c64c:0:b0:21a:7a3:54a4 with SMTP id u12-20020adfc64c000000b0021a07a354a4mr11641836wrg.163.1657446095973;
        Sun, 10 Jul 2022 02:41:35 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d6792000000b0021d4155cd6fsm3235238wru.53.2022.07.10.02.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 02:41:35 -0700 (PDT)
Message-ID: <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
Date:   Sun, 10 Jul 2022 12:41:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hello
> 
> I reproduced this issue on the linux-block/for-next, pls help check
> it, feel free to let me know if you need info/test, thanks.


These reports are making me tired... Should we just remove
MEM_RECLAIM from all nvme/nvmet workqueues are be done with
it?

The only downside is that nvme reset/error-recovery will
also be susceptible for low-memory situation...

Christoph, Keith, what are your thoughts?
