Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57399 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424333AbcKAN5H (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2016 09:57:07 -0400
Date: Tue, 1 Nov 2016 06:57:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Scott Bauer <scott.bauer@intel.com>,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        hch@infradead.org, Rafael.Antognolli@intel.com, axboe@fb.com,
        linux-block@vger.kernel.org, jonathan.derrick@intel.com,
        j.naumann@fu-berlin.de
Subject: Re: [RFC PATCH 5/6] nvme: Add unlock_from_suspend
Message-ID: <20161101135705.GA32697@infradead.org>
References: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
 <1477951099-3127-6-git-send-email-scott.bauer@intel.com>
 <6a6a131a-09fe-4c7c-85a7-01149555e427@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6a6a131a-09fe-4c7c-85a7-01149555e427@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 01, 2016 at 10:18:13AM +0200, Sagi Grimberg wrote:
> > +
> > +	return nvme_insert_rq(q, req, 1, sec_submit_endio);
> 
> No need to introduce nvme_insert_rq at all, just call
> blk_mq_insert_request (other examples call blk_execute_rq_nowait
> but its pretty much the same...)

blk_execute_rq_nowait is the API to use - blk_mq_insert_request isn't
even exported.
