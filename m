Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA93C433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 14:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 717CC61168
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 14:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhIUOZv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 10:25:51 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:33739 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbhIUOZv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 10:25:51 -0400
Received: by mail-pj1-f41.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso2050047pjb.0
        for <linux-block@vger.kernel.org>; Tue, 21 Sep 2021 07:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hbL+R7wB2Kr/LDdCaD8Gk/FVikykLhi9/yURnP/mDhM=;
        b=haMBdxVDnWu4D12OGt1lY5naQLdZu16sRQ8VETwnCH65UG9vt3hBBs9mAUH/eVigT2
         vjNEyjfNalnGevmrmGhYPGdoqFvj4hoYI/e5/EZaU7wMcM5ZJTSniHp5XPWo7QHk2AZr
         23IW43en0UQtIB5XYM1BCldMYEF88s7KIJrzNNxs0co9ytwohAQFxjgiJ4bVop5HkPwl
         IXbgoW4B1pBpjwA9psUNu6TYi2ehE35twfx9yYODINlLpjy5jG2bfdC/lYQFQU7vkU0l
         jyD/psOAJRE6NQbQMBDUmpVwgbmSd/Yr2hwlnKDOS53jPZqcfUuWg18edaBhJE50yX7O
         jqLA==
X-Gm-Message-State: AOAM532hNqRLN7JA56BFhOBVUg5m5QwG9kfXAUfC0oM/Fc1NaeZySHso
        U71lLXlpCHCrXAL3vvpQDlk=
X-Google-Smtp-Source: ABdhPJzx1mu2Oi0IH1SMXAbRWKZAo+BpBNVKdWllThbuGZy2wGSsHRclgY3Ju/VBBgk3dZqiUh0ffA==
X-Received: by 2002:a17:902:e80e:b0:13d:bb71:b1c0 with SMTP id u14-20020a170902e80e00b0013dbb71b1c0mr5445074plg.29.1632234262798;
        Tue, 21 Sep 2021 07:24:22 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id m125sm19009419pfd.174.2021.09.21.07.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 07:24:22 -0700 (PDT)
Subject: Re: tear down file system I/O in del_gendisk
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <20210920112405.1299667-1-hch@lst.de>
 <89982489-a063-0536-2a35-7420d71fc939@acm.org> <20210921090811.GB336@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <868b6e73-0f0a-86d3-395c-dc797a71d616@acm.org>
Date:   Tue, 21 Sep 2021 07:24:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210921090811.GB336@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/21/21 2:08 AM, Christoph Hellwig wrote:
> On Mon, Sep 20, 2021 at 08:38:31PM -0700, Bart Van Assche wrote:
>> On 9/20/21 04:24, Christoph Hellwig wrote:
>>> Ming reported that for SCSI we have a lifetime problem now that
>>> the BDI moved from the request_queue to the disk as del_gendisk
>>> doesn't finish all outstanding file system I/O.  It turns out
>>> this actually is an older problem, although the case where it could
>>> be hit before was very unusual (unbinding of a SCSI upper driver
>>> while the scsi_device stays around).  This series fixes this by
>>> draining all I/O in del_gendisk.
>>
>> Several failures are reported when running blktests against Jens' for-next
>> branch if KASAN and lockdep are enabled. Is this patch series sufficient
>> to make blktests pass again?
> 
> I don't see any new failures (I have a few consistent ones due to the
> fact that blktests is completly fucked up and wants to load modules
> everywhere which doesn't exactly work with builtin drivers).  Care
> to post your issues?

This is the first complaint I run into with KASAN enabled (this failure prevents
running more tests) for Jens' for-next branch merged with Linus' master branch:

root[4270]: run blktests block/010
null_blk: module loaded
==================================================================
BUG: KASAN: null-ptr-deref in null_map_queues+0x131/0x1a0 [null_blk]
Read of size 8 at addr 0000000000000000 by task modprobe/4320

CPU: 9 PID: 4320 Comm: modprobe Tainted: G            E     5.15.0-rc2-dbg+ #2
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
  show_stack+0x52/0x58
  dump_stack_lvl+0x49/0x5e
  kasan_report.cold+0x64/0xdb
  __asan_load8+0x69/0x90
  null_map_queues+0x131/0x1a0 [null_blk]
  blk_mq_update_queue_map+0x122/0x1a0
  blk_mq_alloc_tag_set+0x1e8/0x570
  null_init_tag_set+0x197/0x220 [null_blk]
  null_init+0x1dc/0x1000 [null_blk]
  do_one_initcall+0xc7/0x440
  do_init_module+0x10a/0x3d0
  load_module+0x115c/0x1220
  __do_sys_finit_module+0x124/0x1a0
  __x64_sys_finit_module+0x42/0x50
  do_syscall_64+0x35/0xb0
  entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fa873062d6d
Code: c9 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d3 80 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007fff2aa058b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa873062d6d
RDX: 0000000000000000 RSI: 00005613ba37f750 RDI: 0000000000000003
RBP: 00005613ba37f540 R08: 0000000000000000 R09: 0000000000000050
R10: 0000000000000003 R11: 0000000000000246 R12: 00005613ba37f750
R13: 00005613ba37f7a0 R14: 00005613ba37f750 R15: 00005613ba37f460
==================================================================

This regression may have been introduced by commit 5f7acddf706c ("null_blk: poll
queue support").

Thanks,

Bart.


