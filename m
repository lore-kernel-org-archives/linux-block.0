Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F6EC64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F75208E7
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F75208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbeLFRd3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:33:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbeLFRd3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 12:33:29 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 00066E4D7ADCB;
        Fri,  7 Dec 2018 01:33:24 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Fri, 7 Dec 2018
 01:33:20 +0800
Subject: Re: DIF/DIX issue related to config CONFIG_SCSI_MQ_DEFAULT
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <5d9bf51d-1ef9-b948-2168-9e7526d77225@hisilicon.com>
 <20181127130811.GA2780@ming.t460p>
 <6c573f36-60d8-0631-e9ac-dacd72f6c8ad@hisilicon.com>
 <20181130011935.GA7573@ming.t460p>
 <e0e07583-98ca-4fc5-e60d-055e5474c084@huawei.com>
 <yq1k1kqt07m.fsf@oracle.com>
 <45193ec6-6398-3953-4833-88ca2057971a@huawei.com>
 <yq1ftvcsoes.fsf@oracle.com>
 <fe72aef6-d313-5f02-7c0e-0eea28e86582@huawei.com>
 <yq1efavp9md.fsf@oracle.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Steffen Maier <maier@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6324d4a1-a41e-4322-718c-f6c91099f508@huawei.com>
Date:   Thu, 6 Dec 2018 17:33:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <yq1efavp9md.fsf@oracle.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/12/2018 04:22, Martin K. Petersen wrote:
>

Hi Martin,

> John,
>
>>> I'll have to go revisit the archives for your exact fio bits.
>
> Your fio test case ran to completion on all my test systems.
>
>>> But I successfully ran our DIX/T10 PI qualification tooling without any
>>> errors on the latest SCSI tree. On both scsi_debug and FC hardware.
>>
>> I'm not fimilar with this tooling. Is it internal to your company?
>
> Sadly, yes :( We have not had much luck upstreaming the necessary aio
> integrity passthrough enhancements.
>
>> Unfortunately it seems that no other SAS HBA kernel driver supports
>> DIX, so we have nothing to test against for this transport.
>
> We did a preliminary qual of LSISAS3008 many moons ago. But we had no
> immediate use for it in our offerings so it never went beyond that. I
> know other companies are using it, though.
>

It seems from https://www.spinics.net/lists/linux-scsi/msg97818.html 
that 3008 mainline driver does support DIX:

"DIX is supported in mpt3sas , but not by default and hence while 
loading mpt3sas driver set module parameter "prot_mask=0x7F" to enable 
DIX support. "

Maybe we can try it.

BTW, on a loosely related topic, in drivers/scsi/sd.h, I noticed that 
the arrays in sd_prot_op() and sd_prot_flag_mask() could be made static. 
In doing so I found sd.o object code shrunk by ~100B.

Thanks,
John

