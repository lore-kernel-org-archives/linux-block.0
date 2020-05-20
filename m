Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB491C433DF
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 20:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8260D2075F
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 20:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgETUKj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 16:10:39 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51216 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgETUKi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 16:10:38 -0400
Received: by mail-pj1-f66.google.com with SMTP id cx22so1828303pjb.1
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 13:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TTVzGkKP5QKqwPtV1JhKjM39K03oU6Q+k0TW8ro7wvs=;
        b=jDyW4S1oQebGyx4Uy+yzdn935peySJRdzlEKaMEilEHoW6CykOhB71iHwMTcVq2dM0
         Xi6yBLvSGdmLd3PJnsDg0ucD8BegH8/CEYXhkHttB1qZc+cefRmtsAzDGuSFoxFtdGPV
         ogDIz2FsccjHoPCKVZqBa5DXRzOKo6WlT0tkdReIdr1Ewc6hRVshHCF/MEB3nfK1jgVL
         t7WAJA7yH+hSwxcpTWRXOBrRLtr16WjqcQkFZvMJW0OzZGau5go2FuC/aRA047VO/vnh
         T34J5cJgPYmsT9ELX6colM4dq+5QxhVmpaX77QO6hwtj0CePegm4TOZfMV0OOBWVltZa
         BcFg==
X-Gm-Message-State: AOAM533FyzKxB1ZQGDqDlly177v/hZmSTsSYPlPh8OPHvWgGo92jsWQl
        UmCskHDENdAM1oDVtfCBT/o=
X-Google-Smtp-Source: ABdhPJxaPgrVMtecx0MgOPCVuRy6AQGrYBSOfLXzxnqaZ24gVtz/9cWBxD3254hT/h6dH/d2hg+8/g==
X-Received: by 2002:a17:90a:cb91:: with SMTP id a17mr7629829pju.146.1590005437814;
        Wed, 20 May 2020 13:10:37 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c031:e55:f9a8:4282? ([2601:647:4000:d7:c031:e55:f9a8:4282])
        by smtp.gmail.com with ESMTPSA id q18sm2470093pgt.74.2020.05.20.13.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 13:10:36 -0700 (PDT)
Subject: Re: [PATCH 3/6] blk-mq: move more request initialization to
 blk_mq_rq_ctx_init
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200520170635.2094101-1-hch@lst.de>
 <20200520170635.2094101-4-hch@lst.de>
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
Message-ID: <9b7a16c0-1aff-6793-bc7d-98f4a31bb253@acm.org>
Date:   Wed, 20 May 2020 13:10:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520170635.2094101-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-20 10:06, Christoph Hellwig wrote:
> Don't split request initialization between __blk_mq_alloc_request and
> blk_mq_rq_ctx_init.  Also remove a pointless argument.

Although I'm not sure whether the 'op' argument should be called
pointless since this patch passes that argument in another way to
blk_mq_rq_ctx_init():

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
