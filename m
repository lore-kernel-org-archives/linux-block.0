Return-Path: <SRS0=s2CZ=X3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB65AC352AA
	for <linux-block@archiver.kernel.org>; Wed,  2 Oct 2019 14:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7327821783
	for <linux-block@archiver.kernel.org>; Wed,  2 Oct 2019 14:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cidEGKKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfJBOgz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:36:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46484 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfJBOgz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Oct 2019 10:36:55 -0400
Received: by mail-io1-f66.google.com with SMTP id c6so57276592ioo.13
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2019 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CF1s6HBRoIET1YyCmWKjlpotW1nV8FtTW06863fXKAU=;
        b=cidEGKKCZ6VOHv11YGR9zXXdKQ9D+4PrmkxhGfQbe7h2qMolppQnuD74N39an1V21u
         cr/c+tYGaOz9qEc2vsmF52UD1E6RZu0Pf1mCpMFjEVkW4d98cPD409gkVSgPk0k+6gut
         6yFc5KwFqtPHTd/radTiu+RWtED3GqOt9Uwd0Ba/7hTmEd0wnRw7w53CfhE0mmLcYipb
         AtIt9rHmBCepBsy8dOfnXhkc9gR8keGL0FK3tkc6LbAcQZHRbmaoyL3QELJwv5OYQUsK
         n1rJ6Bj5UddJ0rVC5XBK1pfcU7rqfu53zPwvkIyzQ5verbc0DBTUar7x+8PLWt57JKUw
         a0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CF1s6HBRoIET1YyCmWKjlpotW1nV8FtTW06863fXKAU=;
        b=RPkPfdGR7n3Cu8PylBhqeaKHX++BGNCoRkXVPIB/iYketK03J1FbCLzEKZ6E/wIjGD
         R87Bt9EDAmmfjuN3XqFZZ0OaVwiGRoutV/JAqXVZ60utkmnubwNxGJJZKr+Q1UDVmxDc
         GZCMMqLIWp0D7q6+shvF4s90TKtDFgzX2/ymZGkQvWni63gxnQZqaCpc5qIZSBmNtObh
         v231NzEfZPoBs15IpPzAzmvc2UvYPdfJE85PQWkZrpxL4wLI/3GvmCQ7JFmVlyljtUET
         N4Faj58j1hOKHA7Pk22qlg6D7OFGVcWY75OGJKDjP1MVFH1QMff5xJ6RcpbRgNusnNx0
         V2KA==
X-Gm-Message-State: APjAAAUFC3HTtUgIzbYdcw0EWBgUFPWZK8A1zq03KU+rnWU0Oq2r1Fdb
        sJVkn1sepvyA3/rrtHZ8YS3q1A==
X-Google-Smtp-Source: APXvYqzRPJwdT0IueJ0R5VdwwuCzPufSKqiy+mBclcmzG4JQGCoT1TfNA/XUlmHyHfvibzvu02gB3g==
X-Received: by 2002:a92:ba90:: with SMTP id t16mr4483966ill.19.1570027014390;
        Wed, 02 Oct 2019 07:36:54 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z86sm8712839ilf.73.2019.10.02.07.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 07:36:53 -0700 (PDT)
