Return-Path: <SRS0=95tF=6C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04059C2BB1D
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 02:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2E722202
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 02:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgDRCnS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 22:43:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42557 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgDRCnR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 22:43:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id v2so1656715plp.9;
        Fri, 17 Apr 2020 19:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wWEpP3dqHHbqDPbB1BdY9doWI1aHm0wotxbGSBEcjPo=;
        b=lVy4eAlLRYmaQN2j/FxZCeIP3pbdjuDFGVrn24iPH+L+Imh086VSnvwnMzB6CNcRjy
         WYgH7bYK0SPuSv+4bC/EjJx4R1K5wRUnINTEeHTrhlxnum+KY+/OJa5p043zYMFDBjI5
         G5Vh0oLc4O0l8CF7aDin87neahJn8wctWEJMoS/FrvER+zaXjsSg1H+d4puXAyC1Xmkb
         TzaOmItPuPePo8/xmIO9q60jFb5O6fZ8AzghJwyZ3rRShCmjYBWsN/3McSBuwzXcbKNx
         g4Md8e6j560zUIjz4OQq5P2mA048YyrSXK2G80KodIBPY+h1qLW31BW76WK13NDhsy9Z
         63vg==
X-Gm-Message-State: AGi0PuZ+lhvelMU/F+lq0I0MaLkx5Z5xUU8b/cmhZw4crJ+9M/nUBGgJ
        PuLEjlxfw4M8HuUx0pYZ6+w=
X-Google-Smtp-Source: APiQypIRxe1KKh738FTrj5rdo+tAVRK4BqKjO7lWQ+PaJD/yPCQ44ug9hSe8z53G75yqVuPimmu+8Q==
X-Received: by 2002:a17:902:b186:: with SMTP id s6mr6777103plr.16.1587177796924;
        Fri, 17 Apr 2020 19:43:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:54eb:5dc7:79c2:2fa2? ([2601:647:4000:d7:54eb:5dc7:79c2:2fa2])
        by smtp.gmail.com with ESMTPSA id 62sm13841436pfu.181.2020.04.17.19.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 19:43:15 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Put driver tag in blk_mq_dispatch_rq_list() when
 no budget
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com
References: <1587035931-125028-1-git-send-email-john.garry@huawei.com>
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
Message-ID: <e5416179-2ba0-c9a8-1b86-d52eae29e146@acm.org>
Date:   Fri, 17 Apr 2020 19:43:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587035931-125028-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-04-16 04:18, John Garry wrote:
> If in blk_mq_dispatch_rq_list() we find no budget, then we break of the
> dispatch loop, but the request may keep the driver tag, evaulated
> in 'nxt' in the previous loop iteration.
> 
> Fix by putting the driver tag for that request.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8e56884fd2e9..a7785df2c944 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1222,8 +1222,10 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
>  		rq = list_first_entry(list, struct request, queuelist);
>  
>  		hctx = rq->mq_hctx;
> -		if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
> +		if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
> +			blk_mq_put_driver_tag(rq);
>  			break;
> +		}
>  
>  		if (!blk_mq_get_driver_tag(rq)) {
>  			/*

Is this something that can only happen if q->mq_ops->queue_rq(hctx, &bd)
returns another value than BLK_STS_OK, BLK_STS_RESOURCE and
BLK_STS_DEV_RESOURCE? If so, please add a comment in the source code
that explains this.

Is this perhaps a bug fix for 0bca799b9280 ("blk-mq: order getting
budget and driver tag")? If so, please mention this and add Cc tags for
the people who were Cc-ed on that patch.

Thanks,

Bart.

