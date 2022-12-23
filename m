Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A08C4332F
	for <linux-block@archiver.kernel.org>; Fri, 23 Dec 2022 06:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiLWGi6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Dec 2022 01:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiLWGi6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Dec 2022 01:38:58 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725971BEB4;
        Thu, 22 Dec 2022 22:38:56 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ndcvr5qkYz4f3nqX;
        Fri, 23 Dec 2022 14:38:48 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgBH8yD6TKVjMP5SAQ--.29845S2;
        Fri, 23 Dec 2022 14:38:51 +0800 (CST)
Subject: Re: [PATCH 01/13] blk-mq: avoid sleep in blk_mq_alloc_request_hctx
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com
References: <20221223125223.1687670-1-shikemeng@huaweicloud.com>
 <20221223125223.1687670-2-shikemeng@huaweicloud.com>
 <20221223053718.GA2676@lst.de>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <fd69227c-1350-c8fa-8231-5ca230cd2c43@huaweicloud.com>
Date:   Fri, 23 Dec 2022 14:38:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20221223053718.GA2676@lst.de>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgBH8yD6TKVjMP5SAQ--.29845S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYj7kC6x804xWl14x267AKxVW8JVW5JwAF
        c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVW8JVWx
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJ
        UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Christoph.
on 12/23/2022 1:37 PM, Christoph Hellwig wrote:
> On Fri, Dec 23, 2022 at 08:52:11PM +0800, Kemeng Shi wrote:
>> +	if (WARN_ON_ONCE(((!flags) & (BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED))))
> 
> This check does not make any sense.  I think what you want is
> 
> 	if (WARN_ON_ONCE(!(flags & BLK_MQ_REQ_NOWAIT) ||
> 	    WARN_ON_ONCE(!(flags & BLK_MQ_REQ_RESERVED))))
This is exactly what I want and I will fix this in next version. Thanks.

-- 
Best wishes
Kemeng Shi

