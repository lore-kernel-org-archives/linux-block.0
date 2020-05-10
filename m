Return-Path: <SRS0=ZTaq=6Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDB1C38A2A
	for <linux-block@archiver.kernel.org>; Sun, 10 May 2020 16:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DBEF2080C
	for <linux-block@archiver.kernel.org>; Sun, 10 May 2020 16:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEJQUm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 May 2020 12:20:42 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:36985 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgEJQUm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 May 2020 12:20:42 -0400
Received: by mail-pf1-f177.google.com with SMTP id d184so3572388pfd.4
        for <linux-block@vger.kernel.org>; Sun, 10 May 2020 09:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HO/5xa1bfbXzKxbVlWz+nrcqMH30rP5IFMS7CJZQALU=;
        b=T91/uLuiFuBi/Ii7+ZAAUSUyMlgUfmDjgF0fmRJti8cBXCpn06evqMSp3JWeMqrtFO
         OJm9zMDV7/Qz0IjSObw/1+MboYuZXm0HoUoECGH2xeOYpGnpE9gWz0MJiWbYfXXdw6Pp
         d7pB55H/+P7yLwSJOAQSEL+NP6oKURETBWK7wkbj9h7LLybH912nCqONTX/lgfiibqlJ
         h1oVpRDrB0vzrc2IM3cuz7/lvS2ogtiDWygiO8PwT/d5S2atqaaw7quLJd2XHoY1LXub
         lHuQd7kxZAI1rmjeKBQISquMXVaQdmm8BFmief33jNrzXmcX6MZ/qaGXP4mELXB6Hcj1
         WFpw==
X-Gm-Message-State: AGi0PubrBF7hZGQipA0rAJYU2ruVR0btr+WVbJQRSlXCSuG6i5FJxWYg
        gipLKZ2RrS2hIDGOg37hu7I=
X-Google-Smtp-Source: APiQypIyyy66mM6sZoxKLYLkRqmho9Dr7VBxnO0B/MPSU811AB0mbe1ZjrNly9uGGboGfUGq53k4RA==
X-Received: by 2002:aa7:8eca:: with SMTP id b10mr12706478pfr.4.1589127641195;
        Sun, 10 May 2020 09:20:41 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:b088:c0f:1789:b6dc? ([2601:647:4000:d7:b088:c0f:1789:b6dc])
        by smtp.gmail.com with ESMTPSA id gz14sm7604735pjb.42.2020.05.10.09.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 09:20:40 -0700 (PDT)
Subject: Re: null_handle_cmd() doesn't initialize data when reading
To:     Alexander Potapenko <glider@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>
References: <CAG_fn=VBHmBgqLi35tD27NRLH2tEZLH=Y+rTfZ3rKNz9ipG+jQ@mail.gmail.com>
 <d204a9d7-3722-5e55-d6cc-3018e366981e@kernel.dk>
 <CAG_fn=XXsjDsA0_MoTF3XfjSuLCc+6wRaOCY_ZDt661P_rSmOg@mail.gmail.com>
 <BYAPR04MB57495B31CEA65B2B5D76203C864A0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CAG_fn=WVHpRQ19MK12pxiizTEvUFLiV7LJgF_LrX_G2SYd=ivQ@mail.gmail.com>
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
Message-ID: <277579c9-9e33-89ea-bfcd-bc14a543726c@acm.org>
Date:   Sun, 10 May 2020 09:20:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=WVHpRQ19MK12pxiizTEvUFLiV7LJgF_LrX_G2SYd=ivQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-10 03:03, Alexander Potapenko wrote:
> Thanks for the explanation!
> The code has changed recently, and my patch does not apply anymore,
> yet the problem still persists.
> I ended up just calling null_handle_rq() at the end of
> null_process_cmd(), but we probably need a cleaner fix.

Does this (totally untested) patch help? copy_to_nullb() guarantees that
it will write some data to the pages that it allocates but does not
guarantee yet that all data of the pages it allocates is initialized.

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 8efd8778e209..06f5761fccb6 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -848,7 +848,7 @@ static struct nullb_page *null_insert_page(struct
nullb *nullb,

 	spin_unlock_irq(&nullb->lock);

-	t_page = null_alloc_page(GFP_NOIO);
+	t_page = null_alloc_page(GFP_NOIO | __GFP_ZERO);
 	if (!t_page)
 		goto out_lock;

