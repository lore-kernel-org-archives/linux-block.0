Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3BEC433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 03:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F8C64E3F
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 03:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhCSDDn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 23:03:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13201 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhCSDDa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 23:03:30 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F1pYq53xhzmZRG;
        Fri, 19 Mar 2021 11:01:03 +0800 (CST)
Received: from [10.174.179.92] (10.174.179.92) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Mar 2021 11:03:28 +0800
Subject: Re: [PATCH] block: do not copy data to user when bi_status is error
To:     Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
CC:     <axboe@kernel.dk>, <hch@lst.de>, <keescook@chromium.org>,
        <linux-block@vger.kernel.org>
References: <20210318122621.330010-1-yanaijie@huawei.com>
 <20210318151305.GB31228@redsun51.ssa.fujisawa.hgst.com>
 <YFQAKIjt5VzUNYDe@T590>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <dbd546df-c520-746b-9e66-9946936c27d4@huawei.com>
Date:   Fri, 19 Mar 2021 11:03:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <YFQAKIjt5VzUNYDe@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.92]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


ÔÚ 2021/3/19 9:36, Ming Lei Ð´µÀ:
> On Fri, Mar 19, 2021 at 12:13:05AM +0900, Keith Busch wrote:
>> On Thu, Mar 18, 2021 at 08:26:21PM +0800, Jason Yan wrote:
>>> When the user submitted a request with unaligned buffer, we will
>>> allocate a new page and try to copy data to or from the new page.
>>> If it is a reading request, we always copy back the data to user's
>>> buffer, whether the result is good or error. So if the driver or
>>> hardware returns an error, garbage data is copied to the user space.
>>> This is a potential security issue which makes kernel info leaks.
>>>
>>> So do not copy the uninitalized data to user's buffer if the
>>> bio->bi_status is not BLK_STS_OK in bio_copy_kern_endio_read().
>>
>> If we're using copy_kern routines, doesn't that mean it's a kernel
>> request rather than user space?
> 
> It can be a kernel bounce buffer, which will be copied to user space
> later, such as sg_scsi_ioctl(), but sg_scsi_ioctl() checks the request
> result and not copy kernel buffer back in case of error.
> 
> Seems other cases are all kernel request.
> 

Hi Ming & Keith,

Actually in sg_scsi_ioctl() it is still a problem. And the garbage data 
is bad both for user space and kernel space.

Please check this:
https://patchwork.kernel.org/project/linux-block/patch/20210319030128.1345061-3-yanaijie@huawei.com/
https://patchwork.kernel.org/project/linux-block/patch/20210319030128.1345061-2-yanaijie@huawei.com/
