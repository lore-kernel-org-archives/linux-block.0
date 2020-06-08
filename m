Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823D6C433E0
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 14:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64FBD20774
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 14:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgFHONO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:13:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39415 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgFHONO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 10:13:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id v24so6707269plo.6
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2020 07:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DN0O+QccX66cetGTZydxf0UAP3KhSNbwWfBqi0kGguU=;
        b=D+0m0GOvQdAZRdr7yrlENfMO/zHE3ZB0IdxtztUN1h4Cf5lIc/4axsaxsioCNg4fAs
         /WIM/6EapAMRTWZZRL5VQuTwSbhg42yhIV/F1YMLWvCiICV/m+Ve5ZwMWldVaIymQmME
         0oqSgBW9zJSujqNvRNyyXcrLOzIKJIZuKIFaw5O4qznob+V50nRdFVPGfRjYTEhKPE4b
         xo6kLJvv3Zj+hrr+u94adEzqCokCG3BYEBDyc1XY7ULCGJsZct1kIzq5ozJJu+kukJdH
         2lu4CEr8NAobutGwvcjqFZB0mmuLpjS/qaVYhPJHkY0e3KsCRq8FuLzXGNyD3UH7N7fI
         cNCA==
X-Gm-Message-State: AOAM532V0YaNiTyFdPJTC4bTplTDFz/Axz0sEf5EE82tq7t1M4rMW+QR
        LrhaXydGCVRNJoOnow0gGEgFaijO
X-Google-Smtp-Source: ABdhPJyWTqJBDWU65Z9RIFncOdpjetrhcj+yDhnBLjdzCmgEvVhrAWWXPzXMsVTUtUi01cW6cLn2Jw==
X-Received: by 2002:a17:90a:bf14:: with SMTP id c20mr17422104pjs.228.1591625592880;
        Mon, 08 Jun 2020 07:13:12 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id z9sm14854996pjr.39.2020.06.08.07.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 07:13:11 -0700 (PDT)
Subject: Re: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20200604054434.216698-1-harshadshirwadkar@gmail.com>
 <49a4c410-6d42-46b3-adde-1d0a8fc6b594@acm.org>
 <BYAPR04MB4965B37AC6B19F51AAE291D186850@BYAPR04MB4965.namprd04.prod.outlook.com>
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
Message-ID: <40f0c94f-1f9f-f45f-2974-1b562a7e5c32@acm.org>
Date:   Mon, 8 Jun 2020 07:13:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965B37AC6B19F51AAE291D186850@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-06-07 23:34, Chaitanya Kulkarni wrote:
> Bart,
> 
> On 6/4/20 9:31 PM, Bart Van Assche wrote:
>> Where is the code that imposes these limits? I haven't found it. Did I
>> perhaps overlook something?
>
> It is in blktrace.c user-space tool.
> 
>    55
>    56 /*
>    57  * You may want to increase this even more, if you are logging at 
> a high
>    58  * rate and see skipped/missed events
>    59  */
>    60 #define BUF_SIZE                (512 * 1024)
>    61 #define BUF_NR                  (4)
>    62
>    63 #define FILE_VBUF_SIZE          (128 * 1024)
>    64
>    65 #define DEBUGFS_TYPE            (0x64626720)
>    66 #define TRACE_NET_PORT          (8462)
>    67

Hi Chaitanya,

With my question I was referring to kernel code. I think Harshad
understood that part of my question.

Thanks,

Bart.
