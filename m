Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFD3C2BA83
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 07:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA70821734
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 07:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgBMHvq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:51:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729383AbgBMHvq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 02:51:46 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 91ECADF154BA53207527;
        Thu, 13 Feb 2020 15:51:44 +0800 (CST)
Received: from [10.173.220.74] (10.173.220.74) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Feb 2020 15:51:40 +0800
Subject: Re: [PATCH] bdi: fix use-after-free for bdi device
To:     Tejun Heo <tj@kernel.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <jack@suse.cz>,
        <bvanassche@acm.org>
References: <20200211140038.146629-1-yuyufen@huawei.com>
 <b7cd6193-586b-f4e0-9a5d-cc961eafaf81@huawei.com>
 <20200212213344.GE80993@mtj.thefacebook.com>
 <fd9d78b9-1119-27cc-fa74-04cb85d4f578@huawei.com>
 <20200213034818.GE88887@mtj.thefacebook.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <fa6183c5-b92c-c431-37ab-09638f890f6c@huawei.com>
Date:   Thu, 13 Feb 2020 15:51:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200213034818.GE88887@mtj.thefacebook.com>
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

On 2020/2/13 11:48, Tejun Heo wrote:
> Hello,
> 
> On Thu, Feb 13, 2020 at 10:46:34AM +0800, Yufen Yu wrote:
>> For each time of register, bdi_register() will try to create a new 'dev'.
>>
>> bdi_register
>>      bdi_register_va
>>          if (bdi->dev) // if bdi->dev is not NULL, return directly
>>              return 0;
>>          dev = device_create_vargs()...
>>
>> So, I think freeing bdi->dev until bdi itself does may be a problem
>> for drivers that supported re-registration bdi, such as:
> 
> Ugh, thanks for noticing that. I guess the right thing to do is then
> going full RCU. What do you think about expanding your previous patch
> so that ->dev has __rcu annotation, users use the RCU accessors and
> the device is destroyed asynchronously through call_rcu()?
> 

If we destroy the device asynchronously by call_rcu(), we may need to
add a new member 'rcu_head' into struct backing_dev_info. Right?
The code may be like:

bdi_unregister()
{
	...
	if (bdi->dev) {
		...
		device_get(bdi->dev);
		device_unregister(bdi->dev);
		bdi->dev = NULL; //XXX
		bdi_get(bdi); //avoiding bdi to be freed before calling bdi_release_device
		call_rcu(&bdi->rcu_head, bdi_release_device);
	}
		...
}

bdi_release_device()
{
	...
	put_device(bdi->dev);//XXX
	bdi_put(bdi);
}

But, the problem is how do we get 'bdi->dev' in bdi_release_device().
If we do not set bdi->dev as 'NULL', re-registration bdi may cannot work well.

If I get it wrong, please point it out.

Thanks
Yufen
