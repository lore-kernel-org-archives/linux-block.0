Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CD0C2D0FC
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 23:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6F920740
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 23:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbgELXJB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 19:09:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44108 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgELXJA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 19:09:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id x13so1218311pfn.11
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 16:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=E6caCurE+IHAU/xih+WX8JBNE3GdFCiDVYpLiJVO/ME=;
        b=lMHqiHuz9mJZv4sN+5ep39ZxzTC03LAebMz6j04YP6kJWlNmWX2fqeUMWvKP3P2yO4
         COCXaOGlqgbE1yf1TiKuEoUR1daUlEGIXPlJAomNcIxUtFLrBfLnQDYYOpxlyNLsRnwy
         ++NGj62h+SBLaKqpwL7bVOfk9CCtZCvvvRIVIL93HLspsbQXmoFlzty5ZD858AYyPs3M
         f0CzJMp564wsNC/KbkJA9bXpLAL8fsCO896UG/j+cNn51Q+2x3VatEN+63ct8sBVmvLj
         yR2YQ8IunopquXC3oKFhugcDYfWExcEEz4vo0UtNbSMzXcp2qA+bW6auZ7Iv9x0suGdM
         wzqg==
X-Gm-Message-State: AOAM5310I8yMTqx3vqtQqtay98iXBb7hUnyp1qIFQ18ObTDSRJvuzZFO
        IL0AM/7l8IcQOGp1NCMIkYI=
X-Google-Smtp-Source: ABdhPJy2Frk+HEQ6NExGK8VDbLn/ByDnY/5yGhkqf5n/ilPsktoUcpVY7HxPym5aCrnbZ35FFttddw==
X-Received: by 2002:a63:4ca:: with SMTP id 193mr11907685pge.416.1589324939317;
        Tue, 12 May 2020 16:08:59 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:d1a1:34bc:ea5:fadd? ([2601:647:4000:d7:d1a1:34bc:ea5:fadd])
        by smtp.gmail.com with ESMTPSA id f26sm12917997pfn.183.2020.05.12.16.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 16:08:58 -0700 (PDT)
Subject: Re: [PATCH v6 0/5] Fix potential kernel panic when increase hardware
 queue
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, tom.leiming@gmail.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        Weiping Zhang <zhangweiping@didiglobal.com>
References: <cover.1588856361.git.zhangweiping@didiglobal.com>
 <5211ebcc-a123-47be-1a59-b2d767bab519@acm.org>
 <CAA70yB6iG3YmMzHDbhv864wi9dOonb9wFY8GiOMjD6DLSHokNA@mail.gmail.com>
 <CAA70yB42BDtpgkpM1UL_CkBjNAFAWOaWuoga+1eDPd=LoHWnbg@mail.gmail.com>
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
Message-ID: <beb354c0-d2db-ccfb-476c-03f03594c78e@acm.org>
Date:   Tue, 12 May 2020 16:08:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAA70yB42BDtpgkpM1UL_CkBjNAFAWOaWuoga+1eDPd=LoHWnbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-12 05:20, Weiping Zhang wrote:
> On Tue, May 12, 2020 at 8:09 PM Weiping Zhang <zwp10758@gmail.com> wrote:
>> I don't test block/030, since I don't pull blktest very often.

That's unfortunate ...

>> It's a different problem,
>> because the mapping cann't be reset when do fallback, so the
>> cpu[>=1] will point to a hctx(!=0).
>>
>>  it should be fixed by:
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index bc34d6b572b6..d82cefb0474f 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -3365,8 +3365,8 @@ static void __blk_mq_update_nr_hw_queues(struct
>> blk_mq_tag_set *set,
>>                 goto reregister;
>>
>>         set->nr_hw_queues = nr_hw_queues;
>> -       blk_mq_update_queue_map(set);
>>  fallback:
>> +       blk_mq_update_queue_map(set);
>>         list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>                 blk_mq_realloc_hw_ctxs(set, q);
>>                 if (q->nr_hw_queues != set->nr_hw_queues) {

If this is posted as a patch, feel free to add:

Tested-by: Bart van Assche <bvanassche@acm.org>

> And block/030 should also be improved ?
> 
>  35         # Since older null_blk versions do not allow "submit_queues" to be
>  36         # modified, check first whether that configs attribute is writeable.
>  37         # Each iteration of the loop below triggers $(nproc) + 1
>  38         # null_init_hctx() calls. Since <interval>=$(nproc), all possible
>  39         # blk_mq_realloc_hw_ctxs() error paths will be triggered. Whether or
>  40         # not this test succeeds depends on whether or not _check_dmesg()
>  41         # detects a kernel warning.
>  42         if { echo "$(<"$sq")" >$sq; } 2>/dev/null; then
>  43                 for ((i = 0; i < 100; i++)); do
>  44                         echo 1 > $sq
>  45                         nproc > $sq  # this line output lots
> "nproc: write error: Cannot allocate memory"
>  46                 done
>  47         else
>  48                 SKIP_REASON="Skipping test because $sq cannot be modified"
>  49         fi
> 
> 
> The test result show this test case [failed], actually it [pass],
> there is no warning detect
> in kernel log, if apply above patch.
> 
> block/030 (trigger the blk_mq_realloc_hw_ctxs() error path)  [failed]
>     runtime  1.999s  ...  2.115s
>     --- tests/block/030.out 2020-05-12 10:42:26.345782849 +0800
>     +++ /data1/zwp/src/blktests/results/nodev/block/030.out.bad
> 2020-05-12 20:14:59.878915218 +0800
>     @@ -1 +1,51 @@
>     +nproc: write error: Cannot allocate memory
>     +nproc: write error: Cannot allocate memory
>     +nproc: write error: Cannot allocate memory
>     +nproc: write error: Cannot allocate memory
>     +nproc: write error: Cannot allocate memory
>     +nproc: write error: Cannot allocate memory
>     +nproc: write error: Cannot allocate memory
>     ...
>     (Run 'diff -u tests/block/030.out
> /data1/zwp/src/blktests/results/nodev/block/030.out.bad' to see the
> entire diff)

That's weird. I have not yet encountered this. Test block/030 passes on
my setup.

Thanks,

Bart.
