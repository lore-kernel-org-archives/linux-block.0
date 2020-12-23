Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8412DC433DB
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 15:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E4722202
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 15:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgLWPsL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Dec 2020 10:48:11 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:44631 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbgLWPsK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Dec 2020 10:48:10 -0500
Received: by mail-pg1-f177.google.com with SMTP id p18so10796546pgm.11;
        Wed, 23 Dec 2020 07:47:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RZunFE8+rvr+mZUHOuv0pW6RAXodWmXjOHxU/DZJ3U0=;
        b=LOj2KzECJPBhrQleYwFypovPnsoi0WzMwb2RIVqIA47gmakev6yrQqm9ntXTu8Eug0
         XMl/0+xnOpoMpq+BbGMAP3kFVSQOxIwP9D9ucqVqZWZWevHphzCEV8ooiREO5RaExxjw
         vKwXgtsjORHW5aGGCiVYx05Xy4QbhYblDmSvlndMoFbtUr/P67LGgxpagICTus+klJQq
         A+r4idJgtEmZF96OrRjhmAH/sJazbvjQTyxIk4mF5qCjmkPaLisjoBW4+GWnCwYrovzX
         qAXM6E9DVfdZkBQOU5CNikYeOKhXIRleivas1cSFxxl5Vxan1/xZEZi0INHgSKZKQUzK
         z0sw==
X-Gm-Message-State: AOAM533UQ9QFM3aoqtqVF1Cf08JM1li8ZNWhvhWGkNa1Ie18tNckEO5D
        voSNLu1MIN8xDviP+vL5tUTw1JqUtnI=
X-Google-Smtp-Source: ABdhPJx5uLmwBFB+TCV+z18xDJVgnT343zEUxyOTfcwzewpc8zjbMsFdO7EMgJzjdZqvn1TpGE+f4Q==
X-Received: by 2002:aa7:9a07:0:b029:1a6:5f93:a19f with SMTP id w7-20020aa79a070000b02901a65f93a19fmr3280155pfj.21.1608738449461;
        Wed, 23 Dec 2020 07:47:29 -0800 (PST)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id h1sm9137036pgj.59.2020.12.23.07.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 07:47:28 -0800 (PST)
Subject: Re: [RFC PATCH v2 2/2] blk-mq: Lockout tagset iter when freeing rqs
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, hare@suse.de, kashyap.desai@broadcom.com,
        linuxarm@huawei.com
References: <1608203273-170555-1-git-send-email-john.garry@huawei.com>
 <1608203273-170555-3-git-send-email-john.garry@huawei.com>
 <df44b73d-6c42-87ee-3c25-b95a44712e05@acm.org>
 <4d2004bb-4444-7a63-7c72-1759e3037cfd@huawei.com>
 <31de2806-bbc1-dcc3-b9eb-ce9257420432@acm.org>
 <b2edab2b-8af7-816d-9da2-4720d19b96f8@huawei.com>
 <e97a0603-f9e3-1b00-4a09-c569d4f73d7b@acm.org>
 <f98fd31e-89d4-523f-df70-4bd5f39ccbd5@huawei.com>
 <33e41110-b3b2-ac16-f131-de1679ce8238@acm.org>
 <7bdd562d-b258-43a2-0de0-966091086cff@huawei.com>
 <e56e8831-4a74-8411-6c04-3a65aff855f4@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0ab85ab8-c5c7-01aa-6b39-da731b3db829@acm.org>
