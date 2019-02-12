Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879B7C169C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 03:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD4E217FA
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 03:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfBLDMJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 22:12:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbfBLDMJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 22:12:09 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 45F2DD684A69A4395FE9;
        Tue, 12 Feb 2019 11:12:07 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.120) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Feb 2019
 11:12:04 +0800
Subject: Re: [dm-devel] block: Fix a WRITE SAME BUG_ON
To:     Christoph Hellwig <hch@infradead.org>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        John Dorminy <jdorminy@redhat.com>
CC:     <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Mike Snitzer" <snitzer@redhat.com>, <linux-block@vger.kernel.org>,
        <dm-devel@redhat.com>, Alasdair G Kergon <agk@redhat.com>
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
 <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
 <20190128221441.GA24102@redhat.com> <yq1lg34f4i7.fsf@oracle.com>
 <CAMeeMh85T_qui=LWd0u=b_oMN5XLqowqkvLuYGBM2Ae6tS-mzg@mail.gmail.com>
 <20190131103924.GA22503@infradead.org>
 <CAMeeMh-uxiee7rKutnr3jrMjzkc8=R2Y3DPPBLvLYjqSwjfi_w@mail.gmail.com>
 <20190201073527.GA14758@infradead.org>
 <CAMeeMh-wAZ8377sMrnyQZUt2HT1hB02DHSROJURLmPsaZPkeQQ@mail.gmail.com>
 <f7b05928-316c-4c73-b04b-bba38ea60b27@redhat.com>
 <20190201161803.GA21124@infradead.org>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <d693e299-3c7d-b3cb-e8c7-a1f94bba4697@huawei.com>
Date:   Tue, 12 Feb 2019 11:11:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190201161803.GA21124@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.120]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any progress about the problme?
Should we disable the write same when stack the different LBA disks?

On 2/2/2019 12:18 AM, Christoph Hellwig wrote:
> On Fri, Feb 01, 2019 at 05:03:40PM +0100, Heinz Mauelshagen wrote:
>> On 2/1/19 3:09 PM, John Dorminy wrote:
>>> I didn't know such a thing existed... does it work on any block
>>> device? Where do I read more about this?
>>
>>
>> Use sg_write_same(8) from package sg3_utils.
>>
>> For instance 'sg_write_same --in=foobarfile --lba=0 --num=20000
>> --xferlen=512 /dev/sdwhatever'
>>
>> will read the pattern to write same from file 'foobarfile' with length
>> explicitely set to 512 bytes
>> (rather than derived from foobarfile's size) and write it 20000 times
>> starting at LBA 0 to /dev/sdwhatever.
> 
> Yeah.  Note that this will only work on SCSI disks (and maybe ATA
> for a very specific corner case).  But for actual devices and not
> remappers the same is true of REQ_OP_WRITE_SAME.
> 
> .
> 

