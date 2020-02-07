Return-Path: <SRS0=URwg=33=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7192CC04EB5
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 15:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF4A22464
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 15:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgBGP0w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:26:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40851 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgBGP0w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Feb 2020 10:26:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so1438814pfh.7;
        Fri, 07 Feb 2020 07:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VyghO3YKi7wbgbZH57oNxSVsc6On3cTxq1hV8OT2C08=;
        b=dGltc0ScaxfuS5gMyx9RHRD/4O1UshCZnPZjuaciF1SrGjZlwz6iGzlZlsCzG1Ng8R
         2PZAH6yY3Jcn2toXMZRqouZgoBwc9+edoqJ/oQKFTbT6jaSwfiefQ1hYv3pgAAFbKu7+
         AH3xuSEiF2MqJlPBQjNT8Mj37hqiZdPFvZpeBEVGsm6GbegcgO8sTAHVJfMu8nq7gh5n
         fcqtndyhpyi1nRoEhvN0Ghzs6SEVRk3DJ8STJ5RvLbyxZAlVU13IeiG155dn6BwMpUBc
         F8I37TJUfGq1UXjBU7dIk1aLFvATKwvAphjGWdnVtwQxXrR2s1/flCTjZGi1BNmVaed4
         fQ1g==
X-Gm-Message-State: APjAAAWameqtKecPqg9B+Fn67diewjVMo98GbcRh//xbNvG22sIvMDsf
        YyqasthGjBUcpaCgNu4WSVM=
X-Google-Smtp-Source: APXvYqxAJDs/+t+qpQFCnyFVIl8jkN5Zq7NtPC55RJbCLe+Ac/nN1lc6w2VmMAADbFq6jMAPh0BzXQ==
X-Received: by 2002:aa7:98c6:: with SMTP id e6mr10408887pfm.251.1581089211711;
        Fri, 07 Feb 2020 07:26:51 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:2484:4c29:8774:98e4? ([2601:647:4000:d7:2484:4c29:8774:98e4])
        by smtp.gmail.com with ESMTPSA id i11sm3184732pjg.0.2020.02.07.07.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 07:26:50 -0800 (PST)
Subject: Re: [PATCH] block: Limit number of items taken from the I/O scheduler
 in one go
To:     Salman Qazi <sqazi@google.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
References: <20200206101833.GA20943@ming.t460p>
 <20200206211222.83170-1-sqazi@google.com>
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
Message-ID: <5707b17f-e5d7-c274-de6a-694098c4e9a2@acm.org>
Date:   Fri, 7 Feb 2020 07:26:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206211222.83170-1-sqazi@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-06 13:12, Salman Qazi wrote:
> + *
> + * Returns true if hctx->dispatch was found non-empty and
> + * run_work has to be run again.

Please elaborate this comment and explain why this is necessary (to
avoid that flush processing is postponed forever).

> + * Returns true if hctx->dispatch was found non-empty and
> + * run_work has to be run again.

Same comment here.

> +again:
> +	run_again = false;
> +
>  	/*
>  	 * If we have previous entries on our dispatch list, grab them first for
>  	 * more fair dispatch.
> @@ -208,19 +234,28 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  		blk_mq_sched_mark_restart_hctx(hctx);
>  		if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
>  			if (has_sched_dispatch)
> -				blk_mq_do_dispatch_sched(hctx);
> +				run_again = blk_mq_do_dispatch_sched(hctx);
>  			else
> -				blk_mq_do_dispatch_ctx(hctx);
> +				run_again = blk_mq_do_dispatch_ctx(hctx);
>  		}
>  	} else if (has_sched_dispatch) {
> -		blk_mq_do_dispatch_sched(hctx);
> +		run_again = blk_mq_do_dispatch_sched(hctx);
>  	} else if (hctx->dispatch_busy) {
>  		/* dequeue request one by one from sw queue if queue is busy */
> -		blk_mq_do_dispatch_ctx(hctx);
> +		run_again = blk_mq_do_dispatch_ctx(hctx);
>  	} else {
>  		blk_mq_flush_busy_ctxs(hctx, &rq_list);
>  		blk_mq_dispatch_rq_list(q, &rq_list, false);
>  	}
> +
> +	if (run_again) {
> +		if (!restarted) {
> +			restarted = true;
> +			goto again;
> +		}
> +
> +		blk_mq_run_hw_queue(hctx, true);
> +	}

So this patch changes blk_mq_sched_dispatch_requests() such that it
iterates at most two times? How about implementing that loop with an
explicit for-loop? I think that will make
blk_mq_sched_dispatch_requests() easier to read. As you may know forward
goto's are accepted in kernel code but backward goto's are frowned upon.

Thanks,

Bart.
