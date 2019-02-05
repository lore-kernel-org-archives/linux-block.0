Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5C0C282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 15:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7548D217D6
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 15:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfBEPKu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:10:50 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:58909 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbfBEPKu (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Tue, 5 Feb 2019 10:10:50 -0500
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 05 Feb 2019 16:10:48 +0100
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
To:     Keith Busch <keith.busch@intel.com>,
        John Garry <john.garry@huawei.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <0de6dae8-1234-3e3f-d8f3-2d8de47b7f9e@suse.com>
Date:   Tue, 5 Feb 2019 16:10:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190205145244.GB28023@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/5/19 3:52 PM, Keith Busch wrote:
> On Tue, Feb 05, 2019 at 05:24:11AM -0800, John Garry wrote:
>> On 04/02/2019 07:12, Hannes Reinecke wrote:
>>
>> Hi Hannes,
>>
>>>
>>> So, as the user then has to wait for the system to declars 'ready for
>>> CPU remove', why can't we just disable the SQ and wait for all I/O to
>>> complete?
>>> We can make it more fine-grained by just waiting on all outstanding I/O
>>> on that SQ to complete, but waiting for all I/O should be good as an
>>> initial try.
>>> With that we wouldn't need to fiddle with driver internals, and could
>>> make it pretty generic.
>>
>> I don't fully understand this idea - specifically, at which layer would
>> we be waiting for all the IO to complete?
> 
> Whichever layer dispatched the IO to a CPU specific context should
> be the one to wait for its completion. That should be blk-mq for most
> block drivers.
> 
Indeed.
But we don't provide any mechanisms for that ATM, right?

Maybe this would be a topic fit for LSF/MM?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
