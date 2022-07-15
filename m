Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7185DC433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Jul 2022 06:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiGOGH1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jul 2022 02:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOGHZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 02:07:25 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1915D0EC;
        Thu, 14 Jul 2022 23:07:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VJNwYSo_1657865238;
Received: from 30.97.56.204(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VJNwYSo_1657865238)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 14:07:18 +0800
Message-ID: <6723190a-e317-2161-d93e-71f8c2f88232@linux.alibaba.com>
Date:   Fri, 15 Jul 2022 14:07:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH V5 1/2] ublk_drv: add io_uring based userspace block
 driver
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
References: <20220713140711.97356-1-ming.lei@redhat.com>
 <20220713140711.97356-2-ming.lei@redhat.com>
 <a4249561-84a0-a314-c377-b96d28b7b20b@linux.alibaba.com>
 <Ys/0jTxQCEHdI560@T590>
 <fe9508ae-f12a-2216-1160-145308d746f5@linux.alibaba.com>
 <YtDLSdwbV/utn0Qv@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <YtDLSdwbV/utn0Qv@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/7/15 10:04, Ming Lei wrote:
> On Thu, Jul 14, 2022 at 09:23:40PM +0800, Ziyang Zhang wrote:
>> On 2022/7/14 18:48, Ming Lei wrote:
>>> On Thu, Jul 14, 2022 at 06:20:38PM +0800, Ziyang Zhang wrote:
>>>> On 2022/7/13 22:07, Ming Lei wrote:
>>>>> This is the driver part of userspace block driver(ublk driver), the other
>>>>> part is userspace daemon part(ublksrv)[1].
>>>>>
...
>>
>> Put it together:
>>
>> When daemon is PF_EXITING:
>>
>> 1) current ublk_io: aborted immediately in task_work
> 
> Precisely it is just that ublk io request is ended immediately, so io->flags
> won't be touched.
> 
>>
>> 2) UBLK_IO_FLAG_ACTIVE set: aborted in ublk_daemon_monitor_work
> 
> This part is important for making forward progress, that is why it has
> to be done in a wq context.
> 
>>
>> 3) UBLK_IO_FLAG_ACTIVE unset: send cqe with UBLK_IO_RES_ABORT

Oh... sorry for one mistake. case 2) and 3) should be swapped:

ublk_daemon_monitor_work(): abort blk-mq IOs if UBLK_IO_FLAG_ACTIVE is unset

ublk_cancel_queue(): send cqes with UBLK_IO_RES_ABORT if UBLK_IO_FLAG_ACTIVE is set


