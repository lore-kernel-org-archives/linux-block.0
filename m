Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D667C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 00:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12E12082F
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 00:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12E12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeK1Lln (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:41:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeK1Lln (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 06:41:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B10392D80D;
        Wed, 28 Nov 2018 00:42:02 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1844E60BE8;
        Wed, 28 Nov 2018 00:41:57 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id wAS0fu1S018965;
        Tue, 27 Nov 2018 19:41:56 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id wAS0ftxB018961;
        Tue, 27 Nov 2018 19:41:55 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 27 Nov 2018 19:41:55 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>
cc:     Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        "Alasdair G. Kergon" <agk@redhat.com>
Subject: Re: [PATCH 3/3] block: use a driver-specific handler for the "inflight"
 value
In-Reply-To: <c84a1ed6-cc90-472f-446f-d83a27d3ac20@kernel.dk>
Message-ID: <alpine.LRH.2.02.1811271937400.18132@file01.intranet.prod.int.rdu2.redhat.com>
References: <20181116000508.980108938@debian.vm> <20181116091102.GA22961@infradead.org> <20181116135555.GA28870@redhat.com> <c84a1ed6-cc90-472f-446f-d83a27d3ac20@kernel.dk>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 28 Nov 2018 00:42:02 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Fri, 16 Nov 2018, Jens Axboe wrote:

> On 11/16/18 6:55 AM, Mike Snitzer wrote:
> > On Fri, Nov 16 2018 at  4:11am -0500,
> > Christoph Hellwig <hch@infradead.org> wrote:
> > 
> >> On Fri, Nov 16, 2018 at 01:04:19AM +0100, Mikulas Patocka wrote:
> >>> Device mapper was converted to percpu inflight counters. In order to
> >>> display the correct values in the "inflight" sysfs file and in
> >>> /proc/diskstats, we need a custom callback that sums the percpu counters.
> >>>
> >>> The function part_round_stats calculates the number of in-flight I/Os
> >>> every jiffy and uses this to calculate the counters time_in_queue and
> >>> io_ticks. In order to avoid excessive memory traffic on systems with high
> >>> number of CPUs, this functionality is disabled when percpu inflight values
> >>> are used and the values time_in_queue and io_ticks are calculated
> >>> differently - the result is less precise.
> >>
> >> And none of that is device mapper specific.  Please submit this code
> >> to the block layer for use by all make_request based drivers.  Depending
> >> on what Jens as the maintainers thinkgs of the tradeoffs we can discuss
> >> if the summing should be on or off by default, or if we maybe even
> >> need the current code as a fallback.
> > 
> > I agree.
> > 
> > Mikulas, we discussed that the changes would be made to block core.  I
> > know that makes you less comfortable (I assume because you need to
> > consider more than DM) but it is the right way forward.
> > 
> > Now that the legacy IO path is gone we have less to consider; these
> > counters are only impacting bio-based.
> 
> Agree, either the new code is good enough to be used in general, and
> then it should be generally used, or it should not exist in the first
> place. We've always worked very hard to provide the most efficient
> helpers and infrastructure we can in the block layer itself, so that
> drivers don't have to reinvent the wheel.
> 
> -- 
> Jens Axboe

I have generalized the per-cpu changes (so that all bio-based block 
devices use per-cpu in_flight counters) and I've made patches for the 
for-4.21/block branch in your git. I'm sending them.

Mikulas
