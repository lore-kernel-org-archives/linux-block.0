Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC97C433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 00:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C0561BC1
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 00:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhKQASr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 19:18:47 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:34562 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhKQASp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 19:18:45 -0500
Received: by mail-pl1-f182.google.com with SMTP id y8so629491plg.1
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 16:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=npyi+6nGLRmxI3mB1fiadOWEcfNUC+bzni67C5v33Nw=;
        b=64yZGxntzkZ3bb6ApOzxRzYwhtohc5AAm6CtGNkgtcH0K1hgvRMmch7AvSGomT5I4y
         Q0TgWjhKL6Rl58xNe19JbxXJZDYL65KshJfGl7bf3T69akX3GMLNlaoYFF/hD2tvCzuX
         yWaaNOaS0mSkwbJcX9s/CNE6rA/85HV7nbA9IZag7b/TQvU80tzvrVWH8o7IS5GrQL5j
         G6RN5vRfUxBiXT5a0wS8S5URvMywSUNHNqivpTx9/qkczkUntTqlyX4m+/6LayAh9lzl
         l7BU1VA1++3Wdzxr27HWCcE7jdPB0uCeKjU7CanWwSNlh37zZ2+gXrHQ5OY1XZZeLhER
         s2ZQ==
X-Gm-Message-State: AOAM530UyTZOVmJDuBg3FHPIORLhNiVHyqpSc88pIUKQvqW2DDeC13GC
        qd9o4FRHS+Rs3uR2D2noq9UaVIy5VxQ=
X-Google-Smtp-Source: ABdhPJy9wN3QbeK1BvX6m+eiabE5r+SjTudkInja36ZmHZHqtNKHNme6yVAppNLdHHUe8e3TD9EhIA==
X-Received: by 2002:a17:90b:3ec6:: with SMTP id rm6mr3967031pjb.41.1637108148039;
        Tue, 16 Nov 2021 16:15:48 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id na13sm3695075pjb.11.2021.11.16.16.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 16:15:46 -0800 (PST)
Message-ID: <2f79a604-592e-a4b9-48df-020a5923311f@acm.org>
Date:   Tue, 16 Nov 2021 16:15:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Hang in blk_mq_freeze_queue_wait()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

If I run test srp/002 against v5.16-rc1 then dmsetup hangs as follows at 
the end of the test:

sysrq: Show Blocked State
task:dmsetup         state:D stack:28136 pid: 3088 ppid:  3087 
flags:0x00004000
Call Trace:
  <TASK>
  __schedule+0x4bd/0xc20
  schedule+0x84/0x140
  blk_mq_freeze_queue_wait+0xf7/0x130
  del_gendisk+0x342/0x410
  cleanup_mapped_device+0x165/0x170 [dm_mod]
  __dm_destroy+0x280/0x450 [dm_mod]
  dm_destroy+0x13/0x20 [dm_mod]
  dev_remove+0x156/0x1d0 [dm_mod]
  ctl_ioctl+0x2bb/0x4d0 [dm_mod]
  dm_ctl_ioctl+0xe/0x20 [dm_mod]
  __x64_sys_ioctl+0xc2/0xe0
  do_syscall_64+0x35/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

I haven't seen this hang with any previous kernel version. Could this be 
a block layer issue?

v5.16-rc1 includes Ming's commit 10f7335e3627 ("blk-mq: don't grab 
->q_usage_counter in blk_mq_sched_bio_merge").

Thanks,

Bart.
