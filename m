Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82055C433E2
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 16:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5687C20719
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 16:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgINQzr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 12:55:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44888 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgINQsk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 12:48:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7so211228pgm.11;
        Mon, 14 Sep 2020 09:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=v48L7JGX53l/CPfgPRdRY47vGmb+Jr3vZoi7acfa0+s=;
        b=R1otZGJKzYcNcf/JYO0gR3t3fgIgp5hM03CWtrRL4qEeO9VFvVY/9tpQDjM4OiQU2f
         Ys90t0atxrSx5Ya2X9UuzX37h/hvEi1zSnusYYziBYV2NTaxgszkEuhD/ZoTNK97OiT/
         yCqIzwT4eGRIaRxOjy9iYrRqo8DPp+FGaOEkyiZxsTp4muJ85gTwxbPiKiymvnccV4Xy
         AQI/ksytNeCmMNmZshCKFGIYR97IB1kBtLybkAOi23jOsgF/6Upa8xLoP9DgLa0kB510
         MKM08AFmilTy0b9oqryyaQB2dhzrBypTFoXiDt8m/2WxY5jRF4++DYPHoxLG7GhXal6R
         ci/Q==
X-Gm-Message-State: AOAM531O8FrBWLVWpX7mKw7E7pV1kWEjjviw/McpFImNlIgtMs5A64VA
        zAjPpSdFK5/sHj7tP+fyNQh4ADD24Xk=
X-Google-Smtp-Source: ABdhPJyePguPzBlUFLzaQLcFKfIEGTMzHj3PRVFNJ8tN5cMZO0FSobDirkqph0ea+MOsi32QmGimIA==
X-Received: by 2002:a62:d44e:0:b029:13c:1611:652f with SMTP id u14-20020a62d44e0000b029013c1611652fmr14027695pfl.15.1600102089878;
        Mon, 14 Sep 2020 09:48:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:3f5a:7698:1b81:cc96? ([2601:647:4000:d7:3f5a:7698:1b81:cc96])
        by smtp.gmail.com with ESMTPSA id g23sm10805716pfh.133.2020.09.14.09.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 09:48:08 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: fix hang issue in blk_queue_enter()
To:     Yang Yang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     onlyfever@icloud.com
References: <20200914071903.65704-1-yang.yang@vivo.com>
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
Message-ID: <1f7aa460-6a6c-d200-786e-bfccf5fc2bff@acm.org>
Date:   Mon, 14 Sep 2020 09:48:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914071903.65704-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-09-14 00:19, Yang Yang wrote:
> There is a race between blk_queue_enter() and block layer's runtime
> suspend.
> 
>  CPU0                                CPU1
>  ---------------------------------   -------------------------------
>  blk_pre_runtime_suspend(q) {        blk_queue_enter() {
>    /* q->rpm_status=RPM_ACTIVE */
>    blk_set_pm_only(q)
>    /* q->pm_only=1 */
>    blk_freeze_queue_start(q)
>    blk_mq_unfreeze_queue(q)
>                                        if (percpu_ref_tryget_live()) {
>                                          /* pm=0 && q->pm_only=1 */
>                                          if (pm || !blk_queue_pm_only(q)) {
>                                          } else {
>                                            percpu_ref_put()
>                                          }
>                                        }
>                                        wait_event(q->mq_freeze_wq,
>                                          (!q->mq_freeze_depth &&
>                                          /* q->rpm_status=RPM_ACTIVE
>                                             q->pm_only=1 */
>                                          (pm || (blk_pm_request_resume(q),
>                                           !blk_queue_pm_only(q)))) ||
>                                           blk_queue_dying(q))
>                                      }
>    spin_lock_irq(&q->queue_lock)
>    q->rpm_status = RPM_SUSPENDING
>    spin_unlock_irq(&q->queue_lock)
>  }
> 
> At this point blk_pm_request_resume() missed the chance to resume the
> queue, so blk_queue_enter() may wait here forever.
> The solution is to wake up the mq_freeze_wq after runtime suspend
> completed, make blk_pm_request_resume() reexamine the q->rpm_status flag.
> 
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> ---
>  block/blk-pm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-pm.c b/block/blk-pm.c
> index b85234d758f7..dec7d0aef606 100644
> --- a/block/blk-pm.c
> +++ b/block/blk-pm.c
> @@ -132,6 +132,8 @@ void blk_post_runtime_suspend(struct request_queue *q, int err)
>  
>  	if (err)
>  		blk_clear_pm_only(q);
> +	else
> +		wake_up_all(&q->mq_freeze_wq);
>  }
>  EXPORT_SYMBOL(blk_post_runtime_suspend);

Please verify whether the following patch series also fixes the reported
hang: https://lore.kernel.org/linux-block/20200906012219.17893-1-bvanassche@acm.org/T/#t

Thanks,

Bart.
