Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE5BC433E0
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 17:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C87E220866
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 17:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgHGRe2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:34:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42375 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgHGRe1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 13:34:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id j21so1246662pgi.9
        for <linux-block@vger.kernel.org>; Fri, 07 Aug 2020 10:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4eN0ni97v3fR7ENINoYmX5MNOweJeUgowKJnRfQHBjE=;
        b=Dlbuyi3rQG9YVcRLWRomeZonWBRiRzrENg68jXLYDRRWkKT9/BzZ/MtSuoWTRZXnHE
         f1p7lcwv2Qd5sJL3C1vHWnL+E0Ed3vSRWT9BnIYbexDgmI/R90eIgX2YwB2N6+q6MhYt
         ujdLXERV9AGY982YpsghhrzL9rYm9Aw0VHq4ZZjMs9Yq22xbCa8ZuG51F63/JwD+AI9h
         RxGfrlQJMtHiHaYE0ZYL9b/Ofoxw0jM8E4YbtP2PII1jLnUrjqepFpkHtXKCRf/e7a7N
         LztneYTYhOifpvPhXDb8RB05uKE3tusVxkxI4keU5RU7a0+08xF/zbils0Tb9rv7dIfE
         X5kA==
X-Gm-Message-State: AOAM530playqzGVnCJoUhK0GF0Rd4L0SccmQs/2NAfNcKzX61cXXsBRM
        XCozV5vVhII9oHlTgowU/sjDosoC
X-Google-Smtp-Source: ABdhPJzRYyvJx5R4KZQvTkivVt7Yqr+Ny6+gMf3r3rzdffPCvBIdQfdHG1Qz2f+XWfVw7F09OIGsXw==
X-Received: by 2002:aa7:9552:: with SMTP id w18mr14248156pfq.150.1596821666783;
        Fri, 07 Aug 2020 10:34:26 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id fv21sm11217857pjb.16.2020.08.07.10.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 10:34:25 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] common/multipath-over-rdma: don't retry module
 unload
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-7-sagi@grimberg.me>
 <925e1ac6-38fa-6fe9-c0b7-7e665559a989@acm.org>
 <155cb916-062f-e23f-9790-35dee850687b@grimberg.me>
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
Message-ID: <b3ab660e-fd36-36da-fdff-f7582baf47fc@acm.org>
Date:   Fri, 7 Aug 2020 10:34:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <155cb916-062f-e23f-9790-35dee850687b@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-08-07 10:23, Sagi Grimberg wrote:
> 
>>> There is no need to retry module unload for rdma_rxe
>>> and siw. This also creates a dependency on
>>> tests/nvmeof/rc which prevents it from using in
>>> other test subsystems.
>>
>> If it wouldn't be necessary to retry module unload I wouldn't have
>> introduced a loop.
> 
> I thought it was to work-around a driver issue as these drivers
> traditionally had plenty of stability issues.
> 
> To be honest this retry loop to me indicated that either the
> driver has a bug or the test. But maybe there is a need I
> am not seeing.

That loop was introduced a long time ago. I haven't tried to root-cause
it but my guess is that the loop is necessary because the module refcount
only drops to zero a short time after the first attempt to unload these
kernel modules.

Bart.
