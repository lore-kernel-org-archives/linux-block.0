Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250A9C43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 02:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0140F2074D
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 02:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgC0CwK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:52:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46220 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgC0CwK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 22:52:10 -0400
Received: by mail-pl1-f194.google.com with SMTP id s23so2905530plq.13;
        Thu, 26 Mar 2020 19:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o/x+mawiAvGAzXR6KVukxERD/FlFfrvg3WXOiyWEPps=;
        b=SVUH3fje9XgH8zo99lBj38qgCDWKkqdkblr13dD7/YduwMaiLjUfsGYc+NW536+zW0
         0cBMOIj4HddQoAGUFEytg6f3/F8p/O5JQ1G4I+Bn2WAhn+NZzRaCQeOYQTtFhjzlECGb
         8ZZJE8oSxfG5zZO7ekZmSNQIJaQfVWBoUtyF98EnsBn3nspVLKP6uD6E1pwMxd5TxbLJ
         1FOYifjlCQBzUfwGS72eXFqLwp2q0EXbEckzHUn9IFFY5ZkFaoeLb0N1jRLEM6Z+WlNj
         auhOSPwvoseSHMN4Xkqd4cGaUv6RbLmXxDo8/RJZ/OCeX3Uh1MtlYstx4R/ViVU/+LYY
         HPlw==
X-Gm-Message-State: ANhLgQ0XZHd6GTMOIPEjQJZfydixWZg2XvM/DHhspe5fmyN/aaWGcGB2
        BmA8ifVRFCyN3YYU66kowrE=
X-Google-Smtp-Source: ADFU+vvY9d6FD9lutlmPr8wGpYNcXAXgpzUlPywZ8hK6JdGSAwBhtj7WcaYjdzjgsE+pbDMrIU5xyA==
X-Received: by 2002:a17:902:8d94:: with SMTP id v20mr11584657plo.259.1585277528656;
        Thu, 26 Mar 2020 19:52:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:f4c2:6961:f3fb:2dca? ([2601:647:4000:d7:f4c2:6961:f3fb:2dca])
        by smtp.gmail.com with ESMTPSA id q91sm2626217pjb.11.2020.03.26.19.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 19:52:07 -0700 (PDT)
Subject: Re: KASAN: null-ptr-deref Write in blk_mq_map_swqueue
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        syzbot <syzbot+313d95e8a7a49263f88d@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000047770d05a1c70ecb@google.com>
 <ffabca27-309e-4a6e-eac2-d03a56a7493a@oracle.com>
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
Message-ID: <523c2b61-476e-0fb6-12d9-37038d150fb7@acm.org>
Date:   Thu, 26 Mar 2020 19:52:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ffabca27-309e-4a6e-eac2-d03a56a7493a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-03-26 17:19, Dongli Zhang wrote:
> I think the issue is because of line 2827, that is, the q->nr_hw_queues is
> updated too earlier. It is still possible the init would fail later.
> 
> 2809 static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> 2810                                                 struct request_queue *q)
> 2811 {
> 2812         int i, j, end;
> 2813         struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
> 2814
> 2815         if (q->nr_hw_queues < set->nr_hw_queues) {
> 2816                 struct blk_mq_hw_ctx **new_hctxs;
> 2817
> 2818                 new_hctxs = kcalloc_node(set->nr_hw_queues,
> 2819                                        sizeof(*new_hctxs), GFP_KERNEL,
> 2820                                        set->numa_node);
> 2821                 if (!new_hctxs)
> 2822                         return;
> 2823                 if (hctxs)
> 2824                         memcpy(new_hctxs, hctxs, q->nr_hw_queues *
> 2825                                sizeof(*hctxs));
> 2826                 q->queue_hw_ctx = new_hctxs;
> 2827                 q->nr_hw_queues = set->nr_hw_queues;
> 2828                 kfree(hctxs);
> 2829                 hctxs = new_hctxs;
> 2830         }

Which kernel tree does this syzbot report refer to? Commit
d0930bb8f46b ("blk-mq: Fix a recently introduced regression in
blk_mq_realloc_hw_ctxs()") in Jens' tree removed line 2827 shown above.

Thanks,

Bart.
