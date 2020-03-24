Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62881C10DCE
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 03:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41192206F8
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 03:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgCXDJa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 23:09:30 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33883 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgCXDJa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 23:09:30 -0400
Received: by mail-pj1-f67.google.com with SMTP id q16so696031pje.1
        for <linux-block@vger.kernel.org>; Mon, 23 Mar 2020 20:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SkpmDx/V74KvadRgQ8PhAEkrChPp++ObMyXHXZBx3nQ=;
        b=k8AEIa8SPs+Yq5Y95BywWPS5Z5KPmESDC0Dl3wffKpjZTF3tTUwzwZBreSjhXjHcnZ
         TJywoz8aWi2yOpDHzO+ZRk0r5it0+v9v28qbdAHsyB6yGLgHbkFi+UL2TA2FuGjyHPzc
         1e2KqTRlRkItq73JYMhof3hrD/VY1EI5XpnXmgYZtze0eyK1MZPkJXwNt+LfVj6tQ5t7
         QxEDFVaTiZ0Cg8dmwnlqIiDf1RnK/mEgc7SQtnZqhEeq3Ddna3n1gm2SO+ap/huvkhep
         1va2fiuWFqa+eKHCbRrA0BU9OraynjHnQHh7gJDDg0oQcj6pra299UzRmVv2utAgBZho
         /JGA==
X-Gm-Message-State: ANhLgQ3cfse/gqHjczIy48ihk8S2dAmxz04+pw6ORzu78z2egbsMSb8L
        b5iQbAQYxDpcvBFZxKTiMYg=
X-Google-Smtp-Source: ADFU+vsvWmLhB5lRziFB9V7G7pdpS9TI7h3xJ7fE2CnEboGezO8wz8a0L7m6vxvRHJRCsu+IpWgTxw==
X-Received: by 2002:a17:90a:218e:: with SMTP id q14mr2632038pjc.37.1585019369160;
        Mon, 23 Mar 2020 20:09:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:39fc:1d7f:ee6a:174f? ([2601:647:4000:d7:39fc:1d7f:ee6a:174f])
        by smtp.gmail.com with ESMTPSA id v59sm840090pjb.26.2020.03.23.20.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 20:09:28 -0700 (PDT)
Subject: Re: [PATCH blktests v3 4/4] Add a test that triggers the
 blk_mq_realloc_hw_ctxs() error path
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20200320222413.24386-1-bvanassche@acm.org>
 <20200320222413.24386-5-bvanassche@acm.org>
 <20200323112909.wrbnlvdioe37mni7@beryllium.lan>
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
Message-ID: <e4248d0c-445d-55b2-36c7-05b453f6d343@acm.org>
Date:   Mon, 23 Mar 2020 20:09:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323112909.wrbnlvdioe37mni7@beryllium.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-03-23 04:29, Daniel Wagner wrote:
> On Fri, Mar 20, 2020 at 03:24:13PM -0700, Bart Van Assche wrote:
>> Add a test that triggers the code touched by commit d0930bb8f46b ("blk-mq:
>> Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()"). This
>> test only runs if a recently added fault injection feature is available,
>> namely commit 596444e75705 ("null_blk: Add support for init_hctx() fault
>> injection").
> 
> [...]
> 
>> +test() {
>> +	local i sq=/sys/kernel/config/nullb/nullb0/submit_queues
>> +
>> +	: "${TIMEOUT:=30}"
>> +	if ! _init_null_blk nr_devices=0 queue_mode=2 "init_hctx=$(nproc),100,0,0"; then
> 
> Doesn't make the $(nproc) the test subtil depending on the execution
> environment?

Hi Daniel,

The value $(nproc) has been chosen on purpose. The following code from
the test script:

+			echo 1 >$sq
+			nproc >$sq

triggers (nproc + 1) calls to null_init_hctx(). So injecting a failure
after (nproc) null_init_hctx() calls triggers the following pattern:
* The first blk_mq_realloc_hw_ctxs() call fails after (nproc - 1)
null_init_hctx() calls.
* The second blk_mq_realloc_hw_ctxs() call fails after (nproc - 2)
null_init_hctx() calls.
...
* The (nproc) th blk_mq_realloc_hw_ctxs() call fails after one
null_init_hctx() call.
* The (nproc + 1) th blk_mq_realloc_hw_ctxs() call succeeds.

I'm not sure to trigger this behavior without using the $(nproc) value?

Thanks,

Bart.
