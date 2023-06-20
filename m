Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EADEB64D7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 13:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjFTNk6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 09:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjFTNk4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 09:40:56 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6E11704
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 06:40:54 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso11358585e9.0
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 06:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687268452; x=1689860452;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1OGu2pUm28FpsvyFdHhbo2XJa+AfqIAoqGJyzvHHWk=;
        b=eG7DCifX6P5p0cYJLMIOWZ6LvbD2pEz1pTtsSKAy238HyUsoiNZGJ3q8nHoZR4kDGm
         izhmpuUIQgQ5Vm97ntJa50OtvvExj0h0Hc0KWPjUA6IyI3kp6Enok7NlZfYFeUQbrzKv
         Tgy03s2v5FUXLtus654EOygNF6vZ4C+o1aSOXRnt0VS9WhzXdHnx7SHd7D/lnHOactoJ
         jf/LRFtYfqfNA5c93rCeDuWOagcr0gAifC817CLnradYjAO76K/gPBWZbcc4QaraK7xF
         OW18hHCpD4drmUwlZe5eRUNua6cc4OjYH5fs34m8lyfv4Rg0+gbdk3APzfnVj8R54wzS
         0wYg==
X-Gm-Message-State: AC+VfDwEtv/qaWtGDRiuxFPocLCVlIkCWuAJU7vntCvYAlYT5Fku2dmP
        SUc9VmNdPLpqiYtbybUGuTI=
X-Google-Smtp-Source: ACHHUZ44cJuwkesDtL/NECGnennY0w2wAzhofWrWomZyX6RfBqrcD+4K0hy3nY3ufEffsP7ax+cdDA==
X-Received: by 2002:a1c:ed05:0:b0:3f5:927:2b35 with SMTP id l5-20020a1ced05000000b003f509272b35mr10919124wmh.1.1687268452542;
        Tue, 20 Jun 2023 06:40:52 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003f7e4d143cfsm2399517wmi.15.2023.06.20.06.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:40:52 -0700 (PDT)
Message-ID: <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
Date:   Tue, 20 Jun 2023 16:40:49 +0300
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
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> Hello,
>>>
>>> The 1st three patch fixes io hang when controller removal interrupts error
>>> recovery, then queue is left as frozen.
>>>
>>> The 4th patch fixes io hang when controller is left as unquiesce.
>>
>> Ming, what happened to nvme-tcp/rdma move of freeze/unfreeze to the
>> connect patches?
> 
> I'd suggest to handle all drivers(include nvme-pci) in same logic for avoiding
> extra maintain burden wrt. error handling, but looks Keith worries about the
> delay freezing may cause too many requests queued during error handling, and
> that might cause user report.

For nvme-tcp/rdma your patch also addresses IO not failing over because
they block on queue enter. So I definitely want this for fabrics.

AFAICT nvme-pci would also want to failover asap for dual-ported
multipathed devices, not sure if this is something that we are
interested in optimizing though, as pci either succeeds the reset,
or removes the gendisk. But the time-frame is different for fabrics
for sure.
