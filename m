Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751955AbcKPOGO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2016 09:06:14 -0500
From: Jeff Moyer <jmoyer@redhat.com>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-nvdimm@ml01.01.org, axboe@kernel.dk
Subject: Re: [patch] nd_blk,nd_pmem,nd_btt: add endio blktrace events
References: <x49twbgo4i6.fsf@segfault.boston.devel.redhat.com>
        <20161109191715.GA20314@infradead.org>
        <x49mvh8o3fx.fsf@segfault.boston.devel.redhat.com>
        <20161109193441.GA17343@infradead.org>
        <x49inrwo2v5.fsf@segfault.boston.devel.redhat.com>
        <20161110193333.GA10865@infradead.org>
        <x4937iyf4mp.fsf@segfault.boston.devel.redhat.com>
        <20161116045657.GA30049@linux.intel.com>
Date: Wed, 16 Nov 2016 09:06:11 -0500
In-Reply-To: <20161116045657.GA30049@linux.intel.com> (Ross Zwisler's message
        of "Tue, 15 Nov 2016 21:56:57 -0700")
Message-ID: <x49polvikoc.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Ross Zwisler <ross.zwisler@linux.intel.com> writes:

> FWIW I think BRD has this same issue where we get block_bio_queue tracepoint
> events but not block_bio_complete.  Solving this in bio_endio() would fix that
> driver as well.

Yeah, there are several other drivers that will benefit.

> Where does the Q (bio enqueue), I (req insert), etc. naming show up?  Looking
> at a tracepoint trace in perf I don't see that naming.  Is that just a short
> hand used between developers, or is it something else?

That shorthand appears in blkparse and btt output (tools that are part
of blktrace).

Cheers,
Jeff
