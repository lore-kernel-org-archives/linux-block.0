Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2D1C433FE
	for <linux-block@archiver.kernel.org>; Wed, 18 May 2022 00:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiERAjV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 20:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiERAjU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 20:39:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBBE36E0C;
        Tue, 17 May 2022 17:39:18 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L2vGW4rrtzgYCj;
        Wed, 18 May 2022 08:37:55 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 08:39:16 +0800
Received: from [10.174.177.69] (10.174.177.69) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 18 May 2022 08:39:16 +0800
Message-ID: <356ba1b6-7979-a767-2501-0a96b653c860@huawei.com>
Date:   Wed, 18 May 2022 08:39:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v2] blk-throttle: Set BIO_THROTTLED when bio has
 been throttled
To:     Jens Axboe <axboe@kernel.dk>
CC:     <tj@kernel.org>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20220301123919.2381579-1-qiulaibin@huawei.com>
 <Yh92UQ9/bxe6EcWe@T590>
From:   QiuLaibin <qiulaibin@huawei.com>
In-Reply-To: <Yh92UQ9/bxe6EcWe@T590>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.69]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

friendly ping....

在 2022/3/2 21:51, Ming Lei 写道:
> On Tue, Mar 01, 2022 at 08:39:19PM +0800, Laibin Qiu wrote:
>> 1.In current process, all bio will set the BIO_THROTTLED flag
>> after __blk_throtl_bio().
>>
>> 2.If bio needs to be throttled, it will start the timer and
>> stop submit bio directly. Bio will submit in
>> blk_throtl_dispatch_work_fn() when the timer expires.But in
>> the current process, if bio is throttled. The BIO_THROTTLED
>> will be set to bio after timer start. If the bio has been
>> completed, it may cause use-after-free blow.
>>
>> BUG: KASAN: use-after-free in blk_throtl_bio+0x12f0/0x2c70
>> Read of size 2 at addr ffff88801b8902d4 by task fio/26380
> 
> After the queue lock is released, the bio can be dispatched & completed,
> so it shouldn't be touched after lock release:
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
> Thanks,
> Ming
> 
> .
