Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32225C433EF
	for <linux-block@archiver.kernel.org>; Mon,  9 May 2022 11:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiEIL3G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 May 2022 07:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiEIL3F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 May 2022 07:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0575C1790A4
        for <linux-block@vger.kernel.org>; Mon,  9 May 2022 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652095509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tao16devjiGuMImeiSwH1CJ5zItqd6vu+aTs8c/Wmn4=;
        b=h93P0mDIScJCtpRbWdvKx7Qc+cLMUIBOzoxkynUtrbeZuztd8R/ASNvAGKljf9veRMIJkq
        CGEacZ0a0GNmMS8Ki6vfuo+6LJMi8YM0sVzbu7JfGlSyTfa1piM3MP7oIDoqFTF0AeWwYU
        Ai++2x9oVKNbJl0rZh4MaO1cbsU/byA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404--g48QCpeNbyzpFrsDt1ivA-1; Mon, 09 May 2022 07:25:05 -0400
X-MC-Unique: -g48QCpeNbyzpFrsDt1ivA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D87038C5C56;
        Mon,  9 May 2022 11:25:05 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C13A43271F;
        Mon,  9 May 2022 11:25:00 +0000 (UTC)
Date:   Mon, 9 May 2022 19:24:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        joseph.qi@linux.alibaba.com, linux-block@vger.kernel.org
Subject: Re: Follow up on UBD discussion
Message-ID: <Ynj6B2/6lZXFMX9a@T590>
References: <874k27rfwm.fsf@collabora.com>
 <YnDhorlKgOKiWkiz@T590>
 <8a52ed85-3ffa-44a4-3e28-e13cdc793732@linux.alibaba.com>
 <YnaonsoDjQjrutRb@T590>
 <7ae5f6a7-3704-ab93-3f72-a4cdd8196b53@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ae5f6a7-3704-ab93-3f72-a4cdd8196b53@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 09, 2022 at 04:11:47PM +0800, Ziyang Zhang wrote:
