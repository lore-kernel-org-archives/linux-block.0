Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF8C2BB9A
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 16:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE7A2222B
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 16:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgLOQIl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 11:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730871AbgLOQIc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 11:08:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E501C06179C;
        Tue, 15 Dec 2020 08:07:52 -0800 (PST)
Date:   Tue, 15 Dec 2020 17:07:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608048469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H9rdCROzryuIuLwWp3pwCnwm0SYlQB5Wa5LJ3x4hebk=;
        b=zO76aQVIUJs0qnQx+RDHproxUCqJeLbPPm+h49ETNfFooNpkUX+h2WIhcpeeG7Ab2bgjuy
        nZxHJ7buDzEeGoHPGZt3i7/5pxt7RC8+92Lg0zKk4JwkJ+tYX+rVIyL3pW+dkUJypdsR4p
        TE177b6upy078ffU7wivXogJ4uQcnC6F5YINauOLHzNLZuqVr29gP9HgTc6MLbVfGddw2a
        BCFhyAU4fdkT1j39itHVKmyoqR+IjJ8lzV2SjsbGICRjp7im10XglEVhw3SfLTKN13dr2r
        E+0d3sITKDrr/Q2TYfJS5DFJemz+TIo+7tR7WOwbX+Z0+YBbEkRt8ll39czXYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608048469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H9rdCROzryuIuLwWp3pwCnwm0SYlQB5Wa5LJ3x4hebk=;
        b=3IcFz4hwL7hk6yBI9VbfTsbA0RQuk5QGQasTzOpMAaJA7XLlFcCeS1EMc47FRpcSrs+ZxV
        /to2x1Lnn5ZvfyCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] blktrace: fix 'BUG: sleeping function called from
 invalid context' in case of PREEMPT_RT
Message-ID: <20201215160747.zzi3jxfy6kv25c2n@linutronix.de>
References: <20201214022217.1754273-1-ming.lei@redhat.com>
 <20201214102422.2d84035d@gandalf.local.home>
 <20201215120604.GB1798021@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201215120604.GB1798021@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-12-15 20:06:04 [+0800], Ming Lei wrote:
> 
> [  284.527619] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:968
> [  284.527626] in_atomic(): 1, irqs_disabled(): 0, pid: 6705, name: mandb
> [  284.527631] 4 locks held by mandb/6705:
> [  284.527634]  #0: ffff88853f4f2eb0 (&f->f_pos_lock){+.+.}-{0:0}, at: __fdget_pos+0xaf/0xe0
> [  284.527662]  #1: ffff8885eb814048 (&sb->s_type->i_mutex_key#13){++++}-{0:0}, at: xfs_ilock+0x17d/0x590 [xfs]
> [  284.527838]  #2: ffffffffa24d22c0 (rcu_read_lock){....}-{1:2}, at: blk_add_trace_bio+0x0/0x2f0
> [  284.527859]  #3: ffffffffa22177a0 (running_trace_lock){+.+.}-{2:2}, at: __blk_add_trace+0x9ea/0xdf0
> [  284.527877] Preemption disabled at:
> [  284.527886] [<ffffffff9f936743>] get_lock_stats+0x13/0x120
> [  284.527897] CPU: 53 PID: 6705 Comm: mandb Kdump: loaded Not tainted 4.18.0-259.rt7.24.el8.x86_64+debug #1

4.18?
I just gave it a try with 5.10-RT and I don't see a splat. Please retest
with v5.10-RT.

> 
> Thanks,
> Ming

Sebastian
