Return-Path: <SRS0=95tF=6C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8357C38A2F
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 15:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D273D21D6C
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 15:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgDRP1A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Apr 2020 11:27:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44344 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgDRP07 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Apr 2020 11:26:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id 2so2681088pgp.11;
        Sat, 18 Apr 2020 08:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YY/W9I/pR8UrVEkJQ+YbeNp0mBSqe7CYOsNczXxVtrs=;
        b=cusYDrAtdct1smeJtZO8TRFl6NgokYz35oNHdQp0PFtgddJaPfhBIOFbzrFXuVaTLw
         Y4Uk3fHW6I66XRPsFPswOAxCkpRzJrad5UzJkX63M5kYmdq57LIuXJOiZuSahBxhIqhz
         n8J/Z4ZwNL4jne3wG5C7vBr33fcWE1XL97AxUsvEivnXDjML3qPRTh3OtgW/zglB9SDf
         TQWLSipN8Tg1FiERF2Ua9WKTGZuHOOWxLhYIfpVFais2D+Wm3TG0Oagb5N80SsAdfFf7
         ZNeVSL+jx8+HHCTtv18pHjEJHEgJ16n1D31Qhkma8a2PQt9Z92hLtMhtnw4JnZPYumKY
         Ak4Q==
X-Gm-Message-State: AGi0PuZ8WlvuJG17ave0KnQ5JztUrK2thZb9B/N2sZ7atPnropBQtppF
        bFexhvqr1fwmvvbVZzgUI0/d8t4Ydsg=
X-Google-Smtp-Source: APiQypINHxu/cSuMU/AWpxkaKYXPISoRnvDwv01qsf8oXKe7/nwMIiH8VNtvdKHAukG7DRS2G3+tgg==
X-Received: by 2002:a63:b954:: with SMTP id v20mr7919808pgo.100.1587223618050;
        Sat, 18 Apr 2020 08:26:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:551:c132:d476:f445? ([2601:647:4000:d7:551:c132:d476:f445])
        by smtp.gmail.com with ESMTPSA id t7sm18975981pfh.143.2020.04.18.08.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 08:26:56 -0700 (PDT)
Subject: Re: [RFC] block: fix access of uninitialized pointer address in
 bt_for_each()
To:     "yukuai (C)" <yukuai3@huawei.com>, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     yi.zhang@huawei.com, yuyufen@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200417125134.45117-1-yukuai3@huawei.com>
 <340bed9b-e14d-5a22-1601-8fb7aad4ce7f@acm.org>
 <ad7e4125-c90f-4dda-6029-940b9dfeb8c4@huawei.com>
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
Message-ID: <c503f186-9098-0b67-8ade-572fcbc4bf24@acm.org>
Date:   Sat, 18 Apr 2020 08:26:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ad7e4125-c90f-4dda-6029-940b9dfeb8c4@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-04-18 02:42, yukuai (C) wrote:
> [   61.988933] BUG: KASAN: use-after-free in bt_iter+0x29e/0x310
> [   61.989446] Read of size 8 at addr ffff88824f5d8c00 by task dd/2659
> [   61.989996]
> [   61.990136] CPU: 2 PID: 2659 Comm: dd Not tainted
> 4.19.90-00001-g9c3fb8226112-dirty #44

Hi Yu Kuai,

So this use-after-free was encountered with kernel version 4.19? Please
develop block layer kernel patches against Jens' for-next branch from
git://git.kernel.dk/linux-block. If it wouldn't be possible to reproduce
this issue with Jens' for-next branch, the next step is to check which
patch(es) fixed this issue and to ask Greg KH to backport these patches
to the stable tree.

Thanks,

Bart.

