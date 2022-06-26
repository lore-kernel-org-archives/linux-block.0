Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAF5C433EF
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 00:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiFZAXg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Jun 2022 20:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiFZAXf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jun 2022 20:23:35 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C0BDF22
        for <linux-block@vger.kernel.org>; Sat, 25 Jun 2022 17:23:34 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id o18so5212765plg.2
        for <linux-block@vger.kernel.org>; Sat, 25 Jun 2022 17:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1EFJBcbtxaj8/ARYzOxhyZir/8mDO19HnmNapCBJe+k=;
        b=xxUj4zXJizkL08tO+pAo4OffJ7EDTu1poSdoMC8X1kG0/umdJAGPCNtxFYNMnCIkx+
         9YxOGXeyy0YRhBP8zzHsUrVT9IOQP375RlsQH7fMvzE9g25KR9c5ujX+nxVCOfu7NAWP
         52pdtFKbKFdJ9I3qELpCz84aABv2e8etwiJ8bFB4F5ESkildbuE3HLu/ECHL3tVkes4Q
         WTXDW6FrKIWDseucOc43PHfEBsDzvXtoe+rEvWRyxfHpBWBwQAG6FGdO4XCE0iRMQobG
         DOflSJNYCaEmULVKHv+c2pZb4emD/cpjbIbRsugVdj8V3yF2lUSdEBfLBTGflH0yDov5
         OmLA==
X-Gm-Message-State: AJIora8t1Nh0mKrBY5YEo1l9rXFiH0be/LGvjOYTlWV0QUnbsT8MJgTN
        eQDZrLd6L++o6HyW0Ed8lWSXBqkFz10=
X-Google-Smtp-Source: AGRyM1s7xgjy57jYZefJRZOttvm780BtBHO4hwZ+kya6WRZKzfyVavBwb6K3e427OKFMUum+llJ/Cw==
X-Received: by 2002:a17:903:2305:b0:16a:6b9c:2b4c with SMTP id d5-20020a170903230500b0016a6b9c2b4cmr6838383plh.100.1656203013839;
        Sat, 25 Jun 2022 17:23:33 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id y6-20020aa78f26000000b005251ec8bb5bsm4228065pfr.199.2022.06.25.17.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 17:23:32 -0700 (PDT)
Message-ID: <2b662d41-5654-5309-c360-99f058b3967d@acm.org>
Date:   Sat, 25 Jun 2022 17:23:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 6/6] block/null_blk: Add support for pipelining zoned
 writes
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220623232603.3751912-1-bvanassche@acm.org>
 <20220623232603.3751912-7-bvanassche@acm.org> <20220624060659.GA6494@lst.de>
 <31602226-611f-223e-ddd3-0c8ab780cb0b@acm.org>
 <20220625092501.GA23615@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220625092501.GA23615@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/25/22 02:25, Christoph Hellwig wrote:
> On Fri, Jun 24, 2022 at 09:45:54AM -0700, Bart Van Assche wrote:
>> I have not yet seen any UFSHCI 4.0 implementation. The upstream UFSHCI
>> driver does not yet support it either.
>>
>> Hence the choice to add support to the null_blk driver for setting the
>> QUEUE_FLAG_PIPELINE_ZONED_WRITES flag.
> 
> Also I don't think UFS even supports zoned devices as is?

The following ballot has been approved about two weeks ago and is on its 
way to become a standard: 
https://www.jedec.org/members/documents/84467/download (file name: 
Zoned_Storage_for_UFS_Ballot_v3; only JEDEC members have permission to 
download this document).

 > Either way> without an in-tree driver for actually useful and 
existing hardware
> we should not add extra code to the block layer.

There is a zoned NVMe SSD in my workstation. How about adding support 
for zoned NVMe SSDs in this patch series?

Thanks,

Bart.
