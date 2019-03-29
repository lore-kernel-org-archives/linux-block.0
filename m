Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CF1C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 20:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB3520657
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 20:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iHZ1Do1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfC2UVU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:21:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33383 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbfC2UVU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 16:21:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id bg8so1541397plb.0
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=k1RqSW5DlEQNcchLuS+Iqj9UbsEc7ygEDJ5KAYCvQ48=;
        b=iHZ1Do1liWZNBLRVNNxNunES9Qv9+SqhLtB3GWMbfqYpd8VeP10155EBs33WJKN7Rb
         dCkaVR82qgoRYXsH80SLDzRspRdiBI8iPkdcQOah0hKJWvc6HQuBkQUf8g9fwTn38qPR
         /L3Cqh/2CWNdFr010FJyJqkWIzgrLpu3k3VFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=k1RqSW5DlEQNcchLuS+Iqj9UbsEc7ygEDJ5KAYCvQ48=;
        b=rWDMAODNy3PRz0jLduRldjTl7jADw+vxgrBf1BhYVmfx2dXvbnKsrbhf9VGurhwX85
         LqMtAllHlbwxo9GMI+mqLg/J/e1LA0rDhtUEQPNUReWR8sgRYjUfKUVqYikb87DHWQ8+
         Z1QmwT4pq64KyVWoSWOGA9ArkggE4gtz1tOgkoiFnDf/3PS2QyL36trwfFDklNtKKmM3
         551tSOq6OTRkKt+0RmUEiNp1Su7uYSW+I6Ad/fpsVDTU+olq4V1OwkVOwUTiGdcyU5yu
         n9RXSrzqipPei9QuJydKKmjENFpiR4gXTV3hJG9FqhHDnsP4mVPKRBuEbz217CAxDTu5
         gpEA==
X-Gm-Message-State: APjAAAVnk/sgkk5f3Xif8cz+X+33jFmXZGYUhq7+1scBUZq6VJHxdQFC
        AiwXto/74BHhuy+8EGTZ/3IrPg==
X-Google-Smtp-Source: APXvYqx8cZ4KPUvT5PanPpVhLcW54x6hY3lWHAqDEvXGOnGkniYdtvA38m0ZqQ3fA+nMOI2ijiAq4w==
X-Received: by 2002:a17:902:968b:: with SMTP id n11mr43737516plp.118.1553890879407;
        Fri, 29 Mar 2019 13:21:19 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id e2sm4799220pfa.64.2019.03.29.13.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 13:21:18 -0700 (PDT)
Subject: Re: [PATCH V2] SCSI: fix queue cleanup race before queue
 initialization is done
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
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
 <dc374ec8-2ea2-0792-4677-0ae81fa7826e@kernel.dk>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <baba41b1-8495-8bd1-0bea-341d207852a7@broadcom.com>
Date:   Fri, 29 Mar 2019 13:21:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <dc374ec8-2ea2-0792-4677-0ae81fa7826e@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/21/2018 5:42 PM, Jens Axboe wrote:
> On 11/21/18 6:00 PM, Ming Lei wrote:
>> On Wed, Nov 21, 2018 at 02:47:35PM -0700, Jens Axboe wrote:
>>> On 11/14/18 8:20 AM, Jens Axboe wrote:
>>>> On 11/14/18 1:25 AM, Ming Lei wrote:
>>>>> c2856ae2f315d ("blk-mq: quiesce queue before freeing queue") has
>>>>> already fixed this race, however the implied synchronize_rcu()
>>>>> in blk_mq_quiesce_queue() can slow down LUN probe a lot, so caused
>>>>> performance regression.
>>>>>
>>>>> Then 1311326cf4755c7 ("blk-mq: avoid to synchronize rcu inside blk_cleanup_queue()")
>>>>> tried to quiesce queue for avoiding unnecessary synchronize_rcu()
>>>>> only when queue initialization is done, because it is usual to see
>>>>> lots of inexistent LUNs which need to be probed.
>>>>>
>>>>> However, turns out it isn't safe to quiesce queue only when queue
>>>>> initialization is done. Because when one SCSI command is completed,
>>>>> the user of sending command can be waken up immediately, then the
>>>>> scsi device may be removed, meantime the run queue in scsi_end_request()
>>>>> is still in-progress, so kernel panic can be caused.
>>>>>
>>>>> In Red Hat QE lab, there are several reports about this kind of kernel
>>>>> panic triggered during kernel booting.
>>>>>
>>>>> This patch tries to address the issue by grabing one queue usage
>>>>> counter during freeing one request and the following run queue.
>>>> Thanks applied, this bug was elusive but ever present in recent
>>>> testing that we did internally, it's been a huge pain in the butt.
>>>> The symptoms were usually a crash in blk_mq_get_driver_tag() with
>>>> hctx->tags == NULL, or a crash inside deadline request insert off
>>>> requeue.

All,

We are seeing errors with the following error:

[44492.814347] BUG: unable to handle kernel NULL pointer dereference at 
(null)
[44492.814383] IP: [<ffffffff8135a10b>] sbitmap_any_bit_set+0xb/0x30
...
[44492.815634] Call Trace:
[44492.815652]  [<ffffffff81303a88>] blk_mq_run_hw_queues+0x48/0x90
[44492.819755]  [<ffffffff813053cc>] blk_mq_requeue_work+0x10c/0x120
[44492.819777]  [<ffffffff81098cb4>] process_one_work+0x154/0x410
[44492.819781]  [<ffffffff81099896>] worker_thread+0x116/0x4a0
[44492.819784]  [<ffffffff8109edb9>] kthread+0xc9/0xe0
[44492.819790]  [<ffffffff81619b05>] ret_from_fork+0x55/0x80
[44492.822798] DWARF2 unwinder stuck at ret_from_fork+0x55/0x80
[44492.822798]
[44492.822799] Leftover inexact backtrace:

[44492.822802]  [<ffffffff8109ecf0>] ? kthread_park+0x50/0x50
[44492.822818] Code: c6 44 0f 46 ce 83 c2 01 45 89 ca 4c 89 54 01 08 48 
8b 4f
10 2b 74 01 08 39 57 08 77 d8 f3 c3 90 8b 4f 08 85 c9 74 1f 48 8b 57 10 
<48> 83
3a 00 75 18 31 c0 eb 0a 48 83 c2 40 48 83 3a 00 75 0a 83
[44492.822820] RIP  [<ffffffff8135a10b>] sbitmap_any_bit_set+0xb/0x30
[44492.822821]  RSP <ffff8807219ffdd8>
[44492.822821] CR2: 0000000000000000

It appears the queue has been freed thus the bitmap is bad.

Looking at the commit relative to this email thread:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/scsi/scsi_lib.c?id=8dc765d438f1e42b3e8227b3b09fad7d73f4ec9a

It's interesting that the queue reference taken was released after the 
kblockd_schedule_work() call was made, and it's this work element that 
is hitting the issue. So perhaps the patch missed keeping the reference 
until the requeue_work item finished ?

-- james

