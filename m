Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C37AC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 09:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0528F2229F
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 09:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbfBNJgs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:36:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfBNJgs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 04:36:48 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0106B4A9B908726E65EF;
        Thu, 14 Feb 2019 17:36:42 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.120) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Thu, 14 Feb 2019
 17:36:36 +0800
Subject: Re: [dm-devel] block: Fix a WRITE SAME BUG_ON
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        John Dorminy <jdorminy@redhat.com>, <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>,
        <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>
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
 <d693e299-3c7d-b3cb-e8c7-a1f94bba4697@huawei.com>
 <yq1lg2jqex7.fsf@oracle.com>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <6a00e005-656e-7b3c-6b86-1430f3e7e623@huawei.com>
Date:   Thu, 14 Feb 2019 17:36:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <yq1lg2jqex7.fsf@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.120]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any comments about the patch?

On 2/14/2019 10:31 AM, Martin K. Petersen wrote:
> 
> zhangxiaoxu,
> 
>> Any progress about the problme?
>> Should we disable the write same when stack the different LBA disks?
> 
> Yes, please.
> 

