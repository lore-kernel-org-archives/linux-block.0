Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECD4C67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 13:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ACD23C96
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 13:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8ACD23C96
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbeLNNUf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:20:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43512 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729706AbeLNNUf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 08:20:35 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 34C346958C538;
        Fri, 14 Dec 2018 21:20:32 +0800 (CST)
Received: from [127.0.0.1] (10.210.169.251) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Fri, 14 Dec 2018
 21:20:24 +0800
Subject: Re: Question on t10_pi_ref_tag()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <0336fcc8-cfc5-ab51-b2cd-3ad6b971cc8a@huawei.com>
 <yq11s6kmg7w.fsf@oracle.com>
CC:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6ad7bd5d-6cbd-aab1-bc83-a0298a887010@huawei.com>
Date:   Fri, 14 Dec 2018 13:20:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <yq11s6kmg7w.fsf@oracle.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.251]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14/12/2018 12:43, Martin K. Petersen wrote:
>
> John,
>
>> What would we be missing that this is unset?
>
> 60a89a3ce0cc scsi: t10-pi: Return correct ref tag when queue has no integrity profile
>
Hi Martin,

D'oh, we actually reported the issue related to this patch. But it's not 
in your 4.21 queue which we were testing.

Thanks,
John