Date:   Wed, 23 Dec 2020 07:47:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <e56e8831-4a74-8411-6c04-3a65aff855f4@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/23/20 3:40 AM, John Garry wrote:
> Sorry, I got the 2x iter functions mixed up.
> 
> So if we use mutex to solve blk_mq_queue_tag_busy_iter() problem, then we
> still have this issue in blk_mq_tagset_busy_iter() which I report previously
> [0]:
> 
> [  319.771745] BUG: KASAN: use-after-free in bt_tags_iter+0xe0/0x128
> [  319.777832] Read of size 4 at addr ffff0010b6bd27cc by task more/1866
> [  319.784262]
> [  319.785753] CPU: 61 PID: 1866 Comm: more Tainted: G        W
> 5.10.0-rc4-18118-gaa7b9c30d8ff #1070
> [  319.795312] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon
> D05 IT21 Nemo 2.0 RC0 04/18/2018
> [  319.804437] Call trace:
> [  319.806892]  dump_backtrace+0x0/0x2d0
> [  319.810552]  show_stack+0x18/0x68
> [  319.813865]  dump_stack+0x100/0x16c
> [  319.817348]  print_address_description.constprop.12+0x6c/0x4e8
> [  319.823176]  kasan_report+0x130/0x200
> [  319.826831]  __asan_load4+0x9c/0xd8
> [  319.830315]  bt_tags_iter+0xe0/0x128
> [  319.833884]  __blk_mq_all_tag_iter+0x320/0x3a8
> [  319.838320]  blk_mq_tagset_busy_iter+0x8c/0xd8
> [  319.842760]  scsi_host_busy+0x88/0xb8
> [  319.846418]  show_host_busy+0x1c/0x48
> [  319.850079]  dev_attr_show+0x44/0x90
> [  319.853655]  sysfs_kf_seq_show+0x128/0x1c8
> [  319.857744]  kernfs_seq_show+0xa0/0xb8
> [  319.861489]  seq_read_iter+0x1ec/0x6a0
> [  319.865230]  seq_read+0x1d0/0x250
> [  319.868539]  kernfs_fop_read+0x70/0x330
> [  319.872369]  vfs_read+0xe4/0x250
> [  319.875590]  ksys_read+0xc8/0x178
> [  319.878898]  __arm64_sys_read+0x44/0x58
> [  319.882730]  el0_svc_common.constprop.2+0xc4/0x1e8
> [  319.887515]  do_el0_svc+0x90/0xa0
> [  319.890824]  el0_sync_handler+0x128/0x178
> [  319.894825]  el0_sync+0x158/0x180
> [  319.898131]
> [  319.899614] The buggy address belongs to the page:
> [  319.904403] page:000000004e9e6864 refcount:0 mapcount:0
> mapping:0000000000000000 index:0x0 pfn:0x10b6bd2
> [  319.913876] flags: 0xbfffc0000000000()
> [  319.917626] raw: 0bfffc0000000000 0000000000000000 fffffe0000000000
> 0000000000000000
> [  319.925363] raw: 0000000000000000 0000000000000000 00000000ffffffff
> 0000000000000000
> [  319.933096] page dumped because: kasan: bad access detected
> [  319.938658]
> [  319.940141] Memory state around the buggy address:
> [  319.944925]  ffff0010b6bd2680: ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff
> [  319.952139]  ffff0010b6bd2700: ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff
> [  319.959354] >ffff0010b6bd2780: ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff
> [  319.966566] ^
> [  319.972131]  ffff0010b6bd2800: ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff
> [  319.979344]  ffff0010b6bd2880: ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff
> [  319.986557]
> ==================================================================
> [  319.993770] Disabling lock debugging due to kernel taint
> 
> So to trigger this, I start fio on a disk, and then have one script
> which constantly enables and disables an IO scheduler for that disk, and
> another script which constantly reads /sys/class/scsi_host/host0/host_busy .
> 
> And in this problem, the driver tag we iterate may point to a stale IO sched
> request.

Hi John,

I propose to change the order in which blk_mq_sched_free_requests(q) and
blk_mq_debugfs_unregister(q) are called. Today blk_mq_sched_free_requests(q)
is called by blk_cleanup_queue() before blk_put_queue() is called.
blk_put_queue() calls blk_release_queue() if the last reference is dropped.
blk_release_queue() calls blk_mq_debugfs_unregister(). I prefer removing the
debugfs attributes earlier over modifying the tag iteration functions
because I think removing the debugfs attributes earlier is less risky.
Although this will make it harder to debug lockups that happen while
removing a request queue, kernel developers who are analyzing such an issue
can undo this change in their development kernel tree.

Thanks,

Bart.