> On 2022/5/8 01:13, Ming Lei wrote:
> > On Sat, May 07, 2022 at 12:20:17PM +0800, ZiyangZhang wrote:
> >> On 2022/5/3 16:02, Ming Lei wrote:
> >>> Hello Gabriel,
> >>>
> >>> CC linux-block and hope you don't mind, :-)
> >>>
> >>> On Mon, May 02, 2022 at 01:41:13PM -0400, Gabriel Krisman Bertazi wrote:
> >>>>
> >>>> Hi Ming,
> >>>>
> >>>> First of all, I hope I didn't put you on the spot too much during the
> >>>> discussion.  My original proposal was to propose my design, but your
> >>>> implementation quite solved the questions I had. :)
> >>>
> >>> I think that is open source, then we can put efforts together to make things
> >>> better.
> >>>
> >>>>
> >>>> I'd like to follow up to restart the communication and see
> >>>> where I can help more with UBD.  As I said during the talk, I've
> >>>> done some fio runs and I was able to saturate NBD much faster than UBD:
> >>>>
> >>>> https://people.collabora.com/~krisman/mingl-ubd/bw.png
> >>>
> >>> Yeah, that is true since NBD has extra socket communication cost which
> >>> can't be efficient as io_uring.
> >>>
> >>>>
> >>>> I've also wrote some fixes to the initialization path, which I
> >>>> planned to send to you as soon as you published your code, but I think
> >>>> you might want to take a look already and see if you want to just squash
> >>>> it into your code base.
> >>>>
> >>>> I pushed those fixes here:
> >>>>
> >>>>   https://gitlab.collabora.com/krisman/linux/-/tree/mingl-ubd
> >>>
> >>> I have added the 1st fix and 3rd patch into my tree:
> >>>
> >>> https://github.com/ming1/linux/commits/v5.17-ubd-dev
> >>>
> >>> The added check in 2nd patch is done lockless, which may not be reliable
> >>> enough, so I didn't add it. Also adding device is in slow path, and no
> >>> necessary to improve in that code path.
> >>>
> >>> I also cleaned up ubd driver a bit: debug code cleanup, remove zero copy
> >>> code, remove command of UBD_IO_GET_DATA and always make ubd driver
> >>> builtin.
> >>>
> >>> ubdsrv part has been cleaned up too:
> >>>
> >>> https://github.com/ming1/ubdsrv
> >>>
> >>>>
> >>>> I'm looking into adding support for multiple driver queues next, and
> >>>> should be able to share some patches on that shortly.
> >>>
> >>> OK, please post them on linux-block so that more eyes can look at the
> >>> code, meantime the ubdsrv side needs to handle MQ too.
> >>>
> >>> Sooner or later, the single ubdsrv task may be saturated by copying data and
> >>> io_uring command communication only, which can be shown by running io on
> >>> ubd-null target. In my lattop, the ubdsrv cpu utilization is close to
> >>> 90% when IOPS is > 500K. So MQ may help some fast backing cases.
> >>>
> >>>
> >>> Thanks,
> >>> Ming
> >>
> >> Hi Ming,
> >>
> >> Now I am learning your userspace block driver(UBD) [1][2] and we plan to
> >> replace TCMU by UBD as a new choice for implementing userspace bdev for
> >> its high performance and simplicity.
> >>
> >> First, we have conducted some tests by fio and perf to evaluate UBD.
> >>
> >> 1) UBD achieves higher throughput than TCMU. We think TCMU suffers from
> >>      the complicated SCSI layer and does not support multiqueue. However
> >> UBD is simply using io_uring passthrough and may support multiqueue in
> >> the future.(Note that even with a single queue now , UBD outperforms TCMU)
> > 
> > MQ isn't hard to support, and it is basically workable now:
> > 
> > https://github.com/ming1/ubdsrv/commits/devel
> > https://github.com/ming1/linux/commits/my_for-5.18-ubd-devel
> > 
> > Just the affinity of pthread for each queue isn't setup yet.
> 
> Thanks Ming, I will try your new code.
> 
> > 
> >>
> >> 2) Some functions in UBD result in high CPU utilization and we guess
> >> they also lower throughput. For example, ubdsrv_submit_fetch_commands()
> >> frequently iterates on the array of UBD IOs and wastes CPU when no IO is
> >> ready to be submitted. Besides,  ubd_copy_pages() asks CPU to copy data
> >> between bio vectors and UBD internal buffers while handling write and
> >> read requests and it could be eliminated by supporting zero-copy.
> > 
> > copy itself doesn't take much cpu, see the following trace:
> > 
> > -   34.36%     3.73%  ubd              [kernel.kallsyms]             [k] ubd_copy_pages.isra.0                               ▒
> >    - 30.63% ubd_copy_pages.isra.0                                                                                            ▒
> >       - 23.86% internal_get_user_pages_fast                                                                                  ▒
> >          + 21.14% get_user_pages_unlocked                                                                                    ▒
> >          + 2.62% lockless_pages_from_mm                                                                                      ▒
> >         6.42% ubd_release_pages.constprop.0
> I got the following trace:
> -   26.49%   2.26%  ubd    [ubd]    [k] ubd_commit_completion
> 
>    - 24.24% ubd_commit_completion
> 
>       - 24.00% ubd_copy_pages.isra.0
> 
>          - 10.73% internal_get_user_pages_fast
> 
>             - 9.05% get_user_pages_unlocked
> 
>                - 8.92% __get_user_pages
> 
>                   - 5.61% follow_page_pte
> 
>                      - 1.83% folio_mark_accessed
> 
>                           0.70% __lru_cache_activate_folio
> 
>                      - 1.25% _raw_spin_lock
> 
>                           0.61% preempt_count_add
> 
>                        0.91% try_grab_page
> 
>                     1.02% follow_pmd_mask.isra.0
> 
>                     0.58% follow_page_mask
> 
>                     0.52% follow_pud_mask
> 
>             - 1.35% gup_pud_range.constprop.0
> 
>                  1.22% gup_pmd_range.constprop.0
> 
>          - 7.71% memcpy_erms
> 
>             - 0.68% asm_common_interrupt
> 
>                - 0.67% common_interrupt
> 
>                   - 0.62% __common_interrupt
> 
>                      - 0.60% handle_edge_irq
> 
>                         - 0.53% handle_irq_event
> 
>                            - 0.51% __handle_irq_event_percpu
> 
>                                 vring_interrupt
> 
>            4.07% ubd_release_pages.constprop.0

