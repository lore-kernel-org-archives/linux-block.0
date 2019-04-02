Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D90EC4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 14:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456C220857
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 14:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfDBOeg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:34:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbfDBOeg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Apr 2019 10:34:36 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [10.3.19.212])
        by Forcepoint Email with ESMTP id 81619F80B93A12F77944;
        Tue,  2 Apr 2019 22:34:33 +0800 (CST)
Received: from [127.0.0.1] (10.177.219.49) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Tue, 2 Apr 2019
 22:34:27 +0800
Subject: Re: [PATCH] blk-mq: add trace block plug and unplug for multiple
 queues
To:     Christoph Hellwig <hch@lst.de>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <osandov@fb.com>,
        <ming.lei@redhat.com>
References: <20190326131925.60255-1-yuyufen@huawei.com>
 <20190327081356.GD20525@lst.de>
From:   yuyufen <yuyufen@huawei.com>
Message-ID: <3a1014e9-72eb-60e3-3633-82579e82c7e8@huawei.com>
Date:   Tue, 2 Apr 2019 22:34:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190327081356.GD20525@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping ?


On 2019/3/27 16:13, Christoph Hellwig wrote:
> On Tue, Mar 26, 2019 at 09:19:25PM +0800, Yufen Yu wrote:
>> For now, we just trace plug for single queue device or drivers
>> provide .commit_rqs, and have not trace plug for multiple queues
>> device. But, unplug events will be recorded when call
>> blk_mq_flush_plug_list(). Then, trace events will be asymmetrical,
>> just have unplug and without plug.
>>
>> This patch add trace plug and unplug for multiple queues device in
>> blk_mq_make_request(). After that, we can accurately trace plug and
>> unplug for multiple queues.
>>
>> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> .
>


