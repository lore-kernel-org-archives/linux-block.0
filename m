Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C4BC43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74F32075C
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 14:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bmAGvsiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfCLOOZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:14:25 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39396 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfCLOOY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Mar 2019 10:14:24 -0400
Received: by mail-it1-f193.google.com with SMTP id l15so4681502iti.4
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2019 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WPEzUqrUlXj3yDrdg0MOJMX4r/4tJ7hapj8BQdP1FLk=;
        b=bmAGvsiKMWyvolxzZd9mXudTcd9veR7EssmZDF5+qpugTz5oKCJyteH9feH/OjVNNN
         WAVSeWM0Z5dyP6dQO/UWHN/X6pv9l4TkWuvRTLgxb4dRuKuE5vtDygtEX0JVzDGpMf9v
         KmPxCsbys62ddHyhIH+CMv5f0xp0W5N5QOoPA3wjuwmC+A6tenK9lDx17JbzEzJ1p33r
         wBvDTTCziOC0qGCyoQQ08h9+QZHFnEaCp1qPWbYzWRKkyqKYkdKG5zfpmh161kxCEtCp
         cDG1IkHAcFNI1PDVzSEx8Sc1H8cxbLBGK/w4Usu54711RH+gNehAsV/8B2RSghPz5PRq
         31xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WPEzUqrUlXj3yDrdg0MOJMX4r/4tJ7hapj8BQdP1FLk=;
        b=dk835J7mxlEl+bsNCCWoeORAoKEOc4NZmMs8wr253Rh8qSqrUE/m0QCoSBEjnAW2di
         NZfrO8WxHP5zRiQ/n8G7iAQ7aMGt1xGh6x6cNBkjlaZ56cUS4lRGoOXDws1iYooLnO8i
         w9cGw2Ae9HPiWpl0tP98M2wBAElnuzwI7zK/luED1IDmPbXj/yhXY5rCVzjgr9FLZpTS
         wKw7IUk2CgimXJXTx35KbUKz9dbkRvqur92ONZq7J6bwLGmISZu1qqHfg9Yx7/hNaL8R
         l92ls3nuyht0QSY0z1wOPFzLSQzkL46Z8MiqU2vfW/+M4y6L6i9jHPyi8c1mSAdvbaJZ
         FDeg==
X-Gm-Message-State: APjAAAWRSIazpOTdCa98baNQeV6+r1ht4kc+ewAgeUPknkvybGtcHJX0
        BT9SyXXsVkqJyEfpNJdMT+w1L6DSjm6+lw==
X-Google-Smtp-Source: APXvYqwE18XcST9CsE9SBfOPHJLjRMtSkXsQB+fbh+WiS3IOOzXLCGgm8k8zDg4wiX0QVGajKbSGKA==
X-Received: by 2002:a24:5382:: with SMTP id n124mr2073604itb.4.1552400063617;
        Tue, 12 Mar 2019 07:14:23 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y18sm3652936ioa.56.2019.03.12.07.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 07:14:22 -0700 (PDT)
Subject: Re: kernel 5.0 blk_clear_pm_only triggers a warning during resume
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190312132826.12c5f166@xhacker.debian>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3c17c64e-20ca-3aac-0918-0a45095b38e8@kernel.dk>
Date:   Tue, 12 Mar 2019 08:14:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312132826.12c5f166@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/11/19 11:35 PM, Jisheng Zhang wrote:
> Hi,
> 
> kernel version: 5.0
> 
> I got below warning during resume:
> 
> [  673.658888] sd 0:0:0:0: [sda] Starting disk
> [  673.658899] WARNING: CPU: 3 PID: 1039 at blk_clear_pm_only+0x2a/0x30
> [  673.658902] CPU: 3 PID: 1039 Comm: kworker/u8:49 Not tainted 5.0.0+ #1
> [  673.658902] sd 2:0:0:0: [sdb] Starting disk
> [  673.658903] Hardware name: LENOVO 4180F42/4180F42, BIOS 83ET75WW (1.45 ) 05/10/2013
> [  673.658906] Workqueue: events_unbound async_run_entry_fn
> [  673.658909] RIP: 0010:blk_clear_pm_only+0x2a/0x30
> [  673.658911] Code: b8 ff ff ff ff f0 0f c1 87 80 00 00 00 83 e8 01 78 18 74 01 c3 48 81 c7 58 05 00 00 31 c9 31 d2 be 03 00 00 00 e9 36 97 e2 ff <0f> 0b c3 0f 1f 00 48 81 c7 90 00 00 00 e9 04 01 3a 00 0f 1f 40 00
> [  673.658911] RSP: 0000:ffff8881115a7e48 EFLAGS: 00010297
> [  673.658913] RAX: 00000000ffffffff RBX: ffff888118d42800 RCX: ffff8881194c9a00
> [  673.658914] RDX: ffff888118ab1a00 RSI: 0000000000000000 RDI: ffff888117e70000
> [  673.658915] RBP: ffff888118d42f90 R08: 0000000000000004 R09: 000000000001f900
> [  673.658915] R10: 0000000045698a8e R11: 0000000000000010 R12: ffff888119421000
> [  673.658916] R13: 0000000000000000 R14: ffff88800030ea80 R15: 0ffff88811942100
> [  673.658918] FS:  0000000000000000(0000) GS:ffff88811a180000(0000) knlGS:0000000000000000
> [  673.658918] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  673.658919] CR2: 0000000000000000 CR3: 000000000200c001 CR4: 00000000000606e0
> [  673.658920] Call Trace:
> [  673.658924]  ? scsi_device_resume+0x28/0x50
> [  673.658926]  ? scsi_dev_type_resume+0x2b/0x80
> [  673.658927]  ? async_run_entry_fn+0x2c/0xd0
> [  673.658930]  ? process_one_work+0x1f0/0x3f0
> [  673.658932]  ? worker_thread+0x28/0x3c0
> [  673.658933]  ? process_one_work+0x3f0/0x3f0
> [  673.658935]  ? kthread+0x10c/0x130
> [  673.658936]  ? __kthread_create_on_node+0x150/0x150
> [  673.658938]  ? ret_from_fork+0x1f/0x30
> [  673.658940] ---[ end trace ce18772de33e283e ]---
> 
> 
> I notice that commit 388b4e6a00bb3 ("scsi: core: Avoid that system resume
> triggers a kernel warning") tried to fix the warning in the same code path
> perhaps, it isn't enough.

Adding Bart, the author of the patch you are referring to.

-- 
Jens Axboe

