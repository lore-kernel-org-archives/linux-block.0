Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632ADC433E0
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 14:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45EF92072F
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 14:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgFHOU3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:20:29 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51168 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgFHOU3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 10:20:29 -0400
Received: by mail-pj1-f66.google.com with SMTP id jz3so5821525pjb.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2020 07:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=f2WKLo5yJaGtcE3HUtysqV2L8jfUJh9QDofCkroCqhk=;
        b=PfjtZQ8HpeoZ6W+wrluDf/+tlnSJLkCCrdvoBNBBioC5Fzwi91rPYV567rFoTthCfv
         FvppikJYE6S+kmzdq/Ft27+FYi4+1PzhXLegDMWQho7GjK312/FRUodwnTbWwXVMIsbk
         a90p7lYOwKFbL9gTNc24iVZwVrYm2JUSb1H6V+/CgSFHfXs0rJQPkWac+ebLdZkLD9qg
         LtU0+mRtNy1FRseREAfcu0pI1zZ7CspUmnNkHN3IekzdD++HnK54ElzFutcmlKyVAKKa
         SFvAAJHtU+lrL4oc4SehB2S3GUJPGGc9KvEdikK4Hod1hlN5N+dk292JJVntgWlsB6I/
         qnRg==
X-Gm-Message-State: AOAM530Ehd4jxZbh7iTpaEzD3OgTYdz2Ow12zFHWdNG3AwGQ8t/f03En
        uODEfdFHQdTbSof8PXLql382NaXD
X-Google-Smtp-Source: ABdhPJxAnJWTLLE9icIawlEzXxtSIGYIU93DBdZVwqpOQK40X59F5Ox4cuNNTJj71wwFE4G9SQa1sA==
X-Received: by 2002:a17:902:70c2:: with SMTP id l2mr21256590plt.237.1591626028192;
        Mon, 08 Jun 2020 07:20:28 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id y26sm7433217pff.26.2020.06.08.07.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 07:20:26 -0700 (PDT)
Subject: Re: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20200604054434.216698-1-harshadshirwadkar@gmail.com>
 <49a4c410-6d42-46b3-adde-1d0a8fc6b594@acm.org>
 <CAD+ocbzdh0eq+wBQ-DqUUw_Gvwc0xv-FbBUNS0aZfpn+eToUEg@mail.gmail.com>
 <8787ab94-4573-56d4-2e59-0adbaa979c4f@acm.org>
 <BYAPR04MB496523AEF4C84B7BA2D2680486850@BYAPR04MB4965.namprd04.prod.outlook.com>
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
Message-ID: <35a5f5a7-770e-1cbe-10a3-118591b64f29@acm.org>
Date:   Mon, 8 Jun 2020 07:20:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496523AEF4C84B7BA2D2680486850@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-06-07 23:40, Chaitanya Kulkarni wrote:
> Bart,
> On 6/5/20 6:43 AM, Bart Van Assche wrote:
>> We typically do not implement arbitrary limits in the kernel. So I'd
>> prefer not to introduce any artificial limits.
> 
> That is what I mentioned in [1] that we can add a check suggested in 
> [1]. That way we will not enforce any limits in the kernel and keep
> the backward compatibility.
> 
> Do you see any problem with the approach suggested in [1].
> 
> [1] https://www.spinics.net/lists/linux-block/msg54754.html

Please take another look at Harshad's patch description. My
understanding is that Harshad wants to protect the kernel against
malicious user space software. Modifying the user space blktrace
software as proposed in [1] doesn't help at all towards the goal of
hardening the kernel.

Thanks,

Bart.
