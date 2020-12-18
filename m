Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F7EC3526B
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 22:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D472823B88
	for <linux-block@archiver.kernel.org>; Fri, 18 Dec 2020 22:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgLRWo0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Dec 2020 17:44:26 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:44458 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgLRWo0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Dec 2020 17:44:26 -0500
Received: by mail-pf1-f181.google.com with SMTP id f9so2378281pfc.11;
        Fri, 18 Dec 2020 14:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mjYQFKlw1OKFIFpIBjFxMCpNInHN23kLECgiubg/j/A=;
        b=nScerJXXgkvUrud5S4ihLMjBuryxQg5ejRFdI6q4BYjoMYh6PgkGOYbXmSkR7hGig9
         Iqj9vw6C1MqoXQ5XY8IVHzsaLsMx/SETHoqa6D6h5/VjVuFHKLIrIsJsXamGNGYhTtTP
         1I8TVqBdg8QDJFFgj2kgOPUs30XYsekks9IjLM5FsFiSwfNjWuGj9OXYn5dxPFCyyc6b
         w67dByQPv9oMMm7ev2ZniRS8IAJisKEIIIAM7r/2LHd/hWcGNzA+bpD3F3+EJdlDLlPT
         WI51vewmrefUUgfKzmikNsSmODt8iX07TmK3UcIrXmoKqAl10fgoZH2NaHL408sjfnOJ
         CJ3g==
X-Gm-Message-State: AOAM533/4hieRKRQB7GTABasgHpzEqo6hG38+ZXxzEaJkTP1FpNjAAXa
        UaYNO2GDFT8R9ghYnxmp7Lw=
X-Google-Smtp-Source: ABdhPJxVVa1Gkt4uJ4IWKRzN8WDqjTd0sTVRJLUcGBAJZl61mODqhcKpqSAVrSXM86h2JbfnmnVboA==
X-Received: by 2002:a63:ea4b:: with SMTP id l11mr5986767pgk.61.1608331425060;
        Fri, 18 Dec 2020 14:43:45 -0800 (PST)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id u3sm9974174pjf.52.2020.12.18.14.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 14:43:43 -0800 (PST)
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, hare@suse.de, ppvk@codeaurora.org,
        kashyap.desai@broadcom.com, linuxarm@huawei.com
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
 <1608203273-170555-3-git-send-email-john.garry@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <df44b73d-6c42-87ee-3c25-b95a44712e05@acm.org>
Date:   Fri, 18 Dec 2020 14:43:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1608203273-170555-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/20 3:07 AM, John Garry wrote:
> References to old IO sched requests are currently cleared from the
> tagset when freeing those requests; switching elevator or changing
> request queue depth is such a scenario in which this occurs.
> 
> However, this does not stop the potentially racy behaviour of freeing
> and clearing a request reference between a tagset iterator getting a
> reference to a request and actually dereferencing that request.
> 
> Such a use-after-free can be triggered, as follows:
> 
> ==================================================================
> BUG: KASAN: use-after-free in bt_iter+0xa0/0x120
> Read of size 8 at addr ffff00108d589300 by task fio/3052
> 
> CPU: 32 PID: 3052 Comm: fio Tainted: GW
> 5.10.0-rc4-64839-g2dcf1ee5054f #693
> Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon
> D05 IT21 Nemo 2.0 RC0 04/18/2018
> Call trace:
> dump_backtrace+0x0/0x2d0
> show_stack+0x18/0x68
> dump_stack+0x100/0x16c
> print_address_description.constprop.12+0x6c/0x4e8
> kasan_report+0x130/0x200
> __asan_load8+0x9c/0xd8
> bt_iter+0xa0/0x120
> blk_mq_queue_tag_busy_iter+0x2d8/0x540
> blk_mq_in_flight+0x80/0xb8
> part_stat_show+0xd8/0x238
> dev_attr_show+0x44/0x90
> sysfs_kf_seq_show+0x128/0x1c8
> kernfs_seq_show+0xa0/0xb8
> seq_read_iter+0x1ec/0x6a0
> seq_read+0x1d0/0x250
> kernfs_fop_read+0x70/0x330
> vfs_read+0xe4/0x250
> ksys_read+0xc8/0x178
> __arm64_sys_read+0x44/0x58
> el0_svc_common.constprop.2+0xc4/0x1e8
> do_el0_svc+0x90/0xa0
> el0_sync_handler+0x128/0x178
> el0_sync+0x158/0x180
> 
> This is found experimentally by running fio on 2x SCSI disks - 1x disk
> holds the root partition. Userspace is constantly triggering the tagset
> iter from reading the root (gen)disk partition info. And so if the IO
> sched is constantly changed on the other disk, eventually the UAF occurs,
> as described above.

Hi John,

Something is not clear to me. The above call stack includes
blk_mq_queue_tag_busy_iter(). That function starts with
percpu_ref_tryget(&q->q_usage_counter) and ends with calling
percpu_ref_put(&q->q_usage_counter). So it will only iterate over a tag set
if q->q_usage_counter is live. However, both blk_mq_update_nr_requests()
and elevator_switch() start with freezing the request queue.
blk_mq_freeze_queue() starts with killing q->q_usage_counter and waits
until that counter has dropped to zero. In other words,
blk_mq_queue_tag_busy_iter() should not iterate over a tag set while a tag
set is being freed or reallocated. Does this mean that we do not yet have
a full explanation about why the above call stack can be triggered?

Thanks,

Bart.


