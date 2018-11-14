Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D8DC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 22:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93522175B
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 22:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93522175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeKOIyY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:54:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeKOIyY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 03:54:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 999D2315485E;
        Wed, 14 Nov 2018 22:49:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB57760BF6;
        Wed, 14 Nov 2018 22:49:07 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id wAEMn72p011975;
        Wed, 14 Nov 2018 17:49:07 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id wAEMn7ap011971;
        Wed, 14 Nov 2018 17:49:07 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 14 Nov 2018 17:49:07 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     Mike Snitzer <snitzer@redhat.com>,
        "Alasdair G. Kergon" <agk@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [patch 5/5] block: use a driver-specific handler for the "inflight"
 value
In-Reply-To: <20181114151848.GA22138@infradead.org>
Message-ID: <alpine.LRH.2.02.1811141740440.7875@file01.intranet.prod.int.rdu2.redhat.com>
References: <20181106213858.391264280@debian-a64.vm> <20181108145240.GA20087@infradead.org> <20181108170701.GA29107@redhat.com> <20181114151848.GA22138@infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 14 Nov 2018 22:49:12 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Wed, 14 Nov 2018, Christoph Hellwig wrote:

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

We want to make dm-linear (and dm-stripe) completely lockless, because it 
is used often and we don't want it to degrade performance.

DM already uses srcu to handle table changes, so that the fast path 
doesn't take any locks. And the only one "lock" that is remaining is the 
"in_flight" variable.

As for other drivers, md-raid0 could probably be lockless too (using 
percpu counting similar to dm). The other raid levels can't be lockless 
because they need to check the status of the stripe that is being 
accessed.

Mikulas
