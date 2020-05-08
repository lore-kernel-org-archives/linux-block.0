Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC94C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 23:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC462184D
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 23:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgEHX0V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 19:26:21 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37651 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgEHX0U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 19:26:20 -0400
Received: by mail-pj1-f65.google.com with SMTP id a7so4982626pju.2
        for <linux-block@vger.kernel.org>; Fri, 08 May 2020 16:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Nlj/e6Px8K5MZpy0+0LDNcwTwN8yX1LFH1pzBbBYPwU=;
        b=Fe+8yoqk3Ft8X+ftdK39OGTt+SEBAmZS7rosfNXsth8XpGJu6oqR1bQCdsK7/bH5Dw
         Zc++fDypATtnfT7xZd4Vx1kK1J0QS+6QgAWhYY2oVJo1x0hPyR9a2tyK0a/PFyVr5POg
         CS2OLOcitssREeIAxd8mHpddvxECh8DDQcMpQPOozc0dDjpsgobKVxfEkdu1W65S1YH/
         7YwVjaK7IAds9+fHf7vEVFVGbs/O4JeXh8TX02ejIEfmMYCFGvOoqBKSLQNG6DGVS9Xo
         XW5U9FVCa3W/V3wDF6H5XY5KNXw5EwfwKFkCFJaXcFOS1yQa3GSp2wW0Jl3QiehLBGUm
         CaDA==
X-Gm-Message-State: AGi0PuYfPT8sQ/XJ2HIyknRDvnDGu+Zr4vuguW4X2cLfGexBahHsroS+
        bIsMXw5UuSMU7h+Oc/OlcYY=
X-Google-Smtp-Source: APiQypLfZzYuuWRujYH8vbMqNGe5Q9hAHqLfZ3EEJX9mHf21xJZOrv7hAJDn68aZSXfT1omJNqUI2g==
X-Received: by 2002:a17:902:6acc:: with SMTP id i12mr4645027plt.61.1588980379712;
        Fri, 08 May 2020 16:26:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:89ed:1db3:8c60:ba90? ([2601:647:4000:d7:89ed:1db3:8c60:ba90])
        by smtp.gmail.com with ESMTPSA id 131sm2124537pgg.65.2020.05.08.16.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 16:26:18 -0700 (PDT)
Subject: Re: [PATCH V10 06/11] blk-mq: prepare for draining IO when hctx's all
 CPUs are offline
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-7-ming.lei@redhat.com>
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
Message-ID: <756074a0-ea4b-5dcf-9348-e5b4f4414248@acm.org>
Date:   Fri, 8 May 2020 16:26:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505020930.1146281-7-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-04 19:09, Ming Lei wrote:
> @@ -391,6 +393,7 @@ struct blk_mq_ops {
>  enum {
>  	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
>  	BLK_MQ_F_TAG_SHARED	= 1 << 1,
> +	BLK_MQ_F_NO_MANAGED_IRQ	= 1 << 2,
>  	BLK_MQ_F_BLOCKING	= 1 << 5,
>  	BLK_MQ_F_NO_SCHED	= 1 << 6,
>  	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 77d70b633531..24b3a77810b6 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -152,6 +152,7 @@ enum cpuhp_state {
>  	CPUHP_AP_SMPBOOT_THREADS,
>  	CPUHP_AP_X86_VDSO_VMA_ONLINE,
>  	CPUHP_AP_IRQ_AFFINITY_ONLINE,
> +	CPUHP_AP_BLK_MQ_ONLINE,
>  	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
>  	CPUHP_AP_X86_INTEL_EPB_ONLINE,
>  	CPUHP_AP_PERF_ONLINE,

Wouldn't BLK_MQ_F_NO_IRQ be a better name than BLK_MQ_F_NO_MANAGED_IRQ?

Please add comments that explain what BLK_MQ_F_NO_MANAGED_IRQ and
CPUHP_AP_BLK_MQ_ONLINE mean.

Thanks,

Bart.


