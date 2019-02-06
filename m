Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12DAC169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 09:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A832175B
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 09:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfBFJWA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:22:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57044 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbfBFJV7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Feb 2019 04:21:59 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 906D96BC16970496FCFD;
        Wed,  6 Feb 2019 17:21:57 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Feb 2019
 17:21:48 +0800
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
To:     Christoph Hellwig <hch@lst.de>
References: <20190129172059.GC17132@localhost.localdomain>
 <3fe63dab-0791-f476-69c4-9866b70e8520@huawei.com>
 <alpine.DEB.2.21.1901301338170.5537@nanos.tec.linutronix.de>
 <86d5028d-44ab-3696-f7fe-828d7655faa9@huawei.com>
 <745609be-b215-dd2d-c31f-0bd84572f49f@suse.de>
 <alpine.DEB.2.21.1902012255550.8200@nanos.tec.linutronix.de>
 <d93ff049-e96d-36ce-7e58-ec97cbb27ed0@suse.de>
 <42d149c5-0380-c357-8811-81015159ac04@huawei.com>
 <20190205145244.GB28023@localhost.localdomain>
 <d4a04c13-b7db-84df-b1d3-90022905c084@huawei.com>
 <20190205182325.GA3302@lst.de>
CC:     Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hannes Reinecke" <hare@suse.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3413b0b1-cb3f-3b09-106d-89cf8be30178@huawei.com>
Date:   Wed, 6 Feb 2019 09:21:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190205182325.GA3302@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/02/2019 18:23, Christoph Hellwig wrote:
> On Tue, Feb 05, 2019 at 03:09:28PM +0000, John Garry wrote:
>> For SCSI devices, unfortunately not all IO sent to the HW originates from
>> blk-mq or any other single entity.
>
> Where else would SCSI I/O originate from?

Please note that I was referring to other management IO, like SAS SMP, 
TMFs, and other proprietary commands which the driver may generate for 
the HBA - https://marc.info/?l=linux-scsi&m=154831889001973&w=2 
discusses some of them also.

Thanks,
John

>
> .
>


