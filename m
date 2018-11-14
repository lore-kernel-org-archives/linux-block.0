Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D2CC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1D922360
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1D922360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeKOBiY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:38:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733230AbeKOBiY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:38:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7EE8A402D;
        Wed, 14 Nov 2018 15:34:41 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACABA60BF7;
        Wed, 14 Nov 2018 15:34:38 +0000 (UTC)
Date:   Wed, 14 Nov 2018 10:34:37 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        "Alasdair G. Kergon" <agk@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [patch 5/5] block: use a driver-specific handler for the
 "inflight" value
Message-ID: <20181114153437.GA17974@redhat.com>
References: <20181106213858.391264280@debian-a64.vm>
 <20181108145240.GA20087@infradead.org>
 <20181108170701.GA29107@redhat.com>
 <20181114151848.GA22138@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114151848.GA22138@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 14 Nov 2018 15:34:41 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14 2018 at 10:18am -0500,
Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Nov 08, 2018 at 12:07:01PM -0500, Mike Snitzer wrote:
> > Discussed doing that with Jens and reported as much here:
> > 
> > https://www.redhat.com/archives/dm-devel/2018-November/msg00068.html
> > 
> > And Jens gave additional context for why yet another attempt to switch
> > block core's in_flight to percpu counters is doomed (having already been
> > proposed and rejected twice):
> > 
> > https://www.redhat.com/archives/dm-devel/2018-November/msg00071.html
> > 
> > And yes, definitely should've cc'd linux-block (now added).
> 
> So how is dm different from the the other 3 handful of drivers using
> the make_request interface that the per-cpu counters work for dm and
> not the others?

Think the big part of the historic reluctance to switch to percpu
in_flight counters was that until now (4.21) the legacy request path was
also using the in_flight counters.

Now that they are only used by bio-based (make_request) we likely have
more latitude (hopefully?).  Though I cannot say for sure why they
performed so well in Mikulas' testing.. you'd thinking all the percpu
summing on every jiffie during IO completion would've still been
costly.. but Mikulas saw great results.

Mikulas and I have discussed a new way forward and he is actively
working through implementing it.  Basically he'll still switch to percpu
in_flight counters but he'll change the algorithm for IO accounting
during completion so that it is more of an approximation of the
historically precise in_flight counters and io_ticks (io_ticks is
another problematic component that gets in the way of performance).
Basically the accounting done during IO completion would be much much
faster.  Big part of this is the summation of the percpu in_flight
counters would happen on demand (via sysfs or /proc/diskstats access).
I could look back at my logs from my chat with Mikulas to give you more
details or we could just wait for Mikulas to post the patches (hopefully
within a week).  Your call.

Coming off my Monday discussion with Mikulas I really think the approach
will work nicely and offer a nice performance win for bio-based.

Mike
