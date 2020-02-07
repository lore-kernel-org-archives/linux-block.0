Return-Path: <SRS0=URwg=33=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B5BC2D0B1
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 04:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBD42051A
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 04:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgBGEJu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Feb 2020 23:09:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34355 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGEJu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Feb 2020 23:09:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id j4so440358pgi.1;
        Thu, 06 Feb 2020 20:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1/EFHh+LhF1/Sc1aySvedtpsODTs1AtO9/qs6HoPYXY=;
        b=VUlLejPqxtlvaoPPEEf62L2bjrVveUFwrkEdiThOBJLbFDelWUP4fJuUZAZaa+D4a8
         ze86C88GybEa6yjLdBX9PtsC+lQ73Hq4zUH7AQIPNHrikMJ/c5zSwWOxFMRM6ABH57yT
         VQ7hUPSuQaahiEEDZYXJk1HRNIusMFCTyMqC0oLPE7k3EEc4tptVFZcGENt0/v1OTZio
         ZzpvRNT8rwQ3Ol/RTMTp3P8NElSNA+Vz8TPcLcLJSkqXv3ZTB9ID2q5tnxzBv2bgF1s4
         cFxrCGRyPUNVKLWCwJHxLojpidnFjsyCo3igBEHytQPlIuOv54ngGxlrtjv7Rrul4g8r
         7wbg==
X-Gm-Message-State: APjAAAWWIY4mMBKx0KDZkFP/GN/Tn+P5wnwfskH5BldQdRsL7A1FmnbF
        hMuxe9aW3MJKA6tHh+POHdo=
X-Google-Smtp-Source: APXvYqxqepOvSW+SmFmnrLW2ezq8Gv+zDG+zha/cYiehJR9WAq/JGN0GdWwB2nQR9zfPXKKT8RNbPw==
X-Received: by 2002:a63:3154:: with SMTP id x81mr7573184pgx.32.1581048589700;
        Thu, 06 Feb 2020 20:09:49 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:f5b6:2045:8416:42c6? ([2601:647:4000:d7:f5b6:2045:8416:42c6])
        by smtp.gmail.com with ESMTPSA id r66sm921721pfc.74.2020.02.06.20.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 20:09:48 -0800 (PST)
Subject: Re: [PATCH] block: revert pushing the final release of request_queue
 to a workqueue.
To:     yu kuai <yukuai3@huawei.com>, axboe@kernel.dk, ming.lei@redhat.com,
        chaitanya.kulkarni@wdc.com, damien.lemoal@wdc.com,
        dhowells@redhat.com, asml.silence@gmail.com, ajay.joshi@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com, luoshijie1@huawei.com
References: <20200206111052.45356-1-yukuai3@huawei.com>
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
Message-ID: <51b4cd75-2b19-3e4d-7ead-409c77c44b70@acm.org>
Date:   Thu, 6 Feb 2020 20:09:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206111052.45356-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-02-06 03:10, yu kuai wrote:
> commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression") pushed the
> final release of request_queue to a workqueue, witch is not necessary
> since commit 1e9364283764 ("blk-sysfs: Rework documention of
> __blk_release_queue").

I think the second commit reference is wrong. Did you perhaps want to
refer to commit 7b36a7189fc3 ("block: don't call ioc_exit_icq() with the
queue lock held for blk-mq")? That is the commit that removed the
locking from blk_release_queue() and that makes it safe to revert commit
dc9edc44de6c.

Thanks,

Bart.
