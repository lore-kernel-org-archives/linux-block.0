Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2BCECDFA1
	for <linux-block@archiver.kernel.org>; Mon, 24 Oct 2022 08:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJXIsN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Oct 2022 04:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJXIsM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 04:48:12 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F074C627
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 01:48:11 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id b20-20020a05600c4e1400b003cc28585e2fso2829434wmq.1
        for <linux-block@vger.kernel.org>; Mon, 24 Oct 2022 01:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHtF9ER2Or/nLigCVnn/Rwp4YAkOBbty21/0YYZd0eM=;
        b=Sr7EIlES1+W8Uj92azaZtFKqu7MjdPwaO6LTUkAtHYKY48jGs8igWLNpdaL0X4SU9j
         zRtKdts2BYR1ksomZDBpa9NdQNADBaAZ7HJdrFleA9syOnrxhP7F1F/ZAHqS1UXBtZRe
         dsOI11FEmFg6OsHWaamAxV/Tw/mr9bgiSoS+zFwUoul05TXLPY47bU4Mjy/153dAocA2
         Ez5PQAi/fDYptweAvdWqe6pkQPhvXkMf9EuyaoppxZStt1rux+qToq5JSE42g/vzC99S
         6yTZEgbjLcnfS7n/VOzZoimceZO4hIwi0kjX0QeZnzdL5j0r0CyYGj3eRHbzePqmwS1k
         I0SA==
X-Gm-Message-State: ACrzQf1etob/WTq2fHImzQCKFOSe9JZ7P/S6D5kqGVj4kMHcNdvrwF0n
        IIw2kgnaBrW/nMGFQr8ldcY=
X-Google-Smtp-Source: AMsMyM6Rhf5JxAEKMXIy0ZoLMiuAbPkfy1l5rP155lk6IZ22YaJ7mbHRCic1wXvL2q02rWJ7Un6f1Q==
X-Received: by 2002:a05:600c:54f2:b0:3c6:bd60:5390 with SMTP id jb18-20020a05600c54f200b003c6bd605390mr42004705wmb.206.1666601290328;
        Mon, 24 Oct 2022 01:48:10 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b1-20020adfe641000000b002206203ed3dsm9774655wrn.29.2022.10.24.01.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 01:48:09 -0700 (PDT)
Message-ID: <0d4dbbe6-f9da-1a49-1aa7-4610c6dea6e3@grimberg.me>
Date:   Mon, 24 Oct 2022 11:48:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 7/8] nvme: remove nvme_set_queue_dying
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-8-hch@lst.de>
 <55dfcd8e-c2f5-d064-bd4f-770383fc5305@grimberg.me>
 <20221021132950.GF22327@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221021132950.GF22327@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> I have to say that I always found nvme_kill_queues interface somewhat
>> odd.
> 
> It is..
> 
>> its a core function that unquiesces the admin/io queues
>> assuming that they were stopped at some point by the driver.
>>
>> If now there is no dependency between unquiesce and blk_mark_disk_dead,
>> maybe it would be a good idea to move the unquiescing to the drivers
>> which can pair with the quiesce itself, and rename it to
>> nvme_mark_namespaces_dead() or something?
> 
> Yes, something like that is probably a good idea.  This entire area
> is a bit of a mess to say it mildly, so maybe we need to sort that
> out first.

I agree.
