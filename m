Return-Path: <SRS0=UEoe=DD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1918DC2D0A8
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 04:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C236221741
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 04:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgIZEH0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Sep 2020 00:07:26 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:39534 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbgIZEH0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Sep 2020 00:07:26 -0400
Received: by mail-pj1-f47.google.com with SMTP id v14so472151pjd.4;
        Fri, 25 Sep 2020 21:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WVVMmOaizRCAFyknMCJGXyHul5Kj6HqFHMuAWn7Lcko=;
        b=qJPjUWjfBkpBKlnKwdC4zSOaH0pVj9HrIEG6EbOLYmPSGGxYXG2o8En+6skZjz91HV
         klTAYCedT3wPXBdWn2WCNw36sgbnVgvfJXqMorJE6HIzV8lMIDclEv9cFjJ5rQBP4n4z
         nIrOBsl3ehUDdMOlgEJIqZUlB0xK0WdCczvaYaMs6R4j50W55dFolmu+TwEohWGqBc0z
         kKF5xhK5T6k9UhfoePduGyZMKiO9kNs9nr/Dv5VAjwu3qaVSO3bIS7K1EcYEQfcnCksQ
         v76NFNPXFcEnFBh3WJtjyYdX3wlUMSmuZ1H7lbDwpKVjsjRTFA6Z2oyf6WQ0a+XzsMSu
         lWXw==
X-Gm-Message-State: AOAM5310O4cn1Y+6DAyNJZowtYb3VHG41dx8xNUNA1PRhYnoS9ZXGWMv
        iBDUh2va/dGE7l7ZihlFr66juJl1vno=
X-Google-Smtp-Source: ABdhPJxFgSLntvqdTS5snYPlST8ToRUWa1dsFtCNQ86G9Oxr3PlIO/qiMStVh5Z0/gS2x/9MRAsn3w==
X-Received: by 2002:a17:90a:a40d:: with SMTP id y13mr616714pjp.183.1601093245239;
        Fri, 25 Sep 2020 21:07:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:8ee4:7db:d6f2:5686? ([2601:647:4000:d7:8ee4:7db:d6f2:5686])
        by smtp.gmail.com with ESMTPSA id gj6sm504846pjb.10.2020.09.25.21.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 21:07:24 -0700 (PDT)
Subject: Re: [PATCH] [v3] blk-mq: add cond_resched() in
 __blk_mq_alloc_rq_maps()
To:     Xianting Tian <tian.xianting@h3c.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200926023947.1891-1-tian.xianting@h3c.com>
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
Message-ID: <b884d4af-ef49-f294-4099-e35778f2a783@acm.org>
Date:   Fri, 25 Sep 2020 21:07:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200926023947.1891-1-tian.xianting@h3c.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-09-25 19:39, Xianting Tian wrote:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b3d2785ee..62d152d03 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3256,9 +3256,11 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
>  {
>  	int i;
>  
> -	for (i = 0; i < set->nr_hw_queues; i++)
> +	for (i = 0; i < set->nr_hw_queues; i++) {
>  		if (!__blk_mq_alloc_map_and_request(set, i))
>  			goto out_unwind;
> +		cond_resched();
> +	}
>  
>  	return 0;

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
