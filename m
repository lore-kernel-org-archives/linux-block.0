Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5ACC282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 15:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EFA20811
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 15:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfBEPPO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:15:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:58746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728220AbfBEPPN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Feb 2019 10:15:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 52B62B638;
        Tue,  5 Feb 2019 15:15:12 +0000 (UTC)
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
To:     John Garry <john.garry@huawei.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20190129154433.GF15302@localhost.localdomain>
 <757902fc-a9ea-090b-7853-89944a0ce1b5@huawei.com>
 <20190129172059.GC17132@localhost.localdomain>
 <3fe63dab-0791-f476-69c4-9866b70e8520@huawei.com>
 <alpine.DEB.2.21.1901301338170.5537@nanos.tec.linutronix.de>
 <86d5028d-44ab-3696-f7fe-828d7655faa9@huawei.com>
 <745609be-b215-dd2d-c31f-0bd84572f49f@suse.de>
 <alpine.DEB.2.21.1902012255550.8200@nanos.tec.linutronix.de>
 <d93ff049-e96d-36ce-7e58-ec97cbb27ed0@suse.de>
 <42d149c5-0380-c357-8811-81015159ac04@huawei.com>
 <20190205145244.GB28023@localhost.localdomain>
 <d4a04c13-b7db-84df-b1d3-90022905c084@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <43b43df0-8c8a-fbf0-69d8-9165a73bffea@suse.de>
Date:   Tue, 5 Feb 2019 16:15:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <d4a04c13-b7db-84df-b1d3-90022905c084@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/5/19 4:09 PM, John Garry wrote:
> On 05/02/2019 14:52, Keith Busch wrote:
>> On Tue, Feb 05, 2019 at 05:24:11AM -0800, John Garry wrote:
>>> On 04/02/2019 07:12, Hannes Reinecke wrote:
>>>
>>> Hi Hannes,
>>>
>>>>
>>>> So, as the user then has to wait for the system to declars 'ready for
>>>> CPU remove', why can't we just disable the SQ and wait for all I/O to
>>>> complete?
>>>> We can make it more fine-grained by just waiting on all outstanding I/O
>>>> on that SQ to complete, but waiting for all I/O should be good as an
>>>> initial try.
>>>> With that we wouldn't need to fiddle with driver internals, and could
>>>> make it pretty generic.
>>>
>>> I don't fully understand this idea - specifically, at which layer would
>>> we be waiting for all the IO to complete?
>>
>> Whichever layer dispatched the IO to a CPU specific context should
>> be the one to wait for its completion. That should be blk-mq for most
>> block drivers.
> 
> For SCSI devices, unfortunately not all IO sent to the HW originates 
> from blk-mq or any other single entity.
> 
No, not as such.
But each IO sent to the HW requires a unique identifcation (ie a valid 
tag). And as the tagspace is managed by block-mq (minus management 
commands, but I'm working on that currently) we can easily figure out if 
the device is busy by checking for an empty tag map.

Should be doable for most modern HBAs.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
