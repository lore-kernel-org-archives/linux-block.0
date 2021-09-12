Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB06C433F5
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 21:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A5E60200
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 21:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbhILV0k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Sep 2021 17:26:40 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:47077 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhILV0f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Sep 2021 17:26:35 -0400
Received: by mail-pj1-f54.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so4255978pjb.5
        for <linux-block@vger.kernel.org>; Sun, 12 Sep 2021 14:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hn8E5DlsWCdMP7VllBYefolXN9+ieYlK5YMuU3iqoh0=;
        b=qeIPny0TkX5z6xt/oh7Iy3WaXmeouBkxEJLvDe9Gx1LfRCTpkVB95KhIKGBSBuwOBT
         4kxDvkKj0M6vIrkf6B3Ar71xlaDyEgBt91gC2k12uMWLoq29h/1cKRBHbI/2Yub71oNt
         bqYXWvtFEc7U+a1MiBWm6smgnwEL4XBvrDzhdDK5wS2Q2WBs2ysFFiS6eppNwKzlFvrX
         I99pEnzJJFsmfAjaQx1PgsqIYNBh+s/YHKcGi0vRJVjBXVqfyzSiAUsldUW+IjiNK3ZU
         X4x3hQu6yD1rdysRIlMRr8Dv7k3Gk5KZwYo2bfGW8PJo5t1Cf50NBxZ/rDntl6gFfGYc
         WxRA==
X-Gm-Message-State: AOAM533ZYeGwRmJ/JvkfpC2Di1Ham6I8UlLfKduA0V07AbUhmTyjjl8u
        F0dFUtLYX9tomx5jEJyk0c1Xfj/N6pk=
X-Google-Smtp-Source: ABdhPJy2YlYufxlnXDvP7jFWoIuDlKcKKDe9WwD4x1LEYj1E3JJbMRUo1m6YZjCWfRtpah74umvd9A==
X-Received: by 2002:a17:90a:cc02:: with SMTP id b2mr9321335pju.160.1631481920717;
        Sun, 12 Sep 2021 14:25:20 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:559e:5ce1:19a:4ed6? ([2601:647:4000:d7:559e:5ce1:19a:4ed6])
        by smtp.gmail.com with UTF8SMTPSA id l23sm4463146pji.45.2021.09.12.14.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 14:25:19 -0700 (PDT)
Message-ID: <059007be-03fa-5948-d86d-d1750587e894@acm.org>
Date:   Sun, 12 Sep 2021 14:25:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [bug report] blktests srp/013 lead kernel panic with latest
 block/for-next and 5.13.15
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     CKI Project <cki-project@redhat.com>
References: <CAHj4cs8XNtkzbbiLnFmVu82wYeQpLkVp6_wCtrnbhODay+OP9w@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHj4cs8XNtkzbbiLnFmVu82wYeQpLkVp6_wCtrnbhODay+OP9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/12/21 09:26, Yi Zhang wrote:
> [  130.851918] Failing address: 000003ff80815000 TEID: 000003ff80815803
> [  130.852068] CPU: 1 PID: 950 Comm: multipathd Not tainted 5.14.0 #1
> [  130.852071] Hardware name: IBM 8561 LT1 400 (KVM/Linux)
> [  130.852073] Krnl PSW : 0704e00180000000 000000002e37e7cc
> (scsi_mq_exit_request+0x2c/0x58)
> [  130.852113] Call Trace:
> [  130.852115]  [<000000002e37e7cc>] scsi_mq_exit_request+0x2c/0x58
> [  130.852120]  [<000000002e1c2608>] blk_mq_free_rqs+0x80/0x218
> [  130.852125]  [<000000002e1c2f0a>] blk_mq_free_tag_set+0x5a/0x128
> [  130.852128]  [<000000002e3774d0>] scsi_host_dev_release+0xb0/0x118
> [  130.852130]  [<000000002e33fe10>] device_release+0x48/0xb0
> [  130.852136]  [<000000002e28bf12>] kobject_put+0xca/0x1f0
> [  130.852140]  [<000000002e33fe10>] device_release+0x48/0xb0
> [  130.852142]  [<000000002e28bf12>] kobject_put+0xca/0x1f0
> [  130.852145]  [<000000002dc1324a>] execute_in_process_context+0x4a/0xf0
> [  130.852149]  [<000000002e33fe10>] device_release+0x48/0xb0
> [  130.852151]  [<000000002e28bf12>] kobject_put+0xca/0x1f0
> [  130.852153]  [<000000002e38e49e>] sd_release+0x6e/0xf8
> [  130.852158]  [<000000002e1a86d0>] blkdev_put+0xe0/0x278
> [  130.852162]  [<000000002e1a9946>] blkdev_close+0x3e/0x50
> [  130.852164]  [<000000002de94728>] __fput+0xa0/0x280
> [  130.852168]  [<000000002dc19190>] task_work_run+0x88/0xd0
> [  130.852170]  [<000000002dc89b9e>] exit_to_user_mode_loop+0x1ce/0x1d8
> [  130.852175]  [<000000002dc89c22>] exit_to_user_mode_prepare+0x7a/0x80
> [  130.852178]  [<000000002e6e70be>] __do_syscall+0x106/0x1e8
> [  130.852181]  [<000000002e6f5518>] system_call+0x78/0xa0

I haven't seen this yet. Is this crash reproducible? If so, please
bisect this crash.

Thanks,

Bart.
