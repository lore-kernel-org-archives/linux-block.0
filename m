Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5977AC4361B
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 12:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 131D52220F
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 12:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgLOMHv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 07:07:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34214 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727282AbgLOMHo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 07:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608033977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qjDkcmbhQZPnlV3v+8AItoCkCx+DjDiN278iJThHvaE=;
        b=Q9vSXanvz3mmDs37nuqJ7ENBQGdYRaqJVlN0+MEz1LI93ii0tXLp/mdR8WB3HNMTRFXCxJ
        QVfcxMZGvqWROa/tzZfyyfDHMQB1FhsOmBC12fpj38mqCoD5V9i5aKNWSOG1bB+cetIF9X
        fEVjEN5ln19iXWiPvParr+F8uEuHnPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-Kzy_9hJQOE6RlqIbFNpLMQ-1; Tue, 15 Dec 2020 07:06:15 -0500
X-MC-Unique: Kzy_9hJQOE6RlqIbFNpLMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 051C08031FA;
        Tue, 15 Dec 2020 12:06:14 +0000 (UTC)
Received: from T590 (ovpn-12-182.pek2.redhat.com [10.72.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7687260861;
        Tue, 15 Dec 2020 12:06:09 +0000 (UTC)
Date:   Tue, 15 Dec 2020 20:06:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] blktrace: fix 'BUG: sleeping function called from
 invalid context' in case of PREEMPT_RT
Message-ID: <20201215120604.GB1798021@T590>
References: <20201214022217.1754273-1-ming.lei@redhat.com>
 <20201214102422.2d84035d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214102422.2d84035d@gandalf.local.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 14, 2020 at 10:24:22AM -0500, Steven Rostedt wrote:
> On Mon, 14 Dec 2020 10:22:17 +0800
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > trace_note_tsk() is called by __blk_add_trace(), which is covered by RCU read lock.
> > So in case of PREEMPT_RT, warning of 'BUG: sleeping function called from invalid context'
> > will be triggered because spin lock is converted to rtmutex.
> 
> The RCU read_lock() can not be the cause of this issue, because under
> PREEMPT_RT, rcu_read_lock() can be preempted.

OK, got it.

> 
> What was the full back trace of this problem?

[  284.527619] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:968
[  284.527626] in_atomic(): 1, irqs_disabled(): 0, pid: 6705, name: mandb
[  284.527631] 4 locks held by mandb/6705:
[  284.527634]  #0: ffff88853f4f2eb0 (&f->f_pos_lock){+.+.}-{0:0}, at: __fdget_pos+0xaf/0xe0
[  284.527662]  #1: ffff8885eb814048 (&sb->s_type->i_mutex_key#13){++++}-{0:0}, at: xfs_ilock+0x17d/0x590 [xfs]
[  284.527838]  #2: ffffffffa24d22c0 (rcu_read_lock){....}-{1:2}, at: blk_add_trace_bio+0x0/0x2f0
[  284.527859]  #3: ffffffffa22177a0 (running_trace_lock){+.+.}-{2:2}, at: __blk_add_trace+0x9ea/0xdf0
[  284.527877] Preemption disabled at:
[  284.527886] [<ffffffff9f936743>] get_lock_stats+0x13/0x120
[  284.527897] CPU: 53 PID: 6705 Comm: mandb Kdump: loaded Not tainted 4.18.0-259.rt7.24.el8.x86_64+debug #1
[  284.527901] Hardware name: Lenovo ThinkSystem SR630 -[7X02CTO1WW]-/-[7X02CTO1WW]-, BIOS -[IVE136T-2.10]- 03/22/2019
[  284.527904] Call Trace:
[  284.527918]  dump_stack+0x8e/0xd0
[  284.527934]  ? get_lock_stats+0x13/0x120
[  284.527944]  ___might_sleep.cold.58+0x54/0x77
[  284.527964]  rt_spin_lock+0x3e/0x120
[  284.527969]  ? __blk_add_trace+0x9ea/0xdf0
[  284.527980]  __blk_add_trace+0x9ea/0xdf0
[  284.528025]  ? rcu_read_lock_sched_held+0xe0/0xe0
[  284.528048]  blk_add_trace_bio+0x25d/0x2f0
[  284.528074]  ? recalibrate_cpu_khz+0x10/0x10
[  284.528094]  ? blk_add_trace_bio_frontmerge+0x20/0x20
[  284.528107]  generic_make_request_checks+0x1471/0x1cc0
[  284.528143]  ? blk_update_request+0x1610/0x1610
[  284.528172]  ? iomap_readpages_actor+0x4f3/0x900
[  284.528208]  generic_make_request+0x8e/0xa40
[  284.528255]  ? direct_make_request+0x2b0/0x2b0
[  284.528260]  ? iomap_readpage_actor+0xd40/0xd40
[  284.528267]  ? iomap_readpages+0x20b/0x950
[  284.528277]  ? bad_range+0x237/0x410
[  284.528288]  ? trace_event_raw_event_iomap_apply+0x430/0x430
[  284.528329]  ? submit_bio+0xcb/0x440
[  284.528338]  submit_bio+0xcb/0x440
[  284.528358]  ? generic_make_request+0xa40/0xa40
[  284.528387]  ? rcu_read_lock_bh_held+0x100/0x100
[  284.528412]  ? iomap_readpage_actor+0xd40/0xd40
[  284.528422]  iomap_readpages+0x22f/0x950
[  284.528442]  ? iomap_writepage+0xa0/0xa0
[  284.528505]  read_pages+0xf8/0x600
[  284.528535]  ? __alloc_pages_nodemask+0x80d/0xa20
[  284.528554]  ? read_cache_pages+0x6d0/0x6d0
[  284.528560]  ? __alloc_pages_slowpath+0x2a10/0x2a10
[  284.528621]  __do_page_cache_readahead+0x311/0x3c0
[  284.528663]  ? read_pages+0x600/0x600
[  284.528712]  ondemand_readahead+0x443/0xc00
[  284.528717]  ? page_cache_sync_readahead+0x18a/0x3f0
[  284.528757]  generic_file_buffered_read+0xd65/0x1ee0
[  284.528850]  ? read_cache_page_gfp+0xa0/0xa0
[  284.529003]  ? xfs_ilock+0x17d/0x590 [xfs]
[  284.529009]  ? get_lock_stats+0x18/0x120
[  284.529018]  ? put_lock_stats.isra.19+0xb/0xa0
[  284.529045]  ? lock_contended+0xa70/0xa70
[  284.529069]  ? __down_read_trylock+0x53/0x80
[  284.529222]  ? xfs_file_buffered_aio_read+0x146/0x4f0 [xfs]
[  284.529381]  xfs_file_buffered_aio_read+0x151/0x4f0 [xfs]
[  284.529534]  xfs_file_read_iter+0x2bf/0x740 [xfs]
[  284.529545]  ? rt_mutex_slowlock_locked+0x262/0x790
[  284.529572]  new_sync_read+0x39c/0x560
[  284.529582]  ? mark_held_locks+0xb7/0x120
[  284.529594]  ? do_iter_readv_writev+0x6e0/0x6e0
[  284.529660]  ? fsnotify_first_mark+0x150/0x150
[  284.529717]  vfs_read+0x147/0x350
[  284.529745]  ksys_read+0xb8/0x170
[  284.529759]  ? kernel_write+0x130/0x130
[  284.529809]  do_syscall_64+0x13c/0x670
[  284.529830]  entry_SYSCALL_64_after_hwframe+0x6a/0xdf

Thanks,
Ming

