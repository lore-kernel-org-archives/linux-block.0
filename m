Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6A1EB64D9
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 12:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjGJMcb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 08:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGJMca (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 08:32:30 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60839B1
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 05:32:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R03L01LdZz4f3kp0
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 20:32:24 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7NV+qtkgNCZNg--.52198S3;
        Mon, 10 Jul 2023 20:32:24 +0800 (CST)
Message-ID: <ace0451f-b979-be13-cf47-a8cb3656c72e@huaweicloud.com>
Date:   Mon, 10 Jul 2023 20:32:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/4] brd: enable discard
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2209201358120.26535@file01.intranet.prod.int.rdu2.redhat.com>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <alpine.LRH.2.02.2209201358120.26535@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgCnD7NV+qtkgNCZNg--.52198S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVW8JVW5JwAF
        c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr
        0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxG
        rwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
        VjvjDU0xZFpf9x07UCXd8UUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Mikulas

The lack of discard in ramdisk can cause some issues related to dm. see:
https://lore.kernel.org/all/20220228141354.1091687-1-luomeng12@huawei.com/

I noticed that your patch series has already supported discard for brd. 
But this patch series has not been applied to mainline at present, may I 
ask if you still plan to continue working on it?

-- 
Thanks,
Nan