Subject: Re: [PATCH V2 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
To:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>,
        chenxiang <chenxiang66@hisilicon.com>
References: <20190812134312.16732-1-ming.lei@redhat.com>
 <a2f9e930-1b9c-dc95-78f8-70df9460669d@huawei.com>
 <9add1de0-9135-fd1f-8fd4-de17234d8883@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5a49d3b4-75bc-b01d-e77a-a318a70a34e1@kernel.dk>
Date:   Wed, 2 Oct 2019 08:36:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9add1de0-9135-fd1f-8fd4-de17234d8883@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/2/19 3:56 AM, John Garry wrote:
> On 22/08/2019 18:39, John Garry wrote:
>> On 12/08/2019 14:43, Ming Lei wrote:
>>> Hi,
>>>
>>> Thomas mentioned:
>>>      "
>>>       That was the constraint of managed interrupts from the very
>>> beginning:
>>>
>>>        The driver/subsystem has to quiesce the interrupt line and the
>>> associated
>>>        queue _before_ it gets shutdown in CPU unplug and not fiddle
>>> with it
>>>        until it's restarted by the core when the CPU is plugged in again.
>>>      "
>>>
>>> But no drivers or blk-mq do that before one hctx becomes dead(all
>>> CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
>>> to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().
>>>
>>> This patchset tries to address the issue by two stages:
>>>
>>> 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
>>>
>>> - mark the hctx as internal stopped, and drain all in-flight requests
>>> if the hctx is going to be dead.
>>>
>>> 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx
>>> becomes dead
>>>
>>> - steal bios from the request, and resubmit them via
>>> generic_make_request(),
>>> then these IO will be mapped to other live hctx for dispatch
>>>
>>> Please comment & review, thanks!
>>>
>>> V2:
>>>      - patch4 & patch 5 in V1 have been merged to block tree, so remove
>>>        them
>>>      - address comments from John Garry and Minwoo
>>>
>>>
>>> Ming Lei (5):
>>>    blk-mq: add new state of BLK_MQ_S_INTERNAL_STOPPED
>>>    blk-mq: add blk-mq flag of BLK_MQ_F_NO_MANAGED_IRQ
>>>    blk-mq: stop to handle IO before hctx's all CPUs become offline
>>>    blk-mq: re-submit IO in case that hctx is dead
>>>    blk-mq: handle requests dispatched from IO scheduler in case that hctx
>>>      is dead
>>
>> Hi Ming,
>>
>> This looks to fix the hotplug issue for me.
>>
>> Previously I could manufacture a scenario while running fio where I got
>> IO timeouts, like this:
>>
>> root@(none)$ echo 0 > ./sys/devices/system/cpu/cpu0/online
>> [  296.897627] process 891 (fio) no longer affine to cpu0
>> [  296.898488] process 893 (fio) no longer affine to cpu0
>> [  296.910270] process 890 (fio) no longer affine to cpu0
>> [  296.927322] IRQ 775: no longer affine to CPU0
>> [  296.932762] CPU0: shutdown
>> [  296.935469] psci: CPU0 killed.
>> root@(none)$ [  326.971962] sas: Enter sas_scsi_recover_host busy: 61
>> failed: 61
>> [  326.977978] sas: sas_scsi_find_task: aborting task 0x00000000e2cdc79b
>> root@(none)$ [  333.047964] hisi_sas_v3_hw 0000:74:02.0: internal task
>> abort: timeout and not done.
>> [  333.055616] hisi_sas_v3_hw 0000:74:02.0: abort task: internal abort (-5)
>> [  333.062306] sas: sas_scsi_find_task: querying task 0x00000000e2cdc79b
>> [  333.068776] sas: sas_scsi_find_task: task 0x00000000e2cdc79b not at LU
>> [  333.075295] sas: task 0x00000000e2cdc79b is not at LU: I_T recover
>> [  333.081464] sas: I_T nexus reset for dev 5000c500a7b95a49
>>
>> Please notice the 30-second delay for the SCSI IO timeout.
>>
>> And now I don't see it; here's a sample for irq shutdown:
>> root@(none)$ echo 0 > ./sys/devices/system/cpu/cpu0/online
>> [  344.608148] process 849 (fio) no longer affine to cpu0
>> [  344.608639] process 848 (fio) no longer affine to cpu0
>> [  344.609454] process 850 (fio) no longer affine to cpu0
>> [  344.643481] process 847 (fio) no longer affine to cpu0
>> [  346.213842] IRQ 775: no longer affine to CPU0
>> [  346.219712] CPU0: shutdown
>> [  346.222425] psci: CPU0 killed.
>>
>> Please notice the ~1.5s pause, which would be the queue draining.
>>
>> So FWIW:
>> Tested-by: John Garry <john.garry@huawei.com>
>>
>> JFYI, I tested on 5.3-rc5 and cherry-picked
>> https://github.com/ming1/linux/commit/0d2cd3c99bb0fe81d2c0ca5d68e02bdc4521d4d6
>> and "blk-mq: add callback of .cleanup_rq".
>>
>> Cheers,
>> John
> 
> Hi Jens,
> 
> I don't mean to be pushy, but can we consider to get these patches from
> Ming merged?
> 
> As above, I tested on my SCSI driver and it works. I also tested on an
> NVMe disk, and it solves the condition which generates this message:
> root@(none)$ echo 0 > /sys/devices/system/cpu/cpu2/online
> [  465.635960] CPU2: shutdown
> [  465.638662] psci: CPU2 killed.
> [  111.381653] nvme nvme0: I/O 705 QID 18 timeout, completion polled
> 
> (that's on top off v5.4-rc1)

Ming, can you repost the series?

-- 
Jens Axboe

