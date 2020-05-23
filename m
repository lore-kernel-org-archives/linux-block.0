Return-Path: <SRS0=SpOq=7F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A08AC433DF
	for <linux-block@archiver.kernel.org>; Sat, 23 May 2020 15:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F0120787
	for <linux-block@archiver.kernel.org>; Sat, 23 May 2020 15:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387863AbgEWPUE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 May 2020 11:20:04 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:37963 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbgEWPUD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 May 2020 11:20:03 -0400
Received: by mail-pj1-f43.google.com with SMTP id t8so4219934pju.3
        for <linux-block@vger.kernel.org>; Sat, 23 May 2020 08:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=apssdwq+tyl1tas2Q698AKqtFc7kUObUQOlIuUV3CxE=;
        b=I8Ylch2vScXuldCJGxP1NmPyat5gpF5gBeTqg1tZqL0R3kAmjJNtnQHd7fRx8cb0in
         nTxwQ1RxFWKQAhc993ZR01XTXjlFS8thsXSG7WdTx36sC5+ilqN1ssMQwbXs0s/wrd37
         StHXeX38TYOTFMlpgALtrJgZvWcUP63msnrToC4/kz0dbGLsaGYpRe0TZHnXaNFYUTpw
         yzyJTEWwEtX3eAQanKJCFO+MuCkiNd9USUVeh28JWdeMSw2m+1mwuyRkyIOasNaoo1Fb
         FhdbvuuU7pNbPFsKV1Yi+NiSMuW54NDZbwaMzOrhQ6/XRFda1bflH2J7JGw9D8STfV19
         nOWg==
X-Gm-Message-State: AOAM533KfFV9TB0vRVhaXvayZMNs70r0qrDRj8sc3USM0c8QVYGIkfum
        sENcUc704BveiRcykGTjEH3V85IY
X-Google-Smtp-Source: ABdhPJwS6ypcfvNJZ+NVY/GiTkl0ebD6qR5lYHnsLzfRkgVs7hhaaoRK3CSZVp80UiJgQZGXNblrRA==
X-Received: by 2002:a17:90a:d56:: with SMTP id 22mr10286253pju.187.1590247201397;
        Sat, 23 May 2020 08:20:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:e001:10c:9a49:9da9? ([2601:647:4000:d7:e001:10c:9a49:9da9])
        by smtp.gmail.com with ESMTPSA id f3sm9130627pfd.30.2020.05.23.08.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 08:20:00 -0700 (PDT)
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
Message-ID: <26169cd9-49b8-b949-aaa3-9745e821c86c@acm.org>
Date:   Sat, 23 May 2020 08:19:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522023923.GC755458@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-21 19:39, Ming Lei wrote:
> You may argue that two hw queue may share single managed interrupt, that
> is possible if driver plays the trick. But if driver plays the trick in
> this way, it is driver's responsibility to guarantee that the managed
> irq won't be shutdown if either of the two hctxs are active, such as,
> making sure that hctx->cpumask + hctx->cpumask <= this managed interrupt's affinity.
> It is definitely one strange enough case, and this patch doesn't
> suppose to cover this strange case. But, this patch won't break this
> case. Also just be curious, do you have such in-tree case? and are you
> sure the driver uses managed interrupt?

I'm concerned about the block drivers that use RDMA (NVMeOF, SRP, iSER,
...). The functions that accept an interrupt vector argument
(comp_vector), namely ib_alloc_cq() and ib_create_cq(), can be used in
such a way that completion interrupts are handled on another CPU than
those in hctx->cpumask.

Bart.
