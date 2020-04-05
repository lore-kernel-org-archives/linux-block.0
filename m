Return-Path: <SRS0=lh2f=5V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF76BC2BA15
	for <linux-block@archiver.kernel.org>; Sun,  5 Apr 2020 02:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE1B206F5
	for <linux-block@archiver.kernel.org>; Sun,  5 Apr 2020 02:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgDEC36 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Apr 2020 22:29:58 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40082 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgDEC36 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Apr 2020 22:29:58 -0400
Received: by mail-pj1-f66.google.com with SMTP id kx8so4871901pjb.5
        for <linux-block@vger.kernel.org>; Sat, 04 Apr 2020 19:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gx4GHNUWtsGhoMe5BGDWzH5fhwt7Fgyke3F0pxuTNzc=;
        b=Q+DumfvDxXVKBUFvCsaTC3OZU5arHUb/JzDtDZfv+c84boMftChR+hjGWajRcAnl7a
         gpYNTjFIWE/WqOx2pbIBIns76P+cOk1p/UXbKs5nhNwX1E+bDV3LQtEkPODBRFpAiFKw
         KlSooOhue1KxC18juE5CieQKFoInnHQUfEbi7XCKDJ6GA4dLaOzajJuPqOX0Gttz1TgV
         MIwonaBuJiX+Q4xyWdsthJC0O1WXw35aMaDNQ+WICapOPsD27aC7a9bHHFrOKMsrg5h5
         IvXjJb8ltkFYLf+5YSogcEpa2E6o4On7IQVX8MCe0uHKuW4onT1K1KtN9HDuTPN7j+bY
         xsRQ==
X-Gm-Message-State: AGi0PubM6XRIhhjKenOgJmH5SAKqsuRAnpbR3wIrtoP9uxu0EQaR7QON
        b04dObM34k6xjhO1HdwtEeASdOmx/fg=
X-Google-Smtp-Source: APiQypJdm2TpHQcmery5d6u/pjpfRWWNjc/8gTA441g6LtSX59wLjXCdRZ64M5FRadvCNNhauOOo8g==
X-Received: by 2002:a17:90a:362a:: with SMTP id s39mr18899041pjb.28.1586053796477;
        Sat, 04 Apr 2020 19:29:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:103a:6b0b:334d:7fb2? ([2601:647:4000:d7:103a:6b0b:334d:7fb2])
        by smtp.gmail.com with ESMTPSA id n5sm2267100pgb.5.2020.04.04.19.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 19:29:55 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] block: alloc map and request for new hardware
 queue
To:     axboe@kernel.dk, linux-block@vger.kernel.org
References: <cover.1586006904.git.zhangweiping@didiglobal.com>
 <9818e6d277f88df0e40948c580b38316750c626f.1586006904.git.zhangweiping@didiglobal.com>
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
Message-ID: <d08d0ecd-c12e-8b39-bb9c-45df0b8bad13@acm.org>
Date:   Sat, 4 Apr 2020 19:29:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9818e6d277f88df0e40948c580b38316750c626f.1586006904.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-04-04 06:36, Weiping Zhang wrote:
> Alloc new map and request for new hardware queue when increse
  ^^^^^                                                 ^^^^^^^
  allocate?                                            increasing the?
> hardware queue count. Before this patch, it will show a
[ ... ]
> Reproduce script:
> 
> nr=$(expr `cat /sys/block/nvme0n1/device/queue_count` - 1)
> echo $nr > /sys/module/nvme/parameters/write_queues
> echo 1 > /sys/block/nvme0n1/device/reset_controller
> dd if=/dev/nvme0n1 of=/dev/null bs=4K count=1

Can this be converted in a blktests test?

Otherwise this patch looks good to me, hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
