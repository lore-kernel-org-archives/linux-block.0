Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10660C433E1
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 16:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB50F207FF
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 16:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgHSQvc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:51:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45021 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgHSQvQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 12:51:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id m34so11663289pgl.11
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2020 09:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AaDl1RR6BpY+yNMmt/IMIypWc92XWIzM7wSJu1sp+4k=;
        b=hrFzniZYi1eEuY69dmCX1hT9YY8fhlgvb6NjavU71lxPqy+zCaNWnVRbvWQ6fvl2i0
         r/x9CbUMxB/7hRx07NY9LvFiR12Zdy5GT5asvLCaDHjTyKGPCIibi+OqutsRKISPWkPa
         ITkuBqsIL7cOKDWngp5b34V12dG9+21NKbIub3oRew8TupXUyrYHxwS3tpB/aYT5fNH1
         bdEQmcHSLgNo1Afn5H+sdOjkTD4ZtNyZI4jRBqdAdPkBJ9wjtgWd0i2SyyzuniJRuhy1
         x0h5bqv4nO5DAOArWs9DwYzaIFMdGrdkLBWGH+xzvDcjES7JPH+Ot11s5KHSEgaRJQff
         6EXA==
X-Gm-Message-State: AOAM530FU9w//ST4Y9dIWfKZs8sbg9EQKuM1FV2OngtWdJjpLzSZXc9Y
        vcsH+Uy9V9ndceqbKHXXvaw=
X-Google-Smtp-Source: ABdhPJxdaYut9yGXfYNVksH/1cHVDM7AHXyLaTFLja1iSgg1leaG4iW/SY2FkwVMnFnvspd1pJRvYQ==
X-Received: by 2002:a63:485f:: with SMTP id x31mr17457914pgk.49.1597855875705;
        Wed, 19 Aug 2020 09:51:15 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id e26sm29071099pfj.197.2020.08.19.09.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 09:51:14 -0700 (PDT)
Subject: Re: [PATCH blktests] common/multipath-over-rdma: fix warning ignored
 null byte in input
To:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org
Cc:     sagi@grimberg.me, osandov@osandov.com
References: <20200819151601.18526-1-yi.zhang@redhat.com>
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
Message-ID: <ec3fab5b-0d26-a753-4b83-1f9dd94d4418@acm.org>
Date:   Wed, 19 Aug 2020 09:51:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819151601.18526-1-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-08-19 08:16, Yi Zhang wrote:
> [blktests]# nvme_trtype=rdma ./check nvme/004
> nvme/004 (test nvme and nvmet UUID NS descriptors)
>     runtime  1.238s  ...
> nvme/004 (test nvme and nvmet UUID NS descriptors)           [failed]ignored null byte in input
>     runtime  1.238s  ...  1.237s 410: warning: command substitution: ignored null byte in input
>     --- tests/nvme/004.out	2020-08-18 08:11:08.496809985 -0400
>     +++ /root/blktests/results/nodev/nvme/004.out.bad	2020-08-19 10:43:02.193885685 -0400
>     @@ -1,4 +1,5 @@
>      Running nvme/004
>     +common/multipath-over-rdma: line 409: warning: command substitution: ignored null byte in input
>      91fdba0d-f87b-4c25-b80f-db7be1418b9e
>      uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
>      NQN:blktests-subsystem-1 disconnected 1 controller(s)
> 
> manually to reproduce:
> Update one network interface with 15 chars:
> [blktests]# ip a s enp0s29u1u7u3c2
> 5: enp0s29u1u7u3c2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
>     link/ether f0:d4:e2:e6:e1:e3 brd ff:ff:ff:ff:ff:ff
> [blktests]# modprobe rdma_rxe
> [blktests]# echo enp0s29u1u7u3c2 >/sys/module/rdma_rxe/parameters/add
> [blktests]# cat /sys/class/infiniband/rxe0/parent
> enp0s29u1u7u3c2[blktests]# f="/sys/class/infiniband/rxe0/parent"
> [blktests]# echo $(<"$f")
> -bash: warning: command substitution: ignored null byte in input
> enp0s29u1u7u3c2
> [blktests]# echo $(tr -d '\0' <"$f")
> enp0s29u1u7u3c2
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  common/multipath-over-rdma | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
> index 355b169..86e7d86 100644
> --- a/common/multipath-over-rdma
> +++ b/common/multipath-over-rdma
> @@ -406,7 +406,7 @@ has_rdma_rxe() {
>  	local f
>  
>  	for f in /sys/class/infiniband/*/parent; do
> -		if [ -e "$f" ] && [ "$(<"$f")" = "$1" ]; then
> +		if [ -e "$f" ] && [ "$(tr -d '\0' <"$f")" = "$1" ]; then
>  			return 0
>  		fi
>  	done

sysfs reads should not yield '\0' bytes. Please fix the kernel code that yields
a string including '\0' when reading from sysfs.

Thanks,

Bart.


