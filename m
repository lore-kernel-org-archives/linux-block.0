Return-Path: <SRS0=GlWt=UD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A788FC282CE
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 03:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F9024ADB
	for <linux-block@archiver.kernel.org>; Tue,  4 Jun 2019 03:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA8A1v64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFDDtP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jun 2019 23:49:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37961 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFDDtP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jun 2019 23:49:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id a186so11113719pfa.5;
        Mon, 03 Jun 2019 20:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=85o4iG3xfGB0fUSsbEqH3ZsBCOUqqObolZbnZEBcFcI=;
        b=HA8A1v64JxWSt1BD2uYfOFMbAJPch00i/swxG12yGYrqq7CnXn25OqrHLE/3e1MLWA
         0hVtbaik/78sddFdD3ZQ7PwtkA6LDGt13AtSHzbIEld2ENJtHvwaNUr9tEyqBbpH0HiM
         h+1ItAKX8DxiRahTKPuofv8xNaop4+8/RWqsEAknMUN3wAzGn/S1lJbn3irqNS/9npa3
         reu27/wQhVdCQrI1Oe0mfZIh+cqvZh69DxN76E8iJGAmMEvMaCeLnlKs13YbJ8zAEQ3w
         LF080GlUvpB6TAXTqiAVnYCn0YpXEhex0kWTMEei2AbMmp5+lqIZdVQqfRFnpBZP81au
         ERQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=85o4iG3xfGB0fUSsbEqH3ZsBCOUqqObolZbnZEBcFcI=;
        b=UVDQqVLDz8YFsGw+Mk9CBYw7qZSDPwv9/jTuQxw81Dj4sud5ei1xRGEyFh5J4pr5RL
         LBk8+QuRsMIpdn+615YHSeqBa9Lo4PtFBK20ngE2QVIZCdlLhh0bAvo3oigj9495LOx9
         Y1AkhxSYfVG0jCtqrq+iH8pYmcGp1+5ZKZzn0Tbj3c4m28dP2LE2YXRtvwAFSKcKbple
         sb2pFueMv3A8DZanwnzXBsDqb/0mW5dQAUa8IhCYRQ5y2coql81wYxWAe9X/y1V+Drg0
         pNe1I/+rKO06LujLvKr1HZLyeKDx3FLji3/dehEUz/FGF0DGPb1HefefID7JwpBVWcBl
         AM/Q==
X-Gm-Message-State: APjAAAVY4Xjn/eGOAdxrAut+HmLJuZ4evP9VhwiNgOUNzTkrHi+KhuEA
        BK76t1LzMmcxk+moURAfvTo=
X-Google-Smtp-Source: APXvYqzpgigodAXxceJzKrJ0JqbMG3GFEHRvXGebqxa7PlWVe4s6goiZzVkmW0JdYQWVSmKl0hrF8g==
X-Received: by 2002:a63:f10e:: with SMTP id f14mr32527417pgi.226.1559620154139;
        Mon, 03 Jun 2019 20:49:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t124sm16886070pfb.80.2019.06.03.20.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 20:49:12 -0700 (PDT)
Subject: Re: [PATCH V4 3/3] scsi: core: avoid to pre-allocate big chunk for sg
 list
To:     Ming Lei <ming.lei@redhat.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
References: <20190428073932.9898-1-ming.lei@redhat.com>
 <20190428073932.9898-4-ming.lei@redhat.com>
 <20190603204422.GA7240@roeck-us.net> <20190604010002.GA24432@ming.t460p>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <cdf94e43-79a7-078e-676d-dfc736eec286@roeck-us.net>
