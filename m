Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D79CC282D4
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 06:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39652083B
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 06:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfA3Gx2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:53:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3244 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbfA3Gx1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 01:53:27 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0A6692A3F75F301602B4;
        Wed, 30 Jan 2019 14:53:26 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.120) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 30 Jan 2019
 14:53:20 +0800
Subject: Re: block: Fix a WRITE SAME BUG_ON
To:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Mike Snitzer <snitzer@redhat.com>,
        John Dorminy <jdorminy@redhat.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
 <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
 <20190128221441.GA24102@redhat.com> <yq1lg34f4i7.fsf@oracle.com>
 <20190129085226.GA25610@infradead.org>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <5466ca60-0fe0-8833-6029-1e5b54dd29b4@huawei.com>
Date:   Wed, 30 Jan 2019 14:50:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190129085226.GA25610@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.120]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/29/2019 4:52 PM, Christoph Hellwig wrote:
> On Mon, Jan 28, 2019 at 11:54:08PM -0500, Martin K. Petersen wrote:
>> That said, now that we have REQ_OP_WRITE_ZEROES (where the LBS is
>> irrelevant due to the payload being the ZERO_PAGE), it may be worthwhile
>> to remove REQ_OP_WRITE_SAME. I think drbd is the only user relying on a
>> non-zero payload. The target code ends up manually iterating, if I
>> remember correctly...
> 
> I had a series to remove it a while ago, but you wanted to keep it at
> that point.  I can resurrect it.
> 
Do you mean to remove the `blkdev_issue_write_same` interface?
I think we should fix the problem first because other users may also encounter
the same problem.

> .
> 

