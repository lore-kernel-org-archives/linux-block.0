Return-Path: <SRS0=urI+=4C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8785C352A3
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 02:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824C120873
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 02:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgBNCuF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:50:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727604AbgBNCuE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 21:50:04 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BBCFB3F6DC0DA78272C3;
        Fri, 14 Feb 2020 10:50:02 +0800 (CST)
Received: from [10.173.220.74] (10.173.220.74) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Feb 2020 10:50:01 +0800
Subject: Re: [PATCH] bdi: fix use-after-free for bdi device
To:     Tejun Heo <tj@kernel.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <jack@suse.cz>,
        <bvanassche@acm.org>
References: <20200211140038.146629-1-yuyufen@huawei.com>
 <b7cd6193-586b-f4e0-9a5d-cc961eafaf81@huawei.com>
 <20200212213344.GE80993@mtj.thefacebook.com>
 <fd9d78b9-1119-27cc-fa74-04cb85d4f578@huawei.com>
 <20200213034818.GE88887@mtj.thefacebook.com>
 <fa6183c5-b92c-c431-37ab-09638f890f6c@huawei.com>
 <20200213135809.GH88887@mtj.thefacebook.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <f369a99d-e794-0c1b-85cf-83b577fb0f46@huawei.com>
Date:   Fri, 14 Feb 2020 10:50:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200213135809.GH88887@mtj.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.74]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/2/13 21:58, Tejun Heo wrote:
> Hello,
> 
> On Thu, Feb 13, 2020 at 03:51:40PM +0800, Yufen Yu wrote:
>> If we destroy the device asynchronously by call_rcu(), we may need to
>> add a new member 'rcu_head' into struct backing_dev_info. Right?
> 
> Yes.
> 
>> The code may be like:
>>
>> bdi_unregister()
>> {
>> 	...
>> 	if (bdi->dev) {
>> 		...
>> 		device_get(bdi->dev);
>> 		device_unregister(bdi->dev);
>> 		bdi->dev = NULL; //XXX
>> 		bdi_get(bdi); //avoiding bdi to be freed before calling bdi_release_device
>> 		call_rcu(&bdi->rcu_head, bdi_release_device);
>> 	}
>> 		...
>> }
>>
>> bdi_release_device()
>> {
>> 	...
>> 	put_device(bdi->dev);//XXX
>> 	bdi_put(bdi);
>> }
>>
>> But, the problem is how do we get 'bdi->dev' in bdi_release_device().
>> If we do not set bdi->dev as 'NULL', re-registration bdi may cannot work well.
> 
> So, unregistering can leave ->dev along and re-registering can test
> whether it's NULL and if not put the existing one and put a new one
> there. Wouldn't that work?

Do you mean set bdi->dev as 'NULL' in call_rcu() callback function
(i.e. bdi_release_device()) and test 'bdi->dev' in bdi_register_va()?

I think that may do not work.
We cannot make sure the order of rcu callback function and re-registering.
Then bdi_release_device() may put the new allocated device by re-registering.

Thanks,
Yufen

