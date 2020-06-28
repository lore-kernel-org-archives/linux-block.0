Return-Path: <SRS0=t6Xx=AJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465E3C433DF
	for <linux-block@archiver.kernel.org>; Sun, 28 Jun 2020 21:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E17206C3
	for <linux-block@archiver.kernel.org>; Sun, 28 Jun 2020 21:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgF1VXL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Jun 2020 17:23:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34426 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgF1VXL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Jun 2020 17:23:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id d12so6313186ply.1;
        Sun, 28 Jun 2020 14:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BpSg64nR1fToe5brQOkimu2K2EqU7NAiKxVPV21l0fw=;
        b=q3JAOyuwXZ8KxgOESQgEgInfTR3VKHDR2EZimNjHpI2IHByxM28c/lwfQcSE0URt8T
         c3foKBCaaRmSV+1afu9P3OBMQm4dDmq9R0k2c5PZNmpBHkL2LN4+eJNRQ8bEvuCI7LXL
         neDO+8RP6Lxuyxxu6LbTXSsSS6yRfiXWkIMkd8R7WG3WlPVvJwcDadC0C43OAANgmmoL
         bhetnmbiuJIM6OzUpmJAEvMM8sB2d30dQvT5sQ26R7L5tBE/BQHfgzvqV78MF80B7qiJ
         g7sFDkWXscpF37j0XKRcDN2oytgOKHhR+Wx/d/XbTtrYwzXVf3HFFg1Zz4bukuJX+gdh
         OUWg==
X-Gm-Message-State: AOAM533/MeQ+CpB1tpy+34FRjkDYYwoa6PRv4+Ak+PJtFr34WerOClHg
        Kz1dopX/ujSIWCgDfGv6/Z5KHAq0
X-Google-Smtp-Source: ABdhPJyTiSom0cIG/bPULTKmL4EVdBhebzZWUx6MQpODvuljytbZlTX6rjMYGGP97MPSq8g1ro1C8g==
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr11342155pll.18.1593379390017;
        Sun, 28 Jun 2020 14:23:10 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id 73sm4691742pfy.24.2020.06.28.14.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2020 14:23:09 -0700 (PDT)
Subject: Re: [PATCH 2/2] block: move request_queue member docs to kdoc
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        damien.lemoal@wdc.com, ming.lei@redhat.com,
        martin.petersen@oracle.com, satyat@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200623220311.8033-1-mcgrof@kernel.org>
 <20200623220311.8033-3-mcgrof@kernel.org>
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
Message-ID: <b9c5acdd-aef5-46fa-ab80-0d4508289d54@acm.org>
Date:   Sun, 28 Jun 2020 14:23:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623220311.8033-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-06-23 15:03, Luis Chamberlain wrote:
>  /**
>   * struct request_queue - block device driver request queue
> + * @queue_ctx: software queue context

To me the description "software queues" is much more clear than
"software queue context". I wouldn't mind if the queue_ctx member
variable would be renamed to make its role more clear.

Please also mention that there is one software queue per CPU.

> + * @queue_hw_ctx: hw dispatch queues

How about mentioning that requests flow from software queues into
hardware queues, from hardware queues to the storage controller and also
that the block driver controls the number of hardware queues?

> + * @queuedata: the queue owner gets to use this for whatever they like.
> + *	ll_rw_blk doesn't touch it.

How about changing "queue owner" into "block driver"? Please leave out
the reference to ll_rw_blk since that source file was removed in 2008.
See also commit a168ee84c90b ("block: first step of splitting ll_rw_blk,
rename it").

> + * @id: ida allocated id for this queue.  Used to index queues from ioctx.

It seems to me that this ID is not only used to associate an ioctx with
a request queue but also to associate a block cgroup with a request
queue? See also blkg_lookup_slowpath().

> + * @bounce_gfp: queue needs bounce pages for pages above this limit
> + * @kobj: queue kobject

Please mention the path of this object, namely /sys/block/${bdev}/queue.

> + * @mq_kobj: mq queue kobject

Please mention the path of this object too, namely /sys/block/${bdev}/mq.

> + * @nr_requests: maximum number of of requests

Double "of"? Please mention that this is the maximum number of requests
per hardware queue. There is one set of tags per hardware queue and each
hardware queue has 'nr_requests' tags. See also queue_requests_store()
and blk_mq_update_nr_requests().

> + * @ksm: Inline crypto capabilities
> + * @nr_zones:
> + * @nr_zones: total number of zones of the device. This is always 0 for regular
> + *	block devices.

"@nr_zones" occurs twice?

> + * @debugfs_mutex: used to protect access to the @ebugfs_dir
>   * @debugfs_mutex: used to protect access to the @debugfs_dir

Double "@debugfs_mutex"?

Thanks,

Bart.
