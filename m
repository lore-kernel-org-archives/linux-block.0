Return-Path: <SRS0=0w4s=WC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB7CC433FF
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 23:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EBE20B1F
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 23:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565132594;
	bh=qT4gAKs+8ApcJTe9M2dRBF2NOvklKVKeDkSelB5PNpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VSfTGnlenDKcMBhN9N0Jb1tbhmNGBzni3WTFIQZ3Z/VzSs29N3DDufvfWyQJvYSp9
	 jyxsfeU16rWaUTsblKDk9DwAaZuVICETXg5KGaqhjoqB6QYngcguKtPy23KRAHaDdR
	 OBVRg8f+xvAgyrgYE+3S0VpuDkwy093l/i0duMyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfHFXDJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 19:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfHFXDJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Aug 2019 19:03:09 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A33320717;
        Tue,  6 Aug 2019 23:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565132587;
        bh=qT4gAKs+8ApcJTe9M2dRBF2NOvklKVKeDkSelB5PNpE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nYhQksXMjFdjn7qsubpevTF4BxP7xsit/IdT2SfJ3mrS0Rx7B0zEjLoFZc8NJZXxT
         jiawPejTfcVjvKx3FcMC6k2JIomNwGOL5/r2KBhYy/ve+cJBFcRC62rjV6qGuOk6dC
         UUV7Z7MUl5e1flsun/zvccyVkG5K2bYpuLV3Qae0=
Date:   Tue, 6 Aug 2019 16:03:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com
Subject: Re: [PATCH 4/4] writeback, memcg: Implement foreign dirty flushing
Message-Id: <20190806160306.5330bd4fdddf357db4b7086c@linux-foundation.org>
In-Reply-To: <20190803140155.181190-5-tj@kernel.org>
References: <20190803140155.181190-1-tj@kernel.org>
        <20190803140155.181190-5-tj@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat,  3 Aug 2019 07:01:55 -0700 Tejun Heo <tj@kernel.org> wrote:

> There's an inherent mismatch between memcg and writeback.  The former
> trackes ownership per-page while the latter per-inode.  This was a
> deliberate design decision because honoring per-page ownership in the
> writeback path is complicated, may lead to higher CPU and IO overheads
> and deemed unnecessary given that write-sharing an inode across
> different cgroups isn't a common use-case.
> 
> Combined with inode majority-writer ownership switching, this works
> well enough in most cases but there are some pathological cases.  For
> example, let's say there are two cgroups A and B which keep writing to
> different but confined parts of the same inode.  B owns the inode and
> A's memory is limited far below B's.  A's dirty ratio can rise enough
> to trigger balance_dirty_pages() sleeps but B's can be low enough to
> avoid triggering background writeback.  A will be slowed down without
> a way to make writeback of the dirty pages happen.
> 
> This patch implements foreign dirty recording and foreign mechanism so
> that when a memcg encounters a condition as above it can trigger
> flushes on bdi_writebacks which can clean its pages.  Please see the
> comment on top of mem_cgroup_track_foreign_dirty_slowpath() for
> details.
> 
> ...
>
> +void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
> +					     struct bdi_writeback *wb)
> +{
> +	struct mem_cgroup *memcg = page->mem_cgroup;
> +	struct memcg_cgwb_frn *frn;
> +	u64 now = jiffies_64;
> +	u64 oldest_at = now;
> +	int oldest = -1;
> +	int i;
> +
> +	/*
> +	 * Pick the slot to use.  If there is already a slot for @wb, keep
> +	 * using it.  If not replace the oldest one which isn't being
> +	 * written out.
> +	 */
> +	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> +		frn = &memcg->cgwb_frn[i];
> +		if (frn->bdi_id == wb->bdi->id &&
> +		    frn->memcg_id == wb->memcg_css->id)
> +			break;
> +		if (frn->at < oldest_at && atomic_read(&frn->done.cnt) == 1) {
> +			oldest = i;
> +			oldest_at = frn->at;
> +		}
> +	}
> +
> +	if (i < MEMCG_CGWB_FRN_CNT) {
> +		unsigned long update_intv =
> +			min_t(unsigned long, HZ,
> +			      msecs_to_jiffies(dirty_expire_interval * 10) / 8);

An explanation of what's going on here would be helpful.

Why "* 1.25" and not, umm "* 1.24"?

> +		/*
> +		 * Re-using an existing one.  Let's update timestamp lazily
> +		 * to avoid making the cacheline hot.
> +		 */
> +		if (frn->at < now - update_intv)
> +			frn->at = now;
> +	} else if (oldest >= 0) {
> +		/* replace the oldest free one */
> +		frn = &memcg->cgwb_frn[oldest];
> +		frn->bdi_id = wb->bdi->id;
> +		frn->memcg_id = wb->memcg_css->id;
> +		frn->at = now;
> +	}
> +}
> +
> +/*
> + * Issue foreign writeback flushes for recorded foreign dirtying events
> + * which haven't expired yet and aren't already being written out.
> + */
> +void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
> +	unsigned long intv = msecs_to_jiffies(dirty_expire_interval * 10);

Ditto.

> +	u64 now = jiffies_64;
> +	int i;
> +
> +	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> +		struct memcg_cgwb_frn *frn = &memcg->cgwb_frn[i];
> +
> +		if (frn->at > now - intv && atomic_read(&frn->done.cnt) == 1) {
> +			frn->at = 0;
> +			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id,
> +					       LONG_MAX, WB_REASON_FOREIGN_FLUSH,
> +					       &frn->done);
> +		}
> +	}
> +}
> +

