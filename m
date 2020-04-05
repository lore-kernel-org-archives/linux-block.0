Return-Path: <SRS0=lh2f=5V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82442C2BA15
	for <linux-block@archiver.kernel.org>; Sun,  5 Apr 2020 02:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564EE20659
	for <linux-block@archiver.kernel.org>; Sun,  5 Apr 2020 02:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDECUR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Apr 2020 22:20:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35942 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgDECUR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Apr 2020 22:20:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id n10so5735635pff.3
        for <linux-block@vger.kernel.org>; Sat, 04 Apr 2020 19:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BCo+TDaROooML0LkDU4vfg868YlADwQOlAQezTbRTB4=;
        b=tLfcrWF89eCAxVuE7n68hoIp3Rr9L3TYStPSde2EZ5dhPaNLUno76bxbYvmTHW0usx
         48ubHUubwRvaBr/UTGvq8RZuCqT1aVAA7Y4obO26C9NDQUJHmS9Aq4oSxn+Oxu5Xih81
         gzC5pNirM12r4B1tBft4v2OnalCON7A8OOpl7zEM/Fp0XWN8FHazs5HzRJZfOrhc/ADh
         q8kZh6Z2nHiRZNKLn9whfZbLGiKoWsdzHMmrtZPXsug6uYeH45057ZqRYzQsBmSs3Sg5
         uNavkzK1D+JLXpHsPecNkgQsd2PFHMDG9BiJZhKmITrVh2vVmaPuS+bvr69amJJxZmHo
         Lmlg==
X-Gm-Message-State: AGi0Pua6Onia2es5qcC7aW0Vlqcet0GaCI7I8bwWgcesQzYX19xzSDQ5
        JuZKvXNa0FS1duaaKMTTio5d4QMwBlA=
X-Google-Smtp-Source: APiQypLndtK2Uv4JRg7CbQ3K2fDEDZFTR/NMS2oE56JTj65icw4L52NJXYd/8XzBEDmESbeZI3pGNw==
X-Received: by 2002:a63:6d3:: with SMTP id 202mr15152696pgg.445.1586053215386;
        Sat, 04 Apr 2020 19:20:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:103a:6b0b:334d:7fb2? ([2601:647:4000:d7:103a:6b0b:334d:7fb2])
        by smtp.gmail.com with ESMTPSA id m3sm8035758pgt.27.2020.04.04.19.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 19:20:14 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] block: save previous hardware queue count before
 udpate
To:     axboe@kernel.dk, linux-block@vger.kernel.org
References: <cover.1586006904.git.zhangweiping@didiglobal.com>
 <a0230ed5731a2c9183e1929611755579f20616ff.1586006904.git.zhangweiping@didiglobal.com>
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
Message-ID: <78d03e54-0787-f600-9381-e821eee6ad8d@acm.org>
Date:   Sat, 4 Apr 2020 19:20:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a0230ed5731a2c9183e1929611755579f20616ff.1586006904.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-04-04 06:35, Weiping Zhang wrote:
> blk_mq_realloc_tag_set_tags will update set->nr_hw_queues, so
> save old set->nr_hw_queues before call this function.
> 
> Since set->nr_hw_queues has been updated in blk_mq_realloc_tag_set_tags,
> no need set it again.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
