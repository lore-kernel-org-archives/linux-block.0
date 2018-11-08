Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbeKICn3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Nov 2018 21:43:29 -0500
Date: Thu, 8 Nov 2018 12:07:01 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        "Alasdair G. Kergon" <agk@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [patch 5/5] block: use a driver-specific handler for the
 "inflight" value
Message-ID: <20181108170701.GA29107@redhat.com>
References: <20181106213858.391264280@debian-a64.vm>
 <20181108145240.GA20087@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181108145240.GA20087@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Nov 08 2018 at  9:52am -0500,
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Nov 06, 2018 at 10:35:03PM +0100, Mikulas Patocka wrote:
> > Device mapper was converted to percpu inflight counters. In order to
> > display the correct values in the "inflight" sysfs file, we need a custom
> > callback that sums the percpu counters.
> 
> The attribute that calls this is per-partition, while your method
> is per-queue, so there is some impedence mismatch here.
> 
> Is there any way you could look into just making the generic code
> use percpu counters?

Discussed doing that with Jens and reported as much here:

https://www.redhat.com/archives/dm-devel/2018-November/msg00068.html

And Jens gave additional context for why yet another attempt to switch
block core's in_flight to percpu counters is doomed (having already been
proposed and rejected twice):

https://www.redhat.com/archives/dm-devel/2018-November/msg00071.html

And yes, definitely should've cc'd linux-block (now added).

Mike
