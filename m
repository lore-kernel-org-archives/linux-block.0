Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A0AC38A2A
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 00:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6566D208CA
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 00:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgEIAS7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 20:18:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46125 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgEIAS7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 20:18:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id 145so1813989pfw.13
        for <linux-block@vger.kernel.org>; Fri, 08 May 2020 17:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=amNIDICHwKm6KEBIzUeYGktbd4dcMuq/S1UZGTsA4Ks=;
        b=emkXi5NHSPN5+Zqjrh7lzJ7pSZJU5acei3mJPb9SXQsT99jp9dMP0iB0aVLLV72aSO
         NctyL7Ajs38wbP2H62lsidmX4E3LXV6Zwchba41j1RLJRJzrmEUDOkrWjQu81rE8AJyQ
         C/AfrbuoftPEmmEzy7G/Qec3WuseZqIjITi24pdPcbFquY8/omHHjmW9aeU5NXVlnNmb
         d+TdDyoH0J2rrlNbuLRBD2VJ2SfkhmHTP9XvMm+JtvVZqMC1LWkUyKShlm1S18UjEbqd
         vwLy7UpuypbpvQDRYCxew2kzsA9x+r9YRun0FWxBikRxVnXZTloCCsDUpEyMAMR2nWoC
         P5WA==
X-Gm-Message-State: AGi0PuZKn/TigEhGFbCyxxQixI93BmYeOftPCuuFunmMIi9PmF2OWb3s
        PqoVHrodIvkedVAfRcgCYaZD4qeZzJg=
X-Google-Smtp-Source: APiQypJiPvoolwUnu4M64yMPHs8t5tVjA+7UdSlkvbGgc8+EVBZaImzOOXoVCvtTlx79RxURW598eg==
X-Received: by 2002:a62:1994:: with SMTP id 142mr5265544pfz.259.1588983538586;
        Fri, 08 May 2020 17:18:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:89ed:1db3:8c60:ba90? ([2601:647:4000:d7:89ed:1db3:8c60:ba90])
        by smtp.gmail.com with ESMTPSA id x63sm2910330pfc.56.2020.05.08.17.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 17:18:57 -0700 (PDT)
Subject: Re: [PATCH V10 05/11] blk-mq: support rq filter callback when
 iterating rqs
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-6-ming.lei@redhat.com>
 <8d7a14f8-b36c-4f5c-a4af-d5904d3e9ea1@acm.org>
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
Message-ID: <51888b96-1e3b-9810-fb64-47a965b83711@acm.org>
Date:   Fri, 8 May 2020 17:18:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8d7a14f8-b36c-4f5c-a4af-d5904d3e9ea1@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-08 16:32, Bart Van Assche wrote:
> On 2020-05-04 19:09, Ming Lei wrote:
>> @@ -310,19 +313,30 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
>>  /**
>>   * blk_mq_all_tag_busy_iter - iterate over all started requests in a tag map
>>   * @tags:	Tag map to iterate over.
>> - * @fn:		Pointer to the function that will be called for each started
>> - *		request. @fn will be called as follows: @fn(rq, @priv,
>> - *		reserved) where rq is a pointer to a request. 'reserved'
>> - *		indicates whether or not @rq is a reserved request. Return
>> - *		true to continue iterating tags, false to stop.
>> + * @fn:		Pointer to the function that will be called for each request
>> + * 		when .busy_rq_fn(rq) returns true. @fn will be called as
>> + * 		follows: @fn(rq, @priv, reserved) where rq is a pointer to a
>> + * 		request. 'reserved' indicates whether or not @rq is a reserved
>> + * 		request. Return true to continue iterating tags, false to stop.
>> + * @busy_rq_fn: Pointer to the function that will be called for each request,
>> + * 		@busy_rq_fn's type is same with @fn. Only when @busy_rq_fn(rq,
>> + * 		@priv, reserved) returns true, @fn will be called on this rq.
>>   * @priv:	Will be passed as second argument to @fn.
>>   */
>> -static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
>> -		busy_tag_iter_fn *fn, void *priv)
>> +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
>> +		busy_tag_iter_fn *fn, busy_rq_iter_fn *busy_rq_fn,
>> +		void *priv)
>>  {
> 
> The name 'busy_rq_fn' is not ideal because it is named after one
> specific use case, namely checking whether or not a request is busy (has
> already been started). How about using the name 'pred_fn' ('pred' from
> predicate because it controls whether the other function is called)?
> Since only the context that passes 'fn' can know what data structure
> 'priv' points to and since 'busy_rq_fn' is passed from another context,
> can 'busy_rq_fn' even know what data 'priv' points at? Has it been
> considered not to pass the 'priv' argument to 'busy_rq_fn'?

Thinking further about this, another possible approach is not to modify
blk_mq_all_tag_busy_iter() at all and to introduce a new function that
iterates over all requests instead of only over busy requests. I think
that approach will result in easier to read code than patch 5/11 because
each of these request iteration functions will only accept a single
callback function pointer. Additionally, that approach will make the
following function superfluous (from patch 7/11):

+static bool blk_mq_inflight_rq(struct request *rq, void *data,
+			       bool reserved)
+{
+	return rq->tag >= 0;
+}

Thanks,

Bart.
