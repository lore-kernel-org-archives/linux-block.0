Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC941EB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 10:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjFUKOF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjFUKNs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 06:13:48 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3971BD2
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 03:13:14 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f80b192aecso13206245e9.1
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 03:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687342388; x=1689934388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2ziSSDnHmXzqyopdHEpI90tpZriUVyJ27mmVdNAibQ=;
        b=OkZinQZ7MY+fkQbPisy8O6EF1GGecL86Qsw1m7ikIgObcLJjRjNHBUU1GXW2kg7AlY
         cKs8OgnyXB56KleO4C8vC509+T8LLEj7vD1Yn27D2NuGcVVrqETQ/k315+B9OQDGG3YY
         4CHfWR39Ecu5HcPLXOVHKxrgYLdbC9FBZ3o8kcmkLgHqrcc7wmz/LM9Eir3dyhKlo6Dj
         sLwsHApeF+kgIJpRQPEJBtBIuVx98y7Nhee8s9kWpW2zE3uMbpXO025YN9rCf2qdzhxO
         vhD0xqi/bRAEE1pTaXB/RHpttVNYJqAz8S5omqlpBqcc+gkMJTu1e5sdmdLxNmWEPN3s
         e47A==
X-Gm-Message-State: AC+VfDyc7+W4OzqP2y1UNJEkGqHbtNpXGR3RpePhMxRujVzYOb7/01f8
        h+u5CGpo8XB3eoARYclw4zE=
X-Google-Smtp-Source: ACHHUZ51waEdZ8FsyNEQCBlkHeu3MxzAXF5zJdLTOiH5Tcp/JKKq5/qraqY5qK1ij/xekpfSZqA4bg==
X-Received: by 2002:a1c:ed08:0:b0:3f7:369c:c640 with SMTP id l8-20020a1ced08000000b003f7369cc640mr14201347wmh.1.1687342387986;
        Wed, 21 Jun 2023 03:13:07 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t20-20020a1c7714000000b003f900678815sm4517708wmi.39.2023.06.21.03.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 03:13:07 -0700 (PDT)
Message-ID: <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
Date:   Wed, 21 Jun 2023 13:13:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
 <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
 <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
 <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
 <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>> Hello,
>>>>>
>>>>> The 1st three patch fixes io hang when controller removal interrupts error
>>>>> recovery, then queue is left as frozen.
>>>>>
>>>>> The 4th patch fixes io hang when controller is left as unquiesce.
>>>>
>>>> Ming, what happened to nvme-tcp/rdma move of freeze/unfreeze to the
>>>> connect patches?
>>>
>>> I'd suggest to handle all drivers(include nvme-pci) in same logic for avoiding
>>> extra maintain burden wrt. error handling, but looks Keith worries about the
>>> delay freezing may cause too many requests queued during error handling, and
>>> that might cause user report.
>>
>> For nvme-tcp/rdma your patch also addresses IO not failing over because
>> they block on queue enter. So I definitely want this for fabrics.
> 
> The patch in the following link should fix these issues too:
> 
> https://lore.kernel.org/linux-block/ZJGmW7lEaipT6saa@ovpn-8-23.pek2.redhat.com/T/#u
> 
> I guess you still want the paired freeze patch because it makes freeze &
> unfreeze more reliable in error handling. If yes, I can make one fabric
> only change for you.

Not sure exactly what reliability is referred here. I agree that there
is an issue with controller delete during error recovery. The patch
was a way to side-step it, great. But it addressed I/O blocked on enter
and not failing over.

So yes, for fabrics we should have it. I would argue that it would be
the right thing to do for pci as well. But I won't argue if Keith feels
otherwise.
