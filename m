Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BAEC54FCB
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 17:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE192076A
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 17:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgD0RaJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:30:09 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56029 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgD0RaI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 13:30:08 -0400
Received: by mail-pj1-f68.google.com with SMTP id a32so7793753pje.5
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 10:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Q/waOpkeU8bo6Doc8NIp3kRxTaFNq1zSuupdNHjBmtA=;
        b=Ku/2f9F+KbCsOa1XJA9pOqMdmCALxrs+ZkMOxvTq9PY3K/US/oMIh/i5kX4rURrKtq
         4HFtOO0U5xEne9XMpZYNwmTiW8TMSXfI8pAm3vLReSYuq1eSMQL0X/hLjC8vGf4q1lXD
         ydW3ApNLnzKwCI8mu/kp67mZiMowmk1wjfDhqNdGHpsu3nA1QiTxrINt3U+uM2FJlAef
         4ltMuefDouSLcqwZ7PAbxnoP1r9WygFAhlxoVDEri/RY5IDTsIObI6Jg1uCbN2cahja+
         Ua4sqP/n02HyOuvoGrFyIk1z0gr8V6+IEcN36SVLxVjksKh+P7Ulf4HCZXYu05KWQNML
         C/sg==
X-Gm-Message-State: AGi0PuYZQq6Nzuvh0vd0d35dNPTOG549ru7hqqw8w3ZS7eb5E0f4PmGQ
        QZ2L+2Tx86BFYLQTKpONK6M=
X-Google-Smtp-Source: APiQypKtnIphH7q5xttIhTqUhogS5CI3JVS54S6HcvbNiOEe2+HphS9XOXtVXV8bgzhj9IsWdH3tgA==
X-Received: by 2002:a17:902:7208:: with SMTP id ba8mr6223921plb.246.1588008607878;
        Mon, 27 Apr 2020 10:30:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:a598:4365:d06:a875? ([2601:647:4000:d7:a598:4365:d06:a875])
        by smtp.gmail.com with ESMTPSA id r28sm13354557pfg.186.2020.04.27.10.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 10:30:07 -0700 (PDT)
Subject: Re: [PATCH] blk-mq-debugfs: update blk_queue_flag_name[] accordingly
 for new flags
To:     Hou Tao <houtao1@huawei.com>, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20200427133445.26215-1-houtao1@huawei.com>
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
Message-ID: <e1e28027-2dac-3ae3-21c1-9ba779a5a566@acm.org>
Date:   Mon, 27 Apr 2020 10:30:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427133445.26215-1-houtao1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-04-27 06:34, Hou Tao wrote:
> Else there may be magic numbers in /sys/kernel/debug/block/*/state.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  block/blk-mq-debugfs.c | 3 +++
>  include/linux/blkdev.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 7a79db81a63f..49fdbc8a025f 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -125,6 +125,9 @@ static const char *const blk_queue_flag_name[] = {
>  	QUEUE_FLAG_NAME(REGISTERED),
>  	QUEUE_FLAG_NAME(SCSI_PASSTHROUGH),
>  	QUEUE_FLAG_NAME(QUIESCED),
> +	QUEUE_FLAG_NAME(PCI_P2PDMA),
> +	QUEUE_FLAG_NAME(ZONE_RESETALL),
> +	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
>  };
>  #undef QUEUE_FLAG_NAME
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 32868fbedc9e..d56ef0def78b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -585,6 +585,7 @@ struct request_queue {
>  	u64			write_hints[BLK_MAX_WRITE_HINTS];
>  };
>  
> +/* Need to update blk_queue_flag_name[] accordingly */
>  #define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
>  #define QUEUE_FLAG_DYING	1	/* queue being torn down */
>  #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */

Changing "Need to update blk_queue_flag_name[] accordingly" into "Keep
blk_queue_flag_name[] in sync with the definitions below" probably would
be more clear. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
