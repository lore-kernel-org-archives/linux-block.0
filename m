Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC623C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 23:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16392173E
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 23:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgEHXqZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 19:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgEHXqY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 19:46:24 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFBCC061A0C
        for <linux-block@vger.kernel.org>; Fri,  8 May 2020 16:39:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l12so1585927pgr.10
        for <linux-block@vger.kernel.org>; Fri, 08 May 2020 16:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RA//g98RrX8pSIaHaDOZztwoHvyVWigkdqwwP7FNlIk=;
        b=AbRju+Vrq6lVL/vcJIB6wM2TZt6APvoFivGGL9OuKNDbqgConLJnzigeqfMhj+rrSJ
         +iWRN6/8cXLIqWzXbOLMnGH5cZtIeK98NlQUo9f5rA02UeFMitVshm0WyAaun6Jo8Fo7
         uW92Uvx0GX3j9dgSIP4LPhbhdSingFrcmeGF1Ci88iU53VOFrr3kzU0XUMa2uJX8ZSjF
         aD3ITKelv/0WaDfqjucGwHDyun1BbcFTuE2ohN4Q49xufSkE7LTxGb+cyVVa6bGX2HOU
         xETVPDKQCNDEn+XlCf5hJNCeoxC2DV8QB0MH4SWLOF+f3xtWK91uXqRSWLNkbkg70MXc
         0ONQ==
X-Gm-Message-State: AGi0PuZQ2SVx8n1TlQ+VkB3lxP+YXX6rPF38r8Q3hGkOzWU2Pa6xRDCp
        NHsDxGG5Gb7zYuDsqeM7ZFo=
X-Google-Smtp-Source: APiQypLflVhQVkNYq1tXVvog1rh90iCi4iewQBllhXZ4AeaHqE+Fp/RStSbUR7tZdummp9awdKTnpQ==
X-Received: by 2002:a65:684a:: with SMTP id q10mr4097863pgt.329.1588981188715;
        Fri, 08 May 2020 16:39:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:89ed:1db3:8c60:ba90? ([2601:647:4000:d7:89ed:1db3:8c60:ba90])
        by smtp.gmail.com with ESMTPSA id y2sm2896316pfq.16.2020.05.08.16.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 16:39:48 -0700 (PDT)
Subject: Re: [PATCH V10 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-8-ming.lei@redhat.com>
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
Message-ID: <dbada06d-fcc4-55df-935e-2a46433f28a1@acm.org>
Date:   Fri, 8 May 2020 16:39:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505020930.1146281-8-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-04 19:09, Ming Lei wrote:
> -static bool blk_mq_get_driver_tag(struct request *rq)
> +static bool blk_mq_get_driver_tag(struct request *rq, bool direct_issue)
>  {
>  	if (rq->tag != -1)
>  		return true;
> -	return __blk_mq_get_driver_tag(rq);
> +
> +	if (!__blk_mq_get_driver_tag(rq))
> +		return false;
> +	/*
> +	 * In case that direct issue IO process is migrated to other CPU
> +	 * which may not belong to this hctx, add one memory barrier so we
> +	 * can order driver tag assignment and checking BLK_MQ_S_INACTIVE.
> +	 * Otherwise, barrier() is enough given both setting BLK_MQ_S_INACTIVE
> +	 * and driver tag assignment are run on the same CPU because
> +	 * BLK_MQ_S_INACTIVE is only set after the last CPU of this hctx is
> +	 * becoming offline.
> +	 *
> +	 * Process migration might happen after the check on current processor
> +	 * id, smp_mb() is implied by processor migration, so no need to worry
> +	 * about it.
> +	 */
> +	if (unlikely(direct_issue && rq->mq_ctx->cpu != raw_smp_processor_id()))
> +		smp_mb();
> +	else
> +		barrier();
> +
> +	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state))) {
> +		blk_mq_put_driver_tag(rq);
> +		return false;
> +	}
> +	return true;
>  }

How much does this patch slow down the hot path?

Can CPU migration be fixed without affecting the hot path, e.g. by using
the request queue freezing mechanism?

Thanks,

Bart.
