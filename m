Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3AEC54EBD
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 02:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjAIC1l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Jan 2023 21:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjAIC1k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Jan 2023 21:27:40 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8939FCE;
        Sun,  8 Jan 2023 18:27:38 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NqyX50sFvz4f3v57;
        Mon,  9 Jan 2023 10:27:33 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgBnDeuWe7tj6+BkBQ--.41045S2;
        Mon, 09 Jan 2023 10:27:35 +0800 (CST)
Subject: Re: [PATCH v2 08/13] blk-mq: simplify flush check in
 blk_mq_dispatch_rq_list
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
References: <20230104142259.2673013-1-shikemeng@huaweicloud.com>
 <20230104142259.2673013-9-shikemeng@huaweicloud.com>
 <20230108180611.GG23466@lst.de>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <86677943-1c5e-370f-ba69-25e10738b67b@huaweicloud.com>
Date:   Mon, 9 Jan 2023 10:27:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230108180611.GG23466@lst.de>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgBnDeuWe7tj6+BkBQ--.41045S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4DKFy3WF48trW8Xr47Jwb_yoWftrbE9F
        1Fk3Z7Kw4UG3Wqqa1UKFnYqFs8KFyUCF95Aa1ktFZag34kW3Z3JF1DGr15Za13GFZxKr1q
        gr4rWa4Fyw4qyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi, Christoph, thank you so much for review.
on 1/9/2023 2:06 AM, Christoph Hellwig wrote:
> I think we need to come up with a clear rule on when commit_rqs
> needs to be called, and follow that.  In this case I'd be confused
> if there was any case where we need to call it if list was empty.
> 
After we queue request[s] to one driver queue, we need to notify driver
that there are no more request to the queue or driver will keep waiting
for the last request to be queued and IO hung could happen.
Normaly, we will notify this by setting .last in struct blk_mq_queue_data
along with the normal last request .rq in struct blk_mq_queue_data. The
extra commit is only needed if normal last information in .last is lost.
(See comment in struct blk_mq_ops for commit_rqs).

The lost could occur if error happens for sending last request with .last
set or error happen in middle of list and we even do not send the request
with .last set.

-- 
Best wishes
Kemeng Shi

