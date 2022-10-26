Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DC6C433FE
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 12:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiJZM61 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 08:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiJZM60 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 08:58:26 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AF4F63C2
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:58:25 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id v1so26164588wrt.11
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CkziyNulvuCpKttkp9fhQ/YdQN74JvF7A8TDwagZTBg=;
        b=w5ab7l1hr1utKT/xUZsQqd1AXMLggf9Nu0e8BLjgKU47P4nEUSor8uQaxpQFD4YAcL
         G/7Q46IDzPz1UCzpwqLmX5EaXfR1apPQYztoTuE0hPQVdWK/owCrst+NBqhP2fmzApp2
         NsXgfsb82Y1Jif9e/wyx1jgizACPedc2dCNtGQXoNWPv9EX4vhPoMlPtFw99lzgH2860
         aPFwp1OlZsFSZuaKRDvQ7DW0XDYjbwuQaKT7n6k3iACe82qzwwyTBK94rw2URuSAZ6Kk
         Ij1takffk53XHLyCCV+3xWpFC7PaSjp55iOrhNpRsmHDef6JR6OAA1Z5v0HLZZQs5RBk
         uqAg==
X-Gm-Message-State: ACrzQf2ULjauYVih/PLUOgkzJDCP8VMkHFqfNuvF9AOb49fqnPfMrGgx
        q5zX4oUexgUZpH7WN/hi9hQ=
X-Google-Smtp-Source: AMsMyM4RiM1dHUoUivbMPNSZHt0bj3Qv5wBN5O/ZJfLCeamLL9SzyRj2Dnzni9o7VWFNqOL00qqQkg==
X-Received: by 2002:adf:dd0f:0:b0:236:2f7f:4cce with SMTP id a15-20020adfdd0f000000b002362f7f4ccemr21392799wrm.347.1666789104084;
        Wed, 26 Oct 2022 05:58:24 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v14-20020adfedce000000b00228dbf15072sm5346836wro.62.2022.10.26.05.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:58:23 -0700 (PDT)
Message-ID: <224ee1a1-e5ef-6644-36c4-8c1d84af10b0@grimberg.me>
Date:   Wed, 26 Oct 2022 15:58:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 11/17] nvme-pci: don't unquiesce the I/O queues in
 nvme_remove_dead_ctrl
Content-Language: en-US
To:     Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-12-hch@lst.de>
 <cf78bcbb-b918-e9f5-186a-d1d804406011@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <cf78bcbb-b918-e9f5-186a-d1d804406011@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> nvme_remove_dead_ctrl schedules nvme_remove to be called, which will
>> call nvme_dev_disable and unquiesce the I/O queues.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   drivers/nvme/host/pci.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index bef98f6e1396c..3a26c9b2bf454 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -2794,7 +2794,6 @@ static void nvme_remove_dead_ctrl(struct 
>> nvme_dev *dev)
>>       nvme_get_ctrl(&dev->ctrl);
>>       nvme_dev_disable(dev, false);
> Currently set the parameter "shutdown" to false, nvme_dev_disable() do 
> not unquiesce the queues.
> Actually we should set the parameter "shutdown" to true.
>          nvme_dev_disable(dev, true);

But the final put will trigger nvme_remove no?