OK, but both internal_get_user_pages_fast and ubd_release_pages still
takes 15%, and memcpy_erms() is 7.7%. But mm zero copy isn't ready,
so memcpy can't be avoided, also zero copy has other cost, which may
be big enough too.

One approach I thought of for reducing cost of pinning pages is to release
pages lazily, such as, release page when the request is idle for enough time,
meantime takes LRU way to free pages when number of total pinned pages are
beyond max allowed amount. IMO, this approach should get much improvement,
but it needs pre-allocation of userspace buffer, and the implementation
shouldn't be very hard.

> 
> 
> > 
> > And we may provide option to allow to pin pages in the disk lifetime for avoiding
> > the cost in _get_user_pages_fast().
> > 
> > zero-copy has to touch page table, and its cost may be expensive too.
> > The big problem is that MM doesn't provide mechanism to support generic
> > remapping kernel pages to userspace.
> > 
> >>
> >> Second, I'd like to share some ideas on UBD. I'm not sure if they are
> >> reasonable so please figure out my mistakes.
> >>
> >> 1) UBD issues one sqe to commit last completed request and fetch a new
> >> one. Then, blk-mq's queue_rq() issues a new UBD IO request and completes
> >> one cqe for the fetch command. We have evaluated that io_submit_sqes()
> >> costs some CPU and steps of building a new sqe may lower throughput.
> >> Here I'd like to give a new solution: never submit sqe but trump up a
> >> cqe(with information of new UBD IO request) when calling queue_rq(). I
> >> am inspired by one io_uring flag: IORING_POLL_ADD_MULTI, with which a
> >> user issues only one sqe for polling an fd and repeatedly gets multiple
> >> cqes when new events occur. Dose this solution break the architecture of
> >> UBD?
> > 
> > But each cqe has to be associated with one sqe, if I understand
> > correctly.
> > 
> > I will research IORING_POLL_ADD_MULTI a bit and see if it can help UBD.
> > And yes, batching is really important for UBD's performance.
> > 
> >>
> >> 2) UBDSRV(the userspace part) should not allocate data buffers itself.
> >> When an application configs many queues with bigger iodepth, UBDSRV has
> >> to preallocate more buffers(size = 256KiB) and results in heavy memory
> >> overhead. I think data buffers should be allocated by applications
> > 
> > That is just virtual memory, and pages can be reclaimed after IO is
> > done.
> > 
> >> themselves and passed to UBDSRV. In this way UBD offers more
> >> flexibility. However, while handling a write request, the control flow
> >> returns to the kernel part again to set buf addr and copy data from bio
> >> vectors. Is ioctl helpful by setting buf addr and copying write data to
> >> app buf?
> > 
> > It is pretty easy to pass application buffer to UBD_IO_FETCH_REQ or
> > UBD_IO_COMMIT_AND_FETCH_REQ, just by overriding ios[i].buf_addr which
> > is sent to ubd driver via ubdsrv_io_cmd->addr.
> 
> Maybe one app allocates one data buffer until it gets a UBD IO request
> because it does not know the data size and pre-allocation is forbidden.
> In this way, UBD_IO_FETCH_REQ or UBD_IO_COMMIT_AND_FETCH_REQ are not
> helpful.

The userspace buffer from app can be seen when UBD_IO_COMMIT_AND_FETCH_REQ
is sent to ubd driver.

