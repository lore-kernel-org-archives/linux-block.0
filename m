Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7858C43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 12:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DE220656
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 12:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfANMKo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:10:44 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbfANMKn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 07:10:43 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 630A371401E80BC863A6;
        Mon, 14 Jan 2019 20:10:41 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Mon, 14 Jan 2019
 20:10:30 +0800
Subject: Re: [PATCH] scsi: isci: initialize shost fully before calling
 scsi_add_host()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20190108205043.3122-1-logang@deltatee.com>
 <20190109184105.GB22070@lst.de>
 <8d96b40d-fc83-9218-9479-3de423594ddb@huawei.com>
 <yq1lg3qy578.fsf@oracle.com>
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
Message-ID: <0ffaf166-c7e5-b135-fdc5-bcac24148e62@huawei.com>
Date:   Mon, 14 Jan 2019 12:10:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <yq1lg3qy578.fsf@oracle.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/01/2019 02:34, Martin K. Petersen wrote:
>
> John,
>
>> So how about just drop these APIs and let the user set the shost
>> protection parameters directly, like other shost parameters,
>
> The protection interfaces here obviously predate the block layer
> allocation changes that made this particular issue pop up.
>
>> which should make it a bit clearer when these should be set,
>> i.e. before scsi_add_host()?
>
> In general, I am not so keen on the somewhat messy intersection between
> the host parameters and the host template. The static host templates
> made lots of sense in the days of Seagate ST01 and fixed hardware
> capabilities.  But reality is that most modern controllers have to query
> firmware interfaces to figure out what their actual capabilities are.

Hi Martin,

I am not suggested setting the parameters via scsi host template, but 
rather dynamically (as we currently do) but just drop the set helper 
functions, like:

     shost->max_channel = 1;
     shost->max_cmd_len = 16;

     ...

     if (hisi_hba->prot_mask) {
         dev_info(dev, "Registering for DIF/DIX prot_mask=0x%x\n",
              prot_mask);
-        scsi_host_set_prot(hisi_hba->shost, prot_mask);
+        shost->prot_capabilities = prot_mask;
     }

     rc = scsi_add_host(shost, dev);
     if (rc)
         goto err_out_ha;

     rc = sas_register_ha(sha);
     if (rc)
         goto err_out_register_ha;

I find that it is not crystal clear when scsi_host_set_prot() and 
scsi_host_set_guard() should be called, but not so for setting the shost 
parameters directly, which is common.

>
> So in this case I think that accessor functions are actually better
> because they allow us to print a big fat warning when you twiddle
> something you shouldn't post-initialization. So that's something I think
> we could--and should--improve.
>

Sure, this is an alternative, but I would rather make it obvious when 
these parameters should be set so that this would not be required.

Thanks,
John


