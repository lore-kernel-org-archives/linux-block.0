Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2751C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 23:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91BEF21974
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 23:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgEHXcg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 19:32:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33420 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgEHXcf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 19:32:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id t7so1427787plr.0
        for <linux-block@vger.kernel.org>; Fri, 08 May 2020 16:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tCHckCbpvTDUMW+esQiLUncPPrtgrINSwn6jCxUuE9A=;
        b=FgcnyyzSL3qvTUTzUyXNXCurVFwzGZCvluToqMVOKE/GEHX7gzxqNCn5UYRF5nfb32
         2w7bTVEZ1J5IDKPDi2xTt+DCBPA8f/XNmi912EHZ2/5f9cHrW+I2PIlViFHZRPyrYRi1
         IAneZoAvIHvZekIQ+RdrjV7QJTpKxCO4/Cpjjc/NXE67XnjjZpkaa3bOpUOiVdGhcFqS
         uN2APHB1h6RNvY0lZAe7eg02dqOwacSIuU5BOoOg9NU9xVYvwhJ8EfY6KzsFDsqH7XXN
         /aXdz2R6PLfJPqnbKpQWy26zR4EDLmTXYQ5R4BoY/QP6t8kYnTlL1Y3Xu9fSrObdCRMS
         noQw==
X-Gm-Message-State: AGi0PubeQOfznATvYN8KWvbkcMx8CVbB+05mypXJcJBvV5FidytLbBs0
        QbS0kZu4WhdJHYK9Q3Y3jBI=
X-Google-Smtp-Source: APiQypJnQhBYaikvP4XlXS/nlG5zHGCwouWlPnK85M9DP6PVU2Ah2xwBu0Djel+rhnUwureGY23quA==
X-Received: by 2002:a17:90a:1983:: with SMTP id 3mr8532597pji.48.1588980754374;
        Fri, 08 May 2020 16:32:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:89ed:1db3:8c60:ba90? ([2601:647:4000:d7:89ed:1db3:8c60:ba90])
        by smtp.gmail.com with ESMTPSA id t5sm2120794pgp.80.2020.05.08.16.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 16:32:33 -0700 (PDT)
Subject: Re: [PATCH V10 05/11] blk-mq: support rq filter callback when
 iterating rqs
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-6-ming.lei@redhat.com>
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
Message-ID: <8d7a14f8-b36c-4f5c-a4af-d5904d3e9ea1@acm.org>
Date:   Fri, 8 May 2020 16:32:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505020930.1146281-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-04 19:09, Ming Lei wrote:
> @@ -310,19 +313,30 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
>  /**
>   * blk_mq_all_tag_busy_iter - iterate over all started requests in a tag map
>   * @tags:	Tag map to iterate over.
> - * @fn:		Pointer to the function that will be called for each started
> - *		request. @fn will be called as follows: @fn(rq, @priv,
> - *		reserved) where rq is a pointer to a request. 'reserved'
> - *		indicates whether or not @rq is a reserved request. Return
> - *		true to continue iterating tags, false to stop.
> + * @fn:		Pointer to the function that will be called for each request
> + * 		when .busy_rq_fn(rq) returns true. @fn will be called as
> + * 		follows: @fn(rq, @priv, reserved) where rq is a pointer to a
> + * 		request. 'reserved' indicates whether or not @rq is a reserved
> + * 		request. Return true to continue iterating tags, false to stop.
> + * @busy_rq_fn: Pointer to the function that will be called for each request,
> + * 		@busy_rq_fn's type is same with @fn. Only when @busy_rq_fn(rq,
> + * 		@priv, reserved) returns true, @fn will be called on this rq.
>   * @priv:	Will be passed as second argument to @fn.
>   */
> -static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> -		busy_tag_iter_fn *fn, void *priv)
> +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> +		busy_tag_iter_fn *fn, busy_rq_iter_fn *busy_rq_fn,
> +		void *priv)
>  {

The name 'busy_rq_fn' is not ideal because it is named after one
specific use case, namely checking whether or not a request is busy (has
already been started). How about using the name 'pred_fn' ('pred' from
predicate because it controls whether the other function is called)?
Since only the context that passes 'fn' can know what data structure
'priv' points to and since 'busy_rq_fn' is passed from another context,
can 'busy_rq_fn' even know what data 'priv' points at? Has it been
considered not to pass the 'priv' argument to 'busy_rq_fn'?

Thanks,

Bart.
