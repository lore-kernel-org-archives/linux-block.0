Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E69AC433FF
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 19:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5545321EF2
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 19:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565204444;
	bh=H8GQL47oZOjHGMHt6mc7yPh3DyXvvruf/VfI2fdq1XA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=H8U46Y68DH8jRkMxCV63QdSH549h+MkNu3Q3t/kkTgb04DSjFVBjAEyxWTWGzualF
	 uZML8wYMuh9R1BuvoZAm7Ylf6anUzPeAB+73aQ7m1dnkDRw47V834J1y+KG8+Be1ok
	 AcdtoYN8PnvAzALq0A1LiFtltnCsGB4tCq9IFrpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfHGTAk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfHGTAk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Aug 2019 15:00:40 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8554B21EF2;
        Wed,  7 Aug 2019 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565204438;
        bh=H8GQL47oZOjHGMHt6mc7yPh3DyXvvruf/VfI2fdq1XA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YlgkEarDGN0iPkWPaV/pbw5ncD7rQmx4yJoKPQ9nlm4ouA1+CTa9RxYW+98Vy24gI
         qJ6E09hPzeZhxEQ6ywpXQDT2SLGtRgRNv3zVoSJY1Fz2VgEHGrOKuc89UnlAoTAMXS
         uihlSf1Qg+aa309BG0I7DD0CeJ2fpdTb3Y3u8rXk=
Date:   Wed, 7 Aug 2019 12:00:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com
Subject: Re: [PATCH 2/4] bdi: Add bdi->id
Message-Id: <20190807120037.72018c136db40e88d89c05d1@linux-foundation.org>
In-Reply-To: <20190807183151.GM136335@devbig004.ftw2.facebook.com>
References: <20190803140155.181190-1-tj@kernel.org>
        <20190803140155.181190-3-tj@kernel.org>
        <20190806160102.11366694af6b56d9c4ca6ea3@linux-foundation.org>
        <20190807183151.GM136335@devbig004.ftw2.facebook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 7 Aug 2019 11:31:51 -0700 Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> On Tue, Aug 06, 2019 at 04:01:02PM -0700, Andrew Morton wrote:
> > On Sat,  3 Aug 2019 07:01:53 -0700 Tejun Heo <tj@kernel.org> wrote:
> > > There currently is no way to universally identify and lookup a bdi
> > > without holding a reference and pointer to it.  This patch adds an
> > > non-recycling bdi->id and implements bdi_get_by_id() which looks up
> > > bdis by their ids.  This will be used by memcg foreign inode flushing.
> > 
> > Why is the id non-recycling?  Presumably to address some
> > lifetime/lookup issues, but what are they?
> 
> The ID by itself is used to point to the bdi from cgroup and idr
> recycles really aggressively.  Combined with, for example, loop device
> based containers, stale pointing can become pretty common.  We're
> having similar issues with cgroup IDs.

OK, but why is recycling a problem?  For example, file descriptors
recycle as aggressively as is possible, and that doesn't cause any
trouble.  Presumably recycling is a problem with cgroups because of
some sort of stale reference problem?


