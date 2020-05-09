Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9744C28CBC
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 14:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA34208DB
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 14:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgEIOSu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 May 2020 10:18:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34742 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgEIOSt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 May 2020 10:18:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id f6so2280944pgm.1
        for <linux-block@vger.kernel.org>; Sat, 09 May 2020 07:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ug51WSI3uS1EQ8RWZPsLJ7XVrzkLQITJXW7sPsFm47o=;
        b=oYyWfkN4byHlJ+G2e7//GtTT8wHUvl9+b2S9q5Oyy4E4b0MJ6mgzKu9KmQvHUxoCzj
         Qw2whCwKxC+l/zd4tHHNyJQ2GYY85jiqpuPHQwcv+Mwe/mqhbjnhzkWskE95SB2eBEu8
         woDR/yUQq03sCzGFA642nOjNmw+JEZk04/haq8hP2kdCNqQ6ND8MU+gY5xdZzaV9wmlq
         0KwTodKXuCU4xJbnp90tBGrXDSFWe+hcueFsScZmbo28CTxJJkO2ReyEYYplCFDzeOdM
         ZU3FEDPbXEg2jRzhrLa/MJ/vFMbAScEkxNazGz0y4uKwjdISEw+anoQpECqn4ASL/EJC
         KZGg==
X-Gm-Message-State: AGi0PuZ/4qDSjXHacI5f6GJ6NVTNEaxVwNKsu7OHs0j+lluyijG2jDtx
        xfz2HkzZHhhWKvSelmiQxp0=
X-Google-Smtp-Source: APiQypISCsZTD1T6O/Q0IKUTSoi5AawP9AosrNZ/IrLhB+TJBKuz2Ib9rzkDPQdUNXkowxQlMHtpKQ==
X-Received: by 2002:a63:5320:: with SMTP id h32mr6740255pgb.28.1589033928777;
        Sat, 09 May 2020 07:18:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:8ef:746a:4fe7:1df? ([2601:647:4000:d7:8ef:746a:4fe7:1df])
        by smtp.gmail.com with ESMTPSA id v10sm2703711pjy.48.2020.05.09.07.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 07:18:48 -0700 (PDT)
Subject: Re: [PATCH V10 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
 <20200505020930.1146281-8-ming.lei@redhat.com>
 <dbada06d-fcc4-55df-935e-2a46433f28a1@acm.org>
 <20200509022051.GC1392681@T590>
 <0f578345-5a51-b64a-e150-724cfb18dde4@acm.org>
 <20200509041042.GG1392681@T590>
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
Message-ID: <1918187b-2baa-5703-63ee-097a307cf594@acm.org>
Date:   Sat, 9 May 2020 07:18:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509041042.GG1392681@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-08 21:10, Ming Lei wrote:
> queue freezing can only be applied on the request queue level, and not
> hctx level. When requests can't be completed, wait freezing just hangs
> for-ever.

That's indeed what I meant: freeze the entire queue instead of
introducing a new mechanism that freezes only one hardware queue at a time.

Please clarify what "when requests can't be completed" means. Are you
referring to requests that take longer than expected due to e.g. a
controller lockup or to requests that take a long time intentionally?
The former case is handled by the block layer timeout handler. I propose
to handle the latter case by introducing a new callback function pointer
in struct blk_mq_ops that aborts all outstanding requests. Request queue
freezing is such an important block layer mechanism that I think we
should require that all block drivers support freezing a request queue
in a short time.

Bart.
