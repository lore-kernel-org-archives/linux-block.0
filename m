Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8FFC433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 17:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05100206D8
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 17:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgEPRKV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 13:10:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32778 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgEPRKV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 13:10:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id s10so306012pgm.0
        for <linux-block@vger.kernel.org>; Sat, 16 May 2020 10:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VVXNsVoAh9AVxY4eEX48BnbzJN0o5NeVgTWX/fAupCU=;
        b=M+JjH0LoyGyPfVa2K395UObib82ZIBDCy7p0Wkn6PIlhtwoOdebU3F6mBg7a/65vwD
         KozqrTmBW5KWtH1qr5I+QmyPwXa87SdoZ5Mv5QbQhT9B7pZQ766Mprn4cjhodhEAc51S
         YkTNQITp+82j4Ju3Qivg9gwqjPu5zCnsVPH8KwF/s08l96BG/T1vqDJVPtSsWZ7jHHDL
         q36Y8zf1ul0CB3tJHmeN2bUSkKu+VqSK/gXCtPirXGlFSraOd9zyf7eYfyiFkVUQ0BdU
         xfSQ8Yfets6QSKiv+l8t3XizIhjjUyuWHOYeCJlxk5YCH7AdsHHZOvGXGschliUHzQsY
         tXyg==
X-Gm-Message-State: AOAM530jqL6nX2iznpsS7oTwmIFWYLwZQLIcRY72lZ1jzyxb6RItIcV7
        74Ajz1wzBtpSVmdnREfQAWw=
X-Google-Smtp-Source: ABdhPJyPeSkzIUcYEfUo0xYqb3RGE0UFQjcd6QHPyeDZx2JjWibKpRr/AWNndhsabjzx8ECG4DKJHQ==
X-Received: by 2002:a65:62d6:: with SMTP id m22mr8338629pgv.314.1589649020020;
        Sat, 16 May 2020 10:10:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:97a:fd5b:e2c1:c090? ([2601:647:4000:d7:97a:fd5b:e2c1:c090])
        by smtp.gmail.com with ESMTPSA id i184sm4363342pgc.36.2020.05.16.10.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 10:10:18 -0700 (PDT)
Subject: Re: [PATCH 2/5] bio.h: Declare the arguments of bio iteration
 functions const
To:     Alexander Potapenko <glider@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20200516001914.17138-1-bvanassche@acm.org>
 <20200516001914.17138-3-bvanassche@acm.org>
 <CAG_fn=WwtWxFhtx5esv_vqZ4=7Y1Ui0urLpVVvA4t3u-X=Oz1g@mail.gmail.com>
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
Message-ID: <89399ce9-5738-fe58-da15-2b28f166740e@acm.org>
Date:   Sat, 16 May 2020 10:10:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=WwtWxFhtx5esv_vqZ4=7Y1Ui0urLpVVvA4t3u-X=Oz1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-16 01:55, Alexander Potapenko wrote:
> On Sat, May 16, 2020 at 2:19 AM Bart Van Assche <bvanassche@acm.org> wrote:
>> -static inline void bio_advance_iter(struct bio *bio, struct bvec_iter *iter,
>> -                                   unsigned bytes)
>> +static inline void bio_advance_iter(const struct bio *bio,
>> +                                   struct bvec_iter *iter, unsigned bytes)
>>  {
>>         iter->bi_sector += bytes >> 9;
>
> On a related note, should this 9 be SECTOR_SHIFT?

Hi Alexander,

I think a patch series is already under review for replacing "9" with
SECTOR_SHIFT. See also
https://lore.kernel.org/linux-block/20200507075100.1779-1-thunder.leizhen@huawei.com/.

Thanks,

Bart.