Date:   Mon, 3 Jun 2019 20:49:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604010002.GA24432@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/3/19 6:00 PM, Ming Lei wrote:
> On Mon, Jun 03, 2019 at 01:44:22PM -0700, Guenter Roeck wrote:
>> On Sun, Apr 28, 2019 at 03:39:32PM +0800, Ming Lei wrote:
>>> Now scsi_mq_setup_tags() pre-allocates a big buffer for IO sg list,
>>> and the buffer size is scsi_mq_sgl_size() which depends on smaller
>>> value between shost->sg_tablesize and SG_CHUNK_SIZE.
>>>
>>> Modern HBA's DMA is often capable of deadling with very big segment
>>> number, so scsi_mq_sgl_size() is often big. Suppose the max sg number
>>> of SG_CHUNK_SIZE is taken, scsi_mq_sgl_size() will be 4KB.
>>>
>>> Then if one HBA has lots of queues, and each hw queue's depth is
>>> high, pre-allocation for sg list can consume huge memory.
>>> For example of lpfc, nr_hw_queues can be 70, each queue's depth
>>> can be 3781, so the pre-allocation for data sg list is 70*3781*2k
>>> =517MB for single HBA.
>>>
>>> There is Red Hat internal report that scsi_debug based tests can't
>>> be run any more since legacy io path is killed because too big
>>> pre-allocation.
>>>
>>> So switch to runtime allocation for sg list, meantime pre-allocate 2
>>> inline sg entries. This way has been applied to NVMe PCI for a while,
>>> so it should be fine for SCSI too. Also runtime sg entries allocation
>>> has verified and run always in the original legacy io path.
>>>
>>> Not see performance effect in my big BS test on scsi_debug.
>>>
>>
>> This patch causes a variety of boot failures in -next. Typical failure
>> pattern is scsi hangs or failure to find a root file system. For example,
>> on alpha, trying to boot from usb:
> 
> I guess it is because alpha doesn't support sg chaining, and
> CONFIG_ARCH_NO_SG_CHAIN is enabled. ARCHs not supporting sg chaining
> can only be arm, alpha and parisc.
> 

I don't think it is that simple. I do see the problem on x86 (32 and 64 bit)
sparc, ppc, and m68k as well, and possibly others (I didn't check all because
-next is in terrible shape right now). Error log is always a bit different
but similar.

On sparc:

scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-181604017] len[8192]
scsi host0: DMA length is zero!
scsi host0: cur adr[f000f000] len[00000000]
scsi host0: Data transfer overflow.
scsi host0: cur_residue[0] tot_residue[-181604017] len[8192]
scsi host0: DMA length is zero!

On ppc:

scsi host0: DMA length is zero!
scsi host0: cur adr[0fd21000] len[00000000]
scsi host0: Aborting command [(ptrval):28]
scsi host0: Current command [(ptrval):28]
scsi host0:  Active command [(ptrval):28]

On x86, x86_64 (after reverting a different crash-causing patch):

[   20.226809] scsi host0: DMA length is zero!
[   20.227459] scsi host0: cur adr[00000000] len[00000000]
[   50.588814] scsi host0: Aborting command [(____ptrval____):28]
[   50.589210] scsi host0: Current command [(____ptrval____):28]
[   50.589447] scsi host0:  Active command [(____ptrval____):28]
[   50.589674] scsi host0: Dumping command log

On m68k there is a crash.

Unable to handle kernel NULL pointer dereference at virtual address (ptrval)
Oops: 00000000
Modules linked in:
PC: [<00203a9e>] esp_maybe_execute_command+0x31e/0x46c
SR: 2704  SP: (ptrval)  a2: 07c1ea20
d0: 00000002    d1: 00000400    d2: 00000000    d3: 00002000
d4: 00000000    d5: 00000000    a0: 07db753c    a1: 00000000
Process kworker/0:0H (pid: 4, task=(ptrval))
Frame format=7 eff addr=00000020 ssw=0505 faddr=00000020
wb 1 stat/addr/data: 0000 00000000 00000000
wb 2 stat/addr/data: 0000 00000000 00000000
wb 3 stat/addr/data: 0000 00000020 00000000
push data: 00000000 00000000 00000000 00000000
Stack from 07c2be08:
...
Call Trace: [<00002000>] _start+0x0/0x8
  [<001f65ca>] scsi_mq_done+0x0/0x2c
  [<001887fe>] blk_mq_get_driver_tag+0x0/0xba
  [<00188800>] blk_mq_get_driver_tag+0x2/0xba
  [<00025aec>] create_worker+0x0/0x14e
  [<00203f64>] esp_queuecommand+0x9c/0xa2
  [<00203f3a>] esp_queuecommand+0x72/0xa2
  [<001f7fd4>] scsi_queue_rq+0x54e/0x5ba
  [<00188b4a>] blk_mq_dispatch_rq_list+0x292/0x38a
  [<00188656>] blk_mq_dequeue_from_ctx+0x0/0x1a8
  [<001888b8>] blk_mq_dispatch_rq_list+0x0/0x38a
  [<00025aec>] create_worker+0x0/0x14e
...

All those problems are fixed by reverting this patch.

Guenter
