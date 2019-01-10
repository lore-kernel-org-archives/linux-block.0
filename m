Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638E1C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DF1214C6
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 09:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfAJJMF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:12:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:17130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbfAJJMF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 04:12:05 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 08154533F960A97D8195;
        Thu, 10 Jan 2019 17:11:59 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 10 Jan 2019
 17:11:51 +0800
Subject: Re: [PATCH] scsi: isci: initialize shost fully before calling
 scsi_add_host()
To:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>
References: <20190108205043.3122-1-logang@deltatee.com>
 <20190109184105.GB22070@lst.de>
CC:     <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Jeff Moyer <jmoyer@redhat.com>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8d96b40d-fc83-9218-9479-3de423594ddb@huawei.com>
Date:   Thu, 10 Jan 2019 09:11:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190109184105.GB22070@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/01/2019 18:41, Christoph Hellwig wrote:
> This looks good.  I wonder if there is any good way to prevent other
> drivers from picking up this bug byt using a better interface, but
> that should not delay your fix.
>
> .
>

I noticed that hisi_sas has this same problem but I forgot to fix it.

So how about just drop these APIs and let the user set the shost 
protection parameters directly, like other shost parameters, which 
should make it a bit clearer when these should be set, i.e. before 
scsi_add_host()?

John


