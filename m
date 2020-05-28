Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A814C433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 14:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DBB207D3
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 14:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgE1Oom (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 10:44:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41580 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgE1Ool (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 10:44:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id r10so13554156pgv.8
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 07:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=29qFxfslRUDaDFjn/jeb+njyUzkcSR61LnvIy7uOVIc=;
        b=HopktgY69AFyT2OWRtXuT9RPpqouMk3sgDF12xVgbd/hTDCGLf5M/eq2cC8cyjiXDJ
         3oJNFcTqsf9UNGwTJ9+OcEg8HHEO8tHTb7wsvUvadn01Yw+wlCga4/ELqDK4Fs5qA7Qp
         6vwhYsA2eCj9Nbaoya3A0A4sF38wTd0VKMAz1FNogvH7EPt+ihWuGqldaix4FDMPnd0B
         ZzfZDv8pKbQQWGaIIIztp6Xe1NyouSZWv2mmo3ydMoSBzLvorfgf0kT5dk9KbBeL06yK
         nKdhlg5YIKkkBVDCKpV5fE7r5hBAw2GUL2iXmPdzMEc5ZTmDNSu3e34cWEXZOiZAIBFM
         uGEg==
X-Gm-Message-State: AOAM532xlA6JsuOcSj0LaCKc9tp/vYyzLY1QCzquBbCjhweCGD3rvv6w
        haD/NzD1kPHXb9JIEO591/pdascv
X-Google-Smtp-Source: ABdhPJzpgPli9BEWZLmNBvzv6isWToefwVST9g6QmETpj90PZTZrtayxpxQEz881z6nizQo4DoLXFQ==
X-Received: by 2002:aa7:9093:: with SMTP id i19mr3340985pfa.152.1590677080482;
        Thu, 28 May 2020 07:44:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:40e6:aa88:9c03:e0b4? ([2601:647:4000:d7:40e6:aa88:9c03:e0b4])
        by smtp.gmail.com with ESMTPSA id a2sm4911611pfi.208.2020.05.28.07.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 07:44:39 -0700 (PDT)
Subject: Re: [PATCH] blktrace: Avoid sparse warnings when assigning
 q->blk_trace
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20200528092910.11118-1-jack@suse.cz>
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
Message-ID: <298af02a-3b58-932a-8769-72dcc52750ad@acm.org>
Date:   Thu, 28 May 2020 07:44:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528092910.11118-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(+Luis)

On 2020-05-28 02:29, Jan Kara wrote:
> Mostly for historical reasons, q->blk_trace is assigned through xchg()
> and cmpxchg() atomic operations. Although this is correct, sparse
> complains about this because it violates rcu annotations. Furthermore
> there's no real need for atomic operations anymore since all changes to
> q->blk_trace happen under q->blk_trace_mutex. So let's just replace
> xchg() with rcu_replace_pointer() and cmpxchg() with explicit check and
> rcu_assign_pointer(). This makes the code more efficient and sparse
> happy.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

How about adding a reference to commit c780e86dd48e ("blktrace: Protect
q->blk_trace with RCU") in the description of this patch?

> @@ -1669,10 +1672,7 @@ static int blk_trace_setup_queue(struct request_queue *q,
>  
>  	blk_trace_setup_lba(bt, bdev);
>  
> -	ret = -EBUSY;
> -	if (cmpxchg(&q->blk_trace, NULL, bt))
> -		goto free_bt;
> -
> +	rcu_assign_pointer(q->blk_trace, bt);
>  	get_probe_ref();
>  	return 0;

This changes a conditional assignment of q->blk_trace into an
unconditional assignment. Shouldn't q->blk_trace only be assigned if
q->blk_trace == NULL?

Thanks,

Bart.

