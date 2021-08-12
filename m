Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC519C4338F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 09:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DD461038
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 09:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbhHLJlI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 05:41:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3641 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbhHLJlH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 05:41:07 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GlhVq4DZvz6GB7n;
        Thu, 12 Aug 2021 17:40:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 12 Aug 2021 11:40:41 +0200
Received: from [10.47.80.186] (10.47.80.186) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 12 Aug
 2021 10:40:40 +0100
Subject: Re: [PATCH V2] blk-mq: don't grab rq's refcount in
 blk_mq_check_expired()
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Keith Busch <kbusch@kernel.org>
References: <20210811155202.629575-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5c6060a9-9fdf-403c-7f7b-74b7528aaf85@huawei.com>
Date:   Thu, 12 Aug 2021 10:40:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210811155202.629575-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.186]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/08/2021 16:52, Ming Lei wrote:
> Inside blk_mq_queue_tag_busy_iter() we already grabbed request's
> refcount before calling ->fn(), so needn't to grab it one more time
> in blk_mq_check_expired().
> 
> Meantime remove extra request expire check in blk_mq_check_expired().
> 
> Cc: Keith Busch<kbusch@kernel.org>
> Signed-off-by: Ming Lei<ming.lei@redhat.com>

Reviewed-by: John Garry <john.garry@huawei.com>
