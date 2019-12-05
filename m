Return-Path: <SRS0=S578=Z3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64653C43603
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 10:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C6324654
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 10:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfLEKI7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:08:59 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728991AbfLEKI7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Dec 2019 05:08:59 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id C1262334311276191A39;
        Thu,  5 Dec 2019 10:08:57 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 5 Dec 2019 10:08:57 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Thu, 5 Dec 2019
 10:08:57 +0000
Subject: Re: [PATCH] block: fix memleak of bio integrity data
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Justin Tee <justin.tee@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20191205020901.18737-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <94d1d847-c2f5-f0ed-fcd3-a6a30ad1962b@huawei.com>
Date:   Thu, 5 Dec 2019 10:08:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191205020901.18737-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/12/2019 02:09, Ming Lei wrote:
> From: Justin Tee <justin.tee@broadcom.com>
> 
> 7c20f11680a4 ("bio-integrity: stop abusing bi_end_io") moves
> bio_integrity_free from bio_uninit() to bio_integrity_verify_fn()
> and bio_endio(). This way looks wrong because bio may be freed
> without calling bio_endio(), for example, blk_rq_unprep_clone() is
> called from dm_mq_queue_rq() when the underlying queue of dm-mpath
> is busy.
> 
> So memory leak of bio integrity data is caused by commit 7c20f11680a4.
> 
> Fixes this issue by re-adding bio_integrity_free() to bio_uninit().
> 
> Fixes: 7c20f11680a4 ("bio-integrity: stop abusing bi_end_io")
> Cc: Justin Tee <justin.tee@broadcom.com>
> Cc: Christoph Hellwig <hch@lst.de>
> 
> Add commit log, and simplify/fix the original patch wroten by Justin.

written

> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Don't forget the author SoB...

> ---
>   block/bio-integrity.c | 2 +-
