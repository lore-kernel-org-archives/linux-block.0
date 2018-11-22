Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB3AC43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1552E2080F
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rnGysb3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1552E2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388768AbeKVMT4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:19:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37265 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbeKVMT4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 07:19:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so8010642plr.4
        for <linux-block@vger.kernel.org>; Wed, 21 Nov 2018 17:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r75XPNaN6HmO08bRM2h75q4zBp7VzYi4aFA10mOBzFo=;
        b=rnGysb3P/1midx3pQFwwjx/E4pzroDzfE0Fw01FdHVQgBNAX/vlsSRld/p4X87nrmC
         v5px1yD4yvf64SX9GXyG3aRTebaF1WMONQkfj+mohZIPqKGM1+JgWR9wuXdDQUZTv7D1
         IbFKaub+nDji2MAUxA9A/lJqwtGWVeIPsqv3NiSek0nbSlCpCRB0NTxY8ABxuW8CPYLu
         KZ5nANHkGgJXOG0Ubn3PMtDgm4htxBxYdTytQB9T2GDBEiAvDOfYIGQpOuKNK3oqcYq6
         e9BTRPQ/t9ECuZgkZUdMLMFfIAge1i3XAbO8CvfbBFISQ0k+Rn4a+VGJIDiZZqf696GN
         I7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r75XPNaN6HmO08bRM2h75q4zBp7VzYi4aFA10mOBzFo=;
        b=G3NCIxFB8vIBtZMqllyYXGgBU8IPYGREh4wNt21Eh2POZbKoOrqwVb/coz6Rk0+Or5
         ZgDCTqWblNTgp+rxXWt9h9QgKzRQLl7QjMN1IBOtHevEgR/TUSSWmTMhkS8spN5x3QyL
         EFj/Nso7p5s5WOP0HKdHyVR6lR2aaHht7iL9sThp7eX1IczcORreHlh7bGdbltLaMzbz
         E4/S+6K95UJQdCTH85GJ7nLnvbqZ/3KlKgS/9KUb0mLwze0hdPifsfy93BM4D72oWIut
         uhEmGvd3hQzOBHq20Lw5gsR85No1kPNoafemfnKyEXkTvi80lFIjDy5uFktXsXvyg/Pb
         UBLQ==
X-Gm-Message-State: AA+aEWY90gyMl1uK+muixnVwV/g39ZXUle+O7mXpqhTKVAcZyRWmA2NS
        6y58ZawkSQkjVv1N3JvAjZ4ZtQ==
X-Google-Smtp-Source: AFSGD/U5FPzFUeMBIjXPNKNercnCxl5tcYHv1dIm2UCRROwl36e73C4dVwlrEZ5LTTLKNodypjHHVQ==
X-Received: by 2002:a62:1d8f:: with SMTP id d137mr4514237pfd.11.1542850975225;
        Wed, 21 Nov 2018 17:42:55 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::14ef? ([2620:10d:c090:180::1:19a1])
        by smtp.gmail.com with ESMTPSA id b202sm40186796pfb.88.2018.11.21.17.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 17:42:54 -0800 (PST)
Subject: Re: [PATCH V2] SCSI: fix queue cleanup race before queue
 initialization is done
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        "jianchao . wang" <jianchao.w.wang@oracle.com>
References: <20181114082551.12141-1-ming.lei@redhat.com>
 <63c063ad-7d74-4268-bfd4-2de89908949e@kernel.dk>
 <4e24ace9-c83f-5311-5419-18f4a0fb5148@kernel.dk>
 <20181122010034.GA20814@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dc374ec8-2ea2-0792-4677-0ae81fa7826e@kernel.dk>
