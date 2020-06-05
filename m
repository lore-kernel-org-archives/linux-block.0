Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9495CC433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 13:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9B52075B
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 13:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFENn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:43:29 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33605 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgFENn2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jun 2020 09:43:28 -0400
Received: by mail-pj1-f68.google.com with SMTP id b7so3299761pju.0
        for <linux-block@vger.kernel.org>; Fri, 05 Jun 2020 06:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rMgkPMWO7N9HHHKlXo3VMYaliqIILUXRWD/RRvYib5I=;
        b=IQ3r0jKrvnSju9/w+kcRTPieUJwqULT8ievFMI31f0s8fOTgQvomo1njrbVgcor8EB
         6Ky47p79mZuxpOEbculTOe00hj7NhDfGtDXO8lb4L1XyHoV0r8dlRug1OnEv9+798ESv
         IqFDr/7nTuO00vHk3TW5yhKapZxf9O6coy+tLml+pmBVBpqy9EbaBBaFNfS/lhYljT8M
         Dfog9fBhBC0KwoKetXiDdFLar0w8RHcgXCYSv9aHQelX/GYaXptwWPHTRObvueX3YXdU
         Mo6c0J6KZfk2IGElUkP7CEsTORBF+CTHkQTYFafHqpbchKKoVR7wiG41eogYRY6cXO+4
         ufTQ==
X-Gm-Message-State: AOAM532hSEqT4ydXF9cL3UljWo5i4U8vxYz3Kip8PcZq5XJXU6mFARU1
        9WnLKLgTglKK07QWEp4oq9E6bT9K
X-Google-Smtp-Source: ABdhPJzcvgCwk/RrgIDYHRpsnV+2X0r9UkLHJBIYiYmu4lxCpvki5LwVNJpXjYewnOvUD+d6zCwrBg==
X-Received: by 2002:a17:90b:50d:: with SMTP id r13mr3149945pjz.94.1591364606544;
        Fri, 05 Jun 2020 06:43:26 -0700 (PDT)
Received: from [192.168.50.149] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id y10sm6752618pgi.54.2020.06.05.06.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 06:43:25 -0700 (PDT)
Subject: Re: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-block@vger.kernel.org
References: <20200604054434.216698-1-harshadshirwadkar@gmail.com>
 <49a4c410-6d42-46b3-adde-1d0a8fc6b594@acm.org>
 <CAD+ocbzdh0eq+wBQ-DqUUw_Gvwc0xv-FbBUNS0aZfpn+eToUEg@mail.gmail.com>
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
Message-ID: <8787ab94-4573-56d4-2e59-0adbaa979c4f@acm.org>
Date:   Fri, 5 Jun 2020 06:43:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAD+ocbzdh0eq+wBQ-DqUUw_Gvwc0xv-FbBUNS0aZfpn+eToUEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-06-04 22:02, harshad shirwadkar wrote:
> Hi Bart,
> 
> On Thu, Jun 4, 2020 at 9:31 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 2020-06-03 22:44, Harshad Shirwadkar wrote:
>>> Make sure that user requested memory via BLKTRACESETUP is within
>>> bounds. This can be easily exploited by setting really large values
>>> for buf_size and buf_nr in BLKTRACESETUP ioctl.
>>>
>>> blktrace program has following hardcoded values for bufsize and bufnr:
>>> BUF_SIZE=(512 * 1024)
>>> BUF_NR=(4)
>>
>> Where is the code that imposes these limits? I haven't found it. Did I
>> perhaps overlook something?
> 
> From what I understand, these are not limits. These are hardcoded
> values used by blktrace userspace when it calls BLKTRACESETUP ioctl.
> Inside the kernel, before this patch there is no checking in the linux
> kernel.

Please do not move limits from userspace tools into the kernel. Doing so
would break other user space software (not sure if there is any) that
uses the same ioctl but different limits.

>>> diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
>>> index 690621b610e5..4d9dc44a83f9 100644
>>> --- a/include/uapi/linux/blktrace_api.h
>>> +++ b/include/uapi/linux/blktrace_api.h
>>> @@ -129,6 +129,9 @@ enum {
>>>  };
>>>
>>>  #define BLKTRACE_BDEV_SIZE   32
>>> +#define BLKTRACE_MAX_BUFSIZ  (1024 * 1024)
>>> +#define BLKTRACE_MAX_BUFNR   16
>>> +#define BLKTRACE_MAX_ALLOC   ((BLKTRACE_MAX_BUFNR) * (BLKTRACE_MAX_BUFNR))
>>
>> Adding these constants to the user space API is a very inflexible
>> approach. There must be better approaches to export constants like these
>> to user space, e.g. through sysfs attributes.
>>
>> It probably will be easier to get a patch like this one upstream if the
>> uapi headers are not modified.
> 
> Thanks, makes sense. I'll do this in the V2. If we do that, we still
> need to define the default values for these limits. Do the values
> chosen for MAX_BUFSIZE and MAX_ALLOC look reasonable?

We typically do not implement arbitrary limits in the kernel. So I'd
prefer not to introduce any artificial limits.

>>
>>>  /*
>>>   * User setup structure passed with BLKTRACESETUP
>>> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
>>> index ea47f2084087..b3b0a8164c05 100644
>>> --- a/kernel/trace/blktrace.c
>>> +++ b/kernel/trace/blktrace.c
>>> @@ -482,6 +482,9 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>>>       if (!buts->buf_size || !buts->buf_nr)
>>>               return -EINVAL;
>>>
>>> +     if (buts->buf_size * buts->buf_nr > BLKTRACE_MAX_ALLOC)
>>> +             return -E2BIG;
>>> +
>>>       if (!blk_debugfs_root)
>>>               return -ENOENT;
>>
>> Where do the overflow(s) happen if buts->buf_size and buts->buf_nr are
>> large? Is the following code from relay_open() the only code that can
>> overflow?
>>
>>         chan->alloc_size = PAGE_ALIGN(subbuf_size * n_subbufs);
> 
> Good catch, I'm not sure if the overflows are checked for, but I maybe
> wrong. Given the possibility of overflows, perhaps we should be
> checking for individual upper bounds instead of the product?

How about using check_mul_overflow() to catch overflows of this
multiplication? There may be other statements that need protection
against overflow.

Thanks,

Bart.
