Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4A6ECAAD1
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 02:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiIACrn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 22:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiIACrm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 22:47:42 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69FB637C;
        Wed, 31 Aug 2022 19:47:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VNuYYTO_1662000457;
Received: from 30.97.56.214(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VNuYYTO_1662000457)
          by smtp.aliyun-inc.com;
          Thu, 01 Sep 2022 10:47:38 +0800
Message-ID: <2fc49714-695b-a4df-509e-5fe61c642918@linux.alibaba.com>
Date:   Thu, 1 Sep 2022 10:47:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] Docs: ublk: add ublk document
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
References: <20220828045003.537131-1-ming.lei@redhat.com>
 <Yw4rcz23R3ofn6H6@fedora>
 <e9df4ed8-a0ea-661f-9947-b18fa1d2145f@linux.alibaba.com>
 <YxAMDBCOshzQqSfq@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <YxAMDBCOshzQqSfq@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/9/1 09:34, Ming Lei wrote:
> 
>>      This makes existing backend very hard to adapt to ublk because they may
>>      want to know the data length or other attributes of the new request.
> 
> It is just for existing project.

Existing project is very important. I believe that embedding libublksrv/UAPI
into existing projects(products) makes ublk more popular and useful.

> 
> Any new project can read the data from the pre-allocated buffer
> directly. That is exactly the handling flow: ublksrv gets one request from
> ublk driver, then let backend handle the request.

Your are correct, Ming. ublksrv tgts does not need UBLK_IO_NEED_GET_DATA.

> 
>>
>> (2) If the backend does not provide the data buffer IN ADVANCE, ublksrv must
>>     pre-allocates data buffer. So a additional data copy from ublksrv to
>>     the backend(such as a RPC mempool) is unavoidable.
> 
> Can you explain why backend can't use the pre-allocated buffer directly? Before
> backend completes the io request, the io request and buffer won't be reused, that
> is owned by this tag/slot.

For existing projects using ublksrv, why it must use ublksrv's pre-allocated buffer?
The backend has its own buffer management.

Besides, existing projects may directly embed libublksrv/UAPI into it.
UBLK_IO_NEED_GET_DATA is just an option for them.

Ming, UBLK_IO_NEED_GET_DATA usecases has been proved useful and we have discussed
it when I introduced it into kernel driver. Really (1)users use ublksrv directly
or (2)developers implement new ublksrv targets do not have to care about it.

> 
>>
>> With UBLK_IO_NEED_GET_DATA, the WRITE request will be firstly issued to ublksrv
>> without data copy. Then, backend gets the request and it can allocate data
>> buffer and embed its addr inside a new ioucmd. After the kernel driver gets the
>> ioucmd, the data copy happens(from biovecs to backend's buffer). Finally,
>> the backend gets the request again with data to be written and it can truly
>> handle the request.
> 
> That is definitely inefficient, and I won't encourage any new project to
> use this command.

UBLK_IO_NEED_GET_DATA is an option. Any user thinks that it may lower performance
should not use it.

BTW, our tests shows that UBLK_IO_NEED_GET_DATA add one additional
round-trip in ublk_drv and one io_uring_enter() syscall.

UBLK_IO_NEED_GET_DATA does not lower the IOPS too much if:
(1) iodepth is bigger. This is because io_uring batches sqes(ioucmds) so the
    syscall overhead is not significant.
(2) the backend is slow. For example, with a network(RPC) backend, we really
    do not care this round-trip since the backend IO handling
    is far slower than ublk_drv's data path.

In conclusion, UBLK_IO_NEED_GET_DATA is designed for existing projects, not for
ublksrv(though it supports this feature) targets. UBLK_IO_NEED_GET_DATA is COMPLETELY
motivated by our real practice in developing userspace storage products.

Regards,
Zhang
