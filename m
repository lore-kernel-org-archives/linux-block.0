Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F11C636CC
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 14:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjBHONV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 09:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjBHONK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 09:13:10 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F7B4616A
        for <linux-block@vger.kernel.org>; Wed,  8 Feb 2023 06:13:08 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PBhmG0qWHz4f3jMK
        for <linux-block@vger.kernel.org>; Wed,  8 Feb 2023 22:13:02 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgA35CHureNjbODRCw--.955S3;
        Wed, 08 Feb 2023 22:13:04 +0800 (CST)
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
To:     Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221130175653.24299-1-jack@suse.cz>
 <ada13b1b-dd2a-8be0-3b12-3470a086bbf6@huaweicloud.com>
 <Y9kiltmuPSbRRLsO@infradead.org>
 <92d53d6b-f83d-0767-4f6a-1b897b33b227@huaweicloud.com>
 <Y9oFHssFz2obv83W@infradead.org>
 <1901c3f0-da34-1df1-2443-3426282a6ecb@huaweicloud.com>
 <1b5d3502-353d-8674-cd5d-79283fa8905d@huaweicloud.com>
 <20230208120258.64yhqho252gaydmu@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <02e769f7-9a41-80bc-4e47-fa87c18a36b2@huaweicloud.com>
Date:   Wed, 8 Feb 2023 22:13:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230208120258.64yhqho252gaydmu@quack3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgA35CHureNjbODRCw--.955S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW7uw4fKFWfZryUCry3Jwb_yoW8AFWUpa
        yrXFW3JFWDWryfuayUJ3WxGw15CrsrZry8JF1rG34Iyws8X395KF1Skaykua48W3ykW3y7
        XF4Uua4vgF1rZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2023/02/08 20:02, Jan Kara 写道:
> 
> After some thought I don't like opencoding blkdev_get_by_dev() in disk_scan
> partitions. But I agree Christoph's approach with blkdev_get_whole() does
> not quite work either. We could propagate holder/owner into
> blkdev_get_whole() to fix Christoph's check but still we are left with a
> question what to do with GD_NEED_PART_SCAN set bit when we get into
> blkdev_get_whole() and find out we are not elligible to rescan partitions.
> Because then some exclusive opener later might be caught by surprise when
> the partition rescan happens due to this bit being set from the past failed
> attempt to rescan.
> 
> So what we could do is play a similar trick as we do in the loop device and
> do in disk_scan_partitions():
> 
> 	/*
> 	 * If we don't hold exclusive handle for the device, upgrade to it
> 	 * here to avoid changing partitions under exclusive owner.
> 	 */
> 	if (!(mode & FMODE_EXCL)) {
This is not necessary, all the caller make sure FMODE_EXCL is not set.

> 		error = bd_prepare_to_claim(disk->part0, disk_scan_partitions);
> 		if (error)
> 			return error;
> 	}
 From what I see, if thread open device excl first, and then call ioctl()
to reread partition, this will cause this ioctl() to fail?

> 	set_bit(GD_NEED_PART_SCAN, &disk->state);
> 	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL);
> 	if (IS_ERR(bdev)) {
> 		error = PTR_ERR(bdev);
> 		goto abort;
> 	}
> 	blkdev_put(bdev, mode & ~FMODE_EXCL);
> 	error = 0;
> abort:
> 	if (!(mode & FMODE_EXCL))
> 		bd_abort_claiming(disk->part0, disk_scan_partitions);
> 	return error;
> 
> So esentially we'll temporarily block any exlusive openers by claiming the
> bdev while we set the GD_NEED_PART_SCAN and force partition rescan. What do
> you think?
> 
> 								Honza
> 

