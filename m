Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86E0C433EF
	for <linux-block@archiver.kernel.org>; Mon,  9 May 2022 04:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiEIENa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 May 2022 00:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiEIEJy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 May 2022 00:09:54 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3BC21271
        for <linux-block@vger.kernel.org>; Sun,  8 May 2022 21:05:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VCcxVX9_1652069155;
Received: from 30.30.115.163(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0VCcxVX9_1652069155)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 May 2022 12:05:57 +0800
Message-ID: <55edea6e-e7dc-054a-b79b-fcfc40c22f2f@linux.alibaba.com>
Date:   Mon, 9 May 2022 12:05:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: Follow up on UBD discussion
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        joseph.qi@linux.alibaba.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <874k27rfwm.fsf@collabora.com> <YnDhorlKgOKiWkiz@T590>
 <8a52ed85-3ffa-44a4-3e28-e13cdc793732@linux.alibaba.com>
 <YnaonsoDjQjrutRb@T590>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
In-Reply-To: <YnaonsoDjQjrutRb@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hi,

> On Sat, May 07, 2022 at 12:20:17PM +0800, ZiyangZhang wrote:
>> On 2022/5/3 16:02, Ming Lei wrote:
>>> Hello Gabriel,
>>>
>>> CC linux-block and hope you don't mind, :-)
>>>
>>> On Mon, May 02, 2022 at 01:41:13PM -0400, Gabriel Krisman Bertazi wrote:
>>>> Hi Ming,
>>>>
>>>> First of all, I hope I didn't put you on the spot too much during the
>>>> discussion.  My original proposal was to propose my design, but your
>>>> implementation quite solved the questions I had. :)
>>> I think that is open source, then we can put efforts together to make things
>>> better.
>>>
>>>> I'd like to follow up to restart the communication and see
>>>> where I can help more with UBD.  As I said during the talk, I've
>>>> done some fio runs and I was able to saturate NBD much faster than UBD:
>>>>
>>>> https://people.collabora.com/~krisman/mingl-ubd/bw.png
>>> Yeah, that is true since NBD has extra socket communication cost which
>>> can't be efficient as io_uring.
>>>
>>>> I've also wrote some fixes to the initialization path, which I
>>>> planned to send to you as soon as you published your code, but I think
>>>> you might want to take a look already and see if you want to just squash
>>>> it into your code base.
>>>>
>>>> I pushed those fixes here:
>>>>
>>>>   https://gitlab.collabora.com/krisman/linux/-/tree/mingl-ubd
>>> I have added the 1st fix and 3rd patch into my tree:
>>>
>>> https://github.com/ming1/linux/commits/v5.17-ubd-dev
>>>
>>> The added check in 2nd patch is done lockless, which may not be reliable
>>> enough, so I didn't add it. Also adding device is in slow path, and no
>>> necessary to improve in that code path.
>>>
>>> I also cleaned up ubd driver a bit: debug code cleanup, remove zero copy
>>> code, remove command of UBD_IO_GET_DATA and always make ubd driver
>>> builtin.
>>>
>>> ubdsrv part has been cleaned up too:
>>>
>>> https://github.com/ming1/ubdsrv
>>>
>>>> I'm looking into adding support for multiple driver queues next, and
>>>> should be able to share some patches on that shortly.
>>> OK, please post them on linux-block so that more eyes can look at the
>>> code, meantime the ubdsrv side needs to handle MQ too.
>>>
>>> Sooner or later, the single ubdsrv task may be saturated by copying data and
>>> io_uring command communication only, which can be shown by running io on
>>> ubd-null target. In my lattop, the ubdsrv cpu utilization is close to
>>> 90% when IOPS is > 500K. So MQ may help some fast backing cases.
>>>
>>>
>>> Thanks,
>>> Ming
>> Hi Ming,
>>
>> Now I am learning your userspace block driver(UBD) [1][2] and we plan to
>> replace TCMU by UBD as a new choice for implementing userspace bdev for
>> its high performance and simplicity.
>>
>> First, we have conducted some tests by fio and perf to evaluate UBD.
>>
>> 1) UBD achieves higher throughput than TCMU. We think TCMU suffers from
>>      the complicated SCSI layer and does not support multiqueue. However
>> UBD is simply using io_uring passthrough and may support multiqueue in
>> the future.(Note that even with a single queue now , UBD outperforms TCMU)
> MQ isn't hard to support, and it is basically workable now:
>
> https://github.com/ming1/ubdsrv/commits/devel
> https://github.com/ming1/linux/commits/my_for-5.18-ubd-devel
>
> Just the affinity of pthread for each queue isn't setup yet.
>
>> 2) Some functions in UBD result in high CPU utilization and we guess
>> they also lower throughput. For example, ubdsrv_submit_fetch_commands()
>> frequently iterates on the array of UBD IOs and wastes CPU when no IO is
>> ready to be submitted. Besides,  ubd_copy_pages() asks CPU to copy data
>> between bio vectors and UBD internal buffers while handling write and
>> read requests and it could be eliminated by supporting zero-copy.
> copy itself doesn't take much cpu, see the following trace:
>
> -   34.36%     3.73%  ubd              [kernel.kallsyms]             [k] ubd_copy_pages.isra.0                               ▒
>    - 30.63% ubd_copy_pages.isra.0                                                                                            ▒
>       - 23.86% internal_get_user_pages_fast                                                                                  ▒
>          + 21.14% get_user_pages_unlocked                                                                                    ▒
>          + 2.62% lockless_pages_from_mm                                                                                      ▒
>         6.42% ubd_release_pages.constprop.0
>
> And we may provide option to allow to pin pages in the disk lifetime for avoiding
> the cost in _get_user_pages_fast().
>
> zero-copy has to touch page table, and its cost may be expensive too.
> The big problem is that MM doesn't provide mechanism to support generic
> remapping kernel pages to userspace.
>
>> Second, I'd like to share some ideas on UBD. I'm not sure if they are
>> reasonable so please figure out my mistakes.
>>
>> 1) UBD issues one sqe to commit last completed request and fetch a new
>> one. Then, blk-mq's queue_rq() issues a new UBD IO request and completes
>> one cqe for the fetch command. We have evaluated that io_submit_sqes()
>> costs some CPU and steps of building a new sqe may lower throughput.
>> Here I'd like to give a new solution: never submit sqe but trump up a
>> cqe(with information of new UBD IO request) when calling queue_rq(). I
>> am inspired by one io_uring flag: IORING_POLL_ADD_MULTI, with which a
>> user issues only one sqe for polling an fd and repeatedly gets multiple
>> cqes when new events occur. Dose this solution break the architecture of
>> UBD?
> But each cqe has to be associated with one sqe, if I understand
> correctly.
Yeah, for current io_uring implementation, it is. But if io_uring offers below
helper:
void io_gen_cqe_direct(struct file *file, u64 user_data, s32 res, u32 cflags)
{
        struct io_ring_ctx *ctx;
        ctx = file->private_data;

        spin_lock(&ctx->completion_lock);
        __io_fill_cqe(ctx, user_data, res, cflags);
        io_commit_cqring(ctx);
        spin_unlock(&ctx->completion_lock);
        io_cqring_ev_posted(ctx);
}