Date:   Wed, 21 Nov 2018 18:42:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181122010034.GA20814@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/21/18 6:00 PM, Ming Lei wrote:
> On Wed, Nov 21, 2018 at 02:47:35PM -0700, Jens Axboe wrote:
>> On 11/14/18 8:20 AM, Jens Axboe wrote:
>>> On 11/14/18 1:25 AM, Ming Lei wrote:
>>>> c2856ae2f315d ("blk-mq: quiesce queue before freeing queue") has
>>>> already fixed this race, however the implied synchronize_rcu()
>>>> in blk_mq_quiesce_queue() can slow down LUN probe a lot, so caused
>>>> performance regression.
>>>>
>>>> Then 1311326cf4755c7 ("blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()")
>>>> tried to quiesce queue for avoiding unnecessary synchronize_rcu()
>>>> only when queue initialization is done, because it is usual to see
>>>> lots of inexistent LUNs which need to be probed.
>>>>
>>>> However, turns out it isn't safe to quiesce queue only when queue
>>>> initialization is done. Because when one SCSI command is completed,
>>>> the user of sending command can be waken up immediately, then the
>>>> scsi device may be removed, meantime the run queue in scsi_end_request()
>>>> is still in-progress, so kernel panic can be caused.
>>>>
>>>> In Red Hat QE lab, there are several reports about this kind of kernel
>>>> panic triggered during kernel booting.
>>>>
>>>> This patch tries to address the issue by grabing one queue usage
>>>> counter during freeing one request and the following run queue.
>>>
>>> Thanks applied, this bug was elusive but ever present in recent
>>> testing that we did internally, it's been a huge pain in the butt.
>>> The symptoms were usually a crash in blk_mq_get_driver_tag() with
>>> hctx->tags == NULL, or a crash inside deadline request insert off
>>> requeue.
>>
>> I'm still hitting some weird crashes even with this applied, like
>> this one:
>>
>>  BUG: unable to handle kernel NULL pointer dereference at 0000000000000148      
>>  PGD 0 P4D 0.                                                                   
>>  Oops: 0000 [#1] SMP PTI                                                        
>>  CPU: 37 PID: 763 Comm: kworker/37:1H Not tainted 4.20.0-rc3-00649-ge64d9a554a91-dirty #14
>>  Hardware name: Wiwynn Leopard-Orv2/Leopard-DDR BW, BIOS LBM08   03/03/2017     
>>  Workqueue: kblockd blk_mq_run_work_fn                                          
>>  RIP: 0010:blk_mq_get_driver_tag+0x81/0x120                                     
>>  Code: 24 10 48 89 7c 24 20 74 21 83 fa ff 0f 95 c0 48 8b 4c 24 28 65 48 33 0c 25 28 00 00 00 0f 85 96 00 00 00 48 83 c4 30 5b 5d c3 <48> 8b 87 48 01 00 00 8b 40 04 39 43 20 72 37 f6 87 b0 00 00 00 02
>>  RSP: 0018:ffffc90004aabd30 EFLAGS: 00010246                                    
>>  RAX: 0000000000000003 RBX: ffff888465ea1300 RCX: ffffc90004aabde8              
>>  RDX: 00000000ffffffff RSI: ffffc90004aabde8 RDI: 0000000000000000              
>>  RBP: 0000000000000000 R08: ffff888465ea1348 R09: 0000000000000000              
>>  R10: 0000000000001000 R11: 00000000ffffffff R12: ffff888465ea1300              
>>  R13: 0000000000000000 R14: ffff888465ea1348 R15: ffff888465d10000              
>>  FS:  0000000000000000(0000) GS:ffff88846f9c0000(0000) knlGS:0000000000000000   
>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033                              
>>  CR2: 0000000000000148 CR3: 000000000220a003 CR4: 00000000003606e0              
>>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000              
>>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400              
>>  Call Trace:                                                                    
>>   blk_mq_dispatch_rq_list+0xec/0x480                                            
>>   ? elv_rb_del+0x11/0x30                                                        
>>   blk_mq_do_dispatch_sched+0x6e/0xf0                                            
>>   blk_mq_sched_dispatch_requests+0xfa/0x170                                     
>>   __blk_mq_run_hw_queue+0x5f/0xe0                                               
>>   process_one_work+0x154/0x350                                                  
>>   worker_thread+0x46/0x3c0                                                      
>>   kthread+0xf5/0x130                                                            
>>   ? process_one_work+0x350/0x350                                                
>>   ? kthread_destroy_worker+0x50/0x50                                            
>>   ret_from_fork+0x1f/0x30                                                       
>>  Modules linked in: sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm switchtec irqbypass iTCO_wdt iTCO_vendor_support efivars cdc_ether usbnet mii cdc_acm i2c_i801 lpc_ich mfd_core ipmi_si ipmi_devintf ipmi_msghandler acpi_cpufreq button sch_fq_codel nfsd nfs_acl lockd grace auth_rpcgss oid_registry sunrpc nvme nvme_core fuse sg loop efivarfs autofs4
>>  CR2: 0000000000000148                                                          
>>  ---[ end trace 340a1fb996df1b9b ]---                                           
>>  RIP: 0010:blk_mq_get_driver_tag+0x81/0x120                                     
>>  Code: 24 10 48 89 7c 24 20 74 21 83 fa ff 0f 95 c0 48 8b 4c 24 28 65 48 33 0c 25 28 00 00 00 0f 85 96 00 00 00 48 83 c4 30 5b 5d c3 <48> 8b 87 48 01 00 00 8b 40 04 39 43 20 72 37 f6 87 b0 00 00 00 02
>>
>> which doesn't look that great... Are we sure this patch closed the window
>> completely?
> 
> I mentioned this patch is just one workaround, see my comment before:
> 
> https://marc.info/?l=linux-scsi&m=154224379320094&w=2
> 
>>
>> One thing I'm pondering is we're running the queue async, so the
>> ref get will protect whatever blk_mq_run_hw_queues() does, but
>> what is preventing the queue from going away as soon as we've
>> returned from that call? Meanwhile we still have the work item
>> queued up, and it'll run, and go boom like above.
> 
> blk_sync_queue() supposes to drain the queued work, but it can be
> queued after blk_sync_queue() returns.

It's definitely broken. Big time. And we need to do something about
it NOW.

> Or maybe we can try the following patch?

I'm going to start backing out the sync removal patches instead of
adding items to the hot path...

Ted, I saw your email, I'm looking into it. Sounds like a regression
between 4.18 and 4.19. The sync issue could still be it, as it can
cause memory corruption, and that could lead to other corruption
issues.

-- 
Jens Axboe

