Return-Path: <SRS0=SfBO=36=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4367CC2BA83
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 01:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16759208C4
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 01:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJBAl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Feb 2020 20:00:41 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40577 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgBJBAl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Feb 2020 20:00:41 -0500
Received: by mail-pj1-f66.google.com with SMTP id 12so3460649pjb.5;
        Sun, 09 Feb 2020 17:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=n//Hlo7EBpBUMWPPN6ZGiJzHWqTb0UUf5/sr19Bi1Mg=;
        b=ssDItFY0RJyhvgBgoYbLmC7KYRTvlEX2+EpcQgDQu0o1MZPqFqCZGPa+TBK8oV1A2s
         wDBF1ytYphVdt95g09ZrgqA1kIb64SmNrfa50aEq5+X/tAwJ2LITZxOqYA2JNSmYyPg5
         RWO8fXqE9kjP84QOUQEsSL9lP8yz/KeMHCmtZ9zzRNw7f8tAZeMiEERJhxK7MoIzqVuC
         kh5oJS4JGntN/1mV1qs7/xJi2fmM/J/j27iyrbPLSLcBXr1dwETUr10YgGY80bjsQscE
         8md0+8DYsKvRyvEE13rplkDHrLj1XVgdgwgqoBB8kNTcHiNzc9CzRTC1EgObh1hnvn2E
         LYlw==
X-Gm-Message-State: APjAAAWP8FvSwQLWL/7DQk254QhSa6dhD4BIiQI4yOJux7040aahFtm2
        SLJzwZT9mQLoI40YJ47qLqs=
X-Google-Smtp-Source: APXvYqzSDrKoEBbSJgTbAgeXUftY1dA1qkN/J9VXkrqbgcxUzZ10PAeq8OpMN5FcYR4LZF6lqXgPAg==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr10515364pll.307.1581296440793;
        Sun, 09 Feb 2020 17:00:40 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:b43a:c72e:d61c:15d6? ([2601:647:4000:d7:b43a:c72e:d61c:15d6])
        by smtp.gmail.com with ESMTPSA id f18sm10175072pgn.2.2020.02.09.17.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 17:00:39 -0800 (PST)
Subject: Re: [PATCH] block: revert pushing the final release of request_queue
 to a workqueue.
To:     yu kuai <yukuai3@huawei.com>, axboe@kernel.dk, ming.lei@redhat.com,
        chaitanya.kulkarni@wdc.com, damien.lemoal@wdc.com,
        dhowells@redhat.com, asml.silence@gmail.com, ajay.joshi@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, zhangxiaoxu5@huawei.com,
        luoshijie1@huawei.com, jan kara <jack@suse.cz>
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
Message-ID: <70ce8830-2594-2b7b-9ca9-5fb7edd374d7@acm.org>
Date:   Sun, 9 Feb 2020 17:00:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
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
> syzbot is reporting use after free bug in debugfs_remove[1].
> 
> This is because in request_queue, 'q->debugfs_dir' and
> 'q->blk_trace->dir' could be the same dir. And in __blk_release_queue(),
> blk_mq_debugfs_unregister() will remove everything inside the dir.

Hi Yu,

Have you already noticed patch "[PATCH] blktrace: Protect q->blk_trace
with RCU"? If not, have you already tried to verify whether that patch
fixes the use-after-free detected by syzbot? See also
https://lore.kernel.org/linux-block/BYAPR04MB57492F689BA17786A24F08EE86190@BYAPR04MB5749.namprd04.prod.outlook.com/T/#mce8ffe534d93716f678d52178b4e34d4d1c3c597

Thanks,

Bart.
