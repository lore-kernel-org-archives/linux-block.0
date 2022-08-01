Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DB2C00144
	for <linux-block@archiver.kernel.org>; Mon,  1 Aug 2022 03:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbiHAD3S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jul 2022 23:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiHAD3R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jul 2022 23:29:17 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AF8101F8
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 20:29:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VL.5hTq_1659324552;
Received: from 30.15.222.160(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VL.5hTq_1659324552)
          by smtp.aliyun-inc.com;
          Mon, 01 Aug 2022 11:29:13 +0800
Message-ID: <807e39e2-1124-2437-9576-082c27c95512@linux.alibaba.com>
Date:   Mon, 1 Aug 2022 11:29:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH V4 0/2] ublk: add support for UBLK_IO_NEED_GET_DATA
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        Ming Lei <ming.lei@redhat.com>
References: <cover.1659011443.git.ZiyangZhang@linux.alibaba.com>
 <4c6f7d83-183a-da98-a41a-5363db6f3297@linux.alibaba.com>
 <Yuc3dq50YoU3CVzP@T590> <70d3dc55-a877-c4c9-cafc-feebf150fbb7@kernel.dk>
 <19236388-4ee0-28ee-c2f8-7fe88f445872@kernel.dk>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <19236388-4ee0-28ee-c2f8-7fe88f445872@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/8/1 10:48, Jens Axboe wrote:
> On 7/31/22 8:43 PM, Jens Axboe wrote:
>> On 7/31/22 8:16 PM, Ming Lei wrote:
>>> On Sun, Jul 31, 2022 at 04:03:30PM +0800, Ziyang Zhang wrote:
>>>> Hi Jens,
>>>>
>>>> Please queue this patchset up for the 5.20 merge window.
>>>>
>>>> UBLK_IO_NEED_GET_DATA is an important feature designed for Ming Lei's
>>>> ublk_drv. All the patches have been reviewed by Ming and all test cases
>>>> in his ublksrv[1] have been passed.
>>>
>>> Hi Jens,
>>>
>>> This feature is helpful for existed projects to switch to ublk from similar
>>> tech, so IMO the change makes sense.
>>
>> Can we get this resent against for-5.20/block? It doesn't apply anymore.
>> Then we can still make the next release.
> 
> Turns it out was just a trivial reject, I fixed it up.

Thanks for queuing it up.

Regards,
Ziyang Zhang
