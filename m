Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8820EC3B188
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 02:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F58624677
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 02:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgBMCqk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:46:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9727 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729527AbgBMCqk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 21:46:40 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 150E3A4D3ED86482C0CF;
        Thu, 13 Feb 2020 10:46:39 +0800 (CST)
Received: from [10.173.220.74] (10.173.220.74) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Feb 2020 10:46:34 +0800
Subject: Re: [PATCH] bdi: fix use-after-free for bdi device
To:     Tejun Heo <tj@kernel.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <jack@suse.cz>,
        <bvanassche@acm.org>
References: <20200211140038.146629-1-yuyufen@huawei.com>
 <b7cd6193-586b-f4e0-9a5d-cc961eafaf81@huawei.com>
 <20200212213344.GE80993@mtj.thefacebook.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <fd9d78b9-1119-27cc-fa74-04cb85d4f578@huawei.com>
Date:   Thu, 13 Feb 2020 10:46:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200212213344.GE80993@mtj.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.74]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2020/2/13 5:33, Tejun Heo wrote:

> So, I don't see why bdi->dev should be freed before bdi itself does.
> Would something like the following work?
> 
> bdi_unregister()
> {
>          ...
>          if (bdi->dev) {
>                  ...
>                  device_get(bdi->dev);   // to be put on release
>                  device_unregister(bdi->dev);
>          }
>          ...
> }
> 
> release_bdi()
> {
>          ...
>          if (bdi->dev) {
>                  // warn if dev is still registered
>                  device_put(bdi->dev);
>          }
>          ...
> }

For each time of register, bdi_register() will try to create a new 'dev'.

bdi_register
     bdi_register_va
         if (bdi->dev) // if bdi->dev is not NULL, return directly
             return 0;
         dev = device_create_vargs()...

So, I think freeing bdi->dev until bdi itself does may be a problem
for drivers that supported re-registration bdi, such as:

commit b6f8fec4448aa52a8c36a392aa1ca2ea99acd460
Author: Jan Kara <jack@suse.cz>
Date:   Wed Mar 8 17:48:31 2017 +0100

     block: Allow bdi re-registration

     SCSI can call device_add_disk() several times for one request queue when
     a device in unbound and bound, creating new gendisk each time. This will
     lead to bdi being repeatedly registered and unregistered.




