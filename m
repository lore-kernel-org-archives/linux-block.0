Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F71C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 12:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiCBMkP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241822AbiCBMkO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 07:40:14 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D73770326
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 04:39:30 -0800 (PST)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K7tvH4mRHz6H7bg;
        Wed,  2 Mar 2022 20:38:19 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 13:39:28 +0100
Received: from [10.47.84.129] (10.47.84.129) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 2 Mar
 2022 12:39:27 +0000
Message-ID: <43fb4f4b-0b4a-6413-0139-5f95d95944ad@huawei.com>
Date:   Wed, 2 Mar 2022 12:39:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V2 1/6] blk-mq: figure out correct numa node for hw queue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Yu Kuai <yukuai3@huawei.com>,
        "Christoph Hellwig" <hch@lst.de>
References: <20220302121407.1361401-1-ming.lei@redhat.com>
 <20220302121407.1361401-2-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220302121407.1361401-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.84.129]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/03/2022 12:14, Ming Lei wrote:
> The current code always uses default queue map and hw queue index
> for figuring out the numa node for hw queue, this way isn't correct
> because blk-mq supports three queue maps, and the correct queue map
> should be used for the specified hw queue.
> 
> Reviewed-by: Christoph Hellwig<hch@lst.de>
> Signed-off-by: Ming Lei<ming.lei@redhat.com>

FWIW:
Reviewed-by: John Garry <john.garry@huawei.com>

thanks

> ---
>   block/blk-mq.c | 36 ++++++++++++++++++++++++++++++------
>   1 file changed, 30 insertions(+), 6 deletions(-)