Then in ubd driver:
1) device setup stage
We attach io_uring files and user_data to every ubd hard queue.

2) when blk-mq->queue_rq() is called.
io_gen_cqe_direct() will be called in ubd's queue_rq, and we put ubd io request's
qid and tag info into cqe's res field, then we don't need to issue sqe to fetch io cmds.

Regards,
Xiaoguang Wang
>
> I will research IORING_POLL_ADD_MULTI a bit and see if it can help UBD.
> And yes, batching is really important for UBD's performance.
>
>> 2) UBDSRV(the userspace part) should not allocate data buffers itself.
>> When an application configs many queues with bigger iodepth, UBDSRV has
>> to preallocate more buffers(size = 256KiB) and results in heavy memory
>> overhead. I think data buffers should be allocated by applications
> That is just virtual memory, and pages can be reclaimed after IO is
> done.
>
>> themselves and passed to UBDSRV. In this way UBD offers more
>> flexibility. However, while handling a write request, the control flow
>> returns to the kernel part again to set buf addr and copy data from bio
>> vectors. Is ioctl helpful by setting buf addr and copying write data to
>> app buf?
> It is pretty easy to pass application buffer to UBD_IO_FETCH_REQ or
> UBD_IO_COMMIT_AND_FETCH_REQ, just by overriding ios[i].buf_addr which
> is sent to ubd driver via ubdsrv_io_cmd->addr.
>
> No need any ioctl, and io_uring command can handle everything.
>
> I think the idea is good, and we can provide one option for using
> pre-allocated buffer or application buffer.
>
> But the application buffer has to be in same process VM space with ubdsrv
> daemon, otherwise it becomes slower to pin these application
> buffers/pages.
>
>> 3) ubd_fetch_and_submit() frequently iterates on the array of ubd IOs
>> and wastes CPU when no IO is ready to be submitted. I think it can be
>> optimized by adding a new array storing UBD IOs that are ready to be
>> commit back to the kernel part. Then we could batch these IOs and avoid
>> unnecessary iterations on IOs which are not ready(fetching or handling
>> by targets).
> That should be easy to avoid the whole queue iteration, but my perf
> trace doesn't show ubd_fetch_and_submit() consumes too much CPU.
>
>> 4) Zero-copy support is important and we are trying to implement it now.
> I talked with Xiaoguang wrt. zero-copy support, and looks it isn't ready
> as one generic approach. If it is ready, it is easy to integrate to UBD.
>
>> 5) Currently, UBD only support the loop target with io_uirng and all
>> works(1.get one cqe 2.issue target io_uring IO 3.get target io_uring IO
>> completion 4.prepare one sqe) are done in one thread. As far as I know,
> loop is one example, and it provides similar function with kernel loop by
> < 200 lines of userspace code.
>
>>  some applications such as SPDK, network fs and customized distribution
>> systems do not support io_uring well.  I think we should separate target
>> IO handling from the UBDSRV loop and allow applications handle target
>> IOs themselves. Is this suggestion reasonable? (Or UBD should focus on
>> io_uring-supported targets?)
> UBD provides one framework for implementing userspace block driver, you
> can do everything for handling the IO in userspace. The target code just
> needs to implement callbacks defined in ubdsrv_tgt_type, so it has been
> separated from ubd loop already. But UBD is still in early stage,
> and the interface will continue to improve or re-design. Or can you
> explain your ideas in a bit details? It could be very helpful if you
> can provide some application background.
>
> Reason why I suggested to use io_uring is that io_uring is very efficient, also
> async IO has been proved as very efficient approach for handling io.
>
>
> Thanks
> Ming

