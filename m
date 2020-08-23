Return-Path: <SRS0=Vt9R=CB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D91DC433DF
	for <linux-block@archiver.kernel.org>; Sun, 23 Aug 2020 01:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EBEA206DA
	for <linux-block@archiver.kernel.org>; Sun, 23 Aug 2020 01:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgHWB6K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Aug 2020 21:58:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40624 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgHWB6J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Aug 2020 21:58:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id b11so2579947pld.7;
        Sat, 22 Aug 2020 18:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FUpDqn3GSqZeYvxxsArGtttJRoK3eORe52wIumG4FE8=;
        b=aY0Jy5RHcwfBtdHh392krsm1iOtzGH30PhwwV5WwO3WVNUUdFg2GwunVAxgdqkTNV1
         r0/hk7TBQKHwBXU/cq/+DL8hP5a5JujUrVowYDDBtLSqUhhcam01w2XVQQV66KMm81AZ
         nLNmV2jPwITqPBOEE3R8w4gJheyyT0bBqbAGNlwYL9qN9/SM2pnrwI/NRqwej1Jx7JdY
         KGg1X1aDJiIBygoxfMEcOUycUkGT/oLFTvoZA6zCtdqBBdvGiM18UmLudv+TzuIBkxLg
         0FNgUHXj4oK1ctUs224OA8PaS+fk/NnWWJZrX6tKsM9MJjUbEJS3KXypzggJFvBXYbrk
         NSRw==
X-Gm-Message-State: AOAM533UOvvJeJKP9epS7KKmIu9KE+QX1RqY28Lb120rkERVelY0w3Q4
        RRzMFugL+sDjrdG6uxo9ZJQMbE+gy0c=
X-Google-Smtp-Source: ABdhPJwxY/OESBRANK55Fb5iFeAwJIxMeib/AxROR6q//81ET4jq0kJs6pLlQ1ZQ/7OV1bSLjz9JXg==
X-Received: by 2002:a17:90a:2e0f:: with SMTP id q15mr4202pjd.49.1598147887514;
        Sat, 22 Aug 2020 18:58:07 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id o192sm7270748pfg.81.2020.08.22.18.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 18:58:06 -0700 (PDT)
Subject: Re: IOPRIO_CLASS_RT without CAP_SYS_ADMIN?
To:     Khazhismel Kumykov <khazhy@google.com>, axboe@kernel.dk,
        paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CACGdZYL_bE2bamw_1uanwWByrCteNF=hmWYLH=VEVm9=R987ew@mail.gmail.com>
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
Message-ID: <992ed2ed-f644-a5ad-3239-b38ddeafe28b@acm.org>
Date:   Sat, 22 Aug 2020 18:58:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CACGdZYL_bE2bamw_1uanwWByrCteNF=hmWYLH=VEVm9=R987ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-08-20 17:35, Khazhismel Kumykov wrote:
> It'd be nice to allow a process to send RT requests without granting
> it the wide capabilities of CAP_SYS_ADMIN, and we already have a
> capability which seems to almost fit this priority idea -
> CAP_SYS_NICE? Would this fit there?
> 
> Being capable of setting IO priorities on per request or per thread
> basis (be it async submission or w/ thread ioprio_set) is useful
> especially when the userspace has its own prioritization/scheduling
> before hitting the kernel, allowing us to signal to the kernel how to
> order certain IOs, and it'd be nice to separate this from ADMIN for
> non-root processes, in a way that's less error prone than e.g. having
> a trusted launcher ionice the process and then drop priorities for
> everything but prio requests.

Hi Khazhy,

In include/uapi/linux/capability.h I found the following:

/* Allow raising priority and setting priority on other (different
   UID) processes */
/* Allow use of FIFO and round-robin (realtime) scheduling on own
   processes and setting the scheduling algorithm used by another
   process. */
/* Allow setting cpu affinity on other processes */
#define CAP_SYS_NICE         23

If it is acceptable that every process that has permission to submit
IOPRIO_CLASS_RT I/O also has permission to modify the priority of
other processes then extending CAP_SYS_NICE is an option. Another
possibility is to extend the block cgroup controller such that the
capability to submit IOPRIO_CLASS_RT I/O can be enabled through the
cgroup interface. There may be other approaches. I'm not sure what
the best approach is.

Bart.
