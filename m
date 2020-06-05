Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91035C433DF
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 04:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66DBC207ED
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 04:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgFEEbQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 00:31:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34910 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgFEEbQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jun 2020 00:31:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id q16so3137502plr.2
        for <linux-block@vger.kernel.org>; Thu, 04 Jun 2020 21:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m0FzEoeB6+GEPJAJ74axetnfAKJJJmIh4RXRoS/aitA=;
        b=UOPHa4dtiMrcVotgF5wBB+77GuhXeWSNyj6uMry7aKxKPEqW2ip0pUQ8W1j4pVeYJ1
         6Pbbf2eyrZvBQ93RB2E5gcYBUgS/6e8gCyevnbhhGUeZBZycfSLk+bGsRiYjYp0vHfKD
         7U+VX7tzXC9qPq4YGjTe0g6CCtgZD75o5Qt+lGc1QDGiylxaBfDuUBqIeTRDURK3UjhO
         Cha+jh/zRCj2Dfw5OVMAQ7bY0MrPEadWlGmu7ox314r1r84AcUoDl3ECMXtg37TMZdVR
         Wl+lHIP9xLs4lBLk6cV/r9T0anKKKBB/NIvtvU17UCaLC0JvaaZ15xL/XvCQObjWv79q
         N9Rg==
X-Gm-Message-State: AOAM532U3ZZSKloV9k9R1VgqvfpPYHT0XrxMJP2yhAMILfMeXtxd0kST
        BbV5Z7z48JCLCekGYeriRhR+qc9J
X-Google-Smtp-Source: ABdhPJwwkAHi8cBCid4Tr5EX+dJMQSKtlGKG/fcvoDKd6oedblpvGUwSGs0Gzmx7G7Enqb+Ea2CS3A==
X-Received: by 2002:a17:90a:7643:: with SMTP id s3mr830486pjl.183.1591331475022;
        Thu, 04 Jun 2020 21:31:15 -0700 (PDT)
Received: from [192.168.50.149] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id nk15sm5593288pjb.57.2020.06.04.21.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 21:31:14 -0700 (PDT)
Subject: Re: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-block@vger.kernel.org
References: <20200604054434.216698-1-harshadshirwadkar@gmail.com>
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
Message-ID: <49a4c410-6d42-46b3-adde-1d0a8fc6b594@acm.org>
Date:   Thu, 4 Jun 2020 21:31:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604054434.216698-1-harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-06-03 22:44, Harshad Shirwadkar wrote:
> Make sure that user requested memory via BLKTRACESETUP is within
> bounds. This can be easily exploited by setting really large values
> for buf_size and buf_nr in BLKTRACESETUP ioctl.
> 
> blktrace program has following hardcoded values for bufsize and bufnr:
> BUF_SIZE=(512 * 1024)
> BUF_NR=(4)

Where is the code that imposes these limits? I haven't found it. Did I
perhaps overlook something?

> diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
> index 690621b610e5..4d9dc44a83f9 100644
> --- a/include/uapi/linux/blktrace_api.h
> +++ b/include/uapi/linux/blktrace_api.h
> @@ -129,6 +129,9 @@ enum {
>  };
>  
>  #define BLKTRACE_BDEV_SIZE	32
> +#define BLKTRACE_MAX_BUFSIZ	(1024 * 1024)
> +#define BLKTRACE_MAX_BUFNR	16
> +#define BLKTRACE_MAX_ALLOC	((BLKTRACE_MAX_BUFNR) * (BLKTRACE_MAX_BUFNR))

Adding these constants to the user space API is a very inflexible
approach. There must be better approaches to export constants like these
to user space, e.g. through sysfs attributes.

It probably will be easier to get a patch like this one upstream if the
uapi headers are not modified.

>  /*
>   * User setup structure passed with BLKTRACESETUP
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index ea47f2084087..b3b0a8164c05 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -482,6 +482,9 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	if (!buts->buf_size || !buts->buf_nr)
>  		return -EINVAL;
>  
> +	if (buts->buf_size * buts->buf_nr > BLKTRACE_MAX_ALLOC)
> +		return -E2BIG;
> +
>  	if (!blk_debugfs_root)
>  		return -ENOENT;

Where do the overflow(s) happen if buts->buf_size and buts->buf_nr are
large? Is the following code from relay_open() the only code that can
overflow?

	chan->alloc_size = PAGE_ALIGN(subbuf_size * n_subbufs);

Thanks,

Bart.

