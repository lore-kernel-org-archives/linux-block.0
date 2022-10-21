Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73428C433FE
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 03:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJUDM6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 23:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJUDMj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 23:12:39 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C4E1D93E0
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 20:12:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MtqFh5Dr4zKJb5
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 11:09:44 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCX0DAHDlJj11m4AA--.38184S3;
        Fri, 21 Oct 2022 11:12:08 +0800 (CST)
Subject: Re: [PATCH 1/6] block: clear the holder releated fields when deleting
 the kobjects
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20221020164605.1764830-1-hch@lst.de>
 <20221020164605.1764830-2-hch@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <cc7d4e79-a14d-1183-09a2-337052321e3e@huaweicloud.com>
Date:   Fri, 21 Oct 2022 11:12:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221020164605.1764830-2-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX0DAHDlJj11m4AA--.38184S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr47Zr4rKFyfGr1rXrWfGrg_yoW8Ar1UpF
        Z8uFsxW3yvkr4qga17Ja17XFyUGa98Wa4fXFySqryIqrnxXr1jvwsrtrWxWF17ur4kKw4q
        vF15XasxAF4vkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Christoph

ÔÚ 2022/10/21 0:46, Christoph Hellwig Ð´µÀ:
> Zero out the pointers to the holder related kobjects so that the holder
> code doesn't incorrectly when called by dm for the delayed holder
> registration.
> 
> Fixes: 89f871af1b26 ("dm: delay registering the gendisk")
> Reported-by: Yu Kuai <yukuai1@huaweicloud.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/genhd.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 17b33c62423df..cd90df6c775c2 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -528,8 +528,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>   	blk_unregister_queue(disk);
>   out_put_slave_dir:
>   	kobject_put(disk->slave_dir);
> +	disk->slave_dir = NULL;
>   out_put_holder_dir:
>   	kobject_put(disk->part0->bd_holder_dir);
> +	disk->part0->bd_holder_dir = NULL;
>   out_del_integrity:
>   	blk_integrity_del(disk);
>   out_del_block_link:
> @@ -623,7 +625,9 @@ void del_gendisk(struct gendisk *disk)
>   	blk_unregister_queue(disk);
>   
>   	kobject_put(disk->part0->bd_holder_dir);
> +	disk->part0->bd_holder_dir = NULL;

I don't think this is enough. There is still no guarantee that
bd_link_disk_holder() won't access freed bd_holder_dir. It's still
possible that bd_link_disk_holer() read bd_holder_dir first, and then
del_gendisk() free and reset it.

By the way, I still think that the problem for the bd_holder_dir uaf is
not just related to dm.

Thanks,
Kuai

>   	kobject_put(disk->slave_dir);
> +	disk->slave_dir = NULL;
>   
>   	part_stat_set_all(disk->part0, 0);
>   	disk->part0->bd_stamp = 0;
> 

