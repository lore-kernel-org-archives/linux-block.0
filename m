Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A86C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 13:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3317B2086B
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 13:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3317B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeKQAIa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:08:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeKQAI3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 19:08:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B7F03097043;
        Fri, 16 Nov 2018 13:55:59 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15A0F60CBA;
        Fri, 16 Nov 2018 13:55:57 +0000 (UTC)
Date:   Fri, 16 Nov 2018 08:55:56 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, "Alasdair G. Kergon" <agk@redhat.com>
Subject: Re: [PATCH 3/3] block: use a driver-specific handler for the
 "inflight" value
Message-ID: <20181116135555.GA28870@redhat.com>
References: <20181116000508.980108938@debian.vm>
 <20181116091102.GA22961@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116091102.GA22961@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 16 Nov 2018 13:55:59 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16 2018 at  4:11am -0500,
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Nov 16, 2018 at 01:04:19AM +0100, Mikulas Patocka wrote:
> > Device mapper was converted to percpu inflight counters. In order to
> > display the correct values in the "inflight" sysfs file and in
> > /proc/diskstats, we need a custom callback that sums the percpu counters.
> > 
> > The function part_round_stats calculates the number of in-flight I/Os
> > every jiffy and uses this to calculate the counters time_in_queue and
> > io_ticks. In order to avoid excessive memory traffic on systems with high
> > number of CPUs, this functionality is disabled when percpu inflight values
> > are used and the values time_in_queue and io_ticks are calculated
> > differently - the result is less precise.
> 
> And none of that is device mapper specific.  Please submit this code
> to the block layer for use by all make_request based drivers.  Depending
> on what Jens as the maintainers thinkgs of the tradeoffs we can discuss
> if the summing should be on or off by default, or if we maybe even
> need the current code as a fallback.

I agree.

Mikulas, we discussed that the changes would be made to block core.  I
know that makes you less comfortable (I assume because you need to
consider more than DM) but it is the right way forward.

Now that the legacy IO path is gone we have less to consider; these
counters are only impacting bio-based.

Mike
