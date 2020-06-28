Return-Path: <SRS0=t6Xx=AJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B52C433DF
	for <linux-block@archiver.kernel.org>; Sun, 28 Jun 2020 20:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FCAE2053B
	for <linux-block@archiver.kernel.org>; Sun, 28 Jun 2020 20:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgF1Uxy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Jun 2020 16:53:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43788 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgF1Uxy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Jun 2020 16:53:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id w2so6558114pgg.10;
        Sun, 28 Jun 2020 13:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/Skqv25wAnqYg3Blzd9AIoqF08tRedT1L7V60PB1U9c=;
        b=U6BGqjGSBMC/RL2sfhGvXkSpBqTNLs/ME+YOZDLyR6VGXwCRl/OsyIRLYwtylS4BoE
         d1a5brfmEVnz1gpzaVXyHC9zmwYMRbmEePewsuQILNXYUGxGUUMccpPFQ4xQpmfXwcmO
         7yhoj01fYnkGW1e2htXp3mr3wLk4eHIPehVDbrTXunbXdhf2syYnSR7J7A19Y0vaRh0R
         5wkkJClZXlreJDwDWfREwDyIAcw14E2naKX2ol55H1yYECmECJU7eJ0pleu10Riaah5r
         Z58vWnBCuFGRP4Siw/77tQn8P/1lL2MGrSRKESx6qYF9WcoHqFBIrrsgxj+Ak1scROpx
         BJ8w==
X-Gm-Message-State: AOAM531bOz71kCgydjDVOI2Rsy4wBM8JD3Y/YAoAvKHcFNtZPKv7yl4h
        s7hvII5llJP2GzizVTqrYF/oQWx9
X-Google-Smtp-Source: ABdhPJzz2265fEWWmSqdhE0+OvrR6x850B3reKP/z5FWuVMsWimAj2NZAiXm8edO4ZU0ThiJeiedlQ==
X-Received: by 2002:a63:5d1:: with SMTP id 200mr7787221pgf.59.1593377632994;
        Sun, 28 Jun 2020 13:53:52 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id r17sm4867487pfg.62.2020.06.28.13.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2020 13:53:51 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: add initial kdoc over the request_queue
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        damien.lemoal@wdc.com, ming.lei@redhat.com,
        martin.petersen@oracle.com, satyat@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200623220311.8033-1-mcgrof@kernel.org>
 <20200623220311.8033-2-mcgrof@kernel.org>
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
Message-ID: <9bdf8661-f616-7cd3-b78c-4a00424a0bac@acm.org>
Date:   Sun, 28 Jun 2020 13:53:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623220311.8033-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-06-23 15:03, Luis Chamberlain wrote:
> +/**
> + * struct request_queue - block device driver request queue

Since request queues are used as a communication channel between the
block layer core and block drivers and since the block layer core
creates request queues, I propose to leave out the word "driver".

> + * @debugfs_mutex: used to protect access to the @debugfs_dir
> + * @blk_trace: used by blktrace to keep track of setup / tracing
> + * @debugfs_dir: directory created to place debugfs information. This is always
> + *	created for make_request and request-based block drivers upon
> + *	initialization. blktrace requires for this directory to be created,
> + *	and so it will be created on demand if its block driver type does not
> + *	create it opon initialization.
> + *
> + * The request_queue is used to manage incoming block layer device driver
> + * requests. We have three main type of block driver types which end up making
> + * use of the request_queue:

"incoming" is correct from the perspective of the block driver but not
from the perspective of the block layer core. How about describing
request queues as a communication channel between the block layer core
and block drivers?

Thanks,

Bart.
