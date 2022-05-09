Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F799C4332F
	for <linux-block@archiver.kernel.org>; Mon,  9 May 2022 07:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiEIHzp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 May 2022 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbiEIHm2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 May 2022 03:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D05219FF49
        for <linux-block@vger.kernel.org>; Mon,  9 May 2022 00:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652081783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rd5PLxpy+OFdcJ3bUbAyPchBvpYiK7JXwLk+6vnDAac=;
        b=JqGyf/smRC8oQPBpy17GaGlgOaZKSi8r6d7XeQ/+KpHS2Id/N+K/Y2fnrnEApDD/9JJWw0
        APMXjIEfZpvPpZq5YTpcfd0PHdYrfss2TSJjBvmG2PUW208Wq/eEv8c+0KgfslkfZSvsz9
        lxVerBWL4LWYbZtCUzNJtGfPP2Hvn6E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-bwH7Sxr4PC6J2esx4FDb9A-1; Mon, 09 May 2022 03:36:20 -0400
X-MC-Unique: bwH7Sxr4PC6J2esx4FDb9A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03F4F811E78;
        Mon,  9 May 2022 07:36:20 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15AA4416178;
        Mon,  9 May 2022 07:36:13 +0000 (UTC)
Date:   Mon, 9 May 2022 15:36:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        joseph.qi@linux.alibaba.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: Follow up on UBD discussion
Message-ID: <YnjEaM5T2aO0mlyi@T590>
References: <874k27rfwm.fsf@collabora.com>
 <YnDhorlKgOKiWkiz@T590>
 <8a52ed85-3ffa-44a4-3e28-e13cdc793732@linux.alibaba.com>
 <YnaonsoDjQjrutRb@T590>
 <55edea6e-e7dc-054a-b79b-fcfc40c22f2f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55edea6e-e7dc-054a-b79b-fcfc40c22f2f@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 09, 2022 at 12:05:54PM +0800, Xiaoguang Wang wrote:
> hi,
> 
> > On Sat, May 07, 2022 at 12:20:17PM +0800, ZiyangZhang wrote:
> >> On 2022/5/3 16:02, Ming Lei wrote:
> >>> Hello Gabriel,
> >>>
> >>> CC linux-block and hope you don't mind, :-)
> >>>
> >>> On Mon, May 02, 2022 at 01:41:13PM -0400, Gabriel Krisman Bertazi wrote:
> >>>> Hi Ming,
> >>>>
> >>>> First of all, I hope I didn't put you on the spot too much during the
> >>>> discussion.  My original proposal was to propose my design, but your
> >>>> implementation quite solved the questions I had. :)
> >>> I think that is open source, then we can put efforts together to make things
> >>> better.
> >>>
> >>>> I'd like to follow up to restart the communication and see
> >>>> where I can help more with UBD.  As I said during the talk, I've
> >>>> done some fio runs and I was able to saturate NBD much faster than UBD:
> >>>>
> >>>> https://people.collabora.com/~krisman/mingl-ubd/bw.png
> >>> Yeah, that is true since NBD has extra socket communication cost which
> >>> can't be efficient as io_uring.
> >>>
> >>>> I've also wrote some fixes to the initialization path, which I
> >>>> planned to send to you as soon as you published your code, but I think
> >>>> you might want to take a look already and see if you want to just squash
> >>>> it into your code base.
> >>>>
> >>>> I pushed those fixes here:
> >>>>
> >>>>   https://gitlab.collabora.com/krisman/linux/-/tree/mingl-ubd
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
> >>>> I'm looking into adding support for multiple driver queues next, and
> >>>> should be able to share some patches on that shortly.
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
> > MQ isn't hard to support, and it is basically workable now:
> >
> > https://github.com/ming1/ubdsrv/commits/devel
> > https://github.com/ming1/linux/commits/my_for-5.18-ubd-devel
> >
> > Just the affinity of pthread for each queue isn't setup yet.
> >
> >> 2) Some functions in UBD result in high CPU utilization and we guess
> >> they also lower throughput. For example, ubdsrv_submit_fetch_commands()
> >> frequently iterates on the array of UBD IOs and wastes CPU when no IO is
> >> ready to be submitted. Besides,  ubd_copy_pages() asks CPU to copy data
> >> between bio vectors and UBD internal buffers while handling write and
> >> read requests and it could be eliminated by supporting zero-copy.
> > copy itself doesn't take much cpu, see the following trace:
> >
> > -   34.36%     3.73%  ubd              [kernel.kallsyms]             [k] ubd_copy_pages.isra.0                               ▒
> >    - 30.63% ubd_copy_pages.isra.0                                                                                            ▒
> >       - 23.86% internal_get_user_pages_fast                                                                                  ▒
> >          + 21.14% get_user_pages_unlocked                                                                                    ▒
> >          + 2.62% lockless_pages_from_mm                                                                                      ▒
> >         6.42% ubd_release_pages.constprop.0
> >
> > And we may provide option to allow to pin pages in the disk lifetime for avoiding
> > the cost in _get_user_pages_fast().
> >
> > zero-copy has to touch page table, and its cost may be expensive too.
> > The big problem is that MM doesn't provide mechanism to support generic
> > remapping kernel pages to userspace.
> >
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
> > But each cqe has to be associated with one sqe, if I understand
> > correctly.
> Yeah, for current io_uring implementation, it is. But if io_uring offers below
> helper:
> void io_gen_cqe_direct(struct file *file, u64 user_data, s32 res, u32 cflags)
> {
>         struct io_ring_ctx *ctx;
>         ctx = file->private_data;
> 
>         spin_lock(&ctx->completion_lock);
>         __io_fill_cqe(ctx, user_data, res, cflags);
>         io_commit_cqring(ctx);
>         spin_unlock(&ctx->completion_lock);
>         io_cqring_ev_posted(ctx);
> }
> 
> Then in ubd driver:
> 1) device setup stage
> We attach io_uring files and user_data to every ubd hard queue.
> 
> 2) when blk-mq->queue_rq() is called.
> io_gen_cqe_direct() will be called in ubd's queue_rq, and we put ubd io request's
> qid and tag info into cqe's res field, then we don't need to issue sqe to fetch io cmds.

The above way is actually anti io_uring design, and I don't think it may
improve much since submitting UBD_IO_COMMIT_AND_FETCH_REQ is pretty lightweight.

Also without re-submitting UBD_IO_COMMIT_AND_FETCH_REQ command, how can you
commit io handling result from ubd server and ask ubd driver to complete
io request?


Thanks, 
Ming

