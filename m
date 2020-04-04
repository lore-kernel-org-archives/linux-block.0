Return-Path: <SRS0=MH8N=5U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86705C4332B
	for <linux-block@archiver.kernel.org>; Sat,  4 Apr 2020 17:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67089206E6
	for <linux-block@archiver.kernel.org>; Sat,  4 Apr 2020 17:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgDDRVy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:21:54 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53147 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgDDRVy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Apr 2020 13:21:54 -0400
Received: by mail-pj1-f66.google.com with SMTP id ng8so4570600pjb.2
        for <linux-block@vger.kernel.org>; Sat, 04 Apr 2020 10:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wI6NERnUwrE6O3yEw0jODm8zxKhvUgyWrZJqQgLzBtM=;
        b=QWWCQXw8XkdzEb5SrBgG8UrCOzWZiX28trVUprMV5NwlxIOnPL2YObue9JLn+Cuqh5
         dXTgTAIn3oQcBf47mRH1z51Y/hom3ZYvzI04Fz3ATLveknMoKr+3uvuWhoObwHd/L7Jo
         c0ELAP51f5wIiD7GxIKmFtaPg0QaROCygensMfCLCbq2Dm6Q1QCXOI2EWcAbqSr3vMnj
         R2jMJae/bCGMZUnqRJGlWCz7xdDbyxWgUmqG4ZtuWvwQ7XiVAAh8UmniOPSNHeA5emJ5
         Mym2SKrt12h4Dst0Upa5KQt1vdGLNBIRxYp0Wr9Sdgbcsqq5824gpsLHs6Jt0dt3IcCn
         O+0g==
X-Gm-Message-State: AGi0Puba2MNSLf0fcJ4/w6Fg22Ta+ug/5Oe1v+wQfL6/1MtJt9TLSGwb
        tXViYbIzz6XFqCTxyM+cvq5HVRLUDeM=
X-Google-Smtp-Source: APiQypKAQhHptXhi3kj+YjWHmwAe+uop/6bQhcZUq5j17DJF0Nkyh31L4YMK316/f/AjHS4iiN+fFQ==
X-Received: by 2002:a17:902:aa01:: with SMTP id be1mr12652170plb.227.1586020912636;
        Sat, 04 Apr 2020 10:21:52 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:103a:6b0b:334d:7fb2? ([2601:647:4000:d7:103a:6b0b:334d:7fb2])
        by smtp.gmail.com with ESMTPSA id x70sm7450439pgd.37.2020.04.04.10.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 10:21:51 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Fix potential kernel panic when increase hardware
 queue
To:     Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
References: <cover.1586006904.git.zhangweiping@didiglobal.com>
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
Message-ID: <3f9abe8e-9017-410c-f0eb-a80e1c232e61@acm.org>
Date:   Sat, 4 Apr 2020 10:21:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1586006904.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-04-04 06:35, Weiping Zhang wrote:
> This patchset fix a potential kernel panic when increase more hardware
> queue at runtime.
> 
> Patch1 fix a seperate issue, since patch2 depends on it, so I send a
> new patchset.
> 
> Change since V1:
>  * Add second patch to fix kernel panic when update hardware queue
> 
> Weiping Zhang (2):
>   block: save previous hardware queue count before udpate
>   block: alloc map and request for new hardware queue

On top of which kernel version have these patches been prepared and
tested? v5.5, v5.6, Jens' for-next branch or perhaps yet another kernel
version? I'm asking this since recently a fix for
blk_mq_realloc_hw_ctxs() has been accepted in Jens' tree.

Thanks,

Bart.
