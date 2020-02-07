Return-Path: <SRS0=URwg=33=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0622BC2D0B1
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 03:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA17522522
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 03:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgBGD4q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Feb 2020 22:56:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34036 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgBGD4q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Feb 2020 22:56:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so580538pfc.1
        for <linux-block@vger.kernel.org>; Thu, 06 Feb 2020 19:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xCZbgJZoAhfGRWBY3znvAaftxz4PU/JT1a6gyENQZWo=;
        b=fyeoWgAkQqT0Or8fvHaCj+XU69KS5h3S710v/OjJvC3xvP6e0puA0GEvMrsiSiyTEA
         HQ6ZrXqZGJs3+Yrx6QM3YbQIWXI0aZJoi4yDBlDMjygdfOu8hYbEqXO2sdgX9VR635Wv
         /kQqtkUm+tXKn2ogg4H3bKqFqkaXI27PZJwy8SqQyZxjefmdU1/WEkjzUa3zXzkEa5EB
         ELxzPvhfjG+5IcBMObFLCpIgxVMEqBbUFzO0t6yNj9nMpBsPj/lrOBofwB1wmrXF2WzH
         499IBIjTUMn0iDfNoVWGS9VcQLtc2dPtj6YesiNAxLRop0B+rBX0vazuVwnNpEmKWJWw
         ERAQ==
X-Gm-Message-State: APjAAAWCZJdhbIsKl5qK+YSBl89iC89WVcwvMdz9UgZUJg+N5qd7PS8j
        aTRyrdzSdKAR8jvsrDsxbbBQrPFchUY=
X-Google-Smtp-Source: APXvYqys+ppHzDadO7caAjW43bzQhO513WRQwCbla3S1q5H8f6TIR1/6o3sOHdsAs33rkCz/AqSfnA==
X-Received: by 2002:a63:2407:: with SMTP id k7mr7169974pgk.174.1581047803907;
        Thu, 06 Feb 2020 19:56:43 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:f5b6:2045:8416:42c6? ([2601:647:4000:d7:f5b6:2045:8416:42c6])
        by smtp.gmail.com with ESMTPSA id z30sm866048pfq.154.2020.02.06.19.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 19:56:43 -0800 (PST)
Subject: Re: [PATCH] blk-mq: Update blk_mq_map_queue() documentation
To:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
References: <20200206175005.7426-1-dwagner@suse.de>
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
Message-ID: <afd91072-ca4f-52d7-3bad-e46f20a19d18@acm.org>
Date:   Thu, 6 Feb 2020 19:56:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206175005.7426-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-06 09:50, Daniel Wagner wrote:
> Commit 8ccdf4a37752 ("blk-mq: save queue mapping result into ctx
> directly") changed the last argument name from cpu to ctx but missed
> to update the documentation.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  block/blk-mq.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index eaaca8fc1c28..76921a970c32 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -97,7 +97,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
>   * blk_mq_map_queue() - map (cmd_flags,type) to hardware queue
>   * @q: request queue
>   * @flags: request command flags
> - * @cpu: cpu ctx
> + * @ctx: software queue state
>   */
>  static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>  						     unsigned int flags,

Just "software queue" instead of "software queue state" probably would
have been more clear. I think that's the name that is used elsewhere in
the block layer. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
