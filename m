Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AE2C55199
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 17:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D921B2076A
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 17:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgD0R16 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:27:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33924 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgD0R16 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 13:27:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id s10so7254607plr.1
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 10:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FyumsHkIOBNQqFwiJRL4Ly7xeGVZh/BMRajGpMy1t9I=;
        b=FHcrMyY9nrEOgccQSks4N2PCONgLrtgwWdLr3nAI13SgedHSWNRbQ6fq1K2IfurPJo
         5g3fzFFD0q8yM+PXSm41sPLIi7adlLaJCj9ZFF6bivAtEMhRB/OmI6QByYJmBqyabkyW
         0Ret7MudzIhNlRgx8r/8WCsTqpnsDgnxe1YV2n6M0e1FtmonlFny248V0Aj27svzyxjt
         GU/RM1Kqs0qyj1GDcWpeUWxuaB/T9D5Mmfj12RKtFjykpWXHRgbkxOG891a5k3HbQjbT
         LmiNDYoW4ERV+GVZqfaKpYmEXLUN+DvPnE+x9UtnrOh+IpD4bP95JF1e0409irozMk4M
         HQeg==
X-Gm-Message-State: AGi0PuYiKffZdLBFMJJcGV0dAJeU1D7S07loxdCXTcreGknVnBv6kriu
        AehjpJMQeuNR/0RqqBP0YfLXajMBNIs=
X-Google-Smtp-Source: APiQypK4aS6a9R53oLhxXUpvnT/WLw/iW+8+0lFpfkUdHLezsmbzaBaQVZqXIs51GGe46u+yMMh1mQ==
X-Received: by 2002:a17:902:a40b:: with SMTP id p11mr24906103plq.304.1588008477192;
        Mon, 27 Apr 2020 10:27:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:a598:4365:d06:a875? ([2601:647:4000:d7:a598:4365:d06:a875])
        by smtp.gmail.com with ESMTPSA id h27sm11316620pgb.90.2020.04.27.10.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 10:27:56 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-mq: remove the pointless call of list_entry_rq()
 in hctx_show_busy_rq()
To:     Hou Tao <houtao1@huawei.com>, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
References: <20200427131250.13725-1-houtao1@huawei.com>
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
Message-ID: <244626f4-3469-1127-377c-d54c589d829b@acm.org>
Date:   Mon, 27 Apr 2020 10:27:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427131250.13725-1-houtao1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-04-27 06:12, Hou Tao wrote:
> And use rq directly.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  block/blk-mq-debugfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index b3f2ba483992..7a79db81a63f 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -400,8 +400,7 @@ static bool hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
>  	const struct show_busy_params *params = data;
>  
>  	if (rq->mq_hctx == params->hctx)
> -		__blk_mq_debugfs_rq_show(params->m,
> -					 list_entry_rq(&rq->queuelist));
> +		__blk_mq_debugfs_rq_show(params->m, rq);
>  
>  	return true;
>  }

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
