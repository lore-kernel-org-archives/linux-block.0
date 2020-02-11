Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B898C352A3
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 13:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0071024672
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 13:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgBKN5z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:57:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729996AbgBKN5w (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 08:57:52 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BE598280D4FDEA4C0563;
        Tue, 11 Feb 2020 21:57:47 +0800 (CST)
Received: from [10.173.220.74] (10.173.220.74) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Tue, 11 Feb 2020 21:57:44 +0800
Subject: Re: [PATCH] bdi: fix use-after-free for bdi device
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <jack@suse.cz>, <bvanassche@acm.org>, <tj@kernel.org>
References: <20200211140038.146629-1-yuyufen@huawei.com>
Message-ID: <b7cd6193-586b-f4e0-9a5d-cc961eafaf81@huawei.com>
Date:   Tue, 11 Feb 2020 21:57:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200211140038.146629-1-yuyufen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.74]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> __blkg_prfill_rwstat() tries to get the device name by
> 'bdi->dev', while the 'dev' has been freed by bdi_unregister().
> Then, blkg_dev_name() will return an invalid name pointer,
> resulting in crash on string(). The race as following:
> 
> CPU1                          CPU2
> blkg_print_stat_bytes
>                                __scsi_remove_device
>                                del_gendisk
>                                  bdi_unregister
> 
>                                  put_device(bdi->dev)
>                                    kfree(bdi->dev)
> __blkg_prfill_rwstat
>    blkg_dev_name
>      //use the freed bdi->dev
>      dev_name(blkg->q->backing_dev_info->dev)
>                                  bdi->dev = NULL
> 

There is another simple way to fix the problem.

Since blkg_dev_name() have been coverd by rcu_read_lock/unlock(),
we can wait all rcu reader to finish before free 'bdi->dev' to avoid use-after-free.

But I am not sure if this solution will introduce new problems.


diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 62f05f605fb5..6f322473ca4d 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1007,15 +1007,19 @@ static void bdi_remove_from_list(struct backing_dev_info *bdi)

  void bdi_unregister(struct backing_dev_info *bdi)
  {
+       struct device *dev = bdi->dev;
         /* make sure nobody finds us on the bdi_list anymore */
         bdi_remove_from_list(bdi);
         wb_shutdown(&bdi->wb);
         cgwb_bdi_unregister(bdi);

-       if (bdi->dev) {
+       if (dev) {
                 bdi_debug_unregister(bdi);
-               device_unregister(bdi->dev);
                 bdi->dev = NULL;
+               device_del(dev);
+               /* wait all rcu reader of bdi->dev before free dev */
+               synchronize_rcu();
+               put_device(dev);
         }

         if (bdi->owner) {
