Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54411 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753162AbcKITRQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2016 14:17:16 -0500
Date: Wed, 9 Nov 2016 11:17:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: "Dan J. Williams" <dan.j.williams@intel.com>,
        linux-nvdimm@ml01.01.org, linux-block@vger.kernel.org
Subject: Re: [patch] nd_blk,nd_pmem,nd_btt: add endio blktrace events
Message-ID: <20161109191715.GA20314@infradead.org>
References: <x49twbgo4i6.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <x49twbgo4i6.fsf@segfault.boston.devel.redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Nov 09, 2016 at 02:08:33PM -0500, Jeff Moyer wrote:
> Right now, any of the above three drivers will report Q events in
> blktrace but no corresponding C events.  Fix it.

It seems like that trace point should simply go into bio_endio
and be removed from any existing callsite.
