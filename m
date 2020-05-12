Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C882C47255
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 01:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27043206F5
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 01:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgELBbA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 21:31:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40131 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgELBbA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 21:31:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so4676679plo.7
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 18:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gxGZ54dqKo+7eGWdU1HQqFEsMIi0z1fHQV46J1TpI8Y=;
        b=TwkJPWKMHFnDZGeZIKgdlhVcs00Bn/9Hw51WzPjPoMzcu03oIgXvKGLZ8LfzQ4oQTv
         wbniu/LOkgt4tjHDxGBwXV6fV4q5HrTpTop3oSG6FMQZ/naxi56i6p4ARpH1hvhvtqZf
         nQoI8l5hg7d9rz68YT3nc9K4AOFhZ9wnIpInPMKYrsIQ5nx8dDVuYAxG8eB5kUTEbiSu
         fOw0ohs3rrQBvYh/jZG5cKAqeENvoJRaOjtTkQ2EqhrF6oDabdLhmHnO9BY/oiol3cAm
         dKH9J+cAIUZg5uppj8ObqQDQR7wFfClL083qQ8WSCtADeHhg5SpjvduhabodcrZZmOga
         CBuQ==
X-Gm-Message-State: AGi0PuYCCErYOKqM81pLs6gATBSq46LwDQx24hVi5TJLOPUIpaGpdxZB
        6bGVWEZVjBmOA+nyneHdykM=
X-Google-Smtp-Source: APiQypJyEw2lP7Q0MtcwHpE/Nvy7CvckavcySGPFXx6hSlGWT3+g9ygYbOLbGliivUCyh4Lsn085LA==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr17435039plp.286.1589247059249;
        Mon, 11 May 2020 18:30:59 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c4e5:b27b:830d:5d6e? ([2601:647:4000:d7:c4e5:b27b:830d:5d6e])
        by smtp.gmail.com with ESMTPSA id n30sm10430806pfq.88.2020.05.11.18.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 18:30:58 -0700 (PDT)
Subject: Re: [PATCH v6 0/5] Fix potential kernel panic when increase hardware
 queue
To:     axboe@kernel.dk, tom.leiming@gmail.com, hch@infradead.org,
        linux-block@vger.kernel.org,
        Weiping Zhang <zhangweiping@didiglobal.com>
References: <cover.1588856361.git.zhangweiping@didiglobal.com>
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
Message-ID: <5211ebcc-a123-47be-1a59-b2d767bab519@acm.org>
Date:   Mon, 11 May 2020 18:30:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1588856361.git.zhangweiping@didiglobal.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-07 06:03, Weiping Zhang wrote:
> This series mainly fix the kernel panic when increase hardware queue,
> and also fix some other misc issue.

Does this patch series survive blktests? I'm asking this because
blktests triggers the crash shown below for Jens' block-for-next branch.
I think this report is the result of a recent change.

run blktests block/030

null_blk: module loaded
Increasing nr_hw_queues to 8 fails, fallback to 1
==================================================================
BUG: KASAN: null-ptr-deref in blk_mq_map_swqueue+0x2f2/0x830
Read of size 8 at addr 0000000000000128 by task nproc/8541

CPU: 5 PID: 8541 Comm: nproc Not tainted 5.7.0-rc4-dbg+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
Call Trace:
 dump_stack+0xa5/0xe6
 __kasan_report.cold+0x65/0xbb
 kasan_report+0x45/0x60
 check_memory_region+0x15e/0x1c0
 __kasan_check_read+0x15/0x20
 blk_mq_map_swqueue+0x2f2/0x830
 __blk_mq_update_nr_hw_queues+0x3df/0x690
 blk_mq_update_nr_hw_queues+0x32/0x50
 nullb_device_submit_queues_store+0xde/0x160 [null_blk]
 configfs_write_file+0x1c4/0x250 [configfs]
 __vfs_write+0x4c/0x90
 vfs_write+0x14b/0x2d0
 ksys_write+0xdd/0x180
 __x64_sys_write+0x47/0x50
 do_syscall_64+0x6f/0x310
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Thanks,

Bart.
