Return-Path: <SRS0=t5dV=4R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE75C3F2D2
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 02:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B192467B
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 02:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgB2CgW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 21:36:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45953 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB2CgW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 21:36:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id m15so2439299pgv.12
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2020 18:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zHUQZcxbaubH0bTzOn+HF/AMgDcs7nyywNhWqXyHzpw=;
        b=ikF/RcrzEpG7wydm/rIlWb3eGz5Bmc0UUAGbVwvwCCvInK939VyEUV47dElKOZVWgR
         w/y5Bdrl/JqSy5zlDoACPZxMoM4rSI56x1/TrWX5xMBiz0iz1gx3sJyigWDTgK2Zwrpp
         9xeB0Gg0S4D4TgRYwYQqiHjDFR/NLiD78I+UqrqZMnROE8tJh/vojkKKoHcHXXtbm6j7
         UAPayfXZ8M26HlX5mORlUA4buPq4wdoGjTH4QuK7Y6+RD6lWtQazwGuT4DdYnqH/Vyj1
         3HqM3wspU6yQeqouJ8IPLxMbO2vxVSfX0xgXlm3Mp5on13Z3R/kqpNRWY7l6gVOe4nrr
         P+4w==
X-Gm-Message-State: APjAAAXQ0aLdRuMXkgKwOMShkCFB+mDi6/vp850LVxr4hzvGZxKhmSym
        Lm0vF6gwSrKPKsoPPHCLGIBrtSZFRAg=
X-Google-Smtp-Source: APXvYqwvQpcJQeW38smvNfYceZifNj8qOfuPJyV1vJekNpT5HJCI4uqPjnqqSkerFnhP8tzZBRzIMQ==
X-Received: by 2002:a63:505b:: with SMTP id q27mr7526330pgl.39.1582943781119;
        Fri, 28 Feb 2020 18:36:21 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:34a0:1fb8:34d0:e7e7? ([2601:647:4000:d7:34a0:1fb8:34d0:e7e7])
        by smtp.gmail.com with ESMTPSA id p18sm14960634pjo.3.2020.02.28.18.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 18:36:20 -0800 (PST)
Subject: Re: [PATCH 6/6] block: cleanup comment for blk_flush_complete_seq
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
 <20200228150518.10496-7-guoqing.jiang@cloud.ionos.com>
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
Message-ID: <6b511848-a5e4-b03e-962f-c029a9f8566a@acm.org>
Date:   Fri, 28 Feb 2020 18:36:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228150518.10496-7-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-28 07:05, Guoqing Jiang wrote:
> Remove the comment about return value, since it is not valid after
> commit 404b8f5a03d84 ("block: cleanup kick/queued handling").

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


