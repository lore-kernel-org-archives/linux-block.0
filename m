Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62723EB64DC
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 08:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbjF1I7P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 04:59:15 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:37941 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbjF1IYy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 04:24:54 -0400
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso14096185e9.0
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 01:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940692; x=1690532692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5dy/snupWusVgt8K7W1fmwHwH0XFytwxYaVysivZUM=;
        b=cDfNR4Id2t0BNGO6/1Fxj2MDdNtVpjdkYuQNw8+Lr8r8y18xypqsOFpRoaa7kSSiKc
         MXRB8bd5SNXEeLEd6Y/aOdsi1+FOIjb+GHXdnQfVe5R83GEt7BCHQWoigX9VMl4XqnGF
         kvf7a+EKcIoHQhFjcvnrK4D6HJDDQNoG7RJI0BzUc0dwc/EjBuKUDBQj9ZxXF+Y5OUnw
         NTV8PM2T+kM1U/XuN+ZTW/5FBEDT9JKGCU66P4SbMRDxsP7RnyTF/jCZhlhkO58NWqyU
         r4WGJ7aK9BScQQcVBDLFaoNSlwgyOxwb5hyA8tMJF1p+hFPKOMkXYz7HTPK6dRZHVNwW
         o/AA==
X-Gm-Message-State: AC+VfDxXtaaNpad5Yj8ghFt35milJbS87G6JRLf4rGoDKhWEmaxxFbDQ
        O2cuAAEbzsr55QcKMmNSZZWKGAYxCpw=
X-Google-Smtp-Source: ACHHUZ71HPWMi/rIIXTPpBkJON+LAtSPBEZCRmJ2TdlAezlDWLOY7PVHRTOBRmUmK6KcvNFPa3pROg==
X-Received: by 2002:a5d:4007:0:b0:313:e8b7:d0f9 with SMTP id n7-20020a5d4007000000b00313e8b7d0f9mr3638170wrp.4.1687937206597;
        Wed, 28 Jun 2023 00:26:46 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6102000000b003127a21e986sm12360177wrt.104.2023.06.28.00.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 00:26:45 -0700 (PDT)
Message-ID: <5bddeeb5-39d2-7cec-70ac-e3c623a8fca6@grimberg.me>
Date:   Wed, 28 Jun 2023 10:26:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
References: <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
 <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
 <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
 <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
 <ZJvb85ovMrZEbilc@ovpn-8-21.pek2.redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZJvb85ovMrZEbilc@ovpn-8-21.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> Yeah, but you can't remove the gap at all with start_freeze, that said
>>> the current code has to live with the situation of new mapping change
>>> and old request with old mapping.
>>>
>>> Actually I considered to handle this kind of situation before, one approach
>>> is to reuse the bio steal logic taken in nvme mpath:
>>>
>>> 1) for FS IO, re-submit bios, meantime free request
>>>
>>> 2) for PT request, simply fail it
>>>
>>> It could be a bit violent for 2) even though REQ_FAILFAST_DRIVER is
>>> always set for PT request, but not see any better approach for handling
>>> PT request.
>>
>> I think that's acceptable for PT requests, or any request that doesn't
>> have a bio. I tried something similiar a while back that was almost
>> working, but I neither never posted it, or it's in that window when
>> infradead lost all the emails. :(
> 
> If you are fine to fail PT request, I'd suggest to handle the
> problem in the following way:
> 
> 1) moving freeze into reset
> 
> 2) during resetting
> 
> - freeze NS queues
> - unquiesce NS queues
> - nvme_wait_freeze()
> - update_nr_hw_queues
> - unfreeze NS queues
> 
> 3) meantime changes driver's ->queue_rq() in case that ctrl state is NVME_CTRL_CONNECTING,
> 
> - if the request is FS IO with data, re-submit all bios of this request,
>    and free the request
> 
> - otherwise, fail the request
> 
> With this way, not only freeze is paired with unfreeze. More
> importantly, it becomes not possible to trigger new timeout during
> handling NVME_CTRL_CONNECTING, then fallback to ctrl removal can
> be avoided.
> 
> Any comment on this approach?

As aid, for tcp/rdma I agree with this approach. No need to worry
about the non-mpath case, I don't think it is really used anyway
nowadays.
