Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11536C433ED
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 19:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9EA610E6
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 19:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhDHTxC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhDHTxA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Apr 2021 15:53:00 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B61C061760;
        Thu,  8 Apr 2021 12:52:48 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so3520620oto.2;
        Thu, 08 Apr 2021 12:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KIJug2I8LAqDysW7Zo57l+mpQ9+Qy9uGWvQ5b4XssOE=;
        b=BzjFJ+sJa9iEVzxX221VwZhVsHUSFC35bCBi/VFen3WfL8h0Vsv/VWtCaHU62e0lT4
         Vb0/CnMCRn/3p6ZtJWScvd0+XBiTRbOIU6I+01kfrRl17YDi1FAmCcrEKJ6RgireYCK5
         9yiTlx8mQkO9kHa/5pKytwbsIJILN1Ka6UdjSG8ko4cN01VKJSbPxjHJqjrx3ZtPdmNU
         3wchXJ37HG392b3stMdxkupThDf70E9M529Yeqs/PPmnHhZHpSwAMSYTZWW+H8fsE57s
         8hRjYcmURniq1cStXVBqDgwHwyirRLqrOU3VuxGnq3+NcQ3GQodV/IyQywcFr/qVryUo
         4RJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KIJug2I8LAqDysW7Zo57l+mpQ9+Qy9uGWvQ5b4XssOE=;
        b=MIpbImRQlWKlndgrfXF0eJP2oxiqJOvF+6nrPtJf9VvKwbJo/5toMJZhlS7YMnkK3W
         /cUhqIWwLXKqhRhC/Pt4I7a/+kxSs7sR9Xw2Lntp7CrD7AxOuMmTfDJ8DPxnolqir5oN
         9Q2TWkwVEScq50gq5tSFAO4mRyRAaWtvSRRjh+r+/IZV06edAo8Vx4MqA2v2lFwOFtTJ
         g9XN8PNfdEhd+7e8lHUtduLFDENPC227ichDSpcO6ifxZ2gbsXZGeqXCdiS48ZDwUcrK
         zN8xfp4TanGfn+Yx3w3vJ8CK/QzIu0SffsQ0Z/2cv7wUcl+TDK3tJRVjhYxhW3tQe/7v
         I5Lw==
X-Gm-Message-State: AOAM531q+/Ui/2pV4ltvbQ+H6ekgSNEcYVCZ3nvdc5TGr9dRilOMyAwQ
        Sb+BioJgl4qb2wN5xdwlOco=
X-Google-Smtp-Source: ABdhPJzB8eBDpZWG+/oM2Nkn3KmvrxuyRmiN2lTsdCg4EyhGe6MuFyOGgwBBxs0npdGZu+gD95GFRg==
X-Received: by 2002:a9d:51cb:: with SMTP id d11mr9314460oth.32.1617911568145;
        Thu, 08 Apr 2021 12:52:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i15sm89125oou.10.2021.04.08.12.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 12:52:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] block: Disable -Walign-mismatch for blk-mq.c
To:     Nathan Chancellor <nathan@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jian Cai <jiancai@google.com>,
        Christopher Di Bella <cjdb@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20210408181210.u7cudatr7zcmbmb2@archlinux-ax161>
 <20210408194458.501617-1-nathan@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <e48bdeee-c8d4-7048-5899-0aa3fe7243ac@roeck-us.net>
Date:   Thu, 8 Apr 2021 12:52:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210408194458.501617-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/21 12:44 PM, Nathan Chancellor wrote:
> LLVM 13 adds a new warning, -Walign-mismatch, which has an instance in
> blk_mq_complete_send_ipi():
> 
> block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to
> 32-byte aligned parameter 2 of 'smp_call_function_single_async' may
> result in an unaligned pointer access [-Walign-mismatch]
>                 smp_call_function_single_async(cpu, &rq->csd);
>                                                     ^
> 1 warning generated.
> 
> This is expected after commit 4ccafe032005 ("block: unalign
> call_single_data in struct request"), which purposefully unaligned the
> structure to save space. Given that there is no real alignment
> requirement and there have been no reports of issues since that change,
> it should be safe to disable the warning for this one translation unit.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1328
> Link: https://lore.kernel.org/r/20210310182307.zzcbi5w5jrmveld4@archlinux-ax161/
> Link: https://lore.kernel.org/r/20210330230249.709221-1-jiancai@google.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  block/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/Makefile b/block/Makefile
> index 8d841f5f986f..d69ac0bd8e61 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
>  			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
>  			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o
>  
> +CFLAGS_blk-mq.o := $(call cc-disable-warning, align-mismatch)
>  obj-$(CONFIG_BOUNCE)		+= bounce.o
>  obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o
>  obj-$(CONFIG_BLK_DEV_BSG)	+= bsg.o
> 
> base-commit: e49d033bddf5b565044e2abe4241353959bc9120
> 

