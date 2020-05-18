Return-Path: <SRS0=EWmM=7A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFED5C433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 02:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFBB020787
	for <linux-block@archiver.kernel.org>; Mon, 18 May 2020 02:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgERC4l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 May 2020 22:56:41 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51990 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgERC4k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 22:56:40 -0400
Received: by mail-pj1-f65.google.com with SMTP id cx22so1011595pjb.1
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 19:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SAflGMcdaG131rPEvbIiw1qcwEBGT6u1s6p80KNja8c=;
        b=aS3Xm26P4m5p1aK3SvmAJGfQqHJuOfXn6YPXmB/KM4Gcd4VY/G/d33v3d/DnXsoAFE
         oUnKrErgkYl2Hibadn1E+02X2vNlsj+CwajJKee3DzPU3s4cs9p6oCvd6RruM+sQ5xr9
         jeeMFp4NfE8EsdzoVC1WLEiPnETT1poGAsaN5f85XyL7Hf7EwjV55fY2pSv6laWDpf/K
         TdiqxwUoTdWjIKWwLTsrxSE2P4T9YeJnKN7Pvf1pP9ZjTqRB89vEyD5iCUqlcGDDdBa0
         dJtxXbX7v834Mxz7chMeB12PF6Zwbdawj19fvOwNjZellAUZ/bchpbyApwqE9EVNoqgy
         m9wQ==
X-Gm-Message-State: AOAM53211C4fMfTbIQly/VtyuqrZsWYHVw+NEy4o+27YbRoLRy5gXa1y
        snpTS13E2+1++FFlDa7U0/Q=
X-Google-Smtp-Source: ABdhPJyEhQD1VH27yL+HhgB3HD2yLkaRDJrnJ52aK1q5RcS/uhbaE609c9ayZyyP+LauI09DW5j0yg==
X-Received: by 2002:a17:90a:2685:: with SMTP id m5mr13943472pje.197.1589770600018;
        Sun, 17 May 2020 19:56:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:1c3f:56a2:fad2:fca1? ([2601:647:4000:d7:1c3f:56a2:fad2:fca1])
        by smtp.gmail.com with ESMTPSA id m2sm3873086pjl.45.2020.05.17.19.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2020 19:56:39 -0700 (PDT)
Subject: Re: [PATCH 5/5] null_blk: Zero-initialize read buffers in
 non-memory-backed mode
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Alexander Potapenko <glider@google.com>
References: <20200516001914.17138-1-bvanassche@acm.org>
 <20200516001914.17138-6-bvanassche@acm.org>
 <BY5PR04MB69008A16B82CD028FC01D0A6E7B80@BY5PR04MB6900.namprd04.prod.outlook.com>
 <440743f4-1053-32f3-2edf-3eb0fdd057ef@acm.org>
 <BY5PR04MB690032A546EF80F2B823C984E7B80@BY5PR04MB6900.namprd04.prod.outlook.com>
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
Message-ID: <45f9df39-a62e-4721-5bc8-ac9fa87b02ea@acm.org>
Date:   Sun, 17 May 2020 19:56:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BY5PR04MB690032A546EF80F2B823C984E7B80@BY5PR04MB6900.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-17 19:10, Damien Le Moal wrote:
> On 2020/05/18 10:32, Bart Van Assche wrote:
>> On 2020-05-17 18:12, Damien Le Moal wrote:
>>> On 2020/05/16 9:19, Bart Van Assche wrote:
>>>> +static void nullb_zero_rq_data_buffer(const struct request *rq)
>>>> +{
>>>> +	struct req_iterator iter;
>>>> +	struct bio_vec bvec;
>>>> +
>>>> +	rq_for_each_bvec(bvec, rq, iter)
>>>> +		zero_fill_bvec(&bvec);
>>>> +}
>>>> +
>>>> +static void nullb_zero_read_cmd_buffer(struct nullb_cmd *cmd)
>>>> +{
>>>> +	struct nullb_device *dev = cmd->nq->dev;
>>>> +
>>>> +	if (dev->queue_mode == NULL_Q_BIO && bio_op(cmd->bio) == REQ_OP_READ)
>>>> +		zero_fill_bio(cmd->bio);
>>>> +	else if (req_op(cmd->rq) == REQ_OP_READ)
>>>> +		nullb_zero_rq_data_buffer(cmd->rq);
>>>> +}
>>>
>>> Shouldn't the definition of these two functions be under a "#ifdef CONFIG_KMSAN" ?
>>
>> It is on purpose that I used IS_ENABLED(CONFIG_KMSAN) below instead of
>> #ifdef CONFIG_KMSAN. CONFIG_KMSAN is not yet upstream and I want to
>> expose the above code to the build robot.
> 
> But then you will get a "defined but unused" build warning, no ?

Not when using IS_ENABLED(...).

Bart.
