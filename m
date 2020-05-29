Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDA8C433E1
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 19:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFDA4207BC
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 19:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgE2Tzs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 15:55:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33074 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgE2Tzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 15:55:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id t7so1671720plr.0;
        Fri, 29 May 2020 12:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gTPKZEbWwB77B3xioLSe2J3rExHMu/3g/QtNSyeaSpA=;
        b=YJLTd9dR2pYeKuWFW+agfldRBK8P9BsDo7OWRLaC1BDIYcNd8byCg4/aP7HCdXWo/7
         QPZ0rscl422IU3D7GcmCb2dV7JciRnsVKxZ32uc3enFYR1xWuFu5YUqfDVrWJjux33nn
         uJNWAq3uwV2r6aNNDDAnao1ZZNSXWhvLuLHj7thuSfzvAz9Cf3lYsyqwnQqH5R+SmJrr
         +mJjEggJei4FOq9D5/SD2+krGGiKJJWitZM1V/cvdwri2rF3/TKJu+H85rG6CLo282Me
         AINg3uyBKocWdAHBQKf7pFR4cLNSOIZm55nu0jpROsVY3+yzOadX4uibqYte3eS5cT8l
         QK9A==
X-Gm-Message-State: AOAM530f9uey026uIfznn5ANgRfhM4nGbn9y6j3K4PZWwnENKPUtzvYY
        wEmj4vVGq6fsaxERv9T3iW5kiwzB
X-Google-Smtp-Source: ABdhPJwLhAiWpNBSlUspndB36b2goGPk367k/w2r2wL0ExwW8UXRrv/k/LeeHIbItyjAjPgQ8RFt3Q==
X-Received: by 2002:a17:90a:aa8d:: with SMTP id l13mr11397021pjq.92.1590782146124;
        Fri, 29 May 2020 12:55:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:9d55:11e:7174:3ec6? ([2601:647:4000:d7:9d55:11e:7174:3ec6])
        by smtp.gmail.com with ESMTPSA id k30sm7943471pfh.49.2020.05.29.12.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 12:55:44 -0700 (PDT)
Subject: Re: [PATCH 8/8] blk-mq: drain I/O when all CPUs in a hctx are offline
To:     paulmck@kernel.org, Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20200527180644.514302-9-hch@lst.de>
 <7acc7ab5-02f9-e6ee-e95f-175bc0df9cbc@acm.org> <20200528014601.GC933147@T590>
 <1ec7922c-f2b0-08ec-5849-f4eb7f71e9e7@acm.org>
 <20200528051932.GA1008129@T590>
 <4fb6f0cf-a356-833e-25ab-47f9131c729b@acm.org>
 <20200528172121.GN2869@paulmck-ThinkPad-P72> <20200529015304.GC1075489@T590>
 <20200529030728.GW2869@paulmck-ThinkPad-P72> <20200529035315.GD1075489@T590>
 <20200529181352.GF2869@paulmck-ThinkPad-P72>
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
Message-ID: <00b74229-f943-fb4b-ade4-3f4511c33146@acm.org>
Date:   Fri, 29 May 2020 12:55:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529181352.GF2869@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-29 11:13, Paul E. McKenney wrote:
> On Fri, May 29, 2020 at 11:53:15AM +0800, Ming Lei wrote:
>> Another pair is in blk_mq_get_tag(), and we expect the following two
>> memory OPs are ordered:
>>
>> 1) set bit in successful test_and_set_bit_lock(), which is called
>> from sbitmap_get()
>>
>> 2) test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state)
>>
>> Do you think that the above two OPs are ordered?
> 
> Given that he has been through the code, I would like to hear Bart's
> thoughts, actually.

Hi Paul,

My understanding of the involved instructions is as follows (see also
https://lore.kernel.org/linux-block/b98f055f-6f38-a47c-965d-b6bcf4f5563f@huawei.com/T/#t
for the entire e-mail thread):
* blk_mq_hctx_notify_offline() sets the BLK_MQ_S_INACTIVE bit in
hctx->state, calls smp_mb__after_atomic() and waits in a loop until all
tags have been freed. Each tag is an integer number that has a 1:1
correspondence with a block layer request structure. The code that
iterates over block layer request tags relies on
__sbitmap_for_each_set(). That function examines both the 'word' and
'cleared' members of struct sbitmap_word.
* What blk_mq_hctx_notify_offline() waits for is freeing of tags by
blk_mq_put_tag(). blk_mq_put_tag() frees a tag by setting a bit in
sbitmap_word.cleared (see also sbitmap_deferred_clear_bit()).
* Tag allocation by blk_mq_get_tag() relies on test_and_set_bit_lock().
The actual allocation happens by sbitmap_get() that sets a bit in
sbitmap_word.word. blk_mg_get_tag() tests the BLK_MQ_S_INACTIVE bit
after tag allocation succeeded.

What confuses me is that blk_mq_hctx_notify_offline() uses
smp_mb__after_atomic() to enforce the order of memory accesses while
blk_mq_get_tag() relies on the acquire semantics of
test_and_set_bit_lock(). Usually ordering is enforced by combining two
smp_mb() calls or by combining a store-release with a load-acquire.

Does the Linux memory model provide the expected ordering guarantees
when combining load-acquire with smp_mb__after_atomic() as used in patch
8/8 of this series?

Thanks,

Bart.
