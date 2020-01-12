Return-Path: <SRS0=6DrF=3B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4914CC33CA7
	for <linux-block@archiver.kernel.org>; Sun, 12 Jan 2020 00:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229FA20848
	for <linux-block@archiver.kernel.org>; Sun, 12 Jan 2020 00:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbgALASS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Jan 2020 19:18:18 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39273 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731715AbgALASS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Jan 2020 19:18:18 -0500
Received: by mail-pj1-f65.google.com with SMTP id e11so1083847pjt.4
        for <linux-block@vger.kernel.org>; Sat, 11 Jan 2020 16:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JO4J0ZHY5+E3jZA2AWCCl7gHqxDqY00S3F0O9vC55YM=;
        b=J+YON+EEZGAwZM0L4spgFnmq3/EqeZLksFhYGftqlBVnSWSlcoLigtzNMPKoms/DGy
         vqKW8eJZyQF+7drioEhgagn1goGnAxOK8vxUY0M9fEGTQ4znP8jcFUcyvTNuQwJmz9oE
         YlEkeyKVwkCHOAgmatD0hoxecZRNJPYkYYfjyvwoRQ8F5Dw6/mWN7Gi653d8qJWl5Li6
         ei178nq+2zWh2iAMld1LkfkplAGEh2PdLEKmTs3Jf57I0pfUOigarH2XOI2IN4rllaAi
         Xo7TLblvdbWFq+MbZyBixd1TicFHEqMTC6vMbWE5C8ULj3gY2ptOjVFQ3gDNV/y+EnD2
         Rnug==
X-Gm-Message-State: APjAAAVf1NLMn9Jo+5GU7PLm1sP3OgtJnz6sUuu2G4XIrolX2YbW82ud
        6swQWKDMEzYkHISrkddtVx4=
X-Google-Smtp-Source: APXvYqy6JuX0+/AIqQhwbN8aSFdvO0gVQACclVAemeUupxp4+g96/uGIGd6zuqB+P3PbYtUYKycujQ==
X-Received: by 2002:a17:90a:3747:: with SMTP id u65mr14405503pjb.25.1578788297466;
        Sat, 11 Jan 2020 16:18:17 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:7c72:26f5:20:bf58? ([2601:647:4000:d7:7c72:26f5:20:bf58])
        by smtp.gmail.com with ESMTPSA id k1sm7977110pgk.90.2020.01.11.16.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2020 16:18:16 -0800 (PST)
Subject: Re: [PATCH] blk-map: add kernel address validation in blk_rq_map_kern
 func
To:     Christoph Hellwig <hch@infradead.org>,
        renxudong <renxudong1@huawei.com>
Cc:     Bob Liu <bob.liu@oracle.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        jens.axboe@oracle.com, namhyung@gmail.com, bharrosh@panasas.com,
        Mingfangsen <mingfangsen@huawei.com>, zhengbin13@huawei.com,
        Guiyao <guiyao@huawei.com>, ming.lei@redhat.com
References: <239c8928-aea0-abe9-a75d-dc3f1b573ec5@huawei.com>
 <6b282b91-b157-5260-57d9-774be223998c@huawei.com>
 <91b13d6f-04b5-28b0-ea1b-d99564ecc898@oracle.com>
 <bc469dc8-19b6-d979-c061-075e52a355b0@huawei.com>
 <20200108150738.GB18991@infradead.org>
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
Message-ID: <5de25176-88ff-2c2b-7282-fadc0cab2065@acm.org>
Date:   Sat, 11 Jan 2020 16:18:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108150738.GB18991@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-01-08 07:07, Christoph Hellwig wrote:
> On Tue, Jan 07, 2020 at 02:51:04PM +0800, renxudong wrote:
>> When we issued scsi cmd, oops occurred. The call stack was as follows.
>> Call trace:
>>  __memcpy+0x110/0x180
>>  bio_endio+0x118/0x190
>>  blk_update_request+0x94/0x378
>>  scsi_end_request+0x48/0x2a8
>>  scsi_io_completion+0xa4/0x6d0
>>  scsi_finish_command+0xd4/0x138
>>  scsi_softirq_done+0x13c/0x198
>>  blk_done_softirq+0xc4/0x108
>>  __do_softirq+0x120/0x324
>>  run_ksoftirqd+0x44/0x60
>>  smpboot_thread_fn+0x1ac/0x1e8
>>  kthread+0x134/0x138
>>  ret_from_fork+0x10/0x18
>>  Since oops is in the process of scsi cmd done, we have not added oops info
>> to the commit log.
> 
> What workload is this?  If the address is freed while the I/O is
> in progress we have much deeper problem than what a virt_addr_valid
> could paper over.

Hi Zhiqiang Liu and renxudong,

I have not yet encountered the above callstack myself but I'm also
interested to learn more about the workload. Is this call trace e.g.
only triggered by one particular SCSI LLD?

Thanks,

Bart.

