Return-Path: <SRS0=t9QE=7D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B328C433E0
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 19:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A8CD20738
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 19:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgEUTP4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 May 2020 15:15:56 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:34159 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbgEUTP4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 May 2020 15:15:56 -0400
Received: by mail-pf1-f169.google.com with SMTP id x15so3839323pfa.1
        for <linux-block@vger.kernel.org>; Thu, 21 May 2020 12:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=me8k5kO6gJhEHivRx7ZHWKWt03O6RaXrFJvlIQxegbw=;
        b=WYlzF6lgcRGHl7HpHyMxE0haO45UAbKsCf1XMXf3IlgIDw7MzGoWhCc0NewCwWDZ5q
         UqQudS4ajveggEqBR3jM88Qhv54nzShz6ylbmNxX3FVtqOYG/w1HMxwoL3N41F64D7/r
         rT3/JUr14I7zZkMjZ5Mcu6JfCJcrfVu7djN5Y1yTcHPeE4Tnbnnh0bZW0znFyJNsVhEn
         Nl50iM4+dZmDmWpRgUBhqYz+oOwvNilWj33Gk/98NIy+6H0Scx+9e88/U0UyqBOvbcOO
         pc+4WDPi0dmPb+ezc73jiNja0e+7+BvR5hZtqjLtmVT3DdiQQJofISTpzeEAyB0fqT2L
         pCGQ==
X-Gm-Message-State: AOAM530+nPFbrsawYNEeJCuThfnDNUhVPNPzxHV+iwidnv/hT2IjvZ5j
        k8BrPUQXQKMSw9FgpTSa8AE=
X-Google-Smtp-Source: ABdhPJz/uXy2paEqFPJPCvkWYo8ns60pQcOxyZuCvECwiGX+6uSJ/SHf9oz1AIxGZ7wsl6+8hrA4uQ==
X-Received: by 2002:a63:d516:: with SMTP id c22mr10504293pgg.123.1590088555242;
        Thu, 21 May 2020 12:15:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:50cc:4329:ba49:7ab1? ([2601:647:4000:d7:50cc:4329:ba49:7ab1])
        by smtp.gmail.com with ESMTPSA id f64sm5273180pjd.5.2020.05.21.12.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 12:15:54 -0700 (PDT)
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v3
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200520170635.2094101-1-hch@lst.de>
 <0cbc37cf-5439-c68c-3581-b3c436932388@acm.org> <20200521025744.GC735749@T590>
 <9249e1cc-b6f2-010e-78d2-ead5a1b93464@acm.org> <20200521043305.GA741019@T590>
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
Message-ID: <7accb5b2-6c7d-0e0d-56df-d06e8d9ac5af@acm.org>
Date:   Thu, 21 May 2020 12:15:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521043305.GA741019@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-20 21:33, Ming Lei wrote:
> No.
> 
> If vector 3 is for covering hw queue 12 ~ 15, the vector shouldn't be
> shutdown when cpu 14 is offline.
>> Also I am pretty sure that we don't do this way with managed IRQ. And
> non-managed IRQ will be migrated to other online cpus during cpu offline,
> so not an issue at all. See migrate_one_irq().

Thanks for the pointer to migrate_one_irq().

However, I'm not convinced the above statement is correct. My
understanding is that the block driver knows which interrupt vector has
been associated with which hardware queue but the blk-mq core not. It
seems to me that patch 6/6 of this series is based on the following
assumptions:
(a) That the interrupt that is associated with a hardware queue is
    processed by one of the CPU's in hctx->cpumask.
(b) That hardware queues do not share interrupt vectors.

I don't think that either assumption is correct.

Bart.
