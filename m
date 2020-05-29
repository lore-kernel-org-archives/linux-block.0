Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431B9C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 16:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2E72077D
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 16:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgE2QR6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 12:17:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34460 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2QR6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 12:17:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id z64so1576296pfb.1
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 09:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4iA4fLluUKM2wBC2KZq3FDrTT8K1VIFSPGTSfVomd6g=;
        b=LUNVfCoHzqHe85VbrbAv4kM6Flcys1JROxMnTemcAVrsQzqklA1E32K7K46Q6yE3Hs
         7TbKGzwpW7W+ZtlOmfMkpXNNObl/bPkGnhxT7bGbLPUYTfMh8PAdY6qD8b/MMvu23i7m
         vVV5xQtIQyDr2cMBV5euj8J39LKe0u0nHJg9AKKmHMNZz0matEHjwAC1FcH8mB+h7l8p
         ftH1jdVaIzo/hWrrITkrHHvr0TTm9l2ZpYAhd4zMIW/Xl/BGgf1HYYjDdaIEWtb3FpiN
         nBSxQutkAO4wBCoiGU8G9hBKe26zQ5Lkbin7o4weakeRQjWOWa+PtCYEZ5BSZjen4QkO
         FlZA==
X-Gm-Message-State: AOAM532p8ZmgEjKW5mWNITOa1bTMGfRk3Rb/r2iew/v6G7cSiJNC4uY/
        2CtiyG6ObhiO8FZ4Ce+vQEY=
X-Google-Smtp-Source: ABdhPJxwQydfBiFICgA7vh5wGfewiNlAbsg51PbUNZUjJmjXsACMxXRQ8glpjWATnt31jEiNKNMCww==
X-Received: by 2002:a63:f103:: with SMTP id f3mr9096130pgi.30.1590769077288;
        Fri, 29 May 2020 09:17:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:9d55:11e:7174:3ec6? ([2601:647:4000:d7:9d55:11e:7174:3ec6])
        by smtp.gmail.com with ESMTPSA id a2sm7746895pfg.98.2020.05.29.09.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 09:17:56 -0700 (PDT)
Subject: Re: [PATCH] block: improve discard bio alignment in
 __blkdev_issue_discard()
To:     Coly Li <colyli@suse.de>, linux-block@vger.kernel.org
Cc:     Acshai Manoj <acshai.manoj@microfocus.com>,
        Christoph Hellwig <hch@lst.de>,
        Enzo Matsumiya <ematsumiya@suse.com>,
        Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, Xiao Ni <xni@redhat.com>
References: <20200529160350.99710-1-colyli@suse.de>
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
Message-ID: <d5d8af86-659f-d2cb-06e7-876c9481f73d@acm.org>
Date:   Fri, 29 May 2020 09:17:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529160350.99710-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-29 09:03, Coly Li wrote:
> +static inline unsigned int bio_aligned_discard_max_sectors(
> +					struct request_queue *q)
> +{
> +	return round_down(UINT_MAX, (q->limits.max_discard_sectors << 9)) >> 9;
> +}

How about changing '9' into 'SECTOR_SHIFT'?

Thanks,

Bart.

