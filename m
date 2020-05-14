Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8986C433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 04:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAADD20575
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 04:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgENErV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 00:47:21 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33942 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgENErU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 00:47:20 -0400
Received: by mail-pj1-f68.google.com with SMTP id l73so2419660pjb.1
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 21:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5BZ1Q/KhNxerT2YC/bFsNN0ZMGGuYHN558e0FGkJOC8=;
        b=JUdJ0x9C/Izs7Y0O1tWvLYz6B9ceZXCR7cAfR9xcTHHoRVUcJXJviW2fZ2P1GtS3W9
         wIQSIchFDtuyb6Vp9JlAL9IQUdEJGm8Qcxj1WExA6TmC6BWR1yptFtg8nHya2Y4cqZA9
         Ze4V9EBhF0OVr35mc159UBflB1WlslsjqfYAt5JwMtYA2fI6D9R3hRX9du7Np01GlaC8
         ZNSO4sgfqIzcb/zaHL5dN9gUly/UfqzWKZ2rHVXNYzHYhO5NROL9FMS2/jWMR2hNFRMJ
         9FyitrW+kP/EZ2USRyUJQk1/1T9eM0ZjOWlDgm2C1moH4j1v7xU64sdIP3ynzCe4+K+w
         flMw==
X-Gm-Message-State: AGi0PuaFaHm7BD9tzkc12WlLkX5lj+24ekUaZFV/k1ox8YPvy8nnrXmd
        yl8CnUD74wbT3BuaLgSpMEhEQZBb
X-Google-Smtp-Source: APiQypJKF93ksHvPzFbEGQnY0/hVrr9X7gKYHN77OIFajn1gbqa4od0+EorYJiM/crjOE3Hq55Fekw==
X-Received: by 2002:a17:90a:d78e:: with SMTP id z14mr38691419pju.125.1589431639471;
        Wed, 13 May 2020 21:47:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:89b0:7138:eb9:79bf? ([2601:647:4000:d7:89b0:7138:eb9:79bf])
        by smtp.gmail.com with ESMTPSA id f76sm1013718pfa.167.2020.05.13.21.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 21:47:18 -0700 (PDT)
Subject: Re: [PATCH] nvme: Fix io_opt limit setting
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20200514015452.1055278-1-damien.lemoal@wdc.com>
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
Message-ID: <fed0df8c-3005-fbdd-c413-06fd7d174dee@acm.org>
Date:   Wed, 13 May 2020 21:47:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514015452.1055278-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-13 18:54, Damien Le Moal wrote:
> @@ -1848,7 +1847,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	 */
>  	blk_queue_physical_block_size(disk->queue, min(phys_bs, atomic_bs));
>  	blk_queue_io_min(disk->queue, phys_bs);
> -	blk_queue_io_opt(disk->queue, io_opt);
> +	if (io_opt)
> +		blk_queue_io_opt(disk->queue, io_opt);

The above change looks confusing to me. We want the NVMe driver to set
io_opt, so why only call blk_queue_io_opt() if io_opt != 0? That means
that the io_opt value will be left to any value set by the block layer
core if io_opt == 0 instead of properly being set to zero.

Thanks,

Bart.
