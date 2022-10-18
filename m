Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2DEC4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 08:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJRIkz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 04:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJRIkq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 04:40:46 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E095CA030E
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 01:40:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ms6gn4N93zKG6n
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 16:37:57 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3PS5xZk5jVJwuAA--.47719S3;
        Tue, 18 Oct 2022 16:40:19 +0800 (CST)
Subject: Re: [PATCH 2/2] block: clear the holder releated fields on late
 disk_add failure
To:     Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221018073822.646207-1-hch@lst.de>
 <20221018073822.646207-2-hch@lst.de>
 <8c5359e3-39ee-d363-9425-0cb8b716dcb0@huaweicloud.com>
 <20221018082651.GA26079@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4c5acbb5-72e6-3f63-2e78-478d3230aa0c@huaweicloud.com>
Date:   Tue, 18 Oct 2022 16:40:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221018082651.GA26079@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3PS5xZk5jVJwuAA--.47719S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4xWrW3Wr4UXrWrKFW8Xrb_yoWkAFb_uF
        yrA3yvgw42k3W3Ka1qqF15urW7tr1jvrWUZFZ7JanxGryUXFW3GFy7Zr15AF4xGrsIk3s8
        Cr15Ka4Y9rsrZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

ÔÚ 2022/10/18 16:26, Christoph Hellwig Ð´µÀ:
> On Tue, Oct 18, 2022 at 04:00:36PM +0800, Yu Kuai wrote:
>> 1) in del_gendisk: (add a new api kobject_put_and_test)
>>
>> if (kobject_put_and_test(bd_holder_dir/slave_dir))
>> 	bd_holder_dir/slave_dir = NULL;
>>
>> 2) in bd_link_disk_holder, get bd_holder_dir first:
>>
>> if (!kobject_get_unless_zero(bd_holder_dir))
>> 	return -ENODEV;
>> ...
>> bd_find_holder_disk()
>>
>> Do you think this is ok?
> 
> I'm not quite sure what the point is.
> 

Because I'm afraid bd_link_disk_holder() just take bdev as paramater,
(bdev is got by blkdev_get_by_dev), but there is no guarantee that disk
can't be remove(del_gendisk is called for the disk that bdev belongs
to).

Thus I think the interface bd_link_disk_holder() itself is problematic,
current caller drbd/md/dm might all be affected.

Thanks,
Kuai
> If you want to really clean this up a good thing would be to remove
> the delayed holder registration entirely and just do them in dm
> after add_disk and remove them before del_gendisk.  I've been wanting
> to do that a few times but always gave up due to the mess in dm.
> 
> .
> 

