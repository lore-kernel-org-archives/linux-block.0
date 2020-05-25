Return-Path: <SRS0=kLuB=7H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D10CC433E0
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 15:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE3882071A
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 15:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404117AbgEYPcs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 May 2020 11:32:48 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54051 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404104AbgEYPcs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 11:32:48 -0400
Received: by mail-pj1-f65.google.com with SMTP id ci21so103783pjb.3
        for <linux-block@vger.kernel.org>; Mon, 25 May 2020 08:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kh+YTT+jzD/hmN0H5DbEw3di1xsvU/fjnE9ZrACdTd0=;
        b=GpB3t3a/zdHJQ4e0zSNvn16zEZ+T2E03n7UGJjg+j90NMiqTrXuNtkXAADaQCk2udF
         /HaHFrJzOAy4zgs5DgLq2T3doKMFerBb02W4tQA2iL0neREvZnOwkYYo6abskZmeL4as
         EhMOKuUiAz2W/BPSjULJl40jnA1Y0QJWjbJnb4m4pQiw0gWIQ7NK6Oq8NJVvBeNHAggq
         iytXvqtDCmnHUy7DxK/DRLMGEMT/f+p5CDMElC60JOQhizRSpH1f2PiCgo8cQuJrKmUK
         ty/oG5OPSV2nRV2SbPcakt62uJSilLEf9NHoUz/YtavlaUFEFx0TUOUzDwO5A6miJneW
         BzaA==
X-Gm-Message-State: AOAM5311cCjWp57x3/j3DAi255fjdBoHR+eRw2XGZr+NQNj0OJyORdJh
        F3x0xkbZdSpQvn+YUDrzFAs=
X-Google-Smtp-Source: ABdhPJxFWTHPfi4l0ITxzZPOVSct+DuNWdXx8b83QZUzmcYY2djeYK6oGRHbQFovvmboOyACoB6BfQ==
X-Received: by 2002:a17:90a:1141:: with SMTP id d1mr21698939pje.31.1590420766949;
        Mon, 25 May 2020 08:32:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:2590:9462:ff8a:101f? ([2601:647:4000:d7:2590:9462:ff8a:101f])
        by smtp.gmail.com with ESMTPSA id l2sm9562506pga.44.2020.05.25.08.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 08:32:46 -0700 (PDT)
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v3
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200520170635.2094101-1-hch@lst.de>
 <0cbc37cf-5439-c68c-3581-b3c436932388@acm.org> <20200521025744.GC735749@T590>
 <9249e1cc-b6f2-010e-78d2-ead5a1b93464@acm.org> <20200521043305.GA741019@T590>
 <7accb5b2-6c7d-0e0d-56df-d06e8d9ac5af@acm.org> <20200522023923.GC755458@T590>
 <26169cd9-49b8-b949-aaa3-9745e821c86c@acm.org> <20200525040952.GB791214@T590>
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
Message-ID: <a89e6b92-8b43-ec1c-8e6b-7b842608ce5d@acm.org>
Date:   Mon, 25 May 2020 08:32:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200525040952.GB791214@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-24 21:09, Ming Lei wrote:
> On Sat, May 23, 2020 at 08:19:58AM -0700, Bart Van Assche wrote:
>> On 2020-05-21 19:39, Ming Lei wrote:
>>> You may argue that two hw queue may share single managed interrupt, that
>>> is possible if driver plays the trick. But if driver plays the trick in
>>> this way, it is driver's responsibility to guarantee that the managed
>>> irq won't be shutdown if either of the two hctxs are active, such as,
>>> making sure that hctx->cpumask + hctx->cpumask <= this managed interrupt's affinity.
>>> It is definitely one strange enough case, and this patch doesn't
>>> suppose to cover this strange case. But, this patch won't break this
>>> case. Also just be curious, do you have such in-tree case? and are you
>>> sure the driver uses managed interrupt?
>>
>> I'm concerned about the block drivers that use RDMA (NVMeOF, SRP, iSER,
>> ...). The functions that accept an interrupt vector argument
>> (comp_vector), namely ib_alloc_cq() and ib_create_cq(), can be used in
> 
> PCI_IRQ_AFFINITY isn't used in RDMA driver, so RDMA NIC uses non-managed
> irq.

Something doesn't add up ...

On a system with eight CPU cores and a ConnectX-3 RDMA adapter (mlx4
driver; uses request_irq()) I ran the following test:
* Query the affinity of all mlx4 edge interrupts (mlx4-1@0000:01:00.0 ..
mlx4-16@0000:01:00.0).
* Offline CPUs 6 and 7.
* Query CPU affinity again.

As one can see below the affinity of the mlx4 interrupts was modified.
Does this mean that the interrupt core manages more than only interrupts
registered with PCI_IRQ_AFFINITY?

All CPU's online:

55:04
56:80
57:40
58:40
59:20
60:10
61:08
62:02
63:02
64:01
65:20
66:20
67:10
68:10
69:40
70:08

CPUs 6 and 7 offline:

55:04
56:02
57:08
58:02
59:20
60:10
61:08
62:02
63:02
64:01
65:20
66:20
67:10
68:10
69:04
70:08

Bart.