> 
> > 
> > No need any ioctl, and io_uring command can handle everything.
> > 
> > I think the idea is good, and we can provide one option for using
> > pre-allocated buffer or application buffer.
> > 
> > But the application buffer has to be in same process VM space with ubdsrv
> > daemon, otherwise it becomes slower to pin these application
> > buffers/pages.
> > 
> >>
> >> 3) ubd_fetch_and_submit() frequently iterates on the array of ubd IOs
> >> and wastes CPU when no IO is ready to be submitted. I think it can be
> >> optimized by adding a new array storing UBD IOs that are ready to be
> >> commit back to the kernel part. Then we could batch these IOs and avoid
> >> unnecessary iterations on IOs which are not ready(fetching or handling
> >> by targets).
> > 
> > That should be easy to avoid the whole queue iteration, but my perf
> > trace doesn't show ubd_fetch_and_submit() consumes too much CPU.
> 
> My trace:
> -    2.63%     1.71%  ubd     ubd    [.]ubdsrv_submit_fetch_commands
> 
>    - 1.71% 0x495641000034d33d
> 
>         __libc_start_main
> 
>         main
> 
>         cmd_dev_add
> 
>         ubdsrv_start_dev
> 
>         ubdsrv_start_io_daemon
> 
>       - start_daemon
> 
>          - 1.70% ubdsrv_io_handler
> 
>               ubdsrv_submit_fetch_commands
> 
>      0.92% ubdsrv_submit_fetch_commands

Looks it is still not heavy enough, and we can use one per-queue/thread
bitmap to track IOs which need to be queued to ubd driver, and the
change should be easy.

> 
> > 
> >>
> >> 4) Zero-copy support is important and we are trying to implement it now.
> > 
> > I talked with Xiaoguang wrt. zero-copy support, and looks it isn't ready
> > as one generic approach. If it is ready, it is easy to integrate to UBD.
> > 
> >>
> >> 5) Currently, UBD only support the loop target with io_uirng and all
> >> works(1.get one cqe 2.issue target io_uring IO 3.get target io_uring IO
> >> completion 4.prepare one sqe) are done in one thread. As far as I know,
> > 
> > loop is one example, and it provides similar function with kernel loop by
> > < 200 lines of userspace code.
> > 
> >>  some applications such as SPDK, network fs and customized distribution
> >> systems do not support io_uring well.  I think we should separate target
> >> IO handling from the UBDSRV loop and allow applications handle target
> >> IOs themselves. Is this suggestion reasonable? (Or UBD should focus on
> >> io_uring-supported targets?)
> > 
> > UBD provides one framework for implementing userspace block driver, you
> > can do everything for handling the IO in userspace. The target code just
> > needs to implement callbacks defined in ubdsrv_tgt_type, so it has been
> > separated from ubd loop already. But UBD is still in early stage,
> > and the interface will continue to improve or re-design. Or can you
> > explain your ideas in a bit details? It could be very helpful if you
> > can provide some application background.
> 
> The app:
> 1) Another worker thread per queue(not the UBD daemon thread per
> queue)gets(by one API provides by UBDSRV such as ubdsrv_get_new_req) one
> new UBD IO(from blk-mq) with io_size, io_off and tag.
> 
> 2) handles the new IO(e.g. app_write_req_handle, app_read_req_handle)in
> one worker threads(not in the UBD daemon thread).
> 
> 3) One IO completes and the worker thread should notify the UBD daemon
> thread.
> 
> Currently, I find:
> 	if (cqe->user_data & (1ULL << 63)) {
> 		ubdsrv_handle_tgt_cqe(dev, q, cqe);
> 		return;
> 	}
> in ubdsrv.c:ubdsrv_handle_cqe. This assumes a target should use io_uring
> to handle IO requests, and the app above does not support io_uring.
> Maybe we should re-design the IO handling logic.

You can export one helper of ubdsrv_complete_io() for target code

void ubdsrv_complete_io(struct ubdsrv_dev *dev,
        struct ubdsrv_queue *q, int tag, int res)
{
        struct ubd_io *io = &q->ios[tag];

        io->result = res;

        /* Mark this IO as free and ready for issuing to ubd driver */
        io->flags |= (UBDSRV_NEED_COMMIT_RQ_COMP | UBDSRV_IO_FREE);

        /* clear handling */
        io->flags &= ~UBDSRV_IO_HANDLING;
}

Then the target code calls ubdsrv_complete_io(), but you have to add new
approach to wakeup the ubdsrv pthread daemon which can wait in io_uring_enter().
That is why I still suggest to try to use io_uring for handling IO.

If you really have high performance requirement, and if cost of pining pages in
ubdsrv pthread daemon were saved, maybe you can run your app_write_req_handle()/
app_read_req_handle() in the ubdsrv pthread context directly if it is implemented
in AIO style.


Thanks, 
Ming

