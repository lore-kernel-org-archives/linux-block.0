Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48EAC11D24
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 04:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D7C24656
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 04:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgBUEDz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 23:03:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39270 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgBUEDz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 23:03:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so296376plp.6
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2020 20:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wfOvODg+gBQK8K3Cm+ayZ3bkQHRh6FKgk0kigVf0zzg=;
        b=ZFifvzL6XCqo3c0vRJq2FTYdo2pOCX9M5MLky/aOcxaDhtfppS/FjyrD7pirxAByv8
         PrfjnYPDqvVJCaNEjYPDeV4bsJ8/FgZ728PVaXWt6aChYTZpJLb1BSJSoHtsl3JROAc/
         DfY0etIZgIsqeZP+JfO5kOuzFpX50FQCYI17smPcFGfQGWBz3r6kZbwelCX/UVaCGy3B
         jQ75VSvCLP4mvneWsbqg2S96kKLvHL+zVvvNq1LaDgCUVMrf62g5sdGa+/uKH1KCUfYL
         NsXZdpZPCrj0Owk0Nj3lASwEn/+kYyloOj5EskLTITjYbWl62vqOPD4RxNk1JIYJh91P
         /GKg==
X-Gm-Message-State: APjAAAU7YN149EPvB0sGp12g8qLX4KQMaUb6XaXjQIVHxniw3ABygUC9
        OwuYYHN8iR5i1DzmA38D07s=
X-Google-Smtp-Source: APXvYqwmO373vuMigWmC9vV71LUyzYSkNlZMSwgfWIXV77HSoW8zaWSvopO53xVudRWiZIXrVf3CLw==
X-Received: by 2002:a17:90a:db0b:: with SMTP id g11mr626521pjv.140.1582257834826;
        Thu, 20 Feb 2020 20:03:54 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:e57a:a1b3:1a44:bb8c? ([2601:647:4000:d7:e57a:a1b3:1a44:bb8c])
        by smtp.gmail.com with ESMTPSA id ep2sm841097pjb.31.2020.02.20.20.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 20:03:53 -0800 (PST)
Subject: Re: [PATCH 1/4] block: fix use-after-free on cached last_lookup
 partition
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
References: <20200109062109.2313-1-ming.lei@redhat.com>
 <20200109062109.2313-2-ming.lei@redhat.com>
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
Message-ID: <5eb26a32-d2b2-e2c3-52e2-591cf626a1ff@acm.org>
Date:   Thu, 20 Feb 2020 20:03:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200109062109.2313-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-01-08 22:21, Ming Lei wrote:
> delete_partition() clears the cached last_lookup partition. However
> the .last_lookup cache may be overwritten by one IO path after
> it is cleared from delete_partition(). Then another IO path may
> use the cached deleting partition after __delete_partition() is
> called, then use-after-free is triggered on the cached partition.
> 
> Fixes the issue by the following approach:
> 
> 1) always get the partition's refcount via hd_struct_try_get() before
> setting .last_lookup
> 
> 2) move clearing .last_lookup from delete_partition() to
> __delete_partition() which is release handle of the partition's
> percpu-refcount, so that no IO path can overwrite .last_lookup after it
> is cleared in __delete_partition().
> 
> It is one candidate approach of Yufen's patch[1] which adds overhead
> in fast path by indirect lookup which may introduce one extra cacheline
> in IO path. Also this patch relies on percpu-refcount's protection, and
> it is easier to understand and verify.
> 
> [1] https://lore.kernel.org/linux-block/20200109013551.GB9655@ming.t460p/T/#t

Hi Ming,

disk_map_sector_rcu() is called from the I/O path only and hence with
q->q_usage_counter > 0. Has it been considered to freeze disk->queue
from delete_partition() before deleting a partition and unfreezing
disk->queue after partition deletion has finished? Would that approach
allow to eliminate partition reference counting and thereby improve the
performance of the hot path?

Thanks,

Bart.
