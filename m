Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71512C433DF
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 18:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DDE206C3
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 18:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgETSXP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 14:23:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46646 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgETSXP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 14:23:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id 145so1956219pfw.13
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 11:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RsDGNlSQHJ2Z1Cr6fN3tjyiOST2YKu8TerEaeDjc1QM=;
        b=I00v5ede5cRNrspnyLhu/3h/8hujnFMTCY+xbykn3lANHTTjr9zPN96hCC9wo2qbQ0
         yceT0irDWZ7LyYH3RFWBuz2+QtsjP5deAWxq0jXOaY8d7pKKdNV112JeG7rmG3A2OMHG
         l8t8zVKQKFnzIF1w6O3H6bxXkB2lftesqs0mXUZfjEvqnnhd/JapMNNWfhoL6324Evpa
         x+pxevrl1PhtXMnEvKi7dBS15iiNU+UO/DBCNbFTa0aS48FfUhXLC8S9Ch2J8mHTs2JF
         wodSm9Zp9PNUdVVui9J5vypO5Fg5e9lA3+6Z8QBJ5dx4Q6+US94efDjuqU5tv6xibgKz
         u9+A==
X-Gm-Message-State: AOAM532arL3qBkicUGhM/BxJa6aPQ+zyos8jE4EsMKo846VCPAcCfPYH
        SWM1J4AgTyLp0I2C12idBck=
X-Google-Smtp-Source: ABdhPJxM4BJIcQz0/HHXXc186L1bDPMBmHlz+q4BORIaFYPd3bZJnn/G+lZZ1mAkvlFULNqkh6S0nw==
X-Received: by 2002:aa7:8b0a:: with SMTP id f10mr5600090pfd.268.1589998993664;
        Wed, 20 May 2020 11:23:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c031:e55:f9a8:4282? ([2601:647:4000:d7:c031:e55:f9a8:4282])
        by smtp.gmail.com with ESMTPSA id v127sm2662867pfb.91.2020.05.20.11.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 11:23:12 -0700 (PDT)
Subject: Re: [PATCH 2/6] blk-mq: simplify the blk_mq_get_request calling
 convention
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200520170635.2094101-1-hch@lst.de>
 <20200520170635.2094101-3-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <4eca3727-78f4-2aba-97df-bf4ffcf97ed2@acm.org>
Date:   Wed, 20 May 2020 11:22:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520170635.2094101-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-20 10:06, Christoph Hellwig wrote:
> The bio argument is entirely unused, and the request_queue can be passed
> through the alloc_data, given that it needs to be filled out for the
> low-level tag allocation anyway.  Also rename the function to
> __blk_mq_alloc_request as the switch between get and alloc in the call
> chains is rather confusing.

I think there are three changes in this patch (remove 'bio' argument,
pass request queue pointer through struct blk_mq_alloc_data instead of
as an argument and rename 'alloc_data' into 'data') which makes this
patch harder to read than necessary. Additionally, I like the old name
"alloc_data" better than the new name "data". Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
