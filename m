Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AC8C433FE
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 16:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiI2Qco (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 12:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiI2Qcn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 12:32:43 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D1914FE0F
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 09:32:43 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id c11so3011659wrp.11
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 09:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IYZh+nK5YCCQ4oiVyHqObkTmxD0DKA6yJReA9paQ+eI=;
        b=1owLOZbcQZP5hUfilIPSIEjHfyFDGi2bP0/LCZvPHM0HJdACuTrtrv/8PhD7L9wFjm
         AMICvqdNBQ5Jfo0PJ7kf8nAo+offzmGdvlB2FN+MB/OfNzigPVz0aTSU58Kol8bkHu/0
         2qTK36HFp9fZWvUOkFLbEQvY3FrBuUJKxB/q/0pd5GdOnWZn1Lkcr/N2+yZPwsrJtySs
         O0eC5WtIzq6GTW4MfMxQdcgfJcfTgYZYe7fHVnl02zRv+dtVNspJSrpsJZdCePYL4f0X
         10PCEVTsqo0QqAn2b4/+KNacWYJFUTk7EfHrgnT7c2MyqSUv+hBh5O28ROhfFlAOX2Ob
         RAbQ==
X-Gm-Message-State: ACrzQf1YqqHr8a1xp3tSGx8SVHrCEDi7VPxMOueGeoIDT3SJiYKWeRL3
        vL0u2Lr/P+sddkuiLuvLYFbm5RxmUU4=
X-Google-Smtp-Source: AMsMyM7Vi8Zv246zWA3Kl9vxysqsy5NxHTXSGu7gRTfgvoZ4sXaYFHNRRsDOlBr92PMvARCHZtpRfw==
X-Received: by 2002:adf:a4ce:0:b0:22a:f5e8:6dcc with SMTP id h14-20020adfa4ce000000b0022af5e86dccmr2899437wrb.445.1664469161531;
        Thu, 29 Sep 2022 09:32:41 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe389000000b00228daaa84aesm6942020wrm.25.2022.09.29.09.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 09:32:41 -0700 (PDT)
Message-ID: <e5299b5e-5e9a-5a2a-b7dc-30de2bf43adc@grimberg.me>
Date:   Thu, 29 Sep 2022 19:32:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> 3. Do you have some performance numbers (we're touching the fast path
>>> here) ?
>>
>> This is pretty light-weight, accounting is per-cpu and only wrapped by
>> preemption disable. This is a very small price to pay for what we gain.
> 
> It does add up, though, and some environments disable stats to skip the
> overhead. At a minimum, you need to add a check for blk_queue_io_stat() before
> assuming you need to account for stats.

But QUEUE_FLAG_IO_STAT is set by nvme-mpath itself?
You mean disable IO stats in runtime?
