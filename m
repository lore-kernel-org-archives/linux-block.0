Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE456C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 14:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C5B206C2
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 14:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393725AbfAPOpB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:45:01 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:37990 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387478AbfAPOpB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 09:45:01 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D8051284502F73FCD192;
        Wed, 16 Jan 2019 22:44:56 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 16 Jan 2019
 22:44:48 +0800
Subject: Re: [PATCH] scsi: isci: initialize shost fully before calling
 scsi_add_host()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20190108205043.3122-1-logang@deltatee.com>
 <20190109184105.GB22070@lst.de>
 <8d96b40d-fc83-9218-9479-3de423594ddb@huawei.com>
 <yq1lg3qy578.fsf@oracle.com>
 <0ffaf166-c7e5-b135-fdc5-bcac24148e62@huawei.com>
 <yq1sgxts46u.fsf@oracle.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Jeff Moyer <jmoyer@redhat.com>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f393a8f4-aff9-2117-d7a1-26abd72e22b4@huawei.com>
Date:   Wed, 16 Jan 2019 14:44:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <yq1sgxts46u.fsf@oracle.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16/01/2019 02:54, Martin K. Petersen wrote:
>
> Hi John,
>

Hi Martin,

>>> So in this case I think that accessor functions are actually better
>>> because they allow us to print a big fat warning when you twiddle
>>> something you shouldn't post-initialization. So that's something I think
>>> we could--and should--improve.
>>>
>> Sure, this is an alternative, but I would rather make it obvious when
>> these parameters should be set so that this would not be required.
>
> I would like to have a mechanism in place that warns if you twiddle
> things that break assumptions made at host registration time.

Yes, something more robust would be good.

That's not
> a scenario the old registration interface was designed to handle.
>
> I am not sure I agree with your assertion that setting these masks in
> the struct prior to scsi_add_host() makes this ordering requirement much
> more obvious.
It is not like you are passing in a list of parameters and
> then receiving a separately instantiated immutable scsi_host object. You
> are performing an operation on something you already have and own.
>
> That's why I commented that the current intersection between
> compile-time static host template, dynamically discovered
> pre-registration scsi_host parameters, and the registered runtime
> scsi_host struct is somewhat messy.
>
> Btw. I have no attachment to the prot wrappers whatsoever. The reason
> they exist is that the SCSI integrity support was optional. And
> therefore we had stub functions so things could be compiled without any
> of the integrity fields being present in the various SCSI structs.

I never noticed stubs for setting/getting 
Scsi_host.prot_{capabilities,guard_type}

So I
> don't have any problem killing the wrappers except they may actually be
> handy for regressions like this one where you could #error if the driver
> writer violates the ordering requirement.
>

We set many Scsi_host parameters without such safeguarding, and I don't 
know what's special about these protection-related members.

Thanks,
John


