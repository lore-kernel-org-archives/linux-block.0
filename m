Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDCAC433DF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 06:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6190F2076A
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 06:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgFHGoF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:44:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43376 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728334AbgFHGoF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Jun 2020 02:44:05 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 28BD040B08E9AF0A973B;
        Mon,  8 Jun 2020 14:44:02 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.7) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Jun 2020
 14:43:53 +0800
Subject: Re: [PATCH v4] block: Fix use-after-free in blkdev_get()
To:     Christoph Hellwig <hch@lst.de>
CC:     <viro@zeniv.linux.org.uk>, <axboe@kernel.dk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>, Hulk Robot <hulkci@huawei.com>
References: <20200608020557.31668-1-yanaijie@huawei.com>
 <20200608061502.GB17366@lst.de>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <0f43671d-c583-e5ec-f0a3-a919d300301f@huawei.com>
Date:   Mon, 8 Jun 2020 14:43:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200608061502.GB17366@lst.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.7]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

ÔÚ 2020/6/8 14:15, Christoph Hellwig Ð´µÀ:
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Can you dig into the history for a proper fixes tag?
> 

This one started to accessing bdev after __blkdev_get(). So I think it 
may be a proper fixes tag:

Fixes: e525fd89d380 ("block: make blkdev_get/put() handle exclusive access")

Thanks,
Jason

> .
> 

