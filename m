Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C547C433FE
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 16:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiI2Q1J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 12:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbiI2Q0n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 12:26:43 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074FC11F125
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 09:25:53 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id s14so3049703wro.0
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 09:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=474tjA3Gjf60Pz38dDMyAaRwLrDVcBWJSEsK7Yc5yII=;
        b=alPjwN1lE9s7e2mo6vbJDKNF1QOk8q/mHm/zYeZISTwGNLgcm//a+Gmnjk4rPqCuuH
         WOCC3dgDOsircAmVOUkmdSwraZ5DJR59oi0glZByUmCWVAAxp0TeANoD7zMyxrxKDeWA
         hqpAZ2K0/Aqf7e93GQn/mW9NImL1Ep33pQpWy+G9RdNiGGATaJ542h/eFOR5qMrH4jZu
         4Txgi19FF5q7uozjJim3m80IHxGn3LPtSmILIMpQfhJF3MmNHF1sf1Zw3jw7jZCubCTL
         wRP3z97fERplAgHqLkPOpyV4ketnUzYKgFcAg5R7WpJlPCrZ6XRIk+kOECMUjntE1He3
         Soaw==
X-Gm-Message-State: ACrzQf2W0RcBbk7ebPvXWBiLWDbbmw6CXwzhX3FQ6MdtTn8vyweBi0wU
        oExZj4lZp7A+h21Gf3S8RXk=
X-Google-Smtp-Source: AMsMyM5ArMrAJHgtGVPKjq2yZzCVLOipwE7b7GNao9dudVYRpPyv4+HVhfSpxojNMkZYvmrzoH7nsA==
X-Received: by 2002:a05:6000:1c18:b0:22b:13e3:19d3 with SMTP id ba24-20020a0560001c1800b0022b13e319d3mr3106868wrb.699.1664468751518;
        Thu, 29 Sep 2022 09:25:51 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4743000000b00225307f43fbsm7155649wrs.44.2022.09.29.09.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 09:25:50 -0700 (PDT)
Message-ID: <91ebc84d-c0e3-b792-4f92-79612271eb91@grimberg.me>
Date:   Thu, 29 Sep 2022 19:25:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
To:     Jens Axboe <axboe@kernel.dk>, Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <04b39974-6b55-7aca-70de-4a567f2eac8f@kernel.dk>
Content-Language: en-US
In-Reply-To: <04b39974-6b55-7aca-70de-4a567f2eac8f@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> 3. Do you have some performance numbers (we're touching the fast path here) ?
>>
>> This is pretty light-weight, accounting is per-cpu and only wrapped by
>> preemption disable. This is a very small price to pay for what we gain.
> 
> Is it? Enabling IO stats for normal devices has a very noticeable impact
> on performance at the higher end of the scale.

Interesting, I didn't think this would be that noticeable. How much
would you quantify the impact in terms of %?

I don't have any insight on this for blk-mq, probably because I've never
seen any user turn IO stats off (or at least don't remember).

My (very limited) testing did not show any noticeable differences for
nvme-loop. All I'm saying that we need to have IO stats for the mpath
device node. If there is a clever way to collect this from the hidden
devices just for nvme, great, but we need to expose these stats.

> So much so that I've contemplated how we can make this less expensive than it currently is.

Then nvme-mpath would benefit from that as well.
