Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60197 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753335AbcKITen (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2016 14:34:43 -0500
Date: Wed, 9 Nov 2016 11:34:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Dan J. Williams" <dan.j.williams@intel.com>,
        linux-nvdimm@ml01.01.org, linux-block@vger.kernel.org
Subject: Re: [patch] nd_blk,nd_pmem,nd_btt: add endio blktrace events
Message-ID: <20161109193441.GA17343@infradead.org>
References: <x49twbgo4i6.fsf@segfault.boston.devel.redhat.com>
 <20161109191715.GA20314@infradead.org>
 <x49mvh8o3fx.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <x49mvh8o3fx.fsf@segfault.boston.devel.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Nov 09, 2016 at 02:31:30PM -0500, Jeff Moyer wrote:
> bio_endio is still called for request_fn drivers, so you'd see two
> completion events for those drivers if we did that, no?

We'd see the bio_endio trace in addition to the request one, but
they are at different granularities.  Similar to how on the issue side
we have trace_block_bio_queue for each bio, and trace_block_rq_issue
for each request.
