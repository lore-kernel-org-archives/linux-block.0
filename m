Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB3EC282D7
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 01:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84DA20B1F
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 01:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfAaBZe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:25:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbfAaBZe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 20:25:34 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DAD9FDAF8F2BBF840F65;
        Thu, 31 Jan 2019 09:25:31 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.120) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 31 Jan 2019
 09:25:30 +0800
Subject: Re: block: Fix a WRITE SAME BUG_ON
To:     John Dorminy <jdorminy@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Mike Snitzer <snitzer@redhat.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
 <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
 <20190128221441.GA24102@redhat.com> <yq1lg34f4i7.fsf@oracle.com>
 <CAMeeMh85T_qui=LWd0u=b_oMN5XLqowqkvLuYGBM2Ae6tS-mzg@mail.gmail.com>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <b9ac025a-87ba-7693-ae4f-943702609ffc@huawei.com>
Date:   Thu, 31 Jan 2019 08:58:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAMeeMh85T_qui=LWd0u=b_oMN5XLqowqkvLuYGBM2Ae6tS-mzg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.189.120]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/30/2019 10:08 PM, John Dorminy wrote:
> Alternately, could possibly WRITE_SAME bios be accepted with the
> minimum sector size of the stack rather than the max, e.g. 512 in this
> example rather than 4k? They'd need to have a granularity of the
> larger sector size, though, presumabily necessitating new queue limits
> write_same_{granularity,block_size}, which might be too much work. For
> devices with bigger sectors, the block layer or DM would need to
> expand the small-sector payload to an appropriate larger-sector
> payload, but it would preserve the ability to use WRITE_SAME with
> non-zero payloads.
> 
> (I use WRITE_SAME to fill devices with a particular pattern in order
> to catch failures to initialize disk structures appropriately,
> personally, but it's just for convenience/speed.)
I think two LBSs will produce ambiguity.
Reference spec
	Information technology -
	SCSI Block Commands – 4 (SBC-4)
	ISO/IEC 14776-324:201x
	BSR INCITS 506:201x
5.50 WRITE SAME (10) command
The WRITE SAME (10) command (see table 145) requests that the device server
**transfer a single logical block** from the Data-Out Buffer and for each LBA in
the specified range of LBAs:




