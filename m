Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868BFC00140
	for <linux-block@archiver.kernel.org>; Sun, 31 Jul 2022 08:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiGaIDk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jul 2022 04:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGaIDj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jul 2022 04:03:39 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB7ED66
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 01:03:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VKvgbsy_1659254613;
Received: from 172.20.10.3(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VKvgbsy_1659254613)
          by smtp.aliyun-inc.com;
          Sun, 31 Jul 2022 16:03:34 +0800
Message-ID: <4c6f7d83-183a-da98-a41a-5363db6f3297@linux.alibaba.com>
Date:   Sun, 31 Jul 2022 16:03:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH V4 0/2] ublk: add support for UBLK_IO_NEED_GET_DATA
Content-Language: en-US
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        ming.lei@redhat.com
References: <cover.1659011443.git.ZiyangZhang@linux.alibaba.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <cover.1659011443.git.ZiyangZhang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Please queue this patchset up for the 5.20 merge window.

UBLK_IO_NEED_GET_DATA is an important feature designed for Ming Lei's
ublk_drv. All the patches have been reviewed by Ming and all test cases
in his ublksrv[1] have been passed.

[1] https://github.com/ming1/ubdsrv


On 2022/7/28 20:39, ZiyangZhang wrote:
> 1. Introduction:
> UBLK_IO_NEED_GET_DATA is a new ublk IO command. It is designed for a user
> application who wants to allocate IO buffer and set IO buffer address
> only after it receives an IO request from ublksrv. This is a reasonable
> scenario because these users may use a RPC framework as one IO backend
> to handle IO requests passed from ublksrv. And a RPC framework may
> allocate its own buffer(or memory pool).
> 
> This new feature (UBLK_F_NEED_GET_DATA) is optional for ublk users.
> Related userspace code has been added in ublksrv[1] as one pull request.
> 
> We have add some test cases in ublksrv and all of them pass. The
> performance result shows that this new feature does bring additional
> latency because one IO is issued back to ublk_drv once again to copy data
> from bio vectors to user-provided data buffer.
> 
> 2. Background:
> For now, ublk requires the user to set IO buffer address in advance(with
> last UBLK_IO_COMMIT_AND_FETCH_REQ command)so the user has to
> pre-allocate IO buffer.
> 
> For READ requests, this work flow looks good because the data copy
> happens after user application gets a cqe and the kernel copies data.
> So user application can allocate IO buffer, copy data to be read into
> it, and issues a sqe with the newly allocated IO buffer.
> 
> However, for WRITE requests, this work flow looks weird because
> the data copy happens in a task_work before the user application gets one
> cqe. So it is inconvenient for users who allocates(or fetch from a
> memory pool)buffer after it gets one request(and know the actual data
> size). For these users, they have to memcpy from ublksrv's pre-allocated
> buffer to their internal buffer(such as RPC buffer). We think this
> additional memcpy could be a bottleneck and it is avoidable.
> 
> 2. Design:
> Consider add a new feature flag: UBLK_F_NEED_GET_DATA.
> 
> If user sets this new flag(through libublksrv) and pass it to kernel
> driver, ublk kernel driver should returns a cqe with
> UBLK_IO_RES_NEED_GET_DATA after a new blk-mq WRITE request comes.
> 
> A user application now can allocate data buffer for writing and pass its
> address in UBLK_IO_NEED_GET_DATA command after ublk kernel driver returns
> cqe with UBLK_IO_RES_NEED_GET_DATA.
> 
> After the kernel side gets the sqe (UBLK_IO_NEED_GET_DATA command), it
> now copies(address pinned, indeed) data to be written from bio vectors
> to newly returned IO data buffer.
> 
> Finally, the kernel side returns UBLK_IO_RES_OK and ublksrv handles the
> IO request as usual.The new feature: UBLK_F_NEED_GET_DATA is enabled on
> demand ublksrv still can pre-allocate data buffers with task_work.
> 
> 3. Evaluation:
> Related userspace code and tests have been added in ublksrv[1] as one
> pull request. We evaluate performance based on this PR.
> 
> We have tested write latency with:
>   (1)  No UBLK_F_NEED_GET_DATA(the old commit) as baseline
>   (2)  UBLK_F_NEED_GET_DATA enabled/disabled
> on demo_null and demo_event of newest ublksrv project.
> 
> Config of fio:bs=4k, iodepth=1, numjobs=1, rw=write/randwrite, direct=1,
> ioengine=libaio.
> 
> Here is the comparison of lat(usec) in fio:
> 
> demo_null:
> write:        28.74(baseline) -- 28.77(disable) -- 57.20(enable)
> randwrite:    27.81(baseline) -- 28.51(disable) -- 54.81(enable)
> 
> demo_event:
> write:        46.45(baseline) -- 43.31(disable) -- 75.50(enable)
> randwrite:    45.39(baseline) -- 43.66(disable) -- 76.02(enable)
> 
> Looks like:
>   (1) UBLK_F_NEED_GET_DATA does not introduce additional overhead when
>       comparing baseline and disable.
>   (2) enabling UBLK_F_NEED_GET_DATA adds about two times more latency
>       than disabling it. And it is reasonable since the IO goes through
>       the total ublk IO stack(ubd_drv <--> ublksrv) once again.
>   (3) demo_null and demo_event are both null targets. And I think this
>       overhead is not too heavy if real data handling backend is used.
> 
> Without UBLK_IO_NEED_GET_DATA, an additional memcpy(from pre-allocated
> ublksrv buffer to user's buffer) is necessary for a WRITE request.
> However, UBLK_IO_NEED_GET_DATA does bring addtional syscall
> (io_uring_enter). To prove the value of UBLK_IO_NEED_GET_DATA, we test
> the single IO latency (usec) of demo_null with:
>   (1) UBLK_F_NEED_GET_DATA disabled; additional memcpy
>   (2) UBLK_F_NEED_GET_DATA enabled
> 
> Config of fio:iodepth=1, numjobs=1, rw=randwrite, direct=1,
> ioengine=libaio.
> 
> For block size, we choose 4k/64k/128k/256k/512k/1m. Note that with 1m block
> size, the original IO request will be split into two blk-mq requests.
> 
> Here is the comparison of lat(usec) in fio:
> 
>                  2 memcpy, w/o NEED_GET_DATA     1 memcpy, w/ NEED_GET_DATA
> 4k-randwrite:               9.65                            10.06
> 64k-randwrite:              15.19                           13.38
> 128k-randwrite:             19.47                           17.77
> 256k-randwrite:             32.63                           25.33
> 512k-randwrite:             90.57                           46.08
> 1m-randwrite:               177.06                          117.26
> 
> We find that with bigger block size, cases with one memcpy w/ NEED_GET_DATA
> result in lower latency than cases with two memcpy w/o NEED_GET_DATA.
> Therefore, we think NEED_GET_DATA is suitable for bigger block size,
> such as 512B or 1MB.
> 
> [1] https://github.com/ming1/ubdsrv
> 
> Since V3:
> 
> (1) Touch and clear UBLK_IO_FLAG_NEED_GET_DATA only when
>     UBLK_F_NEED_GET_DATA is enabled.
> 
> Since V2:
> 
> (1) UBLK_IO_NEED_GET_DATA should support both built-in task_work_add() and
>     io_uring_cmd_complete_in_task()
> 
> Since V1:
> 
> (1) Add tests to compare (1)2 memcpy, w/o NEED_GET_DATA and (2)1 memcpy,
>     w/ NEED_GET_DATA to show value of UBLK_IO_NEED_GET_DATA.
> (2) rebase on the newest version of ublk_drv
> 
> ZiyangZhang (2):
>   ublk_cmd.h: add one new ublk command: UBLK_IO_NEED_GET_DATA
>   ublk_drv: add support for UBLK_IO_NEED_GET_DATA
> 
>  drivers/block/ublk_drv.c      | 106 ++++++++++++++++++++++++++++++----
>  include/uapi/linux/ublk_cmd.h |  18 ++++++
>  2 files changed, 112 insertions(+), 12 deletions(-)
> 
