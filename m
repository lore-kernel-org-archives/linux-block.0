Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A47C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 22:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiGUWPA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 18:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiGUWOm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 18:14:42 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A266495B2E
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 15:13:56 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id k11so3709977wrx.5
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 15:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yMhGUzKhO4q8vsmNjx8vSM3P6eQxLqlaQgZs81EVo2k=;
        b=e8iIr2iHIpctNH1PHknb+Df5nPjQB8d7EsGvgeH+ER00ZLg0NPfdZCaKgVkwB2yxBa
         ouZqIHEz7kpoA5FcU4zW9RP///xqvBVpS96PbBTUCbOi7pRFfy/RpvyU09oM/1QHApNC
         PcmGLidu19RdS/M+x5i7yImTnRoj4NRAmTZzXTst8VM2CLVfKePBDhQ7Fo18HqyaIwWZ
         POualY2CLEx7v/74JHE4+m9ljrzW/4bsdAGB5y+n+rNovRqzGrJ6u+ucINiXBtNGLOU8
         8L84HzxMs3KzlWn6N/bDdwARyZ7a/xAMON1F0ZT+K0Trn49eIUM6ejMSqrRvF7Ov1xr1
         f90A==
X-Gm-Message-State: AJIora+OLRaTaPzXoK1ZvbFDLonYnpCV54uYskB2W2B6i7EjMpEfdLgI
        L+xBxYMxEs7BRalyhbZ7xfTXSUX70t4=
X-Google-Smtp-Source: AGRyM1s096zYWMouXG2MBn6K7buWggSH142QGu8Z+nP/LJxCKlDFtw+pvq1YzN9ac1kobWXNg/ukeg==
X-Received: by 2002:a05:6000:187:b0:21e:43b4:f5ed with SMTP id p7-20020a056000018700b0021e43b4f5edmr331405wrx.81.1658441608654;
        Thu, 21 Jul 2022 15:13:28 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c248500b003a3279b9037sm6563617wms.16.2022.07.21.15.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 15:13:28 -0700 (PDT)
Message-ID: <bd233bf9-d554-89cc-4498-c15a45fe860b@grimberg.me>
Date:   Fri, 22 Jul 2022 01:13:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
 <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
 <YteeHq8TJBncRvZu@infradead.org>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YteeHq8TJBncRvZu@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> Hello
>>>
>>> I reproduced this issue on the linux-block/for-next, pls help check
>>> it, feel free to let me know if you need info/test, thanks.
>>
>>
>> These reports are making me tired... Should we just remove
>> MEM_RECLAIM from all nvme/nvmet workqueues are be done with
>> it?
>>
>> The only downside is that nvme reset/error-recovery will
>> also be susceptible for low-memory situation...
> 
> We can't just do that.  We need to sort out the dependency chains
> properly.

The problem is that nvme_wq is MEM_RECLAIM, and nvme_tcp_wq is
for the socket threads, that does not need to be MEM_RECLAIM workqueue.
But reset/error-recovery that take place on nvme_wq, stop nvme-tcp
queues, and that must involve flushing queue->io_work in order to
fence concurrent execution.

So what is the solution? make nvme_tcp_wq MEM_RECLAIM?
