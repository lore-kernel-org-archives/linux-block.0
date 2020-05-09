Return-Path: <SRS0=SfUb=6X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CE1C38A2A
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB57218AC
	for <linux-block@archiver.kernel.org>; Sat,  9 May 2020 03:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgEIDYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 23:24:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44450 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgEIDYr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 23:24:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id b8so1794568pgi.11
        for <linux-block@vger.kernel.org>; Fri, 08 May 2020 20:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UqfC0qKa0pC1OwDJC7dA0CivDRjARRZ8fzPT/dCAGNc=;
        b=dZe0VBRE9/4soM12np8Z9jw16dqMY1dEO4Vcft4ANTtCD97j6jjTxq0S9NiWcjAwET
         3fbKWspKcLHWVS4650vqnMsrzQtGz07LFh7UsjyfZTfMqJMQ7ONSyqTgCJVEhTdVeTQU
         /jW58ieDwcNBVjFf3FmBD7i49FNL0cih7u1i+DvgDk2h1uCUfNZ1BVKtokK4Z2B2fyHt
         nKapjornRVskLTUO/p9Um2Bh7kKDHgmcbSlA8jDXWuwKZGmd0xmczTto2dvH7BYvkAKA
         /hTmtUp923txnbnUrzPZ49Rv9g6C7BSWfhi7u4Mivqe95WLdk/3ey39I0coUKLzF/Rnq
         JjlQ==
X-Gm-Message-State: AGi0PuZNsR0aYVEw1A5w/Z4Z+xNjwfWznXT7CsltUYnp6xN+19NrTdev
        E/MTJTpa6M+txTEBVG4z6nEU1JlQ2sc=
X-Google-Smtp-Source: APiQypJPvLSe35BKdpg8e5HjmKWyDZqkWUGQ/CJ1zVp2eJVMRUeAlv52AP8m+jqwhXJbG6EWaZF0+A==
X-Received: by 2002:a63:1e1f:: with SMTP id e31mr4823476pge.393.1588994686785;
        Fri, 08 May 2020 20:24:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:1981:d78f:7563:fc3d? ([2601:647:4000:d7:1981:d78f:7563:fc3d])
        by smtp.gmail.com with ESMTPSA id c4sm2460387pga.73.2020.05.08.20.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 20:24:45 -0700 (PDT)
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
Message-ID: <0f578345-5a51-b64a-e150-724cfb18dde4@acm.org>
Date:   Fri, 8 May 2020 20:24:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509022051.GC1392681@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-08 19:20, Ming Lei wrote:
> Not sure why you mention queue freezing.

This patch series introduces a fundamental race between modifying the
hardware queue state (BLK_MQ_S_INACTIVE) and tag allocation. The only
mechanism I know of for enforcing the order in which another thread
observes writes to different memory locations without inserting a memory
barrier in the hot path is RCU (see also The RCU-barrier menagerie;
https://lwn.net/Articles/573497/). The only existing such mechanism in
the blk-mq core I know of is queue freezing. Hence my comment about
queue freezing.

Thanks,

Bart.
