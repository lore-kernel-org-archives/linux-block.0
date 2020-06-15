Return-Path: <SRS0=pdd5=74=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF0EC433DF
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 14:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA2E20842
	for <linux-block@archiver.kernel.org>; Mon, 15 Jun 2020 14:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgFOOBE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:01:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40329 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgFOOBE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 10:01:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id x11so1447812plo.7
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 07:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sc9qnqNcfE//c0LRdQjogDdEP0d5h7lBOzqQV0VRGdk=;
        b=cbzlhpVo4G66m6zu40wkNnBj1ViHL1adA/iHKGHJSAyilsgQf+TJhzfb7//H98675o
         EGNhNvNlio7R0ZacfR+GpoAEPLeGDJuLFqwA0TzBKTAj3wLRPQGT4a+wPyW2Q4UA7raP
         ItFDpeTAaHmNLVgL2K0TDX2qUfsJzsUfnrzKbpR3V5xt8VusLRH28KBm/ecdmwIcqzFQ
         sZgVmRV6b6uqa5U2v4lA64dKTjtp313cpCSEJKBON9ALrEnMH0/pDG4gS18kOQtsUjc7
         S3jCQ3YTnt8eT0nDT7Qo605YXqRa8XbsL0vDq6VX/To69ESphxloubuQnWCOVcdKCIF2
         fMpQ==
X-Gm-Message-State: AOAM530s25tQGfzZ/253AtWJYcxBvDuf2f7+gnnvu6Tdmt7Z3axmBX1E
        /MC06oab5bhKkdK+njEgB64=
X-Google-Smtp-Source: ABdhPJw64NTfXh4aVCR4p6jDtM1PQI5TF7a4oulhkS8ejFV/Mn8NFpzTg0e82f+pTEVdbih3RoyVTw==
X-Received: by 2002:a17:90a:62ca:: with SMTP id k10mr12913464pjs.87.1592229663246;
        Mon, 15 Jun 2020 07:01:03 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id h3sm14017794pfr.2.2020.06.15.07.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 07:01:02 -0700 (PDT)
Subject: Re: [PATCH v2] blktrace: put bounds on BLKTRACESETUP buf_size and
 buf_nr
To:     Christoph Hellwig <hch@infradead.org>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-block@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
References: <20200611013326.218542-1-harshadshirwadkar@gmail.com>
 <20200615115236.GA28124@infradead.org>
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
Message-ID: <904b17e6-3ac6-8474-d6e5-32ada0dc2d40@acm.org>
Date:   Mon, 15 Jun 2020 07:01:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615115236.GA28124@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-06-15 04:52, Christoph Hellwig wrote:
> I don't think the configurability makes any sense.  We need to put
> a hard upper cap on, preferably one that doesn't break widely used
> userspace.  Just pick a reasonable large value to get started.

Hi Christoph,

Something that has not been mentioned in the patch description is that
this patch addresses an issue that was discovered by syzbot. Do you
agree that the following changes are useful on top of a hard upper limit
for the blktrace buffer and that these changes will address more
potential syzbot issues?
- Use __GFP_ACCOUNT in the relay_open() call that allocates blktrace
buffers such that the memory allocation is accounted to a process and
such that the OOM killer becomes aware of blktrace buffer allocations.
- Making blkdev_close(), raw_release() and sg_release() shut down
tracing in case the BLKTRACETEARDOWN ioctl has not been invoked. That
will cause the blktrace buffers to be freed when e.g. the process that
owns these buffers is killed.

Thanks,

Bart.
