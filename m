Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EE2C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 14:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729C621773
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 14:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbfBSOYb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:24:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:36084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbfBSOYa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 09:24:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0522B049;
        Tue, 19 Feb 2019 14:24:29 +0000 (UTC)
Subject: Re: [LSF/MM TOPIC] Handling of managed IRQs when hotplugging CPUs
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        SCSI Mailing List <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
References: <99dc311f-16b6-9b0d-e309-198dcc9dcde7@suse.de>
 <CACVXFVPj+zoT9FkE0UqagJMwTHXv8t6OzXM2KtsqrMp3=WMcEw@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ff5c5a70-3c59-87fb-0d5f-5065335ed002@suse.de>
Date:   Tue, 19 Feb 2019 15:24:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVPj+zoT9FkE0UqagJMwTHXv8t6OzXM2KtsqrMp3=WMcEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/19/19 3:19 AM, Ming Lei wrote:
> On Tue, Feb 5, 2019 at 11:30 PM Hannes Reinecke <hare@suse.de> wrote:
>>
>> Hi all,
>>
>> this came up during discussion on the mailing list (cf thread "Question
>> on handling managed IRQs when hotplugging CPUs").
>> The problem is that with managed IRQs and block-mq I/O will be routed to
>> individual CPUs, and the response will be send to the IRQ assigned to
>> that CPU.
>>
>> If now a CPU hotplug event occurs when I/O is still in-flight the IRQ
>> will _still_ be assigned to the CPU, causing any pending interrupt to be
>> lost.
>> Hence the driver will never notice that an interrupt has happened, and
>> an I/O timeout occurs.
> 
> Lots of driver's timeout handler only returns BLK_EH_RESET_TIMER,
> and this situation can't be covered by IO timeout for these devices.
> 
> For example, we have see IO hang issue on HPSA, megaraid_sas
> before when wrong msi vector is set on IO command. Even one such
> issue on aacraid isn't fixed yet.
> 
>>
>> One proposal was to quiesce the device when a CPU hotplug event occurs,
>> and only allow for CPU hotplugging once it's fully quiesced.
> 
> That is the original solution, but big problem is that queue dependency
> exists, such as loop/DM's queue depends on underlying's queue, NVMe
> IO queue depends on  its admin queue.
> 
>>
>> While this would be working, it will be introducing quite some system
>> stall, and it actually a rather big impact in the system.
>> Another possiblity would be to have the driver abort the requests
>> itself, but this requires specific callbacks into the driver, and, of
>> course, the driver having the ability to actually do so.
>>
>> I would like to discuss at LSF/MM how these issues can be addressed best.
> 
> One related topic is that the current static queue mapping without CPU hotplug
> handler involved may waste lots of IRQ vectors[1], and how to deal
> with this problem?
> 
> [1] http://lists.infradead.org/pipermail/linux-nvme/2019-January/021961.html
> 
Yes, ideally I would like to touch upon that, too.
Additionally we have the issue raised by the mpt3sas folks [2], where 
they ran into a CPU lockup when having more CPU cores than interrupts.

[2] https://patchwork.kernel.org/cover/10811825

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
