Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEC7C04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 02:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbiG1C54 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 22:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiG1C5z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 22:57:55 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD6658B7A
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 19:57:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VKdQCTP_1658977068;
Received: from 30.227.93.214(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VKdQCTP_1658977068)
          by smtp.aliyun-inc.com;
          Thu, 28 Jul 2022 10:57:49 +0800
Message-ID: <21ba242e-c936-f1c1-1d9e-1cdaddcbfd31@linux.alibaba.com>
Date:   Thu, 28 Jul 2022 10:57:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH V2 1/5] ublk_drv: avoid to leak ublk device in case that
 add_disk fails
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20220727141628.985429-1-ming.lei@redhat.com>
 <20220727141628.985429-2-ming.lei@redhat.com> <20220727162132.GA18969@lst.de>
 <YuHV11N1A45xwxyT@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <YuHV11N1A45xwxyT@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/7/28 08:18, Ming Lei wrote:
> On Wed, Jul 27, 2022 at 06:21:32PM +0200, Christoph Hellwig wrote:
>> maybe s/avoid/don't/ in the subject?
> 
> OK, will change in V3.
> 
>>
>>> -	get_device(&ub->cdev_dev);
>>>  	ret = add_disk(disk);
>>>  	if (ret) {
>>>  		put_disk(disk);
>>>  		goto out_unlock;
>>
>> Maybe just add a put_device here in the error branch to keep
>> things simple?
> 
> That is fine.
> 
> Another way is to add 'out_put_disk' error label which can be
> reused with previous error handling.

+1, adding another error label looks clear and simple.
