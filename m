Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF5EECDFA1
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 08:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJXIun (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 04:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiJXIum (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 04:50:42 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC75846871
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 01:50:26 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id t4so6108323wmj.5
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 01:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18lRdCEX4yLQYFCKAwJMvIINT0nyFi41bx4NPe/PekE=;
        b=ZxpvjEDFjdz96xMKmfHv1zTuU/nrAz5OrFxuJu/tPdXBA/4xvHUg1HOXHgGDY7Vmp9
         ZpFMiM99jOLHI47GU7vzBO9dUdxdbIF9frs6nv45QcACMWGZaqXbThR9SHvdXVgpCJuq
         Rv0CChRPOn8n3GvkPth6xiV+sC0h0KWS36zy0tZ60X36hnzvwin26Z+OiRXzwYsYrsA9
         L2FDei7oMkYtMhNj6rvUGIp29oLcyy/42Z9A4Jm4+L6ScZL81U7wlIIHyQu0UnfyVzHB
         p0nXrjfihrMKoDn03zJHs1cbO+C0pTYbNQO8htzdkY/iA7D/lpzt3lPL/im6zEy+Pdq5
         HKdg==
X-Gm-Message-State: ACrzQf0YXo497XQe5x5BHQk8dYgWA0ZEdSu17W/CgLCd/H/eIGLECG/Z
        vL+r/ANabJ3Xu9X8NT945iQ=
X-Google-Smtp-Source: AMsMyM55fommkUFOgu8vFZ05nbPW5Or2bLoCsnfUY0atwg+dAF5w8rexofq3CG6mqF5LCUlzBi5d/A==
X-Received: by 2002:a05:600c:1913:b0:3c7:32c8:20f1 with SMTP id j19-20020a05600c191300b003c732c820f1mr11064467wmq.81.1666601424609;
        Mon, 24 Oct 2022 01:50:24 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a10-20020a056000188a00b0022e344a63c7sm26706921wri.92.2022.10.24.01.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 01:50:24 -0700 (PDT)
Message-ID: <45eea8bb-7322-6555-8181-40f57c42d337@grimberg.me>
Date:   Mon, 24 Oct 2022 11:50:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 6/8] nvme: move the NS_DEAD flag to the controller
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-7-hch@lst.de>
 <ac33021a-b7a1-37cf-b156-df021ac4de43@grimberg.me>
 <20221021132815.GE22327@lst.de>
 <7d93b4fe-f88b-2d2c-e58d-396e03f3bc72@grimberg.me>
In-Reply-To: <7d93b4fe-f88b-2d2c-e58d-396e03f3bc72@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> -
>>>> +    if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
>>>> +        list_for_each_entry(ns, &ctrl->namespaces, list)
>>>> +            nvme_set_queue_dying(ns);
>>>> +    }
>>>
>>> Looking at it now, I'm not sure I understand the need for this flag. It
>>> seems to make nvme_kill_queues reentrant safe, but the admin queue
>>> unquiesce can still end up unbalanced under reentrance?
>>>
>>> How is this not broken today (or ever since quiesce/unquiesce started
>>> accounting)? Maybe I lost some context on the exact subtlety of how
>>> nvme-pci uses this interface...
>>
>> Yes, this also looks weird and I had a TODO list entry for myself
>> to look into what is going on here.  The whole interaction
>> with nvme_remove_namespaces is pretty weird to start with,

git blame points to:
0ff9d4e1a284 ("NVMe: Short-cut removal on surprise hot-unplug")

But it is unclear as to why it sits in nvme_remove_namespaces instead
of somewhere before that in nvme_remove()...

Keith?
