Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9EECA9EB9
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 01:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B0620856
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 01:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392216AbfJXBeO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Oct 2019 21:34:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36362 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392133AbfJXBeN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Oct 2019 21:34:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id j11so11003921plk.3;
        Wed, 23 Oct 2019 18:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iIbHqc7whFbM1nynyaO/ZOBOKF9Fq8sPLS2K5pLEFMs=;
        b=t8l8CBihtFwCOAO4eLe0K2hibulR0AALfocDou17GtqK/yNjtN7PLHHnSECCVj5CBv
         eXKKKrAkgTUUv4ObUXxUD9+W3iFffRTDL+9TpvNPRH7TAYfp+XIyMKX314mGqJpe1eAm
         ma3RtR3hWKhylWdPKXWaFOr75vFF3GDEHII5CPOIzzpHHXzg+PKSOH3pPXi9nt0/5+R1
         qcCQNlWwPje4o8mL4PMsnNJqlYHJGjmtSBIF9ppv11H/VdwcI7YgAGPJsOp3SFnccsj9
         yuQOlEz8xD928sVsLVyMmxq161sIK/YZDnC6/D08dNB4fDVYpDxSL0Fe5GKV2LpXe/e6
         oi8g==
X-Gm-Message-State: APjAAAW2i3yCag1JBNSMzBTFoF4PYb0lWPeXw5/m53/+CE7kY89uWDJG
        UPMk63Siiv0BU2kBUI8iiNY=
X-Google-Smtp-Source: APXvYqy4F1Y3R6D8bYRnkzSfgQe1Kh+g2jfNEd1snisQHsc3XeWCysLvBvU4WxXg0gbNpGcbOyfEfw==
X-Received: by 2002:a17:902:690a:: with SMTP id j10mr12995175plk.173.1571880852958;
        Wed, 23 Oct 2019 18:34:12 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:c3:68e9:e651:6431:4a0])
        by smtp.gmail.com with ESMTPSA id ev20sm474208pjb.19.2019.10.23.18.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 18:34:11 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: remove needless goto from blk_mq_get_driver_tag
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, kernel@collabora.com, krisman@collabora.com
References: <20191022174108.15554-1-andrealmeid@collabora.com>
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
Message-ID: <2a8a99a6-4b39-e459-988a-ba9502919044@acm.org>
Date:   Wed, 23 Oct 2019 18:34:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191022174108.15554-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-10-22 10:41, André Almeida wrote:
> The only usage of the label "done" is when (rq->tag != -1) at the
> begging of the function. Rather than jumping to label, we can just
> remove this label and execute the code at the "if". Besides that,
> the code that would be executed after the label "done" is the return of
> the logical expression (rq->tag != -1) but since we are already inside
> the if, we now that this is true. Remove the label and replace the goto
> with the proper result of the label.
> 
> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> ---
> Hello,
> 
> I've used `blktest` to check if this change add any regression. I have
> used `./check block` and I got the same results with and without this
> patch (a bunch of "passed" and three "not run" because of the virtual
> scsi capabilities). Please let me know if there would be a better way to
> test changes at block stack.
> 
> This commit was rebase at linux-block/for-5.5/block.
> 
> Thanks,
> 	André
> ---
>  block/blk-mq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8538dc415499..1e067b78ab97 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1036,7 +1036,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
>  	bool shared;
>  
>  	if (rq->tag != -1)
> -		goto done;
> +		return true;
>  
>  	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
>  		data.flags |= BLK_MQ_REQ_RESERVED;
> @@ -1051,7 +1051,6 @@ bool blk_mq_get_driver_tag(struct request *rq)
>  		data.hctx->tags->rqs[rq->tag] = rq;
>  	}
>  
> -done:
>  	return rq->tag != -1;
>  }

Do we really need code changes like the above? I'm not aware of any text
in the Documentation/ directory that forbids the use of goto statements.

Thanks,

Bart.
