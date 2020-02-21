Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1473C35656
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 16:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84734208E4
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 16:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582302880;
	bh=AeYy9W04Xju1SqpnxRal8094BuWJzVkZCpujWRx0g2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0+VCGU/uC1skrB8sc1QxgAP6J7+gyIdM6NXNfc5g1Cv6vc7A2pqt6EDBWXpl+U+Rg
	 zge/zn5ZpaKlroymfKa9ymiejqDnqK2xBKVTLVmmtvLxknGcB+JhoI+16ICDt/Xvc0
	 8Vt1G4Pzd8m8e2zsmSGUHbUZungFQUlIP1gOmx90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgBUQek (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:34:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgBUQej (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Feb 2020 11:34:39 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DCB120578;
        Fri, 21 Feb 2020 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582302879;
        bh=AeYy9W04Xju1SqpnxRal8094BuWJzVkZCpujWRx0g2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gSB9SVQXMC/3CNGAwJJ14G8mmt8G4VhpJBzZbwCLU609YyX6angbsYcidPUQhtr7w
         j2zEbBRyNJ6h8gJCePG5D948UaD6TmrVPids2l8D3Wd7NmLibwXxR3sphHeRA2xJSP
         ds4qeZ8yBVyzLR7jQaQBQMuHci4vUUMRJHDGNP38=
Date:   Sat, 22 Feb 2020 01:34:32 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Cc:     axboe@kernel.dk, song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Subject: Re: [PATCH v2 2/2] md: enable io polling
Message-ID: <20200221163432.GA15420@redsun51.ssa.fujisawa.hgst.com>
References: <20200211191729.4745-1-andrzej.jakowski@linux.intel.com>
 <20200211191729.4745-3-andrzej.jakowski@linux.intel.com>
 <20200211211334.GB3837@redsun51.ssa.fujisawa.hgst.com>
 <e9941d4d-c403-4177-526d-b3086207f31a@linux.intel.com>
 <20200212214207.GA6409@redsun51.ssa.fujisawa.hgst.com>
 <f516e2b2-1988-03ca-f966-5f26771717ff@linux.intel.com>
 <20200214192526.GA10991@redsun51.ssa.fujisawa.hgst.com>
 <db131d8e-b622-ec80-411e-2ca7643997a7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db131d8e-b622-ec80-411e-2ca7643997a7@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 21, 2020 at 08:25:47AM -0700, Andrzej Jakowski wrote:
> Your proposal makes sense to me, yet still it requires significant rework
> in generic_make_request(). I believe that generic_make_request() would 
> have to return/store cookie for each subordinate bio. I'm wondering why 
> cookie is needed for polling at all? From my understanding it looks 
> like cookie info is used to find HW context which to poll on. Hybrid
> polling uses it to find particular IO request and set its 'RQF_MQ_POLL_SLEPT'
> flag. 

The cookie encodes the hctx and tag of a submitted request, but the
cookies is kind of broken if the original bio gets split:

If the bio that created that request was split, the driver only knows to
look for one tag and may end polling too early while chained bios remain
outstanding. That is mostly okay since we'll just poll the same hctx
again until all the chained bio's complete, but the tag we're polling
for isn't associated with the original bio anymore.

In case of hybrid sleep, if a new request is allocated with the same tag,
the poll function will incorrectly sleep again, and set the "SLEPT"
flag on someone else's request. It also looks like that may corrupt
rq_flags since two threads may set it at the same time (this may
actually be a real problem, but I haven't successfully made it happen
yet).

> Now, if we assume that cookie is not passed to polling function, poll_fn
> would need to find HW context to poll on in different way. Perhaps reference
> to it could be stored in request_queue itself?

A device may provide many polled hardware contexts. Different threads
may want to poll different contexts at the same time, so the poll_fn()
needs to know which one. How would you encode that into the
request_queue?

> Polling in stackable block
> drivers would be much simpler -- they would call polling for underlying MQ
> device, which in turn would poll on correct HW context.
> 
> Does this approach sound reasonable? 
